import 'package:flutter/material.dart';

import '../features/dashboard/dashboard_page.dart';
import '../features/products/product_list_page.dart';
import '../features/orders/orders_list_page.dart';
import '../features/inventory/inventory_page.dart';
import '../features/payments/earnings_page.dart';
import '../features/reviews/reviews_page.dart';
import '../features/notifications/notifications_page.dart';
import '../features/profile/profile_settings_page.dart';
import '../features/support/support_page.dart';

class NavItem {
  const NavItem({
    required this.icon,
    required this.label,
    required this.routeName,
    required this.pageType,
  });

  final IconData icon;
  final String label;
  final String routeName;
  final Type pageType;
}

class SellerScaffold extends StatelessWidget {
  const SellerScaffold({super.key, required this.child});

  final Widget child;

  static final List<NavItem> _navItems = <NavItem>[
    NavItem(
      icon: Icons.dashboard_outlined,
      label: 'Dashboard',
      routeName: DashboardPage.routeName,
      pageType: DashboardPage,
    ),
    NavItem(
      icon: Icons.inventory_2_outlined,
      label: 'Products',
      routeName: ProductListPage.routeName,
      pageType: ProductListPage,
    ),
    NavItem(
      icon: Icons.receipt_long_outlined,
      label: 'Orders',
      routeName: OrdersListPage.routeName,
      pageType: OrdersListPage,
    ),
    NavItem(
      icon: Icons.warehouse_outlined,
      label: 'Inventory',
      routeName: InventoryPage.routeName,
      pageType: InventoryPage,
    ),
    NavItem(
      icon: Icons.account_balance_wallet_outlined,
      label: 'Earnings',
      routeName: EarningsPage.routeName,
      pageType: EarningsPage,
    ),
    NavItem(
      icon: Icons.reviews_outlined,
      label: 'Reviews',
      routeName: ReviewsPage.routeName,
      pageType: ReviewsPage,
    ),
    NavItem(
      icon: Icons.notifications_outlined,
      label: 'Notifications',
      routeName: NotificationsPage.routeName,
      pageType: NotificationsPage,
    ),
    NavItem(
      icon: Icons.person_outline,
      label: 'Profile',
      routeName: ProfileSettingsPage.routeName,
      pageType: ProfileSettingsPage,
    ),
    NavItem(
      icon: Icons.help_outline,
      label: 'Support',
      routeName: SupportPage.routeName,
      pageType: SupportPage,
    ),
  ];

  int _selectedIndexForChild(Widget pageChild) {
    final Type t = pageChild.runtimeType;
    final int index = _navItems.indexWhere((n) => n.pageType == t);
    return index >= 0 ? index : 0;
  }

  String _titleForIndex(int index) {
    if (index < 0 || index >= _navItems.length) return 'Seller';
    return _navItems[index].label;
  }

  void _onDestinationSelected(BuildContext context, int index, int selected) {
    if (index == selected) return;
    Navigator.of(context).pushReplacementNamed(_navItems[index].routeName);
  }

  @override
  Widget build(BuildContext context) {
    final int selectedIndex = _selectedIndexForChild(child);

    return LayoutBuilder(
      builder: (context, constraints) {
        final bool useRail = constraints.maxWidth >= 900;
        final Widget content = Scaffold(
          appBar: AppBar(
            title: Text(_titleForIndex(selectedIndex)),
            actions: [
              IconButton(
                icon: const Icon(Icons.notifications_outlined),
                onPressed: () {
                  if (selectedIndex != _navItems.indexWhere((n) => n.routeName == NotificationsPage.routeName)) {
                    Navigator.of(context).pushReplacementNamed(NotificationsPage.routeName);
                  }
                },
              ),
            ],
          ),
          drawer: useRail ? null : Drawer(
            child: SafeArea(
              child: ListView(
                children: [
                  const DrawerHeader(
                    child: ListTile(
                      leading: CircleAvatar(child: Icon(Icons.storefront)),
                      title: Text('Seller Console'),
                      subtitle: Text('Manage your store'),
                    ),
                  ),
                  for (int i = 0; i < _navItems.length; i++)
                    ListTile(
                      leading: Icon(_navItems[i].icon),
                      title: Text(_navItems[i].label),
                      selected: i == selectedIndex,
                      onTap: () {
                        Navigator.of(context).pop();
                        _onDestinationSelected(context, i, selectedIndex);
                      },
                    ),
                ],
              ),
            ),
          ),
          body: Row(
            children: [
              if (useRail)
                NavigationRail(
                  selectedIndex: selectedIndex,
                  labelType: NavigationRailLabelType.all,
                  destinations: [
                    for (final n in _navItems)
                      NavigationRailDestination(
                        icon: Icon(n.icon),
                        selectedIcon: Icon(n.icon, color: Theme.of(context).colorScheme.primary),
                        label: Text(n.label),
                      ),
                  ],
                  onDestinationSelected: (i) => _onDestinationSelected(context, i, selectedIndex),
                ),
              Expanded(
                child: ColoredBox(
                  color: Theme.of(context).colorScheme.surface,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: child,
                  ),
                ),
              ),
            ],
          ),
        );

        return content;
      },
    );
  }
}


