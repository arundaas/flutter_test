import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:sample/lesson3/providers/todo_provider.dart';
import 'package:sizer/sizer.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key});

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class SizeConfig {
  double heightSize(BuildContext context, double value) {
    value /= 100;
    return MediaQuery.of(context).size.height * value;
  }

  double widthSize(BuildContext context, double value) {
    value /= 100;
    return MediaQuery.of(context).size.width * value;
  }
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  // @override
  // void dispose() {
  //   _titleController.dispose();
  //   _descriptionController.dispose();
  //   _dateController.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    final todoProvider = Provider.of<TodoProvider>(context, listen: false);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: const Text('Add Todo'),
      ),
      body: SingleChildScrollView(
        child:
            // Container(child: addTodoForm(context, todoProvider, width, height)),
            Container(
                child: AddTodoForm(
                    todoProvider: todoProvider, width: width, height: width)),
      ),
    );
  }
}

class AddTodoForm extends StatefulWidget {
  final TodoProvider todoProvider;
  final double width;
  final double height;
  const AddTodoForm(
      {Key? key,
      required this.todoProvider,
      required this.width,
      required this.height})
      : super(key: key);

  @override
  State<AddTodoForm> createState() => _AddTodoFormState();
}

class _AddTodoFormState extends State<AddTodoForm> {
  final _key = GlobalKey<FormState>();
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Form(
      key: _key,
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(widget.width * 0.04),
            child: TextFormField(
              controller: _titleController,
              decoration: FormInputDecorator(
                  "Title", context, widget.width, widget.height),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.name,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Description is Title';
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(widget.width * 0.04),
            child: TextFormField(
              controller: _dateController,
              decoration: FormInputDecorator(
                  "Date", context, widget.width, widget.height),
              readOnly:
                  true, //set it true, so that user will not able to edit text
              onTap: () async {
                DateTime? pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(
                        2000), //DateTime.now() - not to allow to choose before today.
                    lastDate: DateTime(2101));

                if (pickedDate != null) {
                  print(
                      pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                  String formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);

                  setState(() {
                    _dateController.text =
                        formattedDate; //set output date to TextField value.
                  });
                } else {
                  print("Date is not selected");
                }
              },
            ),
          ),
          Padding(
            padding: EdgeInsets.all(widget.width * 0.04),
            child: TextFormField(
              controller: _descriptionController,
              decoration: FormInputDecorator(
                  "Descriptions", context, widget.width, widget.height),
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.multiline,
              maxLines: 8,
              minLines: 4,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Description is Empty';
                }
              },
            ),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              fixedSize: Size(widget.width * 0.6, widget.height * 0.06),
              textStyle: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(widget.width * 0.03),
              ),
            ),
            onPressed: () async {
              if (_key.currentState!.validate() == false) {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text(
                      'Error',
                      style: TextStyle(
                        color: Colors.red,
                      ),
                    ),
                    content: const Text('Check the inputs'),
                    actions: [
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: Colors.white,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text(
                          'Return',
                          style: TextStyle(
                            color: Theme.of(context).primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                await widget.todoProvider.insertData(
                  _titleController.text,
                  _descriptionController.text,
                  _dateController.text,
                );
                _titleController.clear();
                _descriptionController.clear();
                _dateController.clear();
                // Navigator.pop(context);
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text(
                      'Info',
                      style: TextStyle(
                        color: Colors.blue,
                      ),
                    ),
                    content: const Text('Are you want to close'),
                    // actions: [
                    //   ElevatedButton(
                    //     style: ElevatedButton.styleFrom(
                    //       primary: Colors.white,
                    //     ),
                    //     onPressed: () {
                    //       Navigator.pop(context);
                    //       Navigator.of(context, rootNavigator: true).pop();
                    //     },
                    //     child: Text(
                    //       'Return',
                    //       style: TextStyle(
                    //         color: Theme.of(context).primaryColor,
                    //       ),
                    //     ),
                    //   ),
                    // ],
                    actions: [
                      AddFormPopupYesNoButtonRaw(
                          context, widget.width, widget.height)
                    ],
                  ),
                );
              }
            },
            child: Text('Insert'),
          ),
        ],
      ),
    );
  }
}

InputDecoration FormInputDecorator(
    String hintText, BuildContext context, double width, double height) {
  return InputDecoration(
    hintText: hintText,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(width * 0.03),
      borderSide: const BorderSide(color: Colors.black, width: 1),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(width * 0.03),
      borderSide: BorderSide(color: Theme.of(context).primaryColor, width: 2),
    ),
    prefixIcon: const Icon(
      Icons.description_outlined,
      color: Colors.black,
    ),
  );
}

Row AddFormPopupYesNoButtonRaw(
    BuildContext context, double width, double height) {
  return Row(
    children: [
      Expanded(
        child: Padding(
          padding: EdgeInsets.all(width * 0.02),
          child: ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              Navigator.of(context, rootNavigator: true).pop();
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
