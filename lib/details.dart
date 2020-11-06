import 'package:cloud_firestore/cloud_firestore.dart';

class Concert{
  String name;
  List genre = [];
  List searchKey = [];

  Concert();

  Concert.fromMap(Map<String,dynamic>data){
    name = name.toUpperCase();
      for(var i=0;i<name.length;i++)
      {
        for(var j=i+1;j<name.length;j++)
        {
          searchKey.add(name.substring(i,j));
        }
      }
    name = data['name'];
    genre = data['genre'];
    searchKey = data['searchKey'];
  }

  Map<String,dynamic> toMap(){
    return {
      'name': name,
      'genre': genre,
      'searchKey' : searchKey,
    };
  }
}