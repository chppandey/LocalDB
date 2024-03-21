import 'package:database/sqlLigte/Model/notes_model.dart';
import 'package:database/sqlLigte/Presentation/add_data_screen.dart';
import 'package:database/sqlLigte/Service/sqlite_service.dart';
import 'package:flutter/material.dart';

class DataListScreen extends StatefulWidget {
  const DataListScreen({super.key});

  @override
  State<DataListScreen> createState() => _DataListScreenState();
}

class _DataListScreenState extends State<DataListScreen> {
  late SqliteService _sqliteService;
  @override
  void initState() {
    _sqliteService = SqliteService();
    super.initState();
    refreshNotes();
  }

  List<User> users = [];

  void refreshNotes() async {
    final data = await _sqliteService.getItems();
    setState(() {
      users = data;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("User List"),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const AddDataToDatabase()));
        },
        child: const Icon(
          Icons.add,
          color: Colors.green,
        ),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          return ListTile(
            trailing: SizedBox(
              width: 200,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                      onPressed: () async {
                        Navigator.pop(context);
                      },
                      icon: const Icon(Icons.edit)),
                  IconButton(
                      onPressed: () async {
                        await _sqliteService.deleteItem("${index + 1}");
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      )),
                ],
              ),
            ),
            title: Text(users[index].name.toString()),
          );
        },
      ),
    );
  }
}
