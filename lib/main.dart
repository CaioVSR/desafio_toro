import 'package:desafio_toro/screens/splash_screen.dart';
import 'package:desafio_toro/services/stock_provider.dart';
import 'package:desafio_toro/services/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => StockProvider()),
        ChangeNotifierProvider(
          create: (context) => UserProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.dark().copyWith(
          accentColor: Color.fromRGBO(52, 173, 209, 1),
        ),
        home: SplashScreen(),
      ),
    );
  }
}
