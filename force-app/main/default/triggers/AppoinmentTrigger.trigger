trigger AppoinmentTrigger on Appointment__c (before insert) {
	//AppointmentDoctor.doctorPatient(trigger.new);
	AppointmentHandler.doctorPatient(trigger.new);
}