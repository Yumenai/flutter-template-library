import 'package:flutter/material.dart';

Widget? _infoComponent({
  required final Widget? infoIconPrefix,
  required final Widget? infoIconSuffix,
  required final String? infoTitle,
  final Color? foregroundColor,
}) {
  final titleWidgetList = <Widget> [];

  if (infoIconPrefix is Widget) {
    titleWidgetList.add(infoIconPrefix);
    titleWidgetList.add(const SizedBox(
      width: 8,
    ));
  }

  if (infoTitle?.isNotEmpty == true) {
    titleWidgetList.add(Text(
      infoTitle ?? '',
      style: TextStyle(
        color: foregroundColor,
      ),
    ));
  }

  if (infoIconSuffix is Widget) {
    titleWidgetList.add(const SizedBox(
      width: 8,
    ));
    titleWidgetList.add(infoIconSuffix);
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

class ScreenTemplateComponent extends StatelessWidget {
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

  const ScreenTemplateComponent({
    Key? key,
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
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: _infoComponent(
          infoIconPrefix: infoIconPrefix,
          infoIconSuffix: infoIconSuffix,
          infoTitle: infoTitle,
        ),
        actions: infoActionList,
        backgroundColor: enableOverlapHeader ? Colors.transparent : null,
        elevation: enableOverlapHeader ? 0 : null,
        centerTitle: true,
        foregroundColor: foregroundColor,
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
  }
}

class CollapsibleScreenTemplateComponent extends StatelessWidget {
  final String? infoTitle;
  final Widget? infoIconPrefix;
  final Widget? infoIconSuffix;
  final List<Widget>? infoActionList;
  final Widget? infoBackground;

  final Widget? layout;
  final Widget? layoutAction;

  final Widget? navigatorLeft;
  final Widget? navigatorRight;
  final Widget? navigatorBottom;

  final Color? foregroundColor;
  final Color? backgroundColor;

  const CollapsibleScreenTemplateComponent({
    Key? key,
    this.infoTitle,
    this.infoIconPrefix,
    this.infoIconSuffix,
    this.infoActionList,
    this.infoBackground,
    this.layout,
    this.layoutAction,
    this.navigatorLeft,
    this.navigatorRight,
    this.navigatorBottom,
    this.foregroundColor,
    this.backgroundColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final topSpacing = MediaQuery.of(context).padding.top + kToolbarHeight - 16;

    return Scaffold(
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
                expandedHeight: MediaQuery.of(context).size.width,
                foregroundColor: foregroundColor,
                flexibleSpace: FlexibleSpaceBar(
                  title: LayoutBuilder(
                    builder: (context, constraint) {
                      final opacity = topSpacing / constraint.constrainHeight();

                      return Opacity(
                        opacity: opacity < 0.5 ? 0 : opacity,
                        child: _infoComponent(
                          infoIconPrefix: infoIconPrefix,
                          infoIconSuffix: infoIconSuffix,
                          infoTitle: infoTitle,
                          foregroundColor: Theme.of(context).colorScheme.onSurface,
                        ),
                      );
                    },
                  ),
                  centerTitle: true,
                  background: infoBackground,
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
            child: layout,
          ),
        ),
      ),
      floatingActionButton: layoutAction,
      drawer: navigatorLeft,
      endDrawer: navigatorRight,
      bottomNavigationBar: navigatorBottom,
    );
  }
}
