import 'package:flutter/material.dart';

class EarningsPage extends StatelessWidget {
  const EarningsPage({super.key});

  static const String routeName = '/earnings';

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text('Payments & Earnings', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        Wrap(
          spacing: 12,
          runSpacing: 12,
          children: const [
            _EarningCard(title: 'Total Earnings', value: '\$12,420'),
            _EarningCard(title: 'Withdrawable Balance', value: '\$3,200'),
          ],
        ),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerLeft,
          child: FilledButton.icon(
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Payout requested')));
            },
            icon: const Icon(Icons.payments_outlined),
            label: const Text('Request Payout'),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ListTile(
                title: const Text('Payment History'),
                trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.download_outlined)),
              ),
              const Divider(height: 1),
              ...List.generate(8, (i) => ListTile(
                leading: const Icon(Icons.receipt_long_outlined),
                title: Text('Payout #${i + 1}'),
                subtitle: const Text('Completed'),
                trailing: const Text('\$400.00'),
              )),
            ],
          ),
        ),
      ],
    );
  }
}

class _EarningCard extends StatelessWidget {
  const _EarningCard({required this.title, required this.value});

  final String title;
  final String value;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 280,
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


