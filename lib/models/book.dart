/// 图书模型：第 4 课定义的字段，本课直接复用。
class Book {
  final int id;
  final String title;
  final String author;
  final String category;
  final int year;
  final int borrowCount;
  final String description;

  const Book({
    required this.id,
    required this.title,
    required this.author,
    required this.category,
    required this.year,
    required this.borrowCount,
    required this.description,
  });

  /// 从 assets/books.json 的单条记录构造；强类型字段避免页面里到处写 Map。
  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'] as int,
      title: json['title'] as String,
      author: json['author'] as String,
      category: json['category'] as String,
      year: json['year'] as int,
      borrowCount: json['borrowCount'] as int,
      description: json['description'] as String,
    );
  }

  /// 借阅量 ≥ 50 视为“高借阅量”，用于回传值筛选。
  bool get isHot => borrowCount >= 50;
}
