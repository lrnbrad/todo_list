import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
      ),
      home: const MyHomePage(title: 'Simple Todo App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class Todo {
  String _title;

  Todo(this._title);

  String getTitle() => _title;

  String setTitle(String newTitle) {
    _title = newTitle;
    return _title;
  }
}

class _MyHomePageState extends State<MyHomePage> {
  var sampleTodos = <Todo>[
    Todo("To Do 1"),
    Todo("To Do 2"),
    Todo("To Do 3"),
    Todo("To Do 4"),
    Todo("To Do 5"),
  ];

  Todo addTodo(Todo newTodo) {
    sampleTodos.add(newTodo);
    return newTodo;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
          itemCount: sampleTodos.length,
          itemBuilder: (sampleTodos, idx) {
            return todoCard(idx);
          },
        ),
        // child: simpleCard(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showTodoForm(context),
        tooltip: 'Add a new todo',
        child: const Icon(Icons.add_rounded),
      ),
    );
  }

  Padding todoCard(int idx) {
    TextStyle cardTextStyle = TextStyle(
      fontSize: 18,
      fontWeight: FontWeight.w500,
    );
    String todoTitle = sampleTodos[idx].getTitle();

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: SizedBox(
        width: double.infinity,
        child: Card(
          elevation: 4,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Center(
            child: Row(
              children: [
                Expanded(
                  flex: 9,
                  child: Center(
                    child: Column(
                      spacing: 8,
                      children: [Text(todoTitle, style: cardTextStyle)],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: IconButton(
                    onPressed: () {
                      setState(() {
                        sampleTodos.removeAt(idx);
                      });
                    },
                    icon: Icon(Icons.close_rounded),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void showTodoForm(BuildContext context) {
    TextStyle tsAlertTitle = TextStyle(
      fontSize: 20,
      fontWeight: FontWeight.w800,
    );

    TextEditingController textFieldController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Add Todo!", style: tsAlertTitle),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            spacing: 8,
            children: [
              Text("Please input the todo:"),
              TextField(
                controller: textFieldController,
                decoration: InputDecoration(
                  labelText: "Input here!",
                  hintText: "Enter todo task",
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text("Close"),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      var newTodoTitle = textFieldController.text;
                      if (newTodoTitle.isNotEmpty) {
                        setState(() {
                          addTodo(Todo(newTodoTitle));
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "The title is empty, so we won't add it.",
                            ),
                          ),
                        );
                      }
                    },
                    child: Text("Add"),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

Widget simpleCard() {
  TextStyle tsTitle = TextStyle(fontWeight: FontWeight.w600);
  TextStyle tsText = TextStyle(fontWeight: FontWeight.w400);

  return Card(
    child: SizedBox(
      height: 80,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          spacing: 8,
          children: [
            Text("Name Card!", style: tsTitle),
            Text("Hi there, I'm Brad!", style: tsText),
            Text("This is something really long setence", style: tsText),
          ],
        ),
      ),
    ),
  );
}
