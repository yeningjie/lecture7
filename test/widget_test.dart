import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:app_skeleton/data/book_repository.dart';
import 'package:app_skeleton/main.dart';
import 'package:app_skeleton/widgets/book_tile.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  setUpAll(() async {
    await BookRepository.load();
  });

  testWidgets('首页网格显示 5 个分类与全部入口', (tester) async {
    await tester.pumpWidget(const AppSkeletonApp());
    await tester.pumpAndSettle();

    expect(find.text('书架 · app_skeleton'), findsOneWidget);
    for (final category in BookRepository.categories) {
      expect(find.text(category), findsOneWidget);
    }
    expect(find.text('全部'), findsOneWidget);
    expect(BookRepository.all.length, 60);
  });

  testWidgets('列表页首次显示 20 条，加载更多后追加到 40 条', (tester) async {
    await tester.pumpWidget(const AppSkeletonApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('全部'));
    await tester.pumpAndSettle();
    expect(find.text('全部（共 60 本）'), findsOneWidget);
    expect(find.text('已显示 20 本'), findsOneWidget);
    expect(find.byType(BookTile), findsWidgets);

    await tester.scrollUntilVisible(
      find.text('加载更多（已显示 20 / 60）'),
      240,
      scrollable: find.byType(Scrollable).last,
    );
    await tester.tap(find.text('加载更多（已显示 20 / 60）'));
    await tester.pumpAndSettle();
    expect(find.text('已显示 40 本'), findsOneWidget);
  });

  testWidgets('命名路由携带 Book 进入详情页，并把借阅结果回传列表页', (tester) async {
    await tester.pumpWidget(const AppSkeletonApp());
    await tester.pumpAndSettle();

    await tester.tap(find.text('全部'));
    await tester.pumpAndSettle();

    await tester.tap(find.byType(BookTile).first);
    await tester.pumpAndSettle();

    final firstBook = BookRepository.all.first;
    expect(find.text(firstBook.title), findsOneWidget);
    expect(find.text(firstBook.author), findsWidgets);

    await tester.ensureVisible(find.text('借阅并回传'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('借阅并回传'));
    await tester.pumpAndSettle();
    expect(find.text('上次操作：已借阅《${firstBook.title}》'), findsOneWidget);
  });
}
