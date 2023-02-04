import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_tracking/project_view.dart';

import 'constants.dart';

class Coo extends StatefulWidget {
  const Coo({Key? key}) : super(key: key);

  @override
  State<Coo> createState() => _CooState();
}

class _CooState extends State<Coo> {
  showAlertDialog(BuildContext context) {
    // set up the buttons
    Widget cancelButton = ElevatedButton(
      child: Text("Cancel"),
      onPressed:  () {},
    );
    Widget continueButton = ElevatedButton(
      child: Text("Continue"),
      onPressed:  () {},
    );
    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("AlertDialog"),
      content: Text("Would you like to continue learning how to use Flutter alerts?"),
      actions: [
        cancelButton,
        continueButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
  Future<dynamic> getData() async {
    var res = await get(Uri.parse('${Con.url}project_list.php'));
    print(res.body);
    return jsonDecode(res.body);
  }
  Future<void> deleteData(id) async {
   var data = {
      "id":id,
    };
    var result = await post(Uri.parse('${Con.url}delete_project.php'),body: data);
    print(result.body);
    setState(() {

    });
  }
  XFile? pickedFile ;
  File? image;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Icon(Icons.logout),
          )
        ],
      ),
      body: FutureBuilder(
          future: getData(),
          builder: (context,snapshot) {
            if(!snapshot.hasData){
              return Center(child: const CircularProgressIndicator());
            }
            else if(snapshot.data[0]['message']=='failed') {
              return Center(child: Text('No Project added'));
            }
            else{

              return Column(
                children: [
                  Expanded(
                    child: ListView.separated(
                      separatorBuilder: (context, index) {
                        return Divider();
                      },

                      itemCount: snapshot.data.length,

                      itemBuilder: (context, index) {

                        return  ListTile(
                          onTap: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) {
                              return Project(id: snapshot.data![index]['id']);
                            },));
                          },
                          title: Text(snapshot.data![index]['topic']),
                          subtitle: Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Text(snapshot.data![index]['about']),
                          ),
                          trailing: InkWell(
                            onTap: () {
                              var id = snapshot.data![index]['id'];
                              deleteData(id);
                            },
                              child: Icon(Icons.delete,color: Colors.black,))
                        );

                      },

                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: FloatingActionButton(onPressed: ()  {

                          // ImagePicker picker = ImagePicker();
                          // pickedFile = await picker.pickImage(source: ImageSource.gallery);
                          //
                          // setState(() {
                          //   image = File(pickedFile!.path);
                          // });
                        },child: Icon(Icons.upload),),
                      ),
                    ],
                  )
                ],
              );
            }

          }
      ),

    );
  }
}
