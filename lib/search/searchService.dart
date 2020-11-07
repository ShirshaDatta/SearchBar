import 'package:cloud_firestore/cloud_firestore.dart';

class SearchService {
  serachByName(searchField) async {
    //searching based on First char
    for (var i = 0; i < searchField.length; i++) {
          
          String t =searchField[i];
          return await FirebaseFirestore.instance
        .collection('Concerts')
        .where('searchKey',
            isEqualTo: searchField.contains(t)
            )
        .get();
        }
  }

  // searchConcert(String concert) async {
  //   return await FirebaseFirestore.instance
  //       .collection('Concerts')
  //       .where('searchKey', isEqualTo: concert.substring(0, 1).toUpperCase())
  //       .get();
  // }
}
