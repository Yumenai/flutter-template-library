import 'package:flutter/material.dart';

import 'data/authenticate_repository_data.dart';
import 'route/authenticate_directory_route.dart';

class AuthenticateMaster {
  static AuthenticateMaster Function(BuildContext) _of = (context) => AuthenticateMaster();

  static AuthenticateMaster of(final BuildContext context) => _of(context);

  final repository = const AuthenticateRepositoryData();

  AuthenticateDirectoryRoute? directoryRoute;

  AuthenticateMaster();

  void initialise({
    required final AuthenticateMaster Function(BuildContext) provider,
    required final void Function() viewSplash,
  }) {
    _of = provider;
    directoryRoute = AuthenticateDirectoryRoute(
      viewSplash: viewSplash,
    );
  }

  Future<void> clear() async {
    await repository.clear();
  }
}