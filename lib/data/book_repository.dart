import 'dart:convert';

import 'package:flutter/services.dart' show rootBundle;

import '../models/book.dart';

/// 数据仓库：启动时把 assets/books.json 读进内存，各页面共用同一份数据。
class BookRepository {
  static const List<String> categories = ['文学', '科技', '历史', '艺术', '经济'];

  static List<Book> _books = const [];

  static List<Book> get all => _books;

  static Future<void> load() async {
    final raw = await rootBundle.loadString('assets/books.json');
    final list = jsonDecode(raw) as List<dynamic>;
    _books = list
        .map((e) => Book.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// 按分类过滤；“全部”返回全部图书。
  static List<Book> byCategory(String category) {
    if (category == '全部') {
      return all;
    }
    return all.where((b) => b.category == category).toList();
  }

  static int countOf(String category) => byCategory(category).length;
}
