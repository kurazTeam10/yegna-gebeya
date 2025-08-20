import 'package:flutter/material.dart';

class OrderDetailsPage extends StatefulWidget {
  const OrderDetailsPage({super.key});

  static const String routeName = '/orders/details';

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  String status = 'Pending';

  @override
  Widget build(BuildContext context) {
    final Map<String, dynamic>? order = ModalRoute.of(context)?.settings.arguments as Map<String, dynamic>?;

    return ListView(
      children: [
        Text('Order Details', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Customer', style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 8),
                      const Text('John Doe'),
                      const SizedBox(height: 16),
                      Text('Shipping Address', style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 8),
                      const Text('123 Main St, City, Country'),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Items', style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 8),
                      ...List.generate(3, (i) => const ListTile(
                        title: Text('Product'),
                        trailing: Text('x1  \$25.00'),
                      )),
                      const Divider(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text('Total', style: TextStyle(fontWeight: FontWeight.bold)),
                          Text('\$75.00', style: TextStyle(fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Status', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: status,
                        items: const [
                          DropdownMenuItem(value: 'Pending', child: Text('Pending')),
                          DropdownMenuItem(value: 'Processing', child: Text('Processing')),
                          DropdownMenuItem(value: 'Shipped', child: Text('Shipped')),
                          DropdownMenuItem(value: 'Delivered', child: Text('Delivered')),
                          DropdownMenuItem(value: 'Cancelled', child: Text('Cancelled')),
                        ],
                        onChanged: (v) => setState(() => status = v ?? status),
                      ),
                    ),
                    const SizedBox(width: 12),
                    FilledButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Status updated to $status')));
                      },
                      child: const Text('Update Status'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 16,
                  children: const [
                    _StatusChip(label: 'Pending', isDone: true),
                    _StatusChip(label: 'Processing', isDone: true),
                    _StatusChip(label: 'Shipped', isDone: false),
                    _StatusChip(label: 'Delivered', isDone: false),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.label, required this.isDone});

  final String label;
  final bool isDone;

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(isDone ? Icons.check_circle : Icons.radio_button_unchecked, color: isDone ? Colors.green : Colors.grey),
      label: Text(label),
    );
  }
}


