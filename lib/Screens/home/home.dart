import 'package:blood_db/constants.dart';
import 'package:blood_db/widget/profilebar.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryLightColor,
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              const Center(child: Text('Evedaaaa searchbar with filtration')),
            ],
          ),
          SingleChildScrollView(
            child: Column(children: [
              ProfileBar(),
            ]),
            // <-- wrap this around
            // child: Column(
            //   children: const [
            //     ProfileBar(),
            //   ],
            // ),
          )
        ],
      ),
    );
  }
}
