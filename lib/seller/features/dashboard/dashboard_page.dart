import 'package:flutter/material.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  static const String routeName = '/';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 👇 full width stat cards stacked vertically
          Column(
            children: const [
              _StatCard(title: "Today's Sales", value: '\$1,240'),
              _StatCard(title: 'Pending Orders', value: '8'),
              _StatCard(title: 'Total Products', value: '124'),
            ],
          ),
          const SizedBox(height: 24),

          Card(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Sales Trend',
                      style: Theme.of(context).textTheme.titleLarge),
                  const SizedBox(height: 12),
                  Container(
                    height: 200,
                    alignment: Alignment.center,
                    child: const Text('Chart placeholder'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),

          Wrap(
            spacing: 12,
            children: [
              FilledButton.icon(
                onPressed: () =>
                    Navigator.of(context).pushNamed('/products/add'),
                icon: const Icon(Icons.add),
                label: const Text('Add Product'),
              ),
              OutlinedButton.icon(
                onPressed: () =>
                    Navigator.of(context).pushNamed('/orders'),
                icon: const Icon(Icons.receipt_long_outlined),
                label: const Text('Manage Orders'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  const _StatCard({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity, // 👈 full width
      child: Card(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: Theme.of(context).textTheme.labelLarge),
              const SizedBox(height: 8),
              Text(value, style: Theme.of(context).textTheme.headlineSmall),
            ],
          ),
        ),
      ),
    );
  }
}
