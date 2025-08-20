import 'package:flutter/material.dart';

import 'order_details_page.dart';

class OrdersListPage extends StatelessWidget {
  const OrdersListPage({super.key});

  static const String routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> orders = List.generate(12, (i) => {
      'id': '#ORD${1000 + i}',
      'customer': 'Customer ${i + 1}',
      'items': i % 3 + 1,
      'total': 49.99 + (i * 3),
      'status': ['Pending', 'Processing', 'Shipped', 'Delivered', 'Cancelled'][i % 5],
    });

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text('Orders', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        Expanded(
          child: Card(
            child: SingleChildScrollView(
              child: DataTable(
                columns: const [
                  DataColumn(label: Text('Order ID')),
                  DataColumn(label: Text('Customer')),
                  DataColumn(label: Text('Items')),
                  DataColumn(label: Text('Total')),
                  DataColumn(label: Text('Status')),
                  DataColumn(label: Text('Action')),
                ],
                rows: [
                  for (final o in orders)
                    DataRow(cells: [
                      DataCell(Text(o['id'] as String)),
                      DataCell(Text(o['customer'] as String)),
                      DataCell(Text('${o['items']}')),
                      DataCell(Text('\$${(o['total'] as num).toStringAsFixed(2)}')),
                      DataCell(Text(o['status'] as String)),
                      DataCell(TextButton(
                        onPressed: () => Navigator.of(context).pushNamed(OrderDetailsPage.routeName, arguments: o),
                        child: const Text('View'),
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


