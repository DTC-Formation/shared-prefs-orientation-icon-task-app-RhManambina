import 'package:flutter/material.dart';
import 'package:projet/add_todo/add_todo_screen.dart';
import 'package:projet/services/shared_preferences_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: MyHomePage());
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final searchBarTec = TextEditingController();
  SharedPreferencesService? service;

  @override
  void initState() {
    initSharedPreferences();
    super.initState();
  }

//Maka ilay valeur ho ampidirina
  initSharedPreferences() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    service = SharedPreferencesService(sharedPreferences);
  }

  @override
  //build(mandray parametre context)
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: const Center(
          child: Text('Liste de tâches : '),
        ),
      ),
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: FutureBuilder(
            future: service?.getTodo(),
            builder: (context, snapshot) {
              return ListView.builder(
                itemCount: snapshot.data?.length ?? 0,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => AddTodoScreen(
                                title: snapshot.data?[index],
                                index: index,
                              )));
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(
                            width: 1,
                            color: Colors.green,
                          )),
                      margin: const EdgeInsets.only(
                        top: 10,
                        left: 20,
                        right: 20,
                        bottom: 10,
                      ),
                      height: 60,
                      //Get Data
                      child: Row(children: [
                        Expanded(
                            child: Row(
                          children: [
                            const SizedBox(
                              width: 10,
                            ),
                            const Icon(
                              Icons.check_circle_outline,
                              color: Colors.blue,
                              size: 20,
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            Expanded(
                              child: Text(
                                //Ilay zavatra ni_ajoutena
                                snapshot.data?[index] ?? '',
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        )),
                        //Remove data
                        Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                service?.removeTodo(index);
                              });
                            },
                            child: const Icon(
                              Icons.delete,
                              color: Colors.red,
                            ),
                          ),
                        )
                      ]),
                    ),
                  );
                },
              );
            }),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const AddTodoScreen(),
            ),
          );
        },
        tooltip: 'Increment',
        child: Center(
          child: Container(
            child: const Icon(
              Icons.add,
            ),
          ),
        ),
      ),
    );
  }
}
