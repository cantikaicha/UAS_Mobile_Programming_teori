class Movie {
  final int id;
  final String title;
  final String? posterPath;
  final double voteAverage;
  final String? releaseDate;

  Movie({
    required this.id,
    required this.title,
    this.posterPath,
    required this.voteAverage,
    this.releaseDate,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'],
      title: json['title'],
      posterPath: json['poster_path'],
      voteAverage: (json['vote_average'] as num).toDouble(),
      releaseDate: json['release_date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'poster_path': posterPath,
      'vote_average': voteAverage,
      'release_date': releaseDate,
    };
  }
}
