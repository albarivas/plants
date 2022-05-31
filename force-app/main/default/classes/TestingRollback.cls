public with sharing class TestingRollback {
  public static void test() {
    Account acct = new Account(name = 'test2');
    insert acct;

    //Savepoint sp = Database.setSavepoint();
    try {
      throw new PlantException();
    } catch (Exception e) {
      // Database.rollback(sp);
    }
  }
}
