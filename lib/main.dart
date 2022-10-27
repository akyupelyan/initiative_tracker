import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Initiative Tracker',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Initiative Tracker'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<String> litems = [];
  List<String> initiatives = [];
  String text = '';
  String name = '';
  String initiative = '';
  final TextEditingController eCtrl = TextEditingController();
  //void _addInitiative() {}

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Column(
        children: <Widget>[
          // TextField(
          //   controller: eCtrl,
          //   onSubmitted: (text) {
          //     litems.add(text);
          //     eCtrl.clear();
          //     setState(() {});
          //   },
          // ),
          IconButton(
              color: Colors.lightGreen,
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => SimpleDialog(
                          children: [
                            Text('Name:'),
                            TextField(onChanged: (value) {
                              setState(() {
                                name = value;
                              });
                            }),
                            Text('Initiative:'),
                            TextField(onChanged: (number) {
                              setState(() {
                                initiative = number;
                              });
                            }),
                            ElevatedButton(
                                onPressed: () {
                                  setState(() {
                                    litems.add(name);
                                    initiatives.add(initiative);
                                  });
                                  Navigator.pop(context);
                                },
                                child: Text('Add'))
                          ],
                        ));
              },
              icon: Icon(Icons.add)),
          Expanded(
              child: ListView.builder(
                  itemCount: litems.length,
                  itemBuilder: (BuildContext ctxt, int index) {
                    return Card(
                      color: Colors.blue,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ListTile(
                          title: Text(litems[index]),
                          trailing: Container(
                            width: 70,
                            child: Row(
                              children: [
                                Expanded(child: Text(initiatives[index])),
                                Expanded(
                                    child: IconButton(
                                        onPressed: () {
                                          showDialog(
                                            context: context,
                                            builder: (context) => SimpleDialog(
                                              children: [
                                                TextField(
                                                  onChanged: (value) {
                                                    setState(() {
                                                      text = value;
                                                    });
                                                  },
                                                ),
                                                ElevatedButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        litems[index] = text;
                                                      });
                                                      Navigator.pop(context);
                                                    },
                                                    child: Text('Update'))
                                              ],
                                            ),
                                          );
                                        },
                                        icon: Icon(Icons.edit))),
                                Expanded(
                                    child: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            litems.removeAt(index);
                                            initiatives.removeAt(index);
                                          });
                                        },
                                        icon: Icon(Icons.delete))),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  })),
        ],
      ),
      persistentFooterButtons: [
        ElevatedButton(
          style: ButtonStyle(
            overlayColor: MaterialStateProperty.all<Color>(Colors.blue),
          ),
          onPressed: () {
            setState(() {
              initiatives.sort();
            });
          },
          child: const Text('Sort', style: TextStyle(fontSize: 20)),
        ),
        IconButton(
          onPressed: () {
            setState(() {
              final String first = litems.removeAt(0);
              litems.add(first);
            });
          },
          icon: Icon(Icons.rotate_right_rounded),
        ),
      ],
    );
  }
}
