import 'package:flutter/material.dart';

import '../models/book.dart';

/// 参数化复用组件 2：列表项卡片。
/// 数据（book）、行为（onTap / onLongPress）、样式（accent 主题色）均可由外部注入。
class BookTile extends StatelessWidget {
  final Book book;
  final Color accent;
  final VoidCallback onTap;
  final VoidCallback? onLongPress;

  const BookTile({
    super.key,
    required this.book,
    required this.accent,
    required this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(16),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: onTap,
        onLongPress: onLongPress,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 56,
                decoration: BoxDecoration(
                  color: accent,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(
                  Icons.menu_book,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      book.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1F2430),
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '${book.author} · ${book.category} · ${book.year}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF8A93A6),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${book.borrowCount}次',
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: book.isHot ? const Color(0xFFE0668A) : accent,
                    ),
                  ),
                  const SizedBox(height: 2),
                  const Text(
                    '借阅',
                    style: TextStyle(fontSize: 11, color: Color(0xFFA8B0C0)),
                  ),
                ],
              ),
              const Icon(Icons.chevron_right, color: Color(0xFFC3CAD8)),
            ],
          ),
        ),
      ),
    );
  }
}
