class Account {
  factory Account(String uid, Account old) {
    if (uid == old?.uid) return old;
    old?.dispose();

    if (uid == null) {
      return null;
    } else {
      return Account._(uid);
    }
  }

  Account._(this.uid);

  String uid;

  void dispose() {
    print('disposed');
  }
}
