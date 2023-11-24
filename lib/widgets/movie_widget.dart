import 'package:flutter/material.dart';
import 'package:beeflix2/screens/detail_screen.dart';

class Movie extends StatelessWidget {
  final String title, backdropPath, posterPath;
  final int id;
  final double moiveWidth;
  final String baseUrl = "https://image.tmdb.org/t/p/w500";

  const Movie({
    super.key,
    required this.title,
    required this.backdropPath,
    required this.posterPath,
    required this.id,
    required this.moiveWidth,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => DetailScreen(
              title: title,
              posterPath: posterPath,
              id: id,
            ),
          ),
        );
      },
      child: Column(
        children: [
          Hero(
            tag: id,
            child: Container(
              width: moiveWidth,
              clipBehavior: Clip.hardEdge,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    blurRadius: 15,
                    offset: const Offset(10, 10),
                    color: Colors.black.withOpacity(0.3),
                  )
                ],
              ),
              child: Image.network(
                backdropPath == ''
                    ? baseUrl + posterPath
                    : baseUrl + backdropPath,
                headers: const {
                  "User-Agent":
                      "Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/110.0.0.0 Safari/537.36",
                },
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: 150,
            child: Text(
              title,
              style: const TextStyle(
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
