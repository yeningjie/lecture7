# app_skeleton

第 9 周·第 7 课《可滚动组件与多页面结构》课堂案例复现与自主实践仓库（远端 `lecture7`）。

## 页面与路由

| 路由 | 文件 | 内容 |
| --- | --- | --- |
| `/` | `lib/pages/home_page.dart` | 网格首页：5 个分类 + “全部”入口（`GridView.builder` 响应式列数），AppBar 副标题显示列表页回传的筛选结果 |
| `/list` | `lib/pages/list_page.dart` | 列表页：`ListView.builder` 懒构建，每页 20 条、“加载更多”每次追加 20 条，长按列表项弹出“仅看高借阅量”并把结果 pop 回首页 |
| `/detail` | `lib/pages/detail_page.dart` | 详情页：`arguments` 接收 `Book` 实例，完整显示字段；“借阅并回传”把结果 pop 回列表页 |
| `/about` | `lib/pages/about_page.dart` | 关于页：展示命名路由表与组件抽取清单 |

## 组件抽取（`lib/widgets/`）

- `category_card.dart` —— 分类卡片，入参：名称、藏书数量、图标、主题色、点击回调；
- `book_tile.dart` —— 列表项，入参：`Book`、主题色、点击与长按回调。

## 运行

```bash
flutter pub get
flutter run -d chrome      # 或 -d windows
```

## 数据

- `assets/books.json` —— 60 本模拟藏书（5 个分类，每类 12 本），字段：`id/title/author/category/year/borrowCount/description`；
- `lib/models/book.dart` —— 第 4 课的 `Book` 模型，本课直接复用并补 `fromJson`；
- `lib/data/book_repository.dart` —— 启动时把 JSON 读入内存，页面共用同一份数据。

## 验证

```bash
dart analyze lib test      # No issues found!
flutter test               # 3 个用例全部通过
flutter build web --release
```

## 目录说明

- `lib/pages/` —— 三页骨架 + 关于页
- `lib/widgets/` —— 两个参数化复用组件
- `docs/screenshots/` —— 运行、`flutter doctor`、Git 记录截图
- `progress.md` —— 进度报告七（与提交到雨课堂的 docx 内容一致）

## Git 提交记录

```
chore: flutter create app_skeleton 初始工程（含 books.json 与 Book 模型）
feat: list page with builder（懒构建列表 + 加载更多每次追加 20 条）
feat: named routes & typed arguments（4 条命名路由、Book 参数与回传筛选值）
test: widget tests for paging & pop-with-value
docs: README、进度报告与截图目录
```
