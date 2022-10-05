import 'package:flutter/material.dart';

// TODO:  Sign up page, Redirect to Sign up page
class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 0.0),
      child: ListView(
        children: [
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(50.0),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10.0),
            child: const Text(
              'Sign in',
              style: TextStyle(fontSize: 25.0),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10.0),
            child: TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                border:  OutlineInputBorder(),
                labelText: 'User Name',
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: TextField(
              obscureText: true,
              controller: passwordController,
              decoration: const InputDecoration(
                border:  OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
          ),
          TextButton(
            onPressed: () {
              print('Quen password ne');
            },
            style: TextButton.styleFrom(
              primary: Colors.black54,
            ),
            child: const Text('Forgot Password'),
          ),
          Container(
            height: 50,
            padding: const EdgeInsets.fromLTRB(10.0, 0.0, 10.0, 0.0),
            child: ElevatedButton(
              onPressed: () {
                print(usernameController.text);
                print(passwordController.text);
              },
              style: ElevatedButton.styleFrom(
                primary: const Color(0xff2D4990),
              ),
              child: const Text('Login'),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Does not have account?'),
              TextButton(
                onPressed: () {
                  print('Di toi trang signup');
                },
                child: const Text(
                  'Sign up',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
