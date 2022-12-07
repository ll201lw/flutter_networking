import 'package:flutter/material.dart';
import 'package:english_words/english_words.dart';

class RandomWords extends StatefulWidget {
  const RandomWords({super.key});

  @override
  State<StatefulWidget> createState() => _RandomWordsState();
}

class _RandomWordsState extends State<RandomWords> {
  final suggestions = <WordPair>[];
  final Set<WordPair> saved = <WordPair>{};
  final TextStyle biggerFront = const TextStyle(fontSize: 16);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Startup Name Generator'),
        actions: <Widget>[
          IconButton(onPressed: pushSaved, icon: const Icon(Icons.list))
        ],
      ),
      body: buildSuggestions(),
    );
  }

  Widget buildSuggestions() {
    return ListView.builder(itemBuilder: (BuildContext context, int i) {
      if (i.isOdd) {
        return const Divider();
      }
      final int index = i ~/ 2;
      if (index >= suggestions.length) {
        suggestions.addAll(generateWordPairs().take(10));
      }

      return buildRow(suggestions[index]);
    });
  }

  Widget buildRow(WordPair pair) {
    final bool alreadSaved = saved.contains(pair);
    return ListTile(
      title: Text(pair.asPascalCase),
      trailing: Icon(
        alreadSaved ? Icons.favorite : Icons.favorite_border,
        color: alreadSaved ? Colors.blueAccent : null,
      ),
      onTap: () {
        setState(() {
          if (alreadSaved) {
            saved.remove(pair);
          } else {
            saved.add(pair);
          }
        });
      },
    );
  }

  void pushSaved() {
    Navigator.of(context)
        .push(MaterialPageRoute<void>(builder: (BuildContext context) {
      final Iterable<ListTile> tiles = saved.map((WordPair pair) {
        return ListTile(
          title: Text(
            pair.asPascalCase,
          ),
        );
      });
      final List<Widget> divided =
          ListTile.divideTiles(context: context, tiles: tiles).toList();
      return Scaffold(
        appBar: AppBar(
          title: const Text('Save Suggestions'),
        ),
        body: ListView(children: divided),
      );
    }));
  }
}
