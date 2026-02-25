'use strict';

const sfPublisher = require('./sfPublisher');

const WEBHOOK_URL = process.env.WEBHOOK_URL || '';

/**
 * handle() — receives a raw CDC event from Salesforce Streaming API
 * and returns a normalised event object.
 */
function handle(rawEvent, conn) {
    const header  = rawEvent.payload?.ChangeEventHeader || {};
    const replayId = rawEvent.event?.replayId;

    // Extract only the changed field values (everything except ChangeEventHeader)
    const changedValues = {};
    for (const [key, value] of Object.entries(rawEvent.payload || {})) {
        if (key !== 'ChangeEventHeader') {
            changedValues[key] = value;
        }
    }

    const normalised = {
        replayId,
        receivedAt       : new Date().toISOString(),
        entityName       : header.entityName,
        changeType       : header.changeType,          // CREATE | UPDATE | DELETE | UNDELETE
        recordIds        : header.recordIds || [],
        changedFields    : header.changedFields || [],
        changedValues,
        commitTimestamp  : header.commitTimestamp
            ? new Date(header.commitTimestamp).toISOString()
            : null,
        commitUser       : header.commitUser,
        transactionKey   : header.transactionKey,
        changeOrigin     : header.changeOrigin,
    };

    // Pretty-print to console
    console.log('─'.repeat(60));
    console.log(`📬  CDC Event Received`);
    console.log(`    Entity      : ${normalised.entityName}`);
    console.log(`    Change Type : ${normalised.changeType}`);
    console.log(`    Record IDs  : ${normalised.recordIds.join(', ')}`);
    // console.log(`    Values      :`, changedValues);
    console.log(`    Replay ID   : ${replayId}`);
    console.log('─'.repeat(60));

    // ── Simulate Database Write & Publish Sync Confirmation ───────────────────
    if (conn && normalised.recordIds.length > 0) {
        // We simulate a 500ms DB write delay
        setTimeout(() => {
            sfPublisher.publishSyncEvent(conn, {
                recordId: normalised.recordIds[0],
                objectType: normalised.entityName,
                operation: normalised.changeType
            });
        }, 500);
    }

    // ── Optional webhook forwarding ───────────────────────────────────────────
    if (WEBHOOK_URL) {
        axios.post(WEBHOOK_URL, normalised)
            .catch((err) => console.error(`   ⚠  Webhook forward failed: ${err.message}`));
    }

    return normalised;
}

module.exports = { handle };
