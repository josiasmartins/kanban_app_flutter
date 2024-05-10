import "package:isar/isar.dart";

// the line is needed to generate file
// then run: dart run build_runner build
part "kanban.g.dart";

@Collection()
class Kanban {
  Id id = Isar.autoIncrement;
  late String text;
}
