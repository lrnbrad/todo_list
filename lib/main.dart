import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '簡易 Todo App',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown),
      ),
      home: const MyHomePage(title: '簡易 Todo App'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

// 定義Todo類別，用於存儲待辦事項
class Todo {
  String _title;

  Todo(this._title);

  String getTitle() => _title;
}

class _MyHomePageState extends State<MyHomePage> {
  // 使用State來管理待辦事項清單，因為這些數據會隨使用者輸入而變化
  // 當我們添加新的待辦事項時，需要使用setState來更新UI
  final List<Todo> todos = <Todo>[
    Todo("待辦事項 1"),
    Todo("待辦事項 2"),
    Todo("待辦事項 3"),
  ];

  // 控制TextField中的文字
  final TextEditingController todoController = TextEditingController();

  // 添加新的待辦事項
  void addTodo() {
    // 檢查輸入是否為空
    if (todoController.text.isNotEmpty) {
      // 使用setState因為我們需要更新UI來顯示新添加的待辦事項
      setState(() {
        todos.add(Todo(todoController.text));
        todoController.clear(); // 清空輸入欄位
      });
    }
  }

  // 刪除待辦事項
  void deleteTodo(int index) {
    // 使用setState因為刪除項目後需要重新渲染UI
    setState(() {
      todos.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Column(
        children: [
          // 頂部的TextField
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                // 使用Expanded確保TextField填滿剩餘空間
                Expanded(
                  child: TextField(
                    controller: todoController,
                    decoration: const InputDecoration(
                      labelText: "新增待辦事項",
                      hintText: "請輸入待辦事項內容",
                      border: OutlineInputBorder(),
                    ),
                    // 當用戶按下Enter鍵時添加待辦事項
                    onSubmitted: (_) => addTodo(),
                  ),
                ),
                // 添加按鈕
                IconButton(
                  icon: const Icon(Icons.add),
                  onPressed: addTodo,
                )
              ],
            ),
          ),

          // 下方的待辦事項列表
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              itemCount: todos.length,
              itemBuilder: (context, index) {
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    title: Text(
                      todos[index].getTitle(),
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => deleteTodo(index),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  // 釋放資源
  @override
  void dispose() {
    todoController.dispose();
    super.dispose();
  }
}