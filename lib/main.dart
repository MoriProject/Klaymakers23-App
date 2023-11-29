import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:morimori/pages/LoginPage.dart';
import 'package:morimori/services/services.dart';
import 'package:provider/provider.dart';

import 'bloc/metamask_auth_bloc.dart';
import 'models/user_model.dart';

void main() {
  initServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const storage = FlutterSecureStorage();
    storage.delete(key: 'address');
    return BlocProvider(
      create: (context) => MetaMaskAuthBloc(),
      child: MultiProvider(

        providers: [
          ChangeNotifierProvider(create: (context) => UserModel()),
        ],
        child: MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const LoginPage(),
        ),
      ),
    );
  }
}