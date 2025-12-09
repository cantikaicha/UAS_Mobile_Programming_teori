class TrendingItem {
  final int id;
  final String? posterPath;
  final double voteAverage;
  final String mediaType;
  final String? title;
  final String? name;

  TrendingItem({
    required this.id,
    this.posterPath,
    required this.voteAverage,
    required this.mediaType,
    this.title,
    this.name,
  });

  factory TrendingItem.fromJson(Map<String, dynamic> json) {
    return TrendingItem(
      id: json['id'],
      posterPath: json['poster_path'],
      voteAverage: (json['vote_average'] as num).toDouble(),
      mediaType: json['media_type'],
      title: json['title'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'poster_path': posterPath,
      'vote_average': voteAverage,
      'media_type': mediaType,
      'title': title,
      'name': name,
    };
  }

  String get displayTitle => title ?? name ?? '';
}
