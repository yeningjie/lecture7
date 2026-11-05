import 'package:flutter/material.dart';

/// 参数化复用组件 1：首页分类卡片。
/// 变化点通过构造入参传入：分类名、藏书数量、图标、主题色、点击回调。
class CategoryCard extends StatelessWidget {
  final String name;
  final int count;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  const CategoryCard({
    super.key,
    required this.name,
    required this.count,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: color,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: Colors.white, size: 22),
              ),
              const Spacer(),
              Text(
                name,
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1F2430),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                '$count 本',
                style: const TextStyle(fontSize: 13, color: Color(0xFF8A93A6)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
