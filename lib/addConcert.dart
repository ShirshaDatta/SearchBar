import 'package:SearchImplement/details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class AddConcert extends StatefulWidget {
  @override
  _AddConcertState createState() => _AddConcertState();
}

class _AddConcertState extends State<AddConcert> {
  TextEditingController mycontroller = TextEditingController();
  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the widget tree.
    // This also removes the _printLatestValue listener.
    mycontroller.dispose();
    super.dispose();
  }

   _printLatestValue() {
    print("Second text field: ${mycontroller.text}");
  }

  @override
  Widget build(BuildContext context) {
    uploadData(String name) async
    {
      List<String> splitList = name.split(' ');
      List<String> indexList = [];

      name = name.toUpperCase();
      for(var i=0;i<name.length;i++)
      {
        for(var j=i+1;j<name.length;j++)
        {
          indexList.add(name.substring(i,j));
        }
      }
      FirebaseFirestore.instance.collection('Concerts')
      .add({'Name': name,'searchKey': indexList});
    }
    return Scaffold(
      appBar: AppBar(
        title: Text("Ombre Concert Details"),
      ),
      body: Container(
        child: Column(
          children: <Widget>[
            Padding(padding: EdgeInsets.all(20),
            child: TextField(
              controller: mycontroller,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                icon: Icon(Icons.celebration),
                onPressed: (){
                  mycontroller.clear();
                },
                ),
                hintText: 'Concert name'
              ),
            ),
            ),
            
            FlatButton(onPressed: ()async{
              uploadData(mycontroller.text);
            }, 
            child: Text("Upload data"),
            ),
          ],
        ),
      ),
    );
  }
}

/*class ConcertForm extends StatefulWidget {
 //final bool isUpdating;

 // ConcertForm({@required this.isUpdating});

  @override
  _ConcertFormState createState() => _ConcertFormState();

}

class _ConcertFormState extends State<ConcertForm> {

  final GlobalKey<FormState> _formKey =GlobalKey<FormState>();

  List _genre = [];
  Concert _currentConcert;
  TextEditingController genreController = new TextEditingController();


  
  Widget _buildNameField(){
    return TextFormField(
      style: TextStyle(
        color: Colors.white,
      ),
      decoration: InputDecoration(
        labelText: 'Name of concert',
      ),
       initialValue: _currentConcert.name,
      keyboardType: TextInputType.text,
      validator: (String value){
        if(value.isEmpty){
          return 'Name is required';
        }
        return null;
      },

      onSaved: (String value){
        _currentConcert.name=value;
      },
    );
  }

  _buildGenreField() {
    return SizedBox(
      width: 200,
      child: TextField(
        controller: genreController,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(labelText: 'Genre'),
        style: TextStyle(fontSize: 20),
      ),
    );
  }
 
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Concert Form"),),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: <Widget>[
               Text(
              'Create Concert',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 30),
            ),
              SizedBox(height: 10),
              FlatButton(onPressed: () =>{}, child: Text(
                "add details",
                style: TextStyle(color: Colors.blue),
              )),
              _buildNameField(),
            ],
          )
          ),
          ),
    );
  }
}*/