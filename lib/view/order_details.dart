// ignore_for_file: prefer_const_constructors

// import 'package:fluent_ui/fluent_ui.dart';

import 'package:flutter/material.dart';

import '../model/entities.dart';

class OrderDetails extends StatefulWidget {
  final List<CustomerOrder> orders;

  const OrderDetails({Key? key, required this.orders}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  get orders => CustomerOrder;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SingleChildScrollView(

        child: DataTable(
          columns: const [
            DataColumn(label: Text('إسم العميل'),

            ),
          ],
          rows: widget.orders.map((order){
            return DataRow(
                cells: [
                  DataCell(Text(order.customer.target?.name??'None'),
                      onTap: (){
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return Material(
                              child: ListView(
                                children: order.customer.target!.orders
                                    .map(
                                      (_) => ListTile(
                                    title: Text(
                                      '${_.id}    ${_.customer.target?.name}    \$${_.price}',
                                    ),
                                  ),
                                )
                                    .toList(),
                              ),
                            );
                          },
                        );

                      }
                  ),
                ]
            );
          }).toList(),
        ),
      ),

    );
  }
}
