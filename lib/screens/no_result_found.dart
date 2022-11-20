import 'package:flutter/material.dart';

class NoResultFoundScreen extends StatelessWidget {
  const NoResultFoundScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Stack(
        fit: StackFit.expand,
        children: [
          Image.network(
            "https://raw.githubusercontent.com/abuanwar072/20-Error-States-Flutter/master/assets/images/14_No%20Search%20Results.png",
            fit: BoxFit.cover,
          ),
          Positioned(
            bottom: MediaQuery.of(context).size.height * 0.15,
            left: MediaQuery.of(context).size.width * 0.065,
            right: MediaQuery.of(context).size.width * 0.065,
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0, 13),
                    blurRadius: 25,
                    color: const Color(0xFF5666C2).withOpacity(0.17),
                  ),
                ],
              ),
              // child: TextField(
              //   style: const TextStyle(fontSize: 12),
              //   onChanged: (value) {},
              //   decoration: InputDecoration(
              //     hintText: "Search...",
              //     contentPadding: const EdgeInsets.symmetric(horizontal: 20),
              //     fillColor: Colors.white,
              //     filled: true,
              //     border: OutlineInputBorder(
              //       borderRadius: BorderRadius.circular(50),
              //       borderSide: BorderSide.none,
              //     ),
              //     suffixIcon: const Icon(
              //       Icons.search,
              //       color: Colors.black,
              //     ),
              //   ),
              // ),
            ),
          )
        ],
      ),
    );
  }
}
