import 'package:flutter/material.dart';

import 'seller/widgets/seller_scaffold.dart';
import 'seller/features/dashboard/dashboard_page.dart';
import 'seller/features/products/product_list_page.dart';
import 'seller/features/products/product_form_page.dart';
import 'seller/features/orders/orders_list_page.dart';
import 'seller/features/orders/order_details_page.dart';
import 'seller/features/inventory/inventory_page.dart';
import 'seller/features/payments/earnings_page.dart';
import 'seller/features/reviews/reviews_page.dart';
import 'seller/features/profile/profile_settings_page.dart';
import 'seller/features/notifications/notifications_page.dart';
import 'seller/features/support/support_page.dart';

void main() {
  runApp(const SellerApp());
}

class SellerApp extends StatelessWidget {
  const SellerApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Seller Console',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.indigo),
        useMaterial3: true,
        filledButtonTheme: FilledButtonThemeData(
          style: ButtonStyle(
            backgroundColor: const WidgetStatePropertyAll(Color(0xFF8D00DE)),
            foregroundColor: WidgetStatePropertyAll(Colors.white),
          ),
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: const WidgetStatePropertyAll(Color(0xFF8D00DE)),
            foregroundColor: WidgetStatePropertyAll(Colors.white),
          ),
        ),
        outlinedButtonTheme: OutlinedButtonThemeData(
          style: ButtonStyle(
            foregroundColor: const WidgetStatePropertyAll(Color(0xFF8D00DE)),
            side: const WidgetStatePropertyAll(BorderSide(color: Color(0xFF8D00DE))),
          ),
        ),
        textButtonTheme: TextButtonThemeData(
          style: ButtonStyle(
            foregroundColor: const WidgetStatePropertyAll(Color(0xFF8D00DE)),
          ),
        ),
      ),
      initialRoute: DashboardPage.routeName,
      routes: {
        DashboardPage.routeName: (_) => const SellerScaffold(child: DashboardPage()),
        ProductListPage.routeName: (_) => const SellerScaffold(child: ProductListPage()),
        ProductFormPage.createRouteName: (_) => const SellerScaffold(child: ProductFormPage()),
        OrdersListPage.routeName: (_) => const SellerScaffold(child: OrdersListPage()),
        OrderDetailsPage.routeName: (_) => const SellerScaffold(child: OrderDetailsPage()),
        InventoryPage.routeName: (_) => const SellerScaffold(child: InventoryPage()),
        EarningsPage.routeName: (_) => const SellerScaffold(child: EarningsPage()),
        ReviewsPage.routeName: (_) => const SellerScaffold(child: ReviewsPage()),
        ProfileSettingsPage.routeName: (_) => const SellerScaffold(child: ProfileSettingsPage()),
        NotificationsPage.routeName: (_) => const SellerScaffold(child: NotificationsPage()),
        SupportPage.routeName: (_) => const SellerScaffold(child: SupportPage()),
      },
    );
  }
}
