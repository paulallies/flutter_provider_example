import 'package:flutter/material.dart';
import 'package:flutter_provider_login/blocs/auth.dart';
import 'package:flutter_provider_login/repositories/user.dart';
import 'package:flutter_provider_login/views/home.dart';
import 'package:flutter_provider_login/views/loading_indicator.dart';
import 'package:flutter_provider_login/views/login.dart';
import 'package:flutter_provider_login/views/splash.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(App(userRepository: UserRepository()));
}

class App extends StatelessWidget {
  UserRepository _userRepository;
  App({@required userRepository}) {
    _userRepository = userRepository;
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<AuthBloc>(
            builder: (context) => AuthBloc(userRepository: _userRepository)),
      ],
      child: MaterialApp(
        home: Consumer<AuthBloc>(builder: (context, authBloc, _) {
          if (authBloc.authState == AuthState.Uninitialized) {
            return SplashScreen();
          }

          if (authBloc.authState == AuthState.UnAuthenticated) {
            return LoginScreen();
          }

          if (authBloc.authState == AuthState.Authenticated) {
            return HomeScreen();
          }

          if (authBloc.authState == AuthState.AuthLoading) {
            return LoadingIndicator();
          }

          return LoadingIndicator();
        }),
      ),
    );
  }
}
