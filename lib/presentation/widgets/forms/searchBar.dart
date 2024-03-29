import 'package:flutter/material.dart';

class Searchbar extends StatefulWidget {
  final String placeholder;
  final TextEditingController controller;
  const Searchbar({Key key, this.placeholder, this.controller})
      : super(key: key);

  @override
  State<Searchbar> createState() => _SearchbarState();
}

class _SearchbarState extends State<Searchbar> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: TextField(
        controller: widget.controller,
        textAlignVertical: TextAlignVertical.center,
        decoration: InputDecoration(
          filled: true,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide.none,
          ),
          contentPadding: const EdgeInsets.fromLTRB(10, 0, 0, 0),
          hintText: widget.placeholder,
          hintStyle: const TextStyle(
            fontFamily: 'Poppins',
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
          prefixIcon: const Icon(Icons.search),
        ),
      ),
    );
  }
}
