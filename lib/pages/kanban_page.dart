import "package:flutter/material.dart";

class KanbanPage extends StatefulWidget {
  const KanbanPage({super.key});

  @override
  State<KanbanPage> createState() => _KanbanPage();
}

class _KanbanPage extends State<KanbanPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Kanban app",
          style: TextStyle(color: Colors.white),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("PRESSIONADO");
        },
        // shape:,
        backgroundColor: Color.fromARGB(255, 64, 14, 150),
      ),
      body: Column(
        children: [
          Text("Novo"),
        ],
      ),
    );
  }
}
