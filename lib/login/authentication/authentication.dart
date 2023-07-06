import 'package:authentication_repository/authentication_repository.dart';
import 'package:blocdocplay/login/authentication/bloc/authentication_bloc.dart';
import 'package:blocdocplay/login/authentication/login/view/login_page.dart';
import 'package:blocdocplay/login/authentication/splash/view/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_repository/user_repository.dart';
import 'home/view/home_page.dart';

class BlocAuthapp extends StatefulWidget {
  const BlocAuthapp({super.key});

  @override
  State<BlocAuthapp> createState() => _BlocAuthappState();
}

class _BlocAuthappState extends State<BlocAuthapp> {
  late final AuthenticationRepository _authenticationRepository;
  late final UserRepository _userRepository;

  @override
  void initState() {
    super.initState();
    _authenticationRepository = AuthenticationRepository();
    _userRepository = UserRepository();
  }

  @override
  void dispose() {
    _authenticationRepository.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepositoryProvider.value(
      value: _authenticationRepository,
      child: BlocProvider(
        create: (_) => AuthenticationBloc(
          authenticationRepository: _authenticationRepository,
          userRepository: _userRepository,
        ),
        child: const AppView(),
      ),
    );
  }
}

class AppView extends StatefulWidget {
  const AppView({super.key});

  @override
  State<AppView> createState() => _AppViewState();
}

class _AppViewState extends State<AppView> {
  final _navigatorKey = GlobalKey<NavigatorState>();

  NavigatorState get _navigator => _navigatorKey.currentState!;
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: _navigatorKey,
      builder: (context, child) {
        return BlocListener<AuthenticationBloc, AuthenticationState>(
          listener: (context, state) {
            switch (state.status) {
              case AuthenticationStatus.authenticated:
                _navigator.pushAndRemoveUntil<void>(
                  // Todo homepage
                  HomePage.route(), (route) => false,
                );
              case AuthenticationStatus.unauthenticated:
                _navigator.pushAndRemoveUntil(
                  // TODO login page
                  LoginPage.route(), (route) => false,
                );

              case AuthenticationStatus.unknown:
                break;
            }
          },
          child: child,
        );
      },
      onGenerateRoute: (_) => Splashpage.route(),
    );
  }
}
