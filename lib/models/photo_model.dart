class Photo {
  final String id;
  final String author;
  final int width;
  final int height;
  final String url;
  final String downloadUrl;

  const Photo({
    required this.id,
    required this.author,
    required this.width,
    required this.height,
    required this.url,
    required this.downloadUrl,
  });

  factory Photo.fromJson(Map<String, dynamic> json) {
    return Photo(
      id: json['id']?.toString() ?? '',
      author: json['author']?.toString() ?? 'Unknown',
      width: json['width'] is int
          ? json['width'] as int
          : int.tryParse(json['width'].toString()) ?? 0,
      height: json['height'] is int
          ? json['height'] as int
          : int.tryParse(json['height'].toString()) ?? 0,
      url: json['url']?.toString() ?? '',
      downloadUrl: json['download_url']?.toString() ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'author': author,
      'width': width,
      'height': height,
      'url': url,
      'download_url': downloadUrl,
    };
  }
}
