import 'package:SearchImplement/search/searchService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}



class _HomePageState extends State<HomePage> {
  Widget buildResultCont(data){
      return Container(
        color: Colors.black,
        child: Column(
          children: [
            Text(data['Genre'],
            style: TextStyle(
              color:Colors.pink ,
              ),
              textAlign: TextAlign.right,),
            Text(data['Concerts'],
            style: TextStyle(
              color:Colors.white ,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.right,),
          ],
        ),
      );
    }


 var queryResultSet = [];
 var tempSearchStore = [];
 
  initiateSearch(value)
  {

    //if the user after entering the search removes everything
    if(value.length == 0){
      queryResultSet =[];
      tempSearchStore = [];
    }

    //convert the first letter to capital and append the rest
    var capitalizedValue = value.substring(0,1).toUpperCase() + value.substring(1);

    //make the query to triggr search when the user searches based on first char
    if(queryResultSet.length == 0 && value.length == 1){
      SearchService().serachByName(value).then((QuerySnapshot docs) {
        // ignore: deprecated_member_use
        for(int i=0;i<docs.documents.length; i++){
          // ignore: deprecated_member_use
          queryResultSet.add(docs.documents[i].data);
        }
      });
    }
    else{
      tempSearchStore = [];
      queryResultSet.forEach((element) {
        if (element['Name'].startsWith(capitalizedValue)) {
          setState(() {
            tempSearchStore.add(element);
          });
        }
      });
    }
  } 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
        onChanged: (val){
          initiateSearch(val);
        },
         autocorrect: true,
              decoration: InputDecoration(
                isDense: true, // Added this
                contentPadding: EdgeInsets.all(10),
                hintText: 'Search events',
                suffixIcon: Icon(Icons.search),
                disabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(color: Colors.black, width: 1.5),
                ),
                
        ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(new Radius.circular(20.0)),
        side: BorderSide()
      ), 
      ),
      body: ListView(
        padding: const EdgeInsets.all(8),
        children: tempSearchStore.map((element) {
          return buildResultCont(element);
        }).toList()
      ),
    );

    
  }
}
