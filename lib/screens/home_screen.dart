import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../widgets/custom_bottom_nav.dart';
import '../widgets/category_grid.dart';
import '../widgets/featured_book_card.dart';
import '../widgets/recent_section.dart';
import '../widgets/recommended_section.dart';
import '../providers/book_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    debugPrint('HomeScreen initialized');
    // Load dữ liệu khi màn hình được khởi tạo
    Future.microtask(() {
      debugPrint('Loading initial data...');
      context.read<BookProvider>().loadInitialData();
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(48),
          child: SafeArea(
            bottom: false,
            child: AppBar(
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              flexibleSpace: const TabBar(
                isScrollable: true,
                padding: EdgeInsets.zero,
                indicatorColor: Colors.orange,
                labelColor: Colors.orange,
                unselectedLabelColor: Colors.black87,
                tabs: [
                  Tab(text: 'Khám phá'),
                  Tab(text: 'Mới nhất'),
                  Tab(text: 'Nổi bật'),
                ],
              ),
            ),
          ),
        ),
        body: TabBarView(
          children: [
            _buildDiscoverTab(),
            _buildNewestTab(),
            _buildTrendingTab(),
          ],
        ),
        bottomNavigationBar: const CustomBottomNav(),
      ),
    );
  }

  Widget _buildDiscoverTab() {
    return Consumer<BookProvider>(
      builder: (context, bookProvider, child) {
        debugPrint('Building discover tab. Loading: ${bookProvider.isLoading}');

        if (bookProvider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
            ),
          );
        }

        if (bookProvider.error != null) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.orange),
                const SizedBox(height: 16),
                Text(
                  'Đã xảy ra lỗi:\n${bookProvider.error}',
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.grey),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => bookProvider.loadInitialData(),
                  child: const Text('Thử lại'),
                ),
              ],
            ),
          );
        }

        if (bookProvider.featuredBooks.isEmpty) {
          debugPrint('No featured books available');
          return const Center(
            child: Text('Không tìm thấy sách nào'),
          );
        }

        debugPrint('Building list with ${bookProvider.featuredBooks.length} featured books');
        return ListView(
          padding: EdgeInsets.zero,
          children: [
            SizedBox(
              height: 200,
              child: PageView.builder(
                itemCount: bookProvider.featuredBooks.length,
                itemBuilder: (context, index) {
                  final book = bookProvider.featuredBooks[index];
                  debugPrint('Building featured book card: ${book.title}');
                  return FeaturedBookCard(book: book);
                },
              ),
            ),
            const CategoryGrid(),
            const RecentSection(),
            const RecommendedSection(),
          ],
        );
      },
    );
  }

  Widget _buildNewestTab() {
    return Consumer<BookProvider>(
      builder: (context, bookProvider, child) {
        if (bookProvider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
            ),
          );
        }

        if (bookProvider.error != null) {
          return Center(
            child: Text('Error: ${bookProvider.error}'),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: bookProvider.newestBooks.length,
          itemBuilder: (context, index) {
            return FeaturedBookCard(
              book: bookProvider.newestBooks[index],
            );
          },
        );
      },
    );
  }

  Widget _buildTrendingTab() {
    return Consumer<BookProvider>(
      builder: (context, bookProvider, child) {
        if (bookProvider.isLoading) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange),
            ),
          );
        }

        if (bookProvider.error != null) {
          return Center(
            child: Text('Error: ${bookProvider.error}'),
          );
        }

        return ListView.builder(
          padding: const EdgeInsets.all(16),
          itemCount: bookProvider.trendingBooks.length,
          itemBuilder: (context, index) {
            return FeaturedBookCard(
              book: bookProvider.trendingBooks[index],
            );
          },
        );
      },
    );
  }
}
