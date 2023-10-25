// ignore_for_file: camel_case_types, prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

class search extends StatefulWidget {
  const search({Key? key}) : super(key: key);

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.fromLTRB(10, 5, 10, 0),
      decoration: BoxDecoration(
          border: Border.all(color: Color(0xFF969696), width: 1.5),
          borderRadius: const BorderRadius.all(
            Radius.circular(14.0),
          )),
      child: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Icon(
              Icons.search,
              color: Color(0xFF969696),
            ),
          ),
          Expanded(
              child: TextFormField(
            initialValue: null,
            decoration: InputDecoration.collapsed(
              filled: true,
              fillColor: Colors.transparent,
              hintText: "Cari",
              hintStyle:
                  TextStyle(color: Colors.grey[500], fontFamily: 'Mulish'),
              hoverColor: Colors.transparent,
            ),
            onFieldSubmitted: (value) {
              // Get.to(() => searchBuku(keywords: search.toString()));
            },
          ))
        ],
      ),
    );
  }
}
