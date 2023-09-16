import 'package:fluent_ui/fluent_ui.dart';
import 'package:lastbox_accounting_app/constant/constant.dart';

import '../component/custom_textfild.dart';
import '../constant/table_heading_text.dart';
import '../constant/table_row_text.dart';
import '../model/entities.dart';
import '../objectbox.g.dart';
import 'homeView.dart';
class OrderDetailsScreen extends StatefulWidget {
  final List<CustomerOrder> orders;


  OrderDetailsScreen({required this.orders});

  @override
  State<OrderDetailsScreen> createState() => _OrderDetailsScreenState();
}

class _OrderDetailsScreenState extends State<OrderDetailsScreen> {
  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  Store? _store;
  late Customer _customer;
  late Stream<List<CustomerOrder>> _stream;
  String? _name,_Newprice;

  @override
  Widget build(BuildContext context) {
    return  Container(
        color: MyColors.white,
        child: ScaffoldPage(

          header:Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: widget.orders
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
            children: widget.orders
                .map((order) => Column(
              children: [
                //       ListTile(
                //       title: Text(
                //         '${order.id}    ${order.customer.target?.name}    \$${order.price}',
                //       ),
                // ),
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.all(20),
                    child: Table(
                      textDirection: TextDirection.rtl,

                      defaultVerticalAlignment:
                      TableCellVerticalAlignment.middle,
                      children: [
                        TableRow(


                            decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              color:MyColors.secondary,
                              borderRadius:
                              const BorderRadius.all(
                                  Radius.circular(15)),
                            ),
                            children: [

                              SizedBox(
                                  height: 50,
                                  child: Center(child: HeadingText(text: '  رقم الفاتورة',))),
                              SizedBox(
                                  height: 50,
                                  child: Center(child: HeadingText(text: ' رقم الهاتف',))),

                              SizedBox(
                                  height: 50,
                                  child: Center(child: HeadingText(text: 'المبلغ ',))),
                              SizedBox(
                                  height: 50,
                                  child: Center(child: HeadingText(text: 'التاريخ ',))),
                              SizedBox(
                                  height: 50,
                                  child: Center(child: HeadingText(text: 'الإجمالي ',))),

                            ]
                        ),

                        TableRow(
                            decoration: BoxDecoration(
                              border: Border.all(width: 1),
                              color:MyColors.gray,
                              borderRadius:
                              const BorderRadius.all(
                                  Radius.circular(15)),
                            ),
                            children: [
                              SizedBox(
                                  height: MediaQuery.of(context).size.height/15,
                                  child:
                                  Center(child: RowText(text: '15621${order.id}'))),
                              Center(child: RowText(text: '${order.customer.target?.phone}',)),
                              Center(child: RowText(text: ' ${order.price} جنية ')),
                              Center(child: RowText(text: ' ${order.date}  ')),
                              Center(child: RowText(text: ' ${order.price} جنية  ')),
                            ]
                        ),


                      ],
                    ),
                  ),
                ),


              ],
            ),
            )
                .toList(),
          ),
          bottomBar: Container(
            color: MyColors.secondary,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                HeadingText(text: 'تعديل '),
                SizedBox(
                  height: 50,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: IconButton(
                        icon:Icon( FluentIcons.edit,color: Colors.white,size: 30,),
                        onPressed: (){
                          _detailsDialog(context);
                        }),
                  ),
                ),


              ],
            ),
          ),
        ),
      );




  }
  Future<void> _detailsDialog(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return  ContentDialog(
          // style: RoundedRectangleBorder(
          //     borderRadius:
          //     BorderRadius.all(
          //         Radius.circular(10.0))),

          title: Text('إضافة فاتورة جديدة '),
          content: Builder(
              builder: (context) {
                return Container(
                  width: MediaQuery.of(context).size.width,
                  child: SingleChildScrollView(
                    child: Form(
                        key: _globalKey,
                        child: Column(
                          // ignore: prefer_const_literals_to_create_immutables
                          children: [


                            const SizedBox(
                              height: 20,
                            ),

                            CustomTextField(
                              icon: FluentIcons.money,
                              keyBordNumberType: TextInputType.number,
                              hint: 'أدخل المبلغ ',
                              onClick: (value){
                                setState(() {
                                  _Newprice= value ;
                                });
                              },
                            ),
                            const SizedBox(
                              height: 20,
                            ),




                          ],
                        )
                    ),
                  ),
                );
              }
          ),
          actions: <Widget>[
            IconButton(
                onPressed: (){
                  setState(() {
                    if(_globalKey.currentState!.validate()) {
                      _globalKey.currentState!.save();
                      // _customer = Customer(
                      //   // name: faker.person.name(),
                      //     name: _name,
                      //     // phone: faker.phoneNumber.toString(),
                      //     phone: _phone,
                      //     date: DateTime.now().toString(),
                      //     // details: faker.address.toString(),
                      //     details: _details,
                      //     // price: _price.toInt(),
                      //     payed: 0,
                      //     restOfAmount: 0
                      // );

                      final order = CustomerOrder(
                        // price: faker.randomGenerator.integer(500,min: 10),
                          price: _Newprice.toInt(),
                          date:formattedDate.toString() ,
                          coinType: 'National');
                      order.customer.target = _customer;

                      _store!.box<CustomerOrder>().put(order);

                    }
                    Navigator.pop(context);

                  });
                }, icon: Icon(FluentIcons.saved_offline,color: Colors.blue,)),
            //     IconButton(
            //         onPressed: () {
            //
            //     // print('Price: ${faker.randomGenerator.integer(500,min: 10)}');
            //     },  icon: Icon(Icons.attach_money),
            // ),



          ],
        );
      },
    );
  }
}
