import 'package:flutter/material.dart';

/// 第四条命名路由：关于页。说明路由表与组件抽取，便于检查点答辩时对照。
class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    const rows = [
      ('/', '首页网格（本页入口）'),
      ('/list', '列表页，arguments 传分类名'),
      ('/detail', '详情页，arguments 传 Book 实例'),
      ('/about', '关于页（本页）'),
    ];

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        title: const Text('关于本示例'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          const Text(
            '命名路由表',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: Column(
              children: [
                for (final row in rows)
                  ListTile(
                    leading: Chip(
                      label: Text(
                        row.$1,
                        style: const TextStyle(fontSize: 12),
                      ),
                    ),
                    title: Text(
                      row.$2,
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 18),
          const Text(
            '组件抽取',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
            ),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'lib/widgets/category_card.dart —— 分类卡片（入参：名称、数量、图标、主题色、回调）',
                  style: TextStyle(fontSize: 13, height: 1.8),
                ),
                Text(
                  'lib/widgets/book_tile.dart —— 列表项（入参：Book、主题色、点击与长按回调）',
                  style: TextStyle(fontSize: 13, height: 1.8),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
