import 'package:flutter/material.dart';
import 'package:projet/services/shared_preferences_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddTodoScreen extends StatefulWidget {
  const AddTodoScreen({super.key, this.title, this.index});
  //update
  final String? title;
  final int? index;

  @override
  State<AddTodoScreen> createState() => _AddTodoScreenState();
}

class _AddTodoScreenState extends State<AddTodoScreen> {
  TextEditingController controller = TextEditingController();
  //update
  @override
  void initState() {
    controller = TextEditingController(text: widget.title);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        const SizedBox(
          height: 50,
          width: 100,
        ),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              filled: true,
              hintStyle: TextStyle(color: Colors.grey[800]),
              hintText: 'Ajouter une nouvelle tache',
              fillColor: Colors.white70,
            ),
          ),
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 50,
          margin: const EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          child: ElevatedButton(
              onPressed: () async {
                final sharedPreferences = await SharedPreferences.getInstance();
                SharedPreferencesService(sharedPreferences)
                    .addTodo(controller.text);
                Navigator.of(context).pop();

                // if (controller.text.isNotEmpty) {
                //   final sharedPreferences =
                //       await SharedPreferences.getInstance();
                //   SharedPreferencesService(sharedPreferences)
                //       .addTodo(controller.text);

                //   // if (widget.title?.isEmpty ?? false) {
                //   //   SharedPreferencesService(sharedPreferences)
                //   //       .addTodo(controller.text);
                //   // } else {
                //   //   // SharedPreferencesService(sharedPreferences)
                //   //   //     .updateTodo(widget.index ?? 0, controller.text);
                //   // }

                //   Navigator.of(context).pop();
                // }
              },
              child: const Text(
                'Save',
                style: TextStyle(fontSize: 18),
              )),
        )
      ]),
    );
  }
}
