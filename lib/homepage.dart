import 'package:flutter/material.dart';



class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: TextField(
         autocorrect: true,
              decoration: InputDecoration(
                isDense: true, // Added this
                contentPadding: EdgeInsets.all(8),
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
    );
  }
}