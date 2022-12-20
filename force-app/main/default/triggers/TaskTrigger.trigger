/*You craeted a field - CountCalls__c on contact to count unanswered calls.
Write a trigger on task to update the field when task associated with the contack has been created for phone calls
where Activity_Call_Result__c is either 'not home' or 'left message'.*/

trigger TaskTrigger on Task (after insert) {

    //Get task and related cantacts from database that executes trigger and store them in oldTasks varible
    list<Task> oldTasks = [SELECT Id, Contact.CountCalls__c FROM Task WHERE Id IN : Trigger.new];
    
    //Create an empty list to store updated tasks
    list<task> updatedTasks = new List<Task>();

    for(Task t : oldTasks){
        if(t.Activity_Call_Result__c == 'not home' || t.Activity_Call_Result__c == 'left message'){
            Contact.CountCalls__c = Contact.CountCalls__c + 1;
            updatedTasks.add(t);
        }
    }
    update updatedTasks;
}