import 'package:flutter/material.dart';

class SignUpSuccess extends StatelessWidget {
  const SignUpSuccess({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
      padding: EdgeInsets.all(25.0),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.fromLTRB(0.0, 105.0, 0.0, 0.0),
            alignment: Alignment.center,
            child: const Image(
              image: AssetImage('assets/icons/success-icon-1.png'),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(20.0),
            child: const Text(
              'Your Sign up was successful',
              style: TextStyle(fontSize: 25.0, fontWeight: FontWeight.w500),
            ),
          ),
          TextButton(
            onPressed: () {
              print('Go to homepage');
            },
            style: TextButton.styleFrom(
              primary: Colors.black54,
            ),
            child: const Text(
              'Continue to Home',
              style: TextStyle(
                fontSize: 25,
                decoration: TextDecoration.underline,
                color: Color(0xff2D4990),
              ),
            ),
          ),
        ],
      ),
    ));
  }
}
