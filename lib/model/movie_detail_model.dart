class MovieDetailModel {
  num id, vote_average;
  String title, overview;
  String genres;

  MovieDetailModel({
    required this.id,
    required this.title,
    required this.genres,
    required this.overview,
    required this.vote_average,
  });

  factory MovieDetailModel.fromJson(Map<String, dynamic> json_data) {
    List<dynamic> genre_data = json_data['genres'];
    String genres = genre_data.map((genre) => genre['name']).join(', ');

    return MovieDetailModel(
      id: json_data['id'],
      title: json_data['title'],
      genres: genres,
      overview: json_data['overview'],
      vote_average: json_data['vote_average'],
    );
  }
}
