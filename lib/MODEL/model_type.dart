class ModelType {
  String? backdropPath;
  dynamic title;
  String overview;
  dynamic releaseDate;
  String? posterPath;
  String? tvTitle;
  String? airDate;

  ModelType({
    required this.backdropPath,
    required this.overview,
    required this.posterPath,
    required this.releaseDate,
    required this.title,
    required this.tvTitle,
    required this.airDate,
  });

  factory ModelType.fromJson(Map<String, dynamic> json) {
    return ModelType(
        backdropPath: json["backdrop_path"],
        overview: json["overview"],
        posterPath: json["poster_path"],
        releaseDate: json["release_date"],
        title: json["title"],
        tvTitle: json["name"],
        airDate: json["first_air_date"]);
  }
}
