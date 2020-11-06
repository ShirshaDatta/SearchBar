import 'package:SearchImplement/search/searchService.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
//import 'package:SearchImpl/search/searchService.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  SearchService databaseMethods = SearchService();
  //var auth = FirebaseAuth.instance;
  QuerySnapshot searchSnapshot;

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

  String search;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.blueGrey,
      body: Column(
        children: [
          Container(
            //padding: EdgeInsets.all(.0),
            height: 55,
            margin: EdgeInsets.symmetric(horizontal: 5),
            decoration: BoxDecoration(
              color: Colors.blueGrey[900],
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextField(
                          onChanged: (value) {
                            
                            search = value;
                            databaseMethods.serachByName(search).then((val) {
                              setState(() {
                                searchSnapshot = val;
                              });
                            });
                          },
                          decoration: InputDecoration(
                            hintText: 'Search by name',
                            hintStyle: TextStyle(color: Colors.white,fontSize: 16),
                            border: InputBorder.none,
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          print(searchSnapshot.docs);
                        },
                        child: Container( 
                          padding: EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                           // color: Colors.pink,
                          //  borderRadius: BorderRadius.circular(25),
                          ),
                          child: Icon(
                            Icons.search,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          searchList(),
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
