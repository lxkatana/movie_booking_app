import 'package:flutter/material.dart';
import 'package:khalti_flutter/khalti_flutter.dart';
import 'package:movie_booking/views/screens/home.dart';

class MyApp extends StatelessWidget {
  MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return KhaltiScope(
      publicKey: 'test_public_key_f9d0c18104e546a98b982721a814a3de',
      enabledDebugging: true,
      builder: (context, navKey) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomeScreen(),
          navigatorKey: navKey,
          localizationsDelegates: const[
            KhaltiLocalizations.delegate
          ],
        );
      }
    );
  }
}