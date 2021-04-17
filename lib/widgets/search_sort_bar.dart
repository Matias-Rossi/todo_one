import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      //child: Text("[Searchbar placeholder]"),
      child: CupertinoSearchTextField(
        onChanged: (value) {},
        onSubmitted: (value) {},
      ),
    );
  }
}

class SortButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
        child: TextButton(
      child: Text("Ordenar"),
      onPressed: () {},
    ));
  }
}

class SearchSortBar extends StatelessWidget {
  final _searchBar = SearchBar();
  final _sortButton = SortButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          _searchBar,
          _sortButton,
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
    );
  }
}
