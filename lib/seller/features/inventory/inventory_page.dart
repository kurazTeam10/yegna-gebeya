import 'package:flutter/material.dart';

class InventoryPage extends StatefulWidget {
  const InventoryPage({super.key});

  static const String routeName = '/inventory';

  @override
  State<InventoryPage> createState() => _InventoryPageState();
}

class _InventoryPageState extends State<InventoryPage> {
  late List<Map<String, dynamic>> items;

  @override
  void initState() {
    super.initState();
    items = List.generate(15, (i) => {
      'name': 'Product ${i + 1}',
      'stock': 3 + i,
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Inventory', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        Expanded(
          child: Card(
            child: ListView.separated(
              itemCount: items.length,
              separatorBuilder: (_, __) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final Map<String, dynamic> item = items[index];
                final bool low = (item['stock'] as int) <= 5;
                return ListTile(
                  title: Text(item['name'] as String),
                  subtitle: low ? const Text('Low stock', style: TextStyle(color: Colors.red)) : null,
                  trailing: SizedBox(
                    width: 160,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.remove_circle_outline),
                          onPressed: () => setState(() => item['stock'] = (item['stock'] as int) - 1),
                        ),
                        Text('${item['stock']}'),
                        IconButton(
                          icon: const Icon(Icons.add_circle_outline),
                          onPressed: () => setState(() => item['stock'] = (item['stock'] as int) + 1),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        const SizedBox(height: 12),
        Align(
          alignment: Alignment.centerRight,
          child: FilledButton.icon(
            onPressed: () {
              // Fake bulk update
              setState(() {
                for (final item in items) {
                  item['stock'] = (item['stock'] as int) + 5;
                }
              });
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Bulk quantities updated')));
            },
            icon: const Icon(Icons.upload_outlined),
            label: const Text('Bulk Update'),
          ),
        ),
      ],
    );
  }
}


