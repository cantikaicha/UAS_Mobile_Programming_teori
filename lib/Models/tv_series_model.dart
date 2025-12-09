class TvSeries {
  final int id;
  final String name;
  final String? posterPath;
  final double voteAverage;
  final String? firstAirDate;

  TvSeries({
    required this.id,
    required this.name,
    this.posterPath,
    required this.voteAverage,
    this.firstAirDate,
  });

  factory TvSeries.fromJson(Map<String, dynamic> json) {
    return TvSeries(
      id: json['id'],
      name: json['name'],
      posterPath: json['poster_path'],
      voteAverage: (json['vote_average'] as num).toDouble(),
      firstAirDate: json['first_air_date'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'poster_path': posterPath,
      'vote_average': voteAverage,
      'first_air_date': firstAirDate,
    };
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      "poster_path": posterPath,
      "vote_average": voteAverage,
      "Date": firstAirDate,
      "id": id,
    };
  }
}
