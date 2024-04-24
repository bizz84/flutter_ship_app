import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_ship_app/src/data/category.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'template_loader.g.dart';

@Riverpod(keepAlive: true)
Future<List<Category>> loadFromTemplate(LoadFromTemplateRef ref) async {
  String jsonString = await rootBundle.loadString('checklist_template.json');
  List<dynamic> jsonResponse = jsonDecode(jsonString);
  return jsonResponse.map((category) => Category.fromJson(category)).toList();
}
