import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'dart:io';

class JsonStorage {
  static Future<File> _getFile(String name) async {
    final dir = await getApplicationDocumentsDirectory();
    return File('${dir.path}/$name.json');
  }

  static Future<void> save(String name, List<Map<String, dynamic>> data) async {
    final file = await _getFile(name);
    await file.writeAsString(jsonEncode(data));
  }

  static Future<List<Map<String, dynamic>>> load(String name) async {
    final file = await _getFile(name);
    if (!await file.exists()) return [];
    final List decoded = jsonDecode(await file.readAsString());
    return decoded.cast<Map<String, dynamic>>();
  }
}