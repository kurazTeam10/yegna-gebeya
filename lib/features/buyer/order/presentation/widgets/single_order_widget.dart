import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../domain/models/order.dart';

class SingleOrderWidget extends StatelessWidget {
  final Order order;

  const SingleOrderWidget({super.key, required this.order});

  final Map<bool?, Color> statusColorPair = const {
    null: Color.fromRGBO(222, 18, 0, 0.5),
    true: Color.fromRGBO(44, 222, 0, 0.31),
    false: Color.fromRGBO(222, 215, 0, 0.5),
  };

  final Map<bool?, String> statusStringPair = const {
    null: 'Canceled',
    true: 'Delivered',
    false: 'Pending',
  };

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color.fromRGBO(141, 0, 222, 0.1),
      padding: const EdgeInsets.symmetric(vertical: 18.0, horizontal: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset('assets/images/package.png'),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ID: ${order.orderId}',
                style: TextStyle(color: Color(0xFF8D00DE)),
                overflow: TextOverflow.ellipsis,
              ),
              Text.rich(
                overflow: TextOverflow.ellipsis,
                TextSpan(
                  text: 'Date: ',
                  style: TextStyle(color: Color(0xFF8D00DE)),
                  children: [
                    TextSpan(
                      text: DateFormat('MMM dd, yyyy').format(order.orderDate),
                      style: TextStyle(color: Color(0xFFD08FF5)),
                    ),
                  ],
                ),
              ),
            ],
          ),
          Container(
            decoration: BoxDecoration(
              color: statusColorPair[order.isDelivered],
              borderRadius: BorderRadius.circular(100),
            ),
            padding: EdgeInsets.all(8.0),
            child: Text(statusStringPair[order.isDelivered]!),
          ),
        ],
      ),
    );
  }
}
