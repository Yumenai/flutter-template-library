import 'package:flutter/material.dart';

import '../module/user/route/user_access_route.dart';
import '../utility/navigator_utility.dart';
import 'controller/authenticate_controller_route.dart';
import 'controller/dashboard_controller_route.dart';
import 'controller/landing_controller_route.dart';
import 'controller/register_controller_route.dart';
import 'controller/splash_controller_route.dart';
import 'screen/authenticate_screen_route.dart';
import 'screen/dashboard_screen_route.dart';
import 'screen/landing_screen_route.dart';
import 'screen/register_screen_route.dart';
import 'screen/splash_screen_route.dart';

class AccessRoute {
  static const screen = _ScreenRoute._();

  static const user = UserAccessRoute();

  static void splash(final BuildContext context) {
    NavigatorUtility.screen.nextSession(
      context,
      screen: const SplashScreenRoute(
        controller: SplashControllerRoute(),
      ),
    );
  }

  static void landing(final BuildContext context) {
    NavigatorUtility.screen.nextSession(
      context,
      screen: const LandingScreenRoute(
        controller: LandingControllerRoute(),
      ),
    );
  }

  static void authenticate(final BuildContext context) {
    NavigatorUtility.screen.next(
      context,
      screen: AuthenticateScreenRoute(
        controller: AuthenticationControllerRoute(),
      ),
    );
  }

  static void register(final BuildContext context) {
    NavigatorUtility.screen.next(
      context,
      screen: RegisterScreenRoute(
        controller: RegisterControllerRoute(),
      ),
    );
  }

  static void dashboard(final BuildContext context) {
    NavigatorUtility.screen.nextSession(
      context,
      screen: const DashboardScreenRoute(
        controller: DashboardControllerRoute(),
      ),
    );
  }

  const AccessRoute._();
}

class _ScreenRoute {
  const _ScreenRoute._();

  Widget get splash => const SplashScreenRoute(
    controller: SplashControllerRoute(),
  );
}
