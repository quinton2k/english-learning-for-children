import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter/material.dart';

class LoadingPage extends StatelessWidget {
  const LoadingPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 227, 230, 226),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SpinKitFadingCircle(
              size: 50,
              color: Color(0xff2b5b89),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Loading',
              style: TextStyle(color: Color(0xff2b5b89), fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}

class LoadingSearch extends StatelessWidget {
  const LoadingSearch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 227, 230, 226),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SpinKitFadingCircle(
              size: 50,
              color: Color.fromARGB(221, 69, 67, 67),
            ),
            SizedBox(
              height: 10,
            ),
            // const Text(
            //   'Loading',
            //   style: TextStyle(
            //     fontSize: 20),
            // ),
          ],
        ),
      ),
    );
  }
}

class LoadingDetection extends StatelessWidget {
  const LoadingDetection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff557282),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SpinKitFadingCircle(
              size: 50,
              color: Colors.white,
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              'Please wait 😊',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }
}
