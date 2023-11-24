class MovieModel {
  final String title, backdropPath, posterPath;
  final int id;

  MovieModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        backdropPath = json["backdrop_path"],
        posterPath = json['poster_path'],
        id = json['id'];
}
