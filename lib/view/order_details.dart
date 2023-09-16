import 'package:fluent_ui/fluent_ui.dart';
import 'package:lastbox_accounting_app/constant/constant.dart';

import '../model/entities.dart';
import '../objectbox.g.dart';
class OrderDetailsScreen extends StatelessWidget {
  final List<CustomerOrder> orders;

  OrderDetailsScreen({required this.orders});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: MyColors.white,
      child: ScaffoldPage(
        resizeToAvoidBottomInset: true,
        header:Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: orders
            .map((order) =>
            Row(

              children: [

                Card(
                  margin: EdgeInsets.symmetric(horizontal: 20),
                  backgroundColor: MyColors.secondary,
                  child: Center(
                    child: Text('   فاتورة العميل  ${order.customer.target?.name} ',
                      style: TextStyle(
                          color: MyColors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 30
                      ),),
                  ),
                ),

                IconButton( icon: Icon(FluentIcons.navigate_back_mirrored,size: 35,color: MyColors.secondary,),
                  onPressed: (){
                    Navigator.pop(context);
                  },),
              ],
            ),

        ).toList(),
        ),
        content: ListView(
          children: orders
              .map((order) => Column(
                children: [
                  //       ListTile(
                  //       title: Text(
                  //         '${order.id}    ${order.customer.target?.name}    \$${order.price}',
                  //       ),
                  // ),
                  Table(

                    children: [
                      TableRow(
                        children: [
                          Text('${order.customer.target?.name}')
                        ]
                      ),

                    ],
                  ),

           
                ],
              ),
          )
              .toList(),
        ),
      ),
    );
  }
}
