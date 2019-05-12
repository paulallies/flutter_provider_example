import 'package:flutter/foundation.dart';
import 'package:flutter_provider_login/repositories/user.dart';

enum AuthState {
  AuthLoading,
  AuthLoaded,
  UnAuthenticated,
  Authenticated,
  Uninitialized
}

class AuthBloc extends ChangeNotifier {
  UserRepository _userRepository;

  AuthBloc({@required userRepository}) : assert(userRepository != null) {
    _userRepository = userRepository;
  }

  AuthState _authState = AuthState.Uninitialized;

  AuthState get authState => _authState;

  startAuth() async {
    _authState = AuthState.AuthLoading;
    notifyListeners();
    final bool hasToken = await _userRepository.hasToken();
    if (hasToken) {
      _authState = AuthState.Authenticated;
    } else {
      _authState = AuthState.UnAuthenticated;
    }
    notifyListeners();
  }

  logIn({String username, String password}) async {
    _authState = AuthState.AuthLoading;
    notifyListeners();
    var token = await _userRepository.authenticate(
        username: username, password: password);
    await _userRepository.persistToken(token);
    _authState = AuthState.Authenticated;
    notifyListeners();
  }

  logOut() async {
    _authState = AuthState.AuthLoading;
    notifyListeners();
    await _userRepository.deleteToken();
    _authState = AuthState.UnAuthenticated;
    notifyListeners();
  }
}
