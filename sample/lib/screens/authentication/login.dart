import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/providers/auth_provider.dart';
import 'package:sample/providers/entries_provider.dart';

import 'package:sample/screens/authentication/signup.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    print("in login");
    return loginScaffold(context);
  }

  Widget loginScaffold(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    final email = TextFormField(
      controller: emailController,
      decoration: const InputDecoration(
        hintText: "Email",
      ),
      validator: (value) {
        if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(value!) ||
            value.isEmpty) {
          return ("Please enter a valid email");
        }
        return null;
      },
    );

    final password = TextFormField(
      controller: passwordController,
      obscureText: true,
      decoration: const InputDecoration(
        hintText: 'Password',
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter your password";
        } else if (value.length < 6) {
          return "Password must be at least 6 characters.";
        }

        return null;
      },
    );

    void ShowWarning(String warningTitle) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(warningTitle),
          duration: const Duration(seconds: 2),
        ),
      );
    }

    final loginButton = Padding(
      key: const Key('loginButton'),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () async {
          var result = await context
              .read<AuthProvider>()
              .signIn(emailController.text, passwordController.text);

          print(result);
          if (result == "unknown") {
            if (context.mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text("Invalid email or password.")));
            }
          } else {
            if (context.mounted) {
              context.read<EntriesProvider>().fetchEntries(result);
            }
          }
        },
        child: const Text('Log In', style: TextStyle(color: Colors.white)),
      ),
    );

    final signUpButton = Padding(
      key: const Key('signUpButton'),
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () async {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const SignupChooseUser(),
            ),
          );
        },
        child: const Text('Still don\'t have an account?',
            style: TextStyle(color: Colors.white)),
      ),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: ListView(
          shrinkWrap: true,
          padding: const EdgeInsets.only(left: 40.0, right: 40.0),
          children: <Widget>[
            const Text(
              "Hao Are You?",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 64),
            email,
            password,
            loginButton,
            signUpButton,
          ],
        ),
      ),
    );
  }
}
