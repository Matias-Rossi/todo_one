import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import './sort_menu.dart';

class SearchBar extends StatefulWidget {
  @override
  _SearchBarState createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 275,
      //child: Text("[Searchbar placeholder]"),
      child: CupertinoSearchTextField(
        onChanged: (value) {},
        onSubmitted: (value) {},
      ),
    );
  }
}

class SearchSortBar extends StatelessWidget {
  SearchSortBar(this._sort);

  final Function _sort;
  final _searchBar = SearchBar();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: [
          _searchBar,
          SortMenu(_sort),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      ),
    );
  }
}
