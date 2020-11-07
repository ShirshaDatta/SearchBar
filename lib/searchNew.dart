import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SearchNew extends StatefulWidget {
  @override
  _SearchNewState createState() => _SearchNewState();
}

class _SearchNewState extends State<SearchNew> {
  QuerySnapshot searchSnapshot;
  
   String searchString ;
  TextEditingController mycontroller = TextEditingController();

   Widget searchList() {
    return searchSnapshot != null
        ? ListView.builder(
            shrinkWrap: true,
            itemCount: searchSnapshot.docs.length,
            itemBuilder: (context, index) {
              return SearchTile(
                name: searchSnapshot.docs[index].get('Name'),
                //if(,)
                searchKey: searchSnapshot.docs[index].get('Genre').toString(),
              );
            },
          )
        : Container();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Search Page Ombre"),
      ),
      body: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.all(15.0),
          child: Container(
            child: TextField(
              onChanged: (val){
                setState(() {
                  searchString = val.toUpperCase();
                });
              },
              controller: mycontroller,
              decoration: InputDecoration(
                 hintText: 'Search by name',
                 hintStyle: TextStyle(color: Colors.white,fontSize: 16),
                 suffixIcon: IconButton(
                   icon: Icon(Icons.search),
                   onPressed: ()=> mycontroller.clear(),)
              ),
            ),
          ),
          ),
          Expanded(child: StreamBuilder<QuerySnapshot>(
           stream: (searchString == null || searchString.trim() == '')
           ?FirebaseFirestore.instance.collection('Concerts').snapshots()
           :FirebaseFirestore.instance.collection('Concerts').where('searchKey', arrayContains: searchString).snapshots(),
           builder: (context,snapshot){
             if(snapshot.hasError)
                return Text("We got an error ${snapshot.error}");
              switch(snapshot.connectionState){

                case ConnectionState.waiting :
                return Text("Waiting");

                case ConnectionState.none :
                return Text("No data present");

                case ConnectionState.done :
                return Text("Done");

                default :
                return searchList();
                
              }
           }
           )
            )
        ],
      ),
    );
  }
}

class SearchTile extends StatelessWidget {
  String name;
  String searchKey;

  SearchTile({this.name, this.searchKey});
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(
        searchKey,
        style: TextStyle(
            color: Colors.pinkAccent,  fontSize: 16),
      ),
      subtitle: Text(name, style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 20)),
    );
  }
}
