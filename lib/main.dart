import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:insta_clone/state/auth/backend/authenticator.dart';
import 'package:insta_clone/state/auth/models/auth_result.dart';
import 'package:insta_clone/state/auth/providers/auth_state_provider.dart';
import 'package:insta_clone/state/auth/providers/is_logged_in_provider.dart';
import 'package:insta_clone/state/providers/is_loading_provider.dart';
import 'package:insta_clone/views/components/loading/loading_screen.dart';
import 'package:insta_clone/views/login/login_view.dart';
import 'firebase_options.dart';

import 'dart:developer' as devtools show log;

extension Log on Object {
  void log() => devtools.log(toString());
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(ProviderScope(child: const App()));
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        primarySwatch: Colors.blueGrey,
        indicatorColor: Colors.blueGrey,
      ),
      theme: ThemeData(brightness: Brightness.light, primarySwatch: Colors.blue),
      themeMode: ThemeMode.dark,
      debugShowCheckedModeBanner: false,
      home: Consumer(
        builder: (context, ref, child) {
          // previous value (_) and the next value (isLoading)
          ref.listen<bool>(isLoadingProvider, (_, isLoading) {
            if (isLoading) {
              LoadingScreen.instance().show(context: context);
            } else {
              LoadingScreen.instance().hide();
            }
          });
          final isLoggedIn = ref.watch(isLoggedInProvider);
          isLoggedIn.log();
          if (isLoggedIn) {
            return const MainView();
          } else {
            return const LoginView();
          }
        },
      ),
    );
  }
}

// for when you are already logged in
class MainView extends StatelessWidget {
  const MainView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Main View')),
      body: Consumer(
        builder: (context, ref, child) {
          return TextButton(
            onPressed: () async {
              //LoadingScreen.instance().show(context: context, text: "Hello World"); // shows how the loading screen works. change the context in the builder to _ to use the correct context that is one above
              ref.read(authStateProvider.notifier).logOut();
            },
            child: Text('Logout'),
          );
        },
      ),
    );
  }
}

