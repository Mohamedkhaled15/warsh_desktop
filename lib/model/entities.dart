import 'package:objectbox/objectbox.dart';

@Entity()
class Customer {
  @Id()
  int id=0;

  String? name;
  String? phone;
  String? date;
  // int? price;
  String? details;
  int? payed;
  int? restOfAmount;
@Backlink()
  final orders=ToMany<CustomerOrder>();


  Customer({
    required this.payed,
    required this.restOfAmount,
    required this.name,
    required this.phone,
    required this.date,
    required this.details,
    // required this.price,

  });

}

@Entity()
class CustomerOrder{
  @Id()
  int id=0;
  int? price;
  String date;
  String? coinType;
  final customer =ToOne<Customer>();

  CustomerOrder({
    required this.coinType,
    required this.price,
    required this.date
});
}
