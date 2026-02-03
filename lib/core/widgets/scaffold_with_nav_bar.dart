import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:unihealthai/core/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ScaffoldWithNavBar extends ConsumerWidget {
  final Widget child;

  const ScaffoldWithNavBar({
    required this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Row(
        children: [
          // Sidebar
          NavigationRail(
            selectedIndex: _calculateSelectedIndex(context),
            onDestinationSelected: (int index) => _onItemTapped(index, context),
            extended:
                MediaQuery.of(context).size.width >= 800, // Responsive sidebar
            backgroundColor: Colors.white,
            selectedIconTheme:
                const IconThemeData(color: AppTheme.primaryGreen),
            unselectedIconTheme: const IconThemeData(color: Colors.grey),
            destinations: const [
              NavigationRailDestination(
                icon: Icon(Icons.dashboard_outlined),
                selectedIcon: Icon(Icons.dashboard),
                label: Text('Dashboard'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.people_outlined),
                selectedIcon: Icon(Icons.people),
                label: Text('Patients'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.chat_bubble_outline),
                selectedIcon: Icon(Icons.chat_bubble),
                label: Text('AI Assistant'),
              ),
              NavigationRailDestination(
                icon: Icon(Icons.settings_outlined),
                selectedIcon: Icon(Icons.settings),
                label: Text('Settings'),
              ),
            ],
          ),
          const VerticalDivider(thickness: 1, width: 1),
          // Main Content
          Expanded(
            child: child,
          ),
        ],
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final String location = GoRouterState.of(context).uri.path;
    if (location.startsWith('/patients')) return 1;
    if (location.startsWith('/ai')) return 2;
    if (location.startsWith('/settings')) return 3;
    if (location.startsWith('/')) return 0;
    return 0;
  }

  void _onItemTapped(int index, BuildContext context) {
    switch (index) {
      case 0:
        context.go('/');
        break;
      case 1:
        context.go('/patients');
        break;
      case 2:
        context.go('/ai');
        break;
      case 3:
        // context.go('/settings'); // TODO: Implement
        break;
    }
  }
}
