import 'package:flutter/material.dart';

import '../../data/configuration_data.dart';
import '../../component/button/icon_button_component.dart';
import '../../provider/app_provider.dart';

class ScreenTemplateView extends StatelessWidget {
  final String? infoTitle;
  final Widget? infoIconPrefix;
  final Widget? infoIconSuffix;
  final List<Widget>? infoActionList;

  final Widget? layout;
  final Widget? layoutAction;

  final Widget? navigatorLeft;
  final Widget? navigatorRight;
  final Widget? navigatorBottom;

  final Color? foregroundColor;
  final Color? backgroundColor;
  final bool enableOverlapHeader;

  final void Function()? onBackOverride;

  const ScreenTemplateView({
    super.key,
    this.infoTitle,
    this.infoIconPrefix,
    this.infoIconSuffix,
    this.infoActionList,
    this.layout,
    this.layoutAction,
    this.navigatorLeft,
    this.navigatorRight,
    this.navigatorBottom,
    this.foregroundColor,
    this.backgroundColor,
    this.enableOverlapHeader = false,
    this.onBackOverride,
  });

  @override
  Widget build(BuildContext context) {
    final component = Scaffold(
      appBar: AppBar(
        title: _infoComponent(
          iconPrefix: infoIconPrefix,
          iconSuffix: infoIconSuffix,
          title: infoTitle,
          foregroundColor: foregroundColor,
        ),
        actions: infoActionList,
        foregroundColor: foregroundColor,
        backgroundColor: enableOverlapHeader ? Colors.transparent : backgroundColor,
        elevation: enableOverlapHeader ? 0 : null,
        leading: onBackOverride == null ? null : IconButtonComponent(
          hint: 'Back',
          icon: const Icon(Icons.arrow_back),
          onPressed: onBackOverride ?? () {},
        ),
        centerTitle: true,
      ),
      backgroundColor: backgroundColor,
      extendBodyBehindAppBar: enableOverlapHeader,
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: layout,
      ),
      floatingActionButton: layoutAction,
      drawer: navigatorLeft,
      endDrawer: navigatorRight,
      bottomNavigationBar: navigatorBottom,
    );

    final navigateComponent = onBackOverride == null ? component : WillPopScope(
      onWillPop: () async {
        onBackOverride?.call();
        return false;
      },
      child: component,
    );

    if (ConfigurationData.isTestMode) {
      return _EnvironmentBannerView(navigateComponent);
    } else {
      return navigateComponent;
    }
  }
}

class CollapsibleScreenTemplate extends StatelessWidget {
  final String? infoTitle;
  final Widget? infoIconPrefix;
  final Widget? infoIconSuffix;
  final List<Widget>? infoActionList;
  final Widget? infoBackground;
  final double? infoBackgroundHeight;

  final Widget? layout;
  final Widget? layoutAction;

  final Widget? navigatorLeft;
  final Widget? navigatorRight;
  final Widget? navigatorBottom;

  final Color? foregroundColor;
  final Color? backgroundColor;
  final CollapseMode collapseMode;

  final void Function()? onBackOverride;

  const CollapsibleScreenTemplate({
    super.key,
    this.infoTitle,
    this.infoIconPrefix,
    this.infoIconSuffix,
    this.infoActionList,
    this.infoBackground,
    this.infoBackgroundHeight,
    this.layout,
    this.layoutAction,
    this.navigatorLeft,
    this.navigatorRight,
    this.navigatorBottom,
    this.foregroundColor,
    this.backgroundColor,
    this.collapseMode = CollapseMode.pin,
    this.onBackOverride,
  });

  @override
  Widget build(BuildContext context) {
    final topSpacing = MediaQuery.of(context).padding.top + kToolbarHeight - 16;

    final component = Scaffold(
      backgroundColor: backgroundColor,
      body: NestedScrollView(
        headerSliverBuilder: (context, isInnerBoxScrolled) {
          return [
            SliverOverlapAbsorber(
              handle: NestedScrollView.sliverOverlapAbsorberHandleFor(context),
              sliver: SliverAppBar(
                pinned: true,
                floating: false,
                actions: infoActionList,
                automaticallyImplyLeading: false,
                leading: Navigator.canPop(context) ? UnconstrainedBox(
                  child: IconButtonComponent(
                    icon: const Icon(Icons.arrow_back_rounded),
                    hint: 'Back',
                    size: 38,
                    margin: EdgeInsets.zero,
                    style: IconButtonStyle.elevated,
                    onPressed: onBackOverride ?? () => Navigator.pop(context),
                  ),
                ) : null,
                expandedHeight: infoBackgroundHeight ?? MediaQuery.of(context).size.width * 2 / 3,
                foregroundColor: foregroundColor,
                backgroundColor: backgroundColor,
                flexibleSpace: FlexibleSpaceBar(
                  title: LayoutBuilder(
                    builder: (context, constraint) {
                      final opacity = topSpacing / constraint.constrainHeight();

                      return Opacity(
                        opacity: opacity < 0.5 ? 0 : opacity,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            const SizedBox(
                              width: kToolbarHeight,
                            ),
                            Expanded(
                              child: _infoComponent(
                                iconPrefix: infoIconPrefix,
                                iconSuffix: infoIconSuffix,
                                title: infoTitle,
                                foregroundColor: foregroundColor ?? Theme.of(context).colorScheme.onSurface,
                              ) ?? const SizedBox(),
                            ),
                            const SizedBox(
                              width: kToolbarHeight,
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                  centerTitle: true,
                  background: infoBackground,
                  collapseMode: collapseMode,
                ),
              ),
            ),
          ];
        },
        body: Padding(
          padding: const EdgeInsets.only(
            top: kToolbarHeight,
          ),
          child: GestureDetector(
            onTap: () {
              FocusScope.of(context).unfocus();
            },
            child: SafeArea(
              child: layout ?? const SizedBox(),
            ),
          ),
        ),
      ),
      floatingActionButton: layoutAction,
      drawer: navigatorLeft,
      endDrawer: navigatorRight,
      bottomNavigationBar: navigatorBottom,
    );

    final navigateComponent = onBackOverride == null ? component : WillPopScope(
      onWillPop: () async {
        onBackOverride?.call();
        return false;
      },
      child: component,
    );

    if (ConfigurationData.isTestMode) {
      return _EnvironmentBannerView(navigateComponent);
    } else {
      return navigateComponent;
    }
  }
}

class _EnvironmentBannerView extends StatelessWidget {
  final Widget child;

  const _EnvironmentBannerView(this.child);

  @override
  Widget build(BuildContext context) {
    final environment = AppProvider.of(context).environment;

    return Banner(
      location: BannerLocation.topStart,
      message: environment.code,
      color: environment.color,
      child: child,
    );
  }
}

Widget? _infoComponent({
  required final String? title,
  required final Widget? iconPrefix,
  required final Widget? iconSuffix,
  final Color? foregroundColor,
}) {
  final titleWidgetList = <Widget> [];

  if (iconPrefix is Widget) {
    titleWidgetList.add(iconPrefix);
    titleWidgetList.add(const SizedBox(
      width: 8,
    ));
  }

  if (title?.isNotEmpty == true) {
    titleWidgetList.add(Text(
      title ?? '',
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: foregroundColor,
      ),
    ));
  }

  if (iconSuffix is Widget) {
    titleWidgetList.add(const SizedBox(
      width: 8,
    ));
    titleWidgetList.add(iconSuffix);
  }

  if (titleWidgetList.isEmpty) {
    return null;
  } else if (titleWidgetList.length > 1) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: titleWidgetList,
    );
  } else {
    return titleWidgetList.first;
  }
}
