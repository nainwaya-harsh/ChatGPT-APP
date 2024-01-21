import 'package:chatgpt_integration/constants/constants.dart';
import 'package:chatgpt_integration/providers/models_provider.dart';
import 'package:chatgpt_integration/screens/chat_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:provider/provider.dart';

// void main() {
//   runApp(const MyApp());
// }
Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Future.delayed(Duration(seconds: 3));
  FlutterNativeSplash.remove();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ModelsProvider())],
      child: MaterialApp(
          title: 'Flutter Demo',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
              scaffoldBackgroundColor: scaffoldBackgroundColor,
              appBarTheme: AppBarTheme(color: cardColor)),
          home: ChatScreen()),
    );
  }
}
