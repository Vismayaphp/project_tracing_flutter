import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class Review extends StatefulWidget {
  const Review({Key? key}) : super(key: key);

  @override
  State<Review> createState() => _ReviewState();
}

class _ReviewState extends State<Review> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Lottie.asset('assets/images/date.json',height: 150,width: 400),
          Card(elevation:3,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Text('12/02/2023',style: TextStyle(fontSize: 20,fontWeight: FontWeight.bold,color: Colors.blueAccent),),
              )),
        ],
      ),
    );
  }
}
