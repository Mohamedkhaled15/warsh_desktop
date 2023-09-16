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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }

}
