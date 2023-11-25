import 'package:flutter/material.dart';
import 'package:beeflix2/model/movie_detail_model.dart';
import 'package:beeflix2/service/api_service.dart';

class DetailScreen extends StatefulWidget {
  final String title, poster_path;
  final num id;
  final String base_url = "https://image.tmdb.org/t/p/w500";

  const DetailScreen({
    super.key,
    required this.title,
    required this.poster_path,
    required this.id,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Future<MovieDetailModel> movie;

  @override
  void initState() {
    super.initState();
    movie = ApiSerivce.getMovieById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.fill,
          image: NetworkImage(widget.base_url + widget.poster_path),
          opacity: 0.25,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                const SizedBox(
                  height: 350,
                ),
                FutureBuilder(
                  future: movie,
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              snapshot.data!.title,
                              style: const TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.w600,
                                color: Colors.black,
                              ),
                            ),
                            StarRating(
                              rating: snapshot.data!.vote_average,
                            ),
                            Text(
                              snapshot.data!.genres,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.black,
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            const Text(
                              'Story line',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 22,
                                color: Colors.black,
                              ),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                              textAlign: TextAlign.start,
                            ),
                            Text(
                              snapshot.data!.overview,
                              style: const TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                              ),
                            ),
                          ],
                        ),
                      );
                    }
                    return const Text("...");
                  },
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class StarRating extends StatelessWidget {
  final num rating;

  const StarRating({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    int fullStars = rating ~/ 2;
    bool hasHalfStar = (rating - fullStars) >= 0.5;
    print("rating: $rating");
    return Row(
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(5, (index) {
            if (index < fullStars) {
              return const Icon(
                Icons.star,
                color: Colors.yellow,
              );
            } else if (index == fullStars && hasHalfStar) {
              return const Icon(
                Icons.star_half,
                color: Colors.yellow,
              );
            } else {
              return const Icon(
                Icons.star_border,
                color: Colors.grey,
              );
            }
          }),
        ),
        Text(
          rating.toStringAsFixed(1),
          style: const TextStyle(
            fontSize: 18,
            color: Colors.black,
          ),
        )
      ],
    );
  }
}
