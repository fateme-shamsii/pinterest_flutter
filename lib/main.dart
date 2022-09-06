import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pintreset_flutter_samin/data/UserSimplePrefeneces.dart';
import 'package:pintreset_flutter_samin/page/Login.dart';
import 'package:pintreset_flutter_samin/provider/Provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
 
  await UserSimplePreferences.init();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => hideShow()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        canvasColor: Colors.black,
      ),
      home: Login(),
    );
  }
}
