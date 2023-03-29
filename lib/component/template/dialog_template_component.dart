import 'package:flutter/material.dart';

class DialogTemplateComponent extends StatelessWidget {
  final String? title;
  final Color? titleColor;
  final String? message;
  final Color? messageColor;
  final Widget? layout;
  final EdgeInsets? layoutPadding;

  final String? actionPositiveTitle;
  final Color? actionPositiveForegroundColor;
  final Color? actionPositiveBackgroundColor;

  final String? actionNegativeTitle;
  final Color? actionNegativeForegroundColor;
  final Color? actionNegativeBackgroundColor;

  final bool enableActionPositive;
  final bool enableActionNegative;

  final bool enableDismissalPositive;
  final bool enableDismissalNegative;

  final void Function()? onTapActionPositive;
  final void Function()? onTapActionNegative;

  const DialogTemplateComponent({
    Key? key,
    this.title,
    this.titleColor,
    this.message,
    this.messageColor,
    this.layout,
    this.layoutPadding = const EdgeInsets.symmetric(
      horizontal: 24,
    ),
    this.actionPositiveTitle,
    this.actionPositiveForegroundColor,
    this.actionPositiveBackgroundColor,
    this.actionNegativeTitle,
    this.actionNegativeForegroundColor,
    this.actionNegativeBackgroundColor,
    this.enableActionPositive = false,
    this.enableActionNegative = false,
    this.enableDismissalPositive = true,
    this.enableDismissalNegative = true,
    this.onTapActionPositive,
    this.onTapActionNegative,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        title ?? 'Alert',
        style: TextStyle(
          color: titleColor,
        ),
      ),
      content: _contentLayout(),
      contentPadding: const EdgeInsets.symmetric(
        vertical: 8,
      ),
      actions: _actionLayout(context),
      actionsPadding: const EdgeInsets.symmetric(
        horizontal: 6,
        vertical: 2,
      ),
      scrollable: true,
      clipBehavior: Clip.antiAlias,
    );
  }

  Widget? _contentLayout() {
    final itemList = <Widget> [];

    if (message?.isNotEmpty == true) {
      itemList.add(Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 24,
        ),
        child: Text(
          message ?? '',
          style: TextStyle(
            color: messageColor,
          ),
        ),
      ));
    }

    if (layout is Widget) {
      itemList.add(Padding(
        padding: layoutPadding ?? const EdgeInsets.all(0),
        child: layout,
      ));
    }

    if (itemList.isEmpty) return null;

    if (itemList.length > 1) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: itemList,
      );
    } else {
      return itemList.first;
    }
  }

  List<Widget>? _actionLayout(final BuildContext context) {
    final itemList = <Widget> [];

    if (enableActionNegative) {
      itemList.add(TextButton(
        style: TextButton.styleFrom(
          foregroundColor: actionNegativeForegroundColor,
          backgroundColor: actionNegativeBackgroundColor,
        ),
        child: Text(actionNegativeTitle ?? 'Dismiss'),
        onPressed: () {
          if (enableDismissalNegative) {
            Navigator.pop(context, false);
          }

          onTapActionNegative?.call();
        },
      ));
    }

    if (enableActionPositive) {
      itemList.add(TextButton(
        style: TextButton.styleFrom(
          foregroundColor: actionPositiveForegroundColor,
          backgroundColor: actionPositiveBackgroundColor,
        ),
        child: Text(actionPositiveTitle ?? 'OK'),
        onPressed: () {
          if (enableDismissalPositive) {
            Navigator.pop(context, true);
          }

          onTapActionPositive?.call();
        },
      ));
    }

    if (itemList.isEmpty) return null;

    return itemList;
  }
}
