import 'package:flutter/material.dart';

class NotificationsPage extends StatelessWidget {
  const NotificationsPage({super.key});

  static const String routeName = '/notifications';

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> notifications = [
      {'title': 'Order #1023 shipped', 'body': 'Tracking ID: XX1234'},
      {'title': 'Low stock alert', 'body': 'Product A is below threshold'},
      {'title': 'Payout processed', 'body': '\$400.00 sent to your bank'},
      {'title': 'System', 'body': 'New terms and conditions updated'},
    ];

    return ListView(
      children: [
        Text('Notifications', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        Card(
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: notifications.length,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final Map<String, String> n = notifications[index];
              return ListTile(
                leading: const Icon(Icons.notifications_outlined),
                title: Text(n['title'] ?? ''),
                subtitle: Text(n['body'] ?? ''),
                trailing: IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz)),
              );
            },
          ),
        ),
      ],
    );
  }
}


