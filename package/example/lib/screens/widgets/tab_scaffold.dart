import 'package:flutter/material.dart';

class TabDetails {
  final IconData? icon;
  final Color? color;
  final String text;
  final WidgetBuilder builder;

  TabDetails({
    required this.icon,
    this.color,
    required this.text,
    required this.builder,
  });
}

class TabScaffold extends StatefulWidget {
  final AppBar? appBar;
  final int? initialTab;
  final List<TabDetails> tabs;

  TabScaffold({
    super.key,
    this.appBar,
    this.initialTab,
    required this.tabs,
  }) : assert(tabs.isNotEmpty, 'Tabs must not be empty.');

  @override
  State<TabScaffold> createState() => _TabScaffoldState();
}

class _TabScaffoldState extends State<TabScaffold> {
  late int selectedTab = widget.initialTab ?? 0;

  Widget _buildTab(TabDetails tab) {
    return Tab(
      icon: (tab.icon != null) ? Icon(tab.icon, color: tab.color) : null,
      text: tab.text,
    );
  }

  void _changeTab(int index) {
    if (index >= 0 && index < widget.tabs.length) {
      setState(() {
        selectedTab = index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: widget.tabs.length,
      initialIndex: selectedTab,
      child: Scaffold(
        appBar: widget.appBar,
        body: widget.tabs[selectedTab].builder(context),
        bottomNavigationBar: (widget.tabs.length > 1)
            ? TabBar(
                onTap: _changeTab,
                tabs: widget.tabs.map(_buildTab).toList(growable: false),
              )
            : null,
      ),
    );
  }
}
