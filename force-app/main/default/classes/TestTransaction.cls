public with sharing class TestTransaction {
  public static void test() {
    if (Schema.sObjectType.Account.fields.Name.isCreateable()) {
      Account acct = new Account(name = 'TRX test');
      insert acct;
    }

    try {
      // Unhandled Exception
      throw new MyException();
    } catch (Exception e) {
      System.debug(e.getMessage());
    }
  }
}
