# Real-Time Sales Ops Command Center

A high-performance real-time monitoring and management system for Salesforce Sales Operations, leveraging event-driven architecture and a Node.js middleware.

## 🚀 Key Technologies

### 1. Change Data Capture (CDC)
The project utilizes **Salesforce CDC** to capture data changes on core objects (`Account`, `Contact`, `Opportunity`).
- **Real-time Feedback**: Any field update, creation, or deletion in Salesforce is immediately published to the event bus.
- **Node.js Integration**: A dedicated [cdc-node-server](./cdc-node-server) subscribes to these events using the Streaming API (`jsforce`), providing a bridge for external processing.

### 2. Platform Events
Implemented for **bidirectional communication** between the Command Center and Salesforce.
- **Custom Alerts**: The system publishes Platform Events to trigger custom notifications and automated workflows within the Salesforce UI.
- **Workflow Triggers**: Events from the middleware can initiate Apex logic or Flow executions.

### 3. Lightning Message Service (LMS)
Used for **internal orchestration** between decoupled Lightning Web Components.
- **Shared State**: Components like `dealKanbanBoard` and `cdcFeedPanel` communicate seamlessly without being parent-child related.
- **Unified Experience**: Ensures that the activity feed and status badges react instantly to user interactions within the app.

## 🏗 Project Structure

- **`force-app/`**: Contains the Salesforce metadata (LWCs, Apex Classes, Triggers, Message Channels).
- **`cdc-node-server/`**: A Node.js backend using Express and jsforce to handle high-frequency event streaming.

## 🛠 Setup & Installation

1. **Salesforce**: Deploy the source to your scratch org or sandbox:
   ```bash
   sf project deploy start
   ```
2. **Middleware**:
   ```bash
   cd cdc-node-server
   npm install
   npm start
   ```
   *Ensure you configure your `.env` file with Salesforce credentials.*

## 🔒 Security Note
This project contains placeholders for API keys. Always use environment variables or Named Credentials for sensitive information.
