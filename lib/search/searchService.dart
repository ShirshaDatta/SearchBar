import 'package:cloud_firestore/cloud_firestore.dart';

class SearchService {
  serachByName(String searchField)
  {
    //searching based on First char
    return FirebaseFirestore.instance.collection('Concerts')
    .where('searchKey',
    isEqualTo: searchField.substring(0,1).toUpperCase())
    .get();
  }
}