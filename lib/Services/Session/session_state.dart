import 'package:logos_messenger/Models/account.dart';

/// Global session manager — a single instance shared across the app.
class SessionState {
  static final SessionState _instance = SessionState._internal();
  factory SessionState() => _instance;
  SessionState._internal();

  Account? _currentAccount;

  Account? get currentAccount => _currentAccount;
  bool get isLoggedIn => _currentAccount != null;

  void setAccount(Account account) {
    _currentAccount = account;
  }

  void clear() {
    _currentAccount = null;
  }
}
