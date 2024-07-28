import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:news_app/providers/news_category_provider.dart';
import 'package:news_app/providers/search_news_provider.dart';
import 'package:news_app/providers/user_provider.dart';
import 'package:news_app/services/user_service.dart';
import 'package:provider/provider.dart';
import 'auth_wrapper.dart';
import 'services/authentication_service.dart';
import 'firebase_options.dart';
import 'providers/news_provider.dart';
import 'providers/news_source_provider.dart';
import 'services/remote_config_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthenticationService()),
        ChangeNotifierProvider(create: (_) => TopNewsProvider()),
        ChangeNotifierProvider(create: (_) => SourceNewsProvider()),
        ChangeNotifierProvider(create: (_) => CategoryNewsProvider()),
        ChangeNotifierProvider(create: (_) => SearchNewsProvider()),
        Provider(create: (_) => RemoteConfigService()),
        Provider(create: (_) => UserService()),
        ChangeNotifierProvider(
            create: (context) =>
                UserProvider(userService: context.read<UserService>())),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'News App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const AuthWrapper(),
      ),
    );
  }
}
