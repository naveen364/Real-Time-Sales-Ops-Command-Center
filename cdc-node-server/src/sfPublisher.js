'use strict';

const jsforce = require('jsforce');

async function publishSyncEvent(conn, payload) {
    try {
        console.log(`   ↗  Publishing ExternalSync__e back to Salesforce...`);
        
        // Use the SObject create method to publish Platform Events via REST API
        const result = await conn.sobject('ExternalSync__e').create({
            RecordId__c: payload.recordId,
            ObjectType__c: payload.objectType,
            Operation__c: payload.operation,
            SyncTarget__c: 'Node.js External Server',
            Status__c: 'SUCCESS',
            Message__c: `Successfully synced ${payload.objectType} ${payload.recordId} to external database.`,
            SyncedAt__c: new Date().toISOString()
        });

        if (result.success) {
            console.log(`   ✅  Platform Event published! (ID: ${result.id})`);
        } else {
            console.error(`   ❌  Failed to publish Platform Event:`, result.errors);
        }
    } catch (err) {
        console.error(`   ⚠  Error publishing Platform Event:`, err.message);
    }
}

module.exports = { publishSyncEvent };
