trigger PlantWithProblemsEventTrigger on Plant_with_problem__e(after insert) {
  System.debug('Apex subscriber!');
  System.debug(Trigger.new);

  if (Schema.sObjectType.Account.fields.Name.isCreateable()) {
    Account acct = new Account(name = 'TRX test');
    insert acct;
  }

  throw new MyException();
}
