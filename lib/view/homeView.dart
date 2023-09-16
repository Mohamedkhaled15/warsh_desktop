// ignore_for_file: prefer_const_constructors

import 'package:easy_localization/easy_localization.dart';
import 'package:faker/faker.dart';
import 'package:fluent_ui/fluent_ui.dart' as f ;

import 'package:flutter/material.dart' ;
import 'package:lastbox_accounting_app/model/objectbox_interface.dart';
import 'package:lastbox_accounting_app/objectbox.g.dart';
import 'package:objectbox/objectbox.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import '../component/custom_textfild.dart';
import '../model/entities.dart';
import 'order_data_table.dart';
DateTime now = DateTime.now();
String formattedDate = DateFormat('yyyy-MM-dd – kk:mm').format(now);

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);


  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  final GlobalKey<FormState> _globalKey = GlobalKey<FormState>();
  final faker = Faker();
  Store? _store;

  late final Store store;

  bool hasBeenInitialized = false;

  late Customer _customer;

  late Stream<List<CustomerOrder>> _stream;

  String? _name,_price;
  String? _phone,_details;
  int? _payed,_restOfAmount;
  @override
  void initState() {
    super.initState();
    setNewCustomer();
    getApplicationDocumentsDirectory().then((dir) {
           // openStore();
       _store = Store(
          getObjectBoxModel(),
          maxDBSizeInKB: 1024*1024 /*1 GB*/,
          directory: join(dir.path, 'objectbox'),
        );

      setState(()  {
        _stream =  _store!
            .box<CustomerOrder>()
            .query()
            .watch(triggerImmediately: true)
            .map((query) => query.find());
        hasBeenInitialized = true;
      });


    }

    );
  }

  @override
  void dispose() {
    _store!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add) ,
        onPressed: (){
          _dialogBuilder(context);
        },
      ),

      // bottomBar: IconButton(
      //
      //   icon:Icon(f.FluentIcons.add) ,
      //   onPressed: (){
      //     _dialogBuilder(context);
      //   },
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: (){
      //     _dialogBuilder(context);
      //
      //
      //   },
      //   child: ,
      // ),
      // appBar: AppBar(
      //   title: Text('Accounting App'),
      //   actions: const [
      //     // IconButton(
      //     //     onPressed: setNewCustomer, icon: Icon(Icons.person_add_alt)),
      //     // IconButton(
      //     //     onPressed: addFakerOrderForCurrentCustomer,
      //     //     icon: Icon(Icons.attach_money)),
      //   ],
      // ),
      body: !hasBeenInitialized? Center(child: f.ProgressRing(),):
        StreamBuilder<List<CustomerOrder>>(
          stream: _stream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Center(child: f.ProgressRing(),);
            }
            return OrderDataTable(

                orders: snapshot.data!,
                onSort: (columnIndex, ascending) {
                  final newQueryBuilder = _store?.box<CustomerOrder>().query();
                  final sortField =
                  columnIndex == 0 ? CustomerOrder_.id : CustomerOrder_.price;
                  newQueryBuilder?.order(sortField,
                      flags: ascending ? 0 : Order.descending);

                  setState(() {
                    _stream = newQueryBuilder
                    !.watch(triggerImmediately: true)
                        .map((query) => query.find());
                  }
                  );
                },
              store: _store!,
            );
          }
            ),
    );
  }

   setNewCustomer() {


    // print('Name: ${faker.person.name()}');
  }




  Future<void> _dialogBuilder(BuildContext context) {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return  AlertDialog(
          // style: RoundedRectangleBorder(
          //     borderRadius:
          //     BorderRadius.all(
          //         Radius.circular(10.0))),

          title: Text('إضافة حساب جديد'),
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
                          SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                            icon: f.FluentIcons.personalize,
                            hint: 'أدخل اسم العميل',
                            onClick: (value){
                              setState(() {
                                _name = value;
                              });
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),

                          CustomTextField(
                            icon: f.FluentIcons.money,
                            keyBordNumberType: TextInputType.number,
                            hint: 'أدخل المبلغ ',
                            onClick: (value){
                              setState(() {
                                 _price= value ;
                              });
                            },
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                            keyBordNumberType: TextInputType.phone,
                            icon: f.FluentIcons.phone,
                            hint: 'أدخل رقم الهاتف',
                            onClick: (value){
                              setState(() {
                                _phone = value;
                              });
                            },
                          ),

                          SizedBox(
                            height: 20,
                          ),
                          CustomTextField(
                            hint: 'إضافة تفاصيل ',
                            onClick: (value){
                              setState(() {
                                _details = value;
                              });
                            },
                          ),
                          // SizedBox(
                          //   height: 20,
                          // ),
                          // CustomTextField(
                          //   hint: 'أدخل اسم العميل',
                          //   onClick: (value){
                          //     setState(() {
                          //       _name = value;
                          //     });
                          //   },
                          // ),

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
                      _customer = Customer(
                        // name: faker.person.name(),
                          name: _name,
                          // phone: faker.phoneNumber.toString(),
                          phone: _phone,
                          date: DateTime.now().toString(),
                          // details: faker.address.toString(),
                          details: _details,
                          // price: _price.toInt(),
                          payed: 0,
                          restOfAmount: 0
                      );

                      final order = CustomerOrder(
                         // price: faker.randomGenerator.integer(500,min: 10),
                          price: _price.toInt(),
                          date:formattedDate.toString() ,
                          coinType: 'National');
                      order.customer.target = _customer;

                      _store!.box<CustomerOrder>().put(order);

                    }
                    Navigator.pop(context);

                  });
                }, icon: Icon(f.FluentIcons.saved_offline,color: Colors.blue,)),
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
extension NumberParsing on String?{
  int toInt(){

    int number =int.parse(this!);
    return number;
  }
}

// extension textParsing on int{
//   String toString(){
//     String text= String.p
//   }

//}
