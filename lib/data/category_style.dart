import 'package:flutter/material.dart';

/// 分类的展示样式（图标与主题色），首页卡片与列表页共用，避免两处硬编码不一致。
class CategoryStyle {
  static const Map<String, Color> _colors = {
    '文学': Color(0xFF6C8CFF),
    '科技': Color(0xFF38B6A0),
    '历史': Color(0xFFE0A458),
    '艺术': Color(0xFFB07CD6),
    '经济': Color(0xFFE06C75),
    '全部': Color(0xFF5C6BC0),
  };

  static const Map<String, IconData> _icons = {
    '文学': Icons.menu_book,
    '科技': Icons.memory,
    '历史': Icons.account_balance,
    '艺术': Icons.palette,
    '经济': Icons.trending_up,
    '全部': Icons.library_books,
  };

  static Color colorOf(String category) =>
      _colors[category] ?? const Color(0xFF4F7DF3);

  static IconData iconOf(String category) =>
      _icons[category] ?? Icons.library_books;
}
