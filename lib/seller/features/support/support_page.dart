import 'package:flutter/material.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  static const String routeName = '/support';

  @override
  Widget build(BuildContext context) {
    final TextEditingController messageController = TextEditingController();

    return ListView(
      children: [
        Text('Support & Help Center', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('FAQs', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                const ExpansionTile(
                  title: Text('How to add products?'),
                  children: [ListTile(title: Text('Go to Products > Add Product and fill the form.'))],
                ),
                const ExpansionTile(
                  title: Text('How to request payout?'),
                  children: [ListTile(title: Text('Go to Earnings and click Request Payout.'))],
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Contact Admin', style: Theme.of(context).textTheme.titleMedium),
                const SizedBox(height: 8),
                TextField(
                  controller: messageController,
                  maxLines: 4,
                  decoration: const InputDecoration(hintText: 'Describe your issue...'),
                ),
                const SizedBox(height: 8),
                Align(
                  alignment: Alignment.centerLeft,
                  child: FilledButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Ticket submitted')));
                    },
                    child: const Text('Submit Ticket'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}


