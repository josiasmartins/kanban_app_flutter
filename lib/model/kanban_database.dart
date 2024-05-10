import 'package:flutter/material.dart';
import 'package:isar/isar.dart';
import 'package:kanban_app/model/kanban.dart';

import 'package:path_provider/path_provider.dart';

class KanbanDataBase extends ChangeNotifier {
  static late Isar isar;

  // INITIALIZE DATABASE
  static Future<void> initialize() async {
    final dir = await getApplicationCacheDirectory();
    isar = await Isar.open([KanbanSchema], directory: dir.path);
  }

  // list of kanban
  final List<Kanban> currentNotes = [];

  // CREATE - a kanban and save to db
  Future<void> addKanban(String textFromUser) async {
    // create a new kanban object
    final newKanban = Kanban()..text = textFromUser;

    // save to db
    await isar.writeTxn(() => isar.kanbans.put(newKanban));

    // re-read from db
    fetchKanbans();
  }

  // READ - kanban from db
  Future<void> fetchKanbans() async {
    List<Kanban> fetchKanbans = await isar.kanbans.where().findAll();
    currentNotes.clear();
    currentNotes.addAll(fetchKanbans);
    notifyListeners();
  }

  // UPDATE - kanban in db
  Future<void> updateKanban(int id, String newText) async {
    final existingKanban = await isar.kanbans.get(id);
    if (existingKanban != null) {
      existingKanban.text = newText;
      await isar.writeTxn(() => isar.kanbans.put(existingKanban));
      await fetchKanbans();
    }
  }

  // DELETE - a kanban from the db
  Future<void> deleteKanban(int id) async {
    await isar.writeTxn(() => isar.kanbans.delete(id));

    // re-read kanban
    await fetchKanbans();
  }
}
