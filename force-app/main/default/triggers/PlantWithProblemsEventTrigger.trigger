trigger PlantWithProblemsEventTrigger on Plant_with_problem__e(after insert) {
  System.debug('Apex subscriber!');
  System.debug(Trigger.new);

  Account acct = new Account(name = 'TRX test');
  insert acct;

  throw new MyException();
}
