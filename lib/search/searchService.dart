import 'package:cloud_firestore/cloud_firestore.dart';

class SearchService {
  serachByName(String searchField) async {
    //searching based on First char
    return await FirebaseFirestore.instance
        .collection('Concerts')
        .where('searchKey',
            isEqualTo: searchField.substring(0, 1).toUpperCase())
        .get();
  }

  // searchConcert(String concert) async {
  //   return await FirebaseFirestore.instance
  //       .collection('Concerts')
  //       .where('searchKey', isEqualTo: concert.substring(0, 1).toUpperCase())
  //       .get();
  // }
}
