class MovieModel {
  final String title, backdrop_path, poster_path;
  final int id;

  MovieModel.fromJson(Map<String, dynamic> json)
      : title = json['title'],
        backdrop_path = json['backdrop_path'],
        poster_path = json['poster_path'],
        id = json['id'];
}