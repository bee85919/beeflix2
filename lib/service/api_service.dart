import 'dart:convert';
import 'package:flutter/services.dart';

import 'package:http/http.dart' as http;
import 'package:beeflix2/model/movie_detail_model.dart';
import 'package:beeflix2/model/movie_model.dart';

class ApiSerivce {
  static const String base_url = "https://movies-api.nomadcoders.workers.dev";
  static const String popular_key = "popular";
  static const String now_key = "now-playing";
  static const String coming_key = "coming-soon";

  static Future<List<MovieModel>> getMoviesByKey(String key) async {
    List<MovieModel> movieInstances = [];
    final url = Uri.parse('$base_url/$key');
    final response = await http.get(url);

    if (response.statusCode == 200) {
      final movies = jsonDecode(response.body);
      for (var movie in movies["results"]) {
        movieInstances.add(MovieModel.fromJson(movie));
      }
      return movieInstances;
    } else {
      throw Error();
    }
  }

  static Future<List<MovieModel>> getPopularMovies() async {
    return getMoviesByKey(now_key);
  }

  static Future<List<MovieModel>> getMoviesNow() async {
    return getMoviesByKey(now_key);
  }

  static Future<List<MovieModel>> getComingMovies() async {
    return getMoviesByKey(coming_key);
  }

  static Future<MovieDetailModel> getMovieById(num id) async {
    final url = Uri.parse('$base_url/movie?id=$id');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      return MovieDetailModel.fromJson(jsonDecode(response.body));
    }
    throw Error();
  }
}
