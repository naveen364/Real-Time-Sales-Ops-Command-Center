trigger Notification on Notification__e (after insert) {
    
    system.debug('Test Chunck '+Trigger.new.size());

}