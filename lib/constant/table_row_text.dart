import 'package:fluent_ui/fluent_ui.dart';
import 'package:lastbox_accounting_app/constant/constant.dart';

class RowText extends StatelessWidget {
  final String text;

  RowText( { required this.text}) ;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textDirection: TextDirection.rtl,
      style: TextStyle(
          fontFamily: 'Droid',
          fontSize: MediaQuery.of(context).size.width * .02,
          color: MyColors.black
      ),
    );
  }
}
