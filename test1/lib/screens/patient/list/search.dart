import 'package:flutter/material.dart';
import 'package:test1/ressources/consts_global.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> boxes = ['Box 1', 'Box 2', 'Box 3', 'Box 4'];
  String searchText = '';

  List<Widget> _filteredBoxes() {
    // Filter the boxes based on the search text
    final filteredBoxes = boxes.where((box) => box.contains(searchText));

    // Convert the filtered boxes into a list of Container widgets
    return filteredBoxes.map((box) => _buildBox(box)).toList();
  }

  Widget _buildBox(String text) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: solcolor1,
        title: Container(
          width: double.infinity,
          height: 40,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
          ),
          child: Center(
            child: TextFormField(
              decoration: InputDecoration(
                  prefixIcon: Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: Icon(Icons.clear),
                    onPressed: () {
                      setState(() {
                        searchText = '';
                      });
                    },
                  ),
                  hintText: 'Search...',
                  border: InputBorder.none),
              onChanged: (text) {
                setState(() {
                  searchText = text;
                });
              },
            ),
          ),
        ),
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: _filteredBoxes(),
      ),
    );
  }
}
