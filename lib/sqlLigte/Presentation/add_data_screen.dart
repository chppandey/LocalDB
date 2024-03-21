import 'package:database/sqlLigte/Model/notes_model.dart';
import 'package:database/sqlLigte/Service/sqlite_service.dart';
import 'package:flutter/material.dart';

class AddDataToDatabase extends StatefulWidget {
  const AddDataToDatabase({super.key});

  @override
  State<AddDataToDatabase> createState() => _AddDataToDatabaseState();
}

class _AddDataToDatabaseState extends State<AddDataToDatabase> {
  late SqliteService _sqliteService;
  @override
  void initState() {
    super.initState();
    _sqliteService = SqliteService();
    _sqliteService.initializeDB().whenComplete(() async {
      print("dasdhfgahj");
      var res = await _sqliteService.getAllProjects();
      print("db---> $res");
    });
  }

  final username = TextEditingController();
  final userEmail = TextEditingController();
  final userQlf = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Inser data"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(
                  label: Text("userName"), border: OutlineInputBorder()),
              controller: username,
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                  label: Text("userEmail"), border: OutlineInputBorder()),
              controller: userEmail,
            ),
            const SizedBox(height: 20),
            TextField(
              decoration: const InputDecoration(
                  label: Text("Qualification"), border: OutlineInputBorder()),
              controller: userQlf,
            )
          ],
        ),
      ),
      bottomSheet: ElevatedButton(
          onPressed: () async {
            var reqModel = User(
                id: 1,
                name: username.text,
                email: userEmail.text,
                qualification: userQlf.text);
            await _sqliteService.createItem(reqModel);
            Navigator.pop(context);
          },
          child: const Text("  Save   ")),
    );
  }
}
