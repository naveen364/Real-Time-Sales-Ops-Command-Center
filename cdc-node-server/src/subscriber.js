'use strict';

require('dotenv').config();
const jsforce = require('jsforce');
const eventHandler = require('./eventHandler');

const SF_USERNAME    = process.env.SF_USERNAME;
const SF_PASSWORD    = process.env.SF_PASSWORD;
const SF_TOKEN       = process.env.SF_SECURITY_TOKEN;
const SF_LOGIN_URL   = process.env.SF_LOGIN_URL || 'https://login.salesforce.com';
const CDC_CHANNEL    = process.env.CDC_CHANNEL   || '/data/ContactChangeEvent';
const REPLAY_ID      = parseInt(process.env.REPLAY_ID || '-1', 10);

// Validate required environment variables
if (!SF_USERNAME || !SF_PASSWORD) {
    console.error('❌  Missing SF_USERNAME or SF_PASSWORD in .env');
    process.exit(1);
}

// ── Shared in-memory event store (also used by server.js) ────────────────────
const eventStore = [];
const MAX_EVENTS = 100;

function storeEvent(event) {
    eventStore.unshift(event);          // newest first
    if (eventStore.length > MAX_EVENTS) {
        eventStore.pop();
    }
}

// ── Connect and Subscribe ────────────────────────────────────────────────────
async function startSubscriber() {
    const conn = new jsforce.Connection({ loginUrl: SF_LOGIN_URL });

    console.log(`\n🔐  Connecting to Salesforce as ${SF_USERNAME} ...`);

    try {
        await conn.login(SF_USERNAME, SF_PASSWORD + SF_TOKEN);
        console.log(`✅  Connected to Salesforce!`);
        console.log(`    Instance URL : ${conn.instanceUrl}`);
        console.log(`    User ID      : ${conn.userInfo.id}`);
    } catch (err) {
        console.error('❌  Salesforce login failed:', err.message);
        process.exit(1);
    }

    // ── Streaming API ─────────────────────────────────────────────────────────
    const streaming = conn.streaming;
    const channels = [
        '/data/ContactChangeEvent',
        '/data/OpportunityChangeEvent',
        '/data/AccountChangeEvent'
    ];

    channels.forEach(channel => {
        // Set up replay extension so we resume from last received event
        const replayExt = new jsforce.StreamingExtension.Replay(channel, REPLAY_ID);
        const authFailureExt = new jsforce.StreamingExtension.AuthFailure(() => {
            console.error(`❌  Salesforce auth failure on channel ${channel}. Reconnecting...`);
            setTimeout(startSubscriber, 5000);
        });

        const fayeClient = streaming.createClient([replayExt, authFailureExt]);

        console.log(`📡  Subscribing to channel: ${channel}`);

        const subscription = fayeClient.subscribe(channel, (event) => {
            const processed = eventHandler.handle(event, conn);
            storeEvent(processed);
        });

        subscription.then(() => {
            console.log(`✅  Subscribed to ${channel}!`);
        }).catch((err) => {
            console.error(`❌  Subscription error [${channel}]:`, err.message);
        });
    });

    return streaming;
}

module.exports = { startSubscriber, eventStore };
