import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sample/lesson3/add_todo_screen.dart';
import 'package:sample/lesson3/providers/todo_provider.dart';

AppBar createAppBar(BuildContext context, TodoProvider todoP) {
  return AppBar(
    title: const Text('Title'),
    leading: Text("Leading"),
    actions: [
      IconButton(
        onPressed: () {
          showDialog(
            useSafeArea: true,
            context: context,
            builder: (context) => DeleteTableDialog(todoP: todoP),
          );
        },
        icon: const Icon(
          Icons.delete_forever_outlined,
          color: Color.fromARGB(255, 240, 5, 5),
        ),
      ),
    ],
  );
}

class ShowTodoScreen extends StatefulWidget {
  const ShowTodoScreen({super.key});

  @override
  State<ShowTodoScreen> createState() => _ShowTodoScreen();
}

class _ShowTodoScreen extends State<ShowTodoScreen> {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final todoP = Provider.of<TodoProvider>(context, listen: false);
    return Scaffold(
        //floting add button
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () {
            Navigator.of(context).push(
              MaterialPageRoute(builder: (context) => const AddTodoScreen()),
            );
          },
        ),
        backgroundColor: Colors.white,
        appBar: createAppBar(context, todoP),
        body: null);
  }
}

class DeleteTableDialog extends StatelessWidget {
  const DeleteTableDialog({
    Key? key,
    required this.todoP,
  }) : super(key: key);

  final TodoProvider todoP;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return AlertDialog(
      scrollable: true,
      title: Text('Delete All'),
      content: Text('Do you want to delete all data?'),
      actions: [PopupYesNoButtonRaw(context, todoP, width, height)],
    );
  }
}

Row PopupYesNoButtonRaw(
    BuildContext context, TodoProvider todoP, double width, double height) {
  return Row(
    children: [
      Expanded(
        child: Padding(
          padding: EdgeInsets.all(width * 0.02),
          child: ElevatedButton(
            onPressed: () async {
              await todoP.deleteTable();
              Navigator.pop(context);
            },
            child: const Text('Yes'),
          ),
        ),
      ),
      Expanded(
        child: Padding(
          padding: EdgeInsets.all(width * 0.02),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(primary: Colors.white),
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text(
              'No',
              style: TextStyle(
                color: Theme.of(context).primaryColor,
              ),
            ),
          ),
        ),
      ),
    ],
  );
}
