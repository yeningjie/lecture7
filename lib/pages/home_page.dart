import 'package:flutter/material.dart';

import '../data/book_repository.dart';
import '../data/category_style.dart';
import '../widgets/category_card.dart';

/// 第一页：网格首页。分类入口进入列表页，接收列表页回传的筛选结果并显示在 AppBar 副标题。
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String _subtitle = '共 ${BookRepository.all.length} 本藏书 · 点击分类查看列表';

  Future<void> _openList(String category) async {
    final result = await Navigator.pushNamed(
      context,
      '/list',
      arguments: category,
    );
    // 回程传值：列表页 pop(context, ...) 带回来的字符串在这里接住。
    if (result != null && mounted) {
      setState(() => _subtitle = '筛选：$result');
    }
  }

  @override
  Widget build(BuildContext context) {
    final entries = [...BookRepository.categories, '全部'];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              '书架 · app_skeleton',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 2),
            Text(
              _subtitle,
              style: const TextStyle(fontSize: 12, color: Color(0xFF8A93A6)),
            ),
          ],
        ),
        actions: [
          IconButton(
            tooltip: '关于本页',
            onPressed: () => Navigator.pushNamed(context, '/about'),
            icon: const Icon(Icons.info_outline, color: Color(0xFF8A93A6)),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final columns = constraints.maxWidth >= 900
              ? 4
              : constraints.maxWidth >= 600
              ? 3
              : 2;
          return GridView.builder(
            padding: const EdgeInsets.all(16),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              mainAxisSpacing: 12,
              crossAxisSpacing: 12,
              childAspectRatio: 1.25,
            ),
            itemCount: entries.length,
            itemBuilder: (context, i) {
              final name = entries[i];
              return CategoryCard(
                name: name,
                count: BookRepository.countOf(name),
                icon: CategoryStyle.iconOf(name),
                color: CategoryStyle.colorOf(name),
                onTap: () => _openList(name),
              );
            },
          );
        },
      ),
    );
  }
}
