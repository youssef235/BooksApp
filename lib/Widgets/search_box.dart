import 'package:flutter/material.dart';

class Searchbox {
  Widget buildSearchbox(
      BuildContext context, TextEditingController _controller) {
    return Padding(
        padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 13.0),
        child: Container(
          decoration: BoxDecoration(
            color: const Color.fromARGB(255, 226, 226, 226),
            borderRadius: BorderRadius.circular(15),
          ),
          child: TextField(
            controller: _controller,
            decoration: const InputDecoration(
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                hintText: "Write the title or author of the book",
                prefixIcon: Icon(Icons.search)),
          ),
        ));
  }
}
