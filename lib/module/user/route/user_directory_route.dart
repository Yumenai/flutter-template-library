import '../../../model/route_model.dart';
import '../../../service/route_service.dart';
import 'controller/user_deletion_controller_route.dart';
import 'controller/user_language_controller_route.dart';
import 'controller/user_password_controller_route.dart';
import 'controller/user_profile_controller_route.dart';
import 'controller/user_theme_controller_route.dart';
import 'screen/user_deletion_screen_route.dart';
import 'screen/user_language_screen_route.dart';
import 'screen/user_password_screen_route.dart';
import 'screen/user_profile_screen_route.dart';
import 'screen/user_theme_screen_route.dart';

class UserDirectoryRoute {
  void Function() _viewSplash = () {};
  Future<void> Function() _onDeleteAccount = () async {};

  void initialise({
    required final void Function() viewSplash,
    required final Future<void> Function() onDeleteAccount,
  }) {
    _viewSplash = viewSplash;
    _onDeleteAccount = onDeleteAccount;
  }

  RouteModel get profile => RouteModel(
    onBuild: () => UserProfileScreenRoute(
      controller: UserProfileControllerRoute(),
    ),
    onNavigate: RouteService.push,
  );

  RouteModel get password => RouteModel(
    onBuild: () => UserPasswordScreenRoute(
      controller: UserPasswordControllerRoute(),
    ),
    onNavigate: RouteService.push,
  );

  RouteModel get theme => RouteModel(
    onBuild: () => const UserThemeScreenRoute(
      controller: UserThemeControllerRoute(),
    ),
    onNavigate: RouteService.push,
  );

  RouteModel get language => RouteModel(
    onBuild: () => const UserLanguageScreenRoute(
      controller: UserLanguageControllerRoute(),
    ),
    onNavigate: RouteService.push,
  );

  RouteModel get deletion => RouteModel(
    onBuild: () => UserDeletionScreenRoute(
      controller: UserDeletionControllerRoute(
        viewSplash: _viewSplash,
        onDeleteAccount: _onDeleteAccount,
      ),
    ),
    onNavigate: RouteService.push,
  );
}
