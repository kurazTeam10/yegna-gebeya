import 'package:flutter/material.dart';

class ReviewsPage extends StatelessWidget {
  const ReviewsPage({super.key});

  static const String routeName = '/reviews';

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        Text('Reviews & Ratings', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        Card(
          child: ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 10,
            separatorBuilder: (_, __) => const Divider(height: 1),
            itemBuilder: (context, index) {
              return ListTile(
                leading: const CircleAvatar(child: Icon(Icons.person_outline)),
                title: Row(
                  children: [
                    Text('Customer ${index + 1}'),
                    const SizedBox(width: 8),
                    Row(children: List.generate(5, (i) => Icon(i < 4 ? Icons.star : Icons.star_border, color: Colors.amber, size: 18))),
                  ],
                ),
                subtitle: const Text('Great product!'),
                trailing: OutlinedButton(
                  onPressed: () {
                    showDialog(context: context, builder: (context) {
                      final TextEditingController c = TextEditingController();
                      return AlertDialog(
                        title: const Text('Respond to review'),
                        content: TextField(controller: c, maxLines: 3, decoration: const InputDecoration(hintText: 'Write a response...')),
                        actions: [
                          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
                          FilledButton(onPressed: () { Navigator.pop(context); ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Response sent'))); }, child: const Text('Send')),
                        ],
                      );
                    });
                  },
                  child: const Text('Respond'),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}


