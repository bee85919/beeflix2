class MovieDetailModel {
  num id, voteAerage;
  String title, overview;
  String genres;

  MovieDetailModel({
    required this.id,
    required this.title,
    required this.genres,
    required this.overview,
    required this.voteAerage,
  });

  factory MovieDetailModel.fromJson(Map<String, dynamic> jsonData) {
    List<dynamic> genreData = jsonData['genres'];
    String genres = genreData.map((genre) => genre['name']).join(', ');

    return MovieDetailModel(
      id: jsonData['id'],
      title: jsonData['title'],
      genres: genres,
      overview: jsonData['overview'],
      voteAerage: jsonData['vote_average'],
    );
  }
}
