import 'package:flutter/material.dart';
import 'package:http/http.dart';

import 'constants.dart';

class Addfeed extends StatefulWidget {
  const Addfeed({Key? key}) : super(key: key);

  @override
  State<Addfeed> createState() => _AddfeedState();
}

class _AddfeedState extends State<Addfeed> {
  var feed = TextEditingController();
  void getData(){
   var data = {
      "feedback": feed.text,
    };
    var res = post(Uri.parse('${Con.url}view_feedback.php'),body:data );

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('add your feedback'),),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: TextFormField(
              controller: feed,
              decoration: InputDecoration(
                  border: OutlineInputBorder()
              ),
            ),
          ),
         ElevatedButton(onPressed: (){}, child: Text('Add'))
        ],
      ),
    );
  }
}
