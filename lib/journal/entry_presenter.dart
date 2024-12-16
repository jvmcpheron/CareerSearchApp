import 'dart:core';
import 'entry.dart';
import 'entry_manager.dart';

class EntryPresenter {

  final EntryManager _entryManager = EntryManager();

  List<Entry> getEntries() {
    return _entryManager.getEntries();
  }

  Future<void> addEntry(Entry e) {
    return _entryManager.addEntry(e);
  }

  Future<void> editEntry(Entry e) {
    return _entryManager.editEntry(e);
  }

  Future<void> removeEntry(Entry e) {
    return _entryManager.removeEntry(e);
  }

}