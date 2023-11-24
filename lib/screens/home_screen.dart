import 'package:flutter/material.dart';
import 'package:beeflix2/models/movie_model.dart';
import 'package:beeflix2/services/api_service.dart';
import 'package:beeflix2/widgets/movie_widget.dart';

const POPULAR = 'Popular Movies';
const NOW = 'Now in Cinemas';
const COMING = 'Coming Soon';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  final Future<List<MovieModel>> movies = ApiSerivce.getPopularMovies();
  final Future<List<MovieModel>> moviesNow = ApiSerivce.getMoviesNow();
  final Future<List<MovieModel>> moviesComing = ApiSerivce.getComingMovies();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 80),
            _buildFutureBuilder(movies, POPULAR),
            _buildFutureBuilder(moviesNow, NOW),
            _buildFutureBuilder(moviesComing, COMING),
          ],
        ),
      ),
    );
  }

  FutureBuilder<List<MovieModel>> _buildFutureBuilder(
    Future<List<MovieModel>> future,
    String movieTitle,
  ) {
    return FutureBuilder(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  movieTitle,
                  style: const TextStyle(
                    color: Color(0xFF181818),
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              SizedBox(
                height: movieTitle == POPULAR ? 220 : 300,
                child: makeList(snapshot, movieTitle),
              )
            ],
          );
        }
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
  }

  ListView makeList(
    AsyncSnapshot<List<MovieModel>> snapshot,
    String movieTitle,
  ) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: snapshot.data!.length,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      itemBuilder: (context, index) {
        var movie = snapshot.data![index];
        return Movie(
          title: movieTitle == POPULAR ? '' : movie.title,
          backdropPath: movieTitle == POPULAR ? movie.backdropPath : '',
          posterPath: movie.posterPath,
          id: movie.id,
          moiveWidth: movieTitle == POPULAR ? 300 : 150,
        );
      },
      separatorBuilder: (context, index) => const SizedBox(width: 20),
    );
  }
}
