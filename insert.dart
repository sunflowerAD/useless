// ignore_for_file: prefer_const_constructors

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:mongo_dart/mongo_dart.dart' as M;
import 'package:test_mongodb/dbAuth/MongoDBModel.dart';
import 'package:test_mongodb/dbAuth/mongodb.dart';


class MongoDbInsert extends StatefulWidget{
  MongoDbInsert ({Key? key}) : super(key: key);

  @override
  _MongoDBInsertState createState() => _MongoDBInsertState();

}

class _MongoDBInsertState extends State<MongoDbInsert>{


    var fnameController = new TextEditingController();
    var lnameController = new TextEditingController();
    var addressController = new TextEditingController();

  @override
  Widget build(BuildContext context){
    // ignore: prefer_const_literals_to_create_immutables
    return Scaffold(body: SafeArea(child: Column(children: [
      Text("Insert Data",style: TextStyle(fontSize: 22),),

      SizedBox(
        height: 50,
        ),

      TextField(
        controller: fnameController,
        decoration: InputDecoration(labelText: "First Name"),
      ),

      TextField(
        controller: lnameController,
        decoration: InputDecoration(labelText: "Last Name"),
      ),

      TextField(
        minLines: 3,
        maxLines: 5,
        controller: addressController,
        decoration: InputDecoration(labelText: "Address"),
      ),

     Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        OutlinedButton(onPressed: (){
          _fakeData();
        }, 
        child: Text("Generate Data")),
        ElevatedButton(onPressed: (){
          _insertData(fnameController.text, lnameController.text, 
          addressController.text);
        }, child: Text("Insert Data")),
      ],
     )

    ],)),);
  }

  Future<void> _insertData(String fName, String lName, String address) async {
    var _id = M.ObjectId();
    final data = MongoDbModel(id: _id, fName: fName, lName: lName, address: address);
    var result = await MongoDatabase.insert(data);

    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Inserted ID " + _id.$oid)));
  }

  void _clearAll(){
    fnameController.text ="";
    lnameController.text ="";
    addressController.text ="";
  }

  void _fakeData(){
    setState(() {
      fnameController.text = faker.person.firstName();
      lnameController.text = faker.person.lastName();
      addressController.text = "${faker.address.streetName()}\n${faker.address.streetAddress()}";
    });
  }
}