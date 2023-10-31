import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

import 'Model/model.dart';
import 'Services/service.dart';

class DictionaryScreen extends StatefulWidget {
  const DictionaryScreen({Key? key}) : super(key: key);

  @override
  _DictionaryScreenState createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  TextEditingController controller = TextEditingController();

 void openDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text('Meaning'),
        content: Container(
          width: double.maxFinite,
          child: FutureBuilder(
            future: DictionaryService().getMeaning(word: controller.text),
            builder: (context, AsyncSnapshot<List<DictionaryModel>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              } else if (snapshot.hasData) {
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  itemBuilder: (context, index) {
                    final data = snapshot.data![index];
                    if (data.phonetics == null ||
                        data.phonetics!.isEmpty ||
                        data.meanings == null ||
                        data.meanings!.isEmpty) {
                      return ListTile(
                        title: Text('Not Found'),
                      );
                    }
                    return Column(
                      children: [
                        ListTile(
                          title: Text(data.word!),
                          subtitle: Text(data.phonetics![0].text!),
                        ),
                        ListTile(
                          title: Text(data.meanings![0].definitions![0].definition!),
                          subtitle: Text(data.meanings![0].partOfSpeech!),
                        ),
                      ],
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else {
                return const CircularProgressIndicator();
              }
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      );
    },
  );
}


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Container(
              padding: const EdgeInsets.all(10),
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(),
                    ),
                    child: TextButton(
                      onPressed: () {
                        setState(() {
                          controller.text = 'cellphones';
                          openDialog(context);
                        });
                      },
                      child: Text('meaning'),
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
