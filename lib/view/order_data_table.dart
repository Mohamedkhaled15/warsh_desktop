// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:lastbox_accounting_app/objectbox.g.dart';
import 'package:lastbox_accounting_app/view/homeView.dart';


import '../model/entities.dart';
import 'order_details.dart';
class OrderDataTable extends StatefulWidget {
  final List<CustomerOrder> orders;
  final Store store;

  final void Function(int columnIndex,bool ascending) onSort;

  const OrderDataTable({Key? key,
    required this.orders,
    required this.onSort,
    required this.store

  }) : super(key: key);

  @override
  State<OrderDataTable> createState() => _OrderDataTableState();
}

class _OrderDataTableState extends State<OrderDataTable> {
HomePage controller=HomePage();
  bool _sortAscending = true;
  int _sortColumnIndex=0;
  // String info=

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
        child: SingleChildScrollView(
          child: DataTable(
            headingRowColor:  MaterialStateProperty.resolveWith<Color?>((Set<MaterialState> states) {
              if (states.contains(MaterialState.hovered)) {
                return Theme.of(context).colorScheme.primary.withOpacity(0.8);
              }
              return Colors.cyan;  // Use the default value.
            }),

            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(20),

            ),
            sortColumnIndex: _sortColumnIndex,
            sortAscending: _sortAscending,
            dividerThickness: 2,
            headingTextStyle:const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              fontSize: 25
            ) ,
            dataTextStyle: const TextStyle(
              color: Colors.black,
                  fontWeight: FontWeight.bold
            ),

            columns: [

              DataColumn(label: Container()),

              DataColumn(label: const Text('التاريخ'),
              onSort:_onDataColumnSort,
              ),
              DataColumn(label: const Text('تفاصيل'),
              onSort:_onDataColumnSort,
              ),
              DataColumn(label: const Text('الإجمالي'),
              onSort:_onDataColumnSort,
              ),
              DataColumn(label: const Text('رقم الهاتف'),
              onSort:_onDataColumnSort,
              ),
              DataColumn(label: const Text('إسم العميل'),
                onSort:_onDataColumnSort,
              ),
              DataColumn(label: const Text('رقم'),
                onSort:_onDataColumnSort,
              ),
            ],
            rows: widget.orders.map((order){
              return DataRow(

                    cells: [

                      DataCell(
                          Icon(Icons.delete),
                          onTap: (){
                            widget.store.box<CustomerOrder>().remove(order.id);
                          }
                      ),
                      DataCell(Text(order.date)),
                      DataCell(Text(order.customer.target?.details?? "None" ),),
                      DataCell(Text('\$${order.price}'),),
                      DataCell(Text(order.customer.target?.phone??'None'),),
                      DataCell(Text(order.customer.target?.name??'None'),
                          onTap: (){
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => OrderDetailsScreen(
                                    orders: order.customer.target!.orders),
                              ),
                            );
                            // showModalBottomSheet(
                            //
                            //   context: context,
                            //   builder: (context) {
                            //     return Material(
                            //       child: ListView(
                            //         children: order.customer.target!.orders
                            //             .map((_) => ListTile(
                            //             title: Text(
                            //               '${_.id}    ${_.customer.target?.name}    \$${_.price}',
                            //             ),
                            //           ),
                            //         ).toList(),
                            //       ),
                            //     );
                            //   },
                            // );

                          }
                      ),
                      DataCell(Text((order.customer.target?.id?? 0).toString()),),

                    ]
                );

            }).toList(),

          ),
        ),

    );
  }

  void _onDataColumnSort(int columnIndex, bool ascending) {
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
    widget.onSort(columnIndex, ascending);
  }
}
