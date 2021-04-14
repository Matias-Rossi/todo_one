import 'package:flutter/material.dart';

class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text("[Searchbar placeholder]"),
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
        mainAxisAlignment: MainAxisAlignment.spaceAround,
      ),
    );
  }
}
