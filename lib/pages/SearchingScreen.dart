import 'package:flutter/material.dart';

class SearchingScreen extends StatefulWidget {
  const SearchingScreen({super.key});

  @override
  State<SearchingScreen> createState() => _SearchingScreenState();
}

class _SearchingScreenState extends State<SearchingScreen> {
  TextEditingController searchingTextField = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(
          leading: const BackButton(),
          title: TextField(
            controller: searchingTextField,
            onChanged: (text) {
              setState(() {
              });
            },
          ),
          actions: [
            IconButton(
                onPressed: () {

                },
                icon: const Icon(Icons.search),
            )
          ],
          centerTitle: true,
        ),
        body: Center(
          child: searchingTextField.text.isEmpty
              ? const Text('Can\'t find anything...')
              : Text('Can\'t find anything about ${searchingTextField.text}'),
        )
        ),
      );
  }
}
