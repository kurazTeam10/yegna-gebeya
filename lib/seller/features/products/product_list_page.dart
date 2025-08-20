import 'package:flutter/material.dart';

import 'product_form_page.dart';

class ProductListPage extends StatelessWidget {
  const ProductListPage({super.key});

  static const String routeName = '/products';

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> products = List.generate(8, (i) => {
      'name': 'Product ${i + 1}',
      'price': 19.99 + i,
      'stock': 10 * (i + 1),
      'active': i % 2 == 0,
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('Products', style: Theme.of(context).textTheme.titleLarge),
            FilledButton.icon(
              onPressed: () => Navigator.of(context).pushNamed(ProductFormPage.createRouteName),
              icon: const Icon(Icons.add),
              label: const Text('Add Product'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        Expanded(
          child: Card(
            child: SingleChildScrollView(
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Name')),
                  DataColumn(label: Text('Price')),
                  DataColumn(label: Text('Stock')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Actions')),
                ],
                rows: [
                  for (final p in products)
                    DataRow(cells: [
                      DataCell(Text(p['name'] as String)),
                      DataCell(Text('\$${(p['price'] as num).toStringAsFixed(2)}')),
                      DataCell(Text('${p['stock']}')),
                      DataCell(Chip(
                        label: Text((p['active'] as bool) ? 'Active' : 'Inactive'),
                        color: WidgetStatePropertyAll((p['active'] as bool) ? Colors.green.shade50 : Colors.grey.shade200),
                      )),
                      DataCell(Row(
                        children: [
                          IconButton(
                            icon: const Icon(Icons.edit_outlined),
                            onPressed: () => Navigator.of(context).pushNamed(ProductFormPage.editRouteName, arguments: p),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_outline),
                            onPressed: () {},
                          ),
                        ],
                      )),
                    ]),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}


