class Account {
  Account(this._uid, {bool isFirst = false}) : _isFirst = isFirst;

  String get uid => _uid;
  bool get isFirst => _isFirst;

  String _uid;
  bool _isFirst;

  void markAsRead() => _isFirst = false;
}
