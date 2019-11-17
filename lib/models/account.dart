class Account {
  Account(this.uid);

  String uid;

  void dispose() {
    print('disposed');
  }
}
