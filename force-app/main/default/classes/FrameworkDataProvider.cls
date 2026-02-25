public interface FrameworkDataProvider {
    /**
     * @description Fetches data for the component.
     * @param params Map containing context like 'recordId', 'objectApiName', etc.
     * @return Map<String, Object> Data to be bound to the UI.
     */
    Map<String, Object> getData(Map<String, Object> params);

    /**
     * @description Executes an action (e.g. Save, Callout).
     * @param actionName Name of the action to execute.
     * @param data The current state/data from the UI.
     * @return Map<String, Object> Result of the action (success, message, updatedData).
     */
    Map<String, Object> executeAction(String actionName, Map<String, Object> data);
}