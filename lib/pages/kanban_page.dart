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
        centerTitle: true,
        title: Text(
          "Kanban app",
          style: TextStyle(
            color: Color.fromARGB(255, 108, 55, 223),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("PRESSIONADO");
        },
        child: Text(
          "Proximo",
          style: TextStyle(color: Colors.white),
        ),
        // shape:,
        backgroundColor: Color.fromARGB(255, 64, 14, 150),
      ),
      body: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        // mainAxisAlignment: MainAxisAlignment.center,
        //verticalDirection: VerticalDirection.down,
        children: [
          Padding(
            padding: EdgeInsets.all(24),
          ),
          Center(
            child: Text("Newww"),
          ),
          Text(
            "New",
          ),
        ],
      ),
    );
  }
}
