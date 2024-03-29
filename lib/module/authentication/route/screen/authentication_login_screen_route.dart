import 'package:flutter/material.dart';

import '../../../../component/button/text_button_component.dart';
import '../../../../component/input/text_input_component.dart';
import '../../../../view/template/screen_template_view.dart';
import '../../../../component/view/image_view_component.dart';
import '../../../../provider/app_provider.dart';
import '../../../../utility/app_utility.dart';
import '../controller/authentication_login_controller_route.dart';

class AuthenticationLoginScreenRoute extends StatelessWidget {
  final AuthenticationLoginControllerRoute controller;

  const AuthenticationLoginScreenRoute({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenTemplateView(
      layout: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.all(24),
          children: [
            SizedBox.square(
              dimension: 150,
              child: ImageViewComponent.asset(
                AppProvider.listen(context).image.appSplash,
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            const Text(
              'Authenticate',
              style: TextStyle(
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 12,
            ),
            FutureBuilder(
              future: AppUtility.name,
              builder: (context, asyncSnapshot) {
                return Text(
                  asyncSnapshot.data ?? '',
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                );
              },
            ),
            const SizedBox(
              height: 12,
            ),
            Form(
              key: controller.form.formStateKey,
              child: Column(
                children: [
                  TextInputComponent(
                    label: 'ID',
                    controller: controller.form.idInputController,
                    onValidate: controller.form.validateId,
                  ),
                  SecureTextInputComponent(
                    label: 'Password',
                    controller: controller.form.passwordInputController,
                    onValidate: controller.form.validatePassword,
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            TextButtonComponent.submit(
              title: 'Sign In',
              style: TextButtonStyle.elevated,
              onPressed: () => controller.signIn(context),
            ),
          ],
        ),
      ),
      enableOverlapHeader: true,
    );
  }
}
