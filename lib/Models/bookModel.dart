class Book {
  final String id;
  final String title;
  final String? authors;
  final String? description;
  final String? thumbnail;
  final String? category;
  final String? url;

  Book({
    required this.id,
    required this.title,
    this.authors,
    this.description,
    this.thumbnail,
    this.category,
    this.url,
  });

  factory Book.fromJson(Map<String, dynamic> json) {
    return Book(
      id: json['id'],
      title: json['volumeInfo']['title'] ?? 'No title available',
      authors: (json['volumeInfo']['authors'] as List<dynamic>?)?.join(', '),
      description:
          json['volumeInfo']['description'] ?? 'No description available',
      thumbnail: json['volumeInfo']['imageLinks'] != null
          ? json['volumeInfo']['imageLinks']['thumbnail']
          : null,
      category: (json['volumeInfo']['categories'] as List<dynamic>?)?.first,
      url: json['volumeInfo']['infoLink'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'volumeInfo': {
        'title': title,
        'authors': authors != null ? authors!.split(', ') : null,
        'description': description,
        'imageLinks': {
          'thumbnail': thumbnail,
        },
        'categories': category != null ? [category] : null,
        'infoLink': url,
      },
    };
  }
}
