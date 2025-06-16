class Book {
  final String id;
  final String title;
  final List<String> authors;
  final String description;
  final String thumbnailUrl;
  final String category;
  final double rating;
  final int pageCount;

  Book({
    required this.id,
    required this.title,
    required this.authors,
    required this.description,
    required this.thumbnailUrl,
    required this.category,
    required this.rating,
    required this.pageCount,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    final volumeInfo = json['volumeInfo'];
    return Book(
      id: json['id'] ?? '',
      title: volumeInfo['title'] ?? '',
      authors: List<String>.from(volumeInfo['authors'] ?? []),
      description: volumeInfo['description'] ?? '',
      thumbnailUrl: volumeInfo['imageLinks']?['thumbnail'] ?? '',
      category: volumeInfo['categories']?.first ?? '',
      rating: (volumeInfo['averageRating'] ?? 0.0).toDouble(),
      pageCount: volumeInfo['pageCount'] ?? 0,
    );
  }
}
