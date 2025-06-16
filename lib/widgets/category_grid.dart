import 'package:flutter/material.dart';

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> categories = [
      {'icon': Icons.play_circle, 'name': 'Reels', 'color': Colors.pink[100]},
      {'icon': Icons.book, 'name': 'Sách', 'color': Colors.orange[100]},
      {'icon': Icons.headphones, 'name': 'Sách nói', 'color': Colors.blue[100]},
      {'icon': Icons.article, 'name': 'Truyện', 'color': Colors.red[100]},
      {'icon': Icons.photo_album, 'name': 'Truyện tranh', 'color': Colors.purple[100]},
      {'icon': Icons.edit_note, 'name': 'Danh ngôn', 'color': Colors.cyan[100]},
      {'icon': Icons.music_note, 'name': 'Thơ', 'color': Colors.deepPurple[100]},
      {'icon': Icons.collections_bookmark, 'name': 'Bộ sưu tập', 'color': Colors.indigo[100]},
      {'icon': Icons.tag, 'name': '#BXH', 'color': Colors.green[100]},
      {'icon': Icons.people, 'name': 'Cộng đồng', 'color': Colors.teal[100]},
      {'icon': Icons.translate, 'name': 'Song ngữ', 'color': Colors.blue[100]},
      {'icon': Icons.menu_book, 'name': 'Ngoại văn', 'color': Colors.cyan[100]},
      {'icon': Icons.language, 'name': 'Học T.A', 'color': Colors.indigo[100]},
      {'icon': Icons.more_horiz, 'name': 'Xem thêm', 'color': Colors.grey[100]},
    ];

    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 5,
          childAspectRatio: 0.8,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemCount: categories.length,
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: categories[index]['color'],
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  categories[index]['icon'],
                  color: Colors.black87,
                  size: 24,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                categories[index]['name'],
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          );
        },
      ),
    );
  }
}
