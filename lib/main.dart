import 'package:fluent_ui/fluent_ui.dart';
import 'package:flutter/material.dart';
import 'package:lastbox_accounting_app/view/homeView.dart';
import 'package:path_provider/path_provider.dart';

Future<void> main() async {
   WidgetsFlutterBinding.ensureInitialized();
   await getApplicationDocumentsDirectory();
  runApp(const MyApp());


}

class MyApp extends StatelessWidget {

  const MyApp();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return FluentApp(
      theme: FluentThemeData(
        activeColor: Color(0xFF42A5F5),


      ),
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,

      home: HomePage(),
    );
  }

}
