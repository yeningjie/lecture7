import 'package:flutter/material.dart';

import '../data/book_repository.dart';
import '../data/category_style.dart';
import '../models/book.dart';
import '../widgets/book_tile.dart';

/// 第二页：列表页。ListView.builder 懒构建 + “加载更多”每次追加 20 条；
/// 长按列表项弹出筛选层，选择结果通过 pop 回传给首页。
class ListPage extends StatefulWidget {
  const ListPage({super.key});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  static const int _pageSize = 20;

  String _category = '全部';
  int _visible = _pageSize;
  String? _lastAction;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // 去程传参：首页把分类名作为 arguments 传来，这里强类型接收。
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args is String) {
      _category = args;
    }
  }

  List<Book> get _books => BookRepository.byCategory(_category);

  Future<void> _openDetail(Book book) async {
    final result = await Navigator.pushNamed(
      context,
      '/detail',
      arguments: book,
    );
    // 回程传值：详情页“借阅”按钮 pop 回来的文字，在发起端接住。
    if (result != null && mounted) {
      setState(() => _lastAction = result as String);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(result as String)));
    }
  }

  Future<void> _showFilterSheet() async {
    final selected = await showModalBottomSheet<String>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (sheetContext) => SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Padding(
              padding: EdgeInsets.symmetric(vertical: 14),
              child: Text(
                '长按筛选',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.local_fire_department),
              title: const Text('仅看高借阅量'),
              subtitle: const Text('借阅次数 ≥ 50'),
              onTap: () => Navigator.pop(sheetContext, '仅看高借阅量'),
            ),
            const SizedBox(height: 8),
          ],
        ),
      ),
    );
    if (selected != null && mounted) {
      // 把选择结果回传首页，首页显示在 AppBar 副标题。
      Navigator.pop(context, selected);
    }
  }

  @override
  Widget build(BuildContext context) {
    final books = _books;
    final accent = CategoryStyle.colorOf(_category);
    final itemCount = _visible < books.length ? _visible + 1 : books.length;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$_category（共 ${books.length} 本）',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 2),
            Text(
              _lastAction == null
                  ? '已显示 ${_visible < books.length ? _visible : books.length} 本'
                  : '上次操作：$_lastAction',
              style: const TextStyle(fontSize: 12, color: Color(0xFF8A93A6)),
            ),
          ],
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
        itemCount: itemCount,
        itemBuilder: (context, index) {
          if (index >= _visible) {
            return Padding(
              padding: const EdgeInsets.only(top: 8),
              child: Center(
                child: FilledButton.tonal(
                  onPressed: () => setState(() => _visible += _pageSize),
                  child: Text('加载更多（已显示 $_visible / ${books.length}）'),
                ),
              ),
            );
          }
          final book = books[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: BookTile(
              book: book,
              accent: accent,
              onTap: () => _openDetail(book),
              onLongPress: _showFilterSheet,
            ),
          );
        },
      ),
    );
  }
}
