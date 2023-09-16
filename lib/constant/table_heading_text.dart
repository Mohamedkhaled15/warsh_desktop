import 'package:fluent_ui/fluent_ui.dart';
import 'package:lastbox_accounting_app/constant/constant.dart';

class HeadingText extends StatelessWidget {
 final String text;

  HeadingText({ required this.text}) ;

  @override
  Widget build(BuildContext context) {
    return Text(
     text,
     style: TextStyle(
        fontFamily: 'Droid',
        fontSize: MediaQuery.of(context).size.width * .02,
        color: MyColors.white
     ),
    );
  }
}
