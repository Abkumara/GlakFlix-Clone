import 'dart:convert';

import 'package:glak_flix_app/MODEL/model_type.dart';
import 'package:http/http.dart' as http;

class ApiTools {
  static const apiKey = "bf260b0c2df5fc89a1c6700bf92dfd4e";
  static const imageUrl = "https://image.tmdb.org/t/p/w500";
}

class Api {
  static const _popularMoviesUrl =
      'https://api.themoviedb.org/3/movie/popular?api_key=${ApiTools.apiKey}';

  static const _ratingMoviesUrl =
      'https://api.themoviedb.org/3/movie/top_rated?api_key=${ApiTools.apiKey}';
  static const _upComingMovies =
      'https://api.themoviedb.org/3/movie/upcoming?api_key=${ApiTools.apiKey}';

  static const _popularTvShowsUrl =
      'https://api.themoviedb.org/3/tv/popular?api_key=${ApiTools.apiKey}';
  static const _ratedTvShowsUrl =
      'https://api.themoviedb.org/3/tv/top_rated?api_key=${ApiTools.apiKey}';
  static const _trendingTvShowsUrl =
      'https://api.themoviedb.org/3/trending/tv/day?api_key=${ApiTools.apiKey}';
  static const _searchMovieUrl =
      'https://api.themoviedb.org/3/search/movie?api_key=${ApiTools.apiKey}&query=';
  static const _searchTvShowsUrl =
      'https://api.themoviedb.org/3/search/tv?api_key=${ApiTools.apiKey}&query=';

  Future<List<ModelType>> getPopularMovies() async {
    final response = await http.get(Uri.parse(_popularMoviesUrl));
    if (response.statusCode == 200) {
      final passData = json.decode(response.body)['results'] as List;

      return passData
          .map((modelType) => ModelType.fromJson(modelType))
          .toList();
    } else {
      throw Exception('Something error ');
    }
  }

  Future<List<ModelType>> getSearchMovie(String query) async {
    final response = await http.get(Uri.parse('$_searchMovieUrl$query'));
    if (response.statusCode == 200) {
      final passData = json.decode(response.body)['results'] as List;

      return passData
          .map((modelType) => ModelType.fromJson(modelType))
          .toList();
    } else {
      throw Exception('Something error ');
    }
  }

  Future<List<ModelType>> getSearchTvShows(String query) async {
    final response = await http.get(Uri.parse('$_searchTvShowsUrl$query'));
    if (response.statusCode == 200) {
      final passData = json.decode(response.body)['results'] as List;

      return passData
          .map((modelType) => ModelType.fromJson(modelType))
          .toList();
    } else {
      throw Exception('Something error ');
    }
  }

  Future<List<ModelType>> getRatedTvShows() async {
    final response = await http.get(Uri.parse(_ratedTvShowsUrl));
    if (response.statusCode == 200) {
      final passData = json.decode(response.body)['results'] as List;

      return passData
          .map((modelType) => ModelType.fromJson(modelType))
          .toList();
    } else {
      throw Exception('Something error ');
    }
  }

  Future<List<ModelType>> getTrendingTvShows() async {
    final response = await http.get(Uri.parse(_trendingTvShowsUrl));
    if (response.statusCode == 200) {
      final passData = json.decode(response.body)['results'] as List;

      return passData
          .map((modelType) => ModelType.fromJson(modelType))
          .toList();
    } else {
      throw Exception('Something error ');
    }
  }

  Future<List<ModelType>> getPopularTvShows() async {
    final response = await http.get(Uri.parse(_popularTvShowsUrl));
    if (response.statusCode == 200) {
      final passDat = json.decode(response.body)['results'] as List;

      return passDat.map((modelType) => ModelType.fromJson(modelType)).toList();
    } else {
      throw Exception('something error');
    }
  }

  Future<List<ModelType>> getUpcomingMovies() async {
    final response = await http.get(Uri.parse(_upComingMovies));
    if (response.statusCode == 200) {
      final passUpcomingMovieData =
          json.decode(response.body)['results'] as List;

      return passUpcomingMovieData
          .map((modelType) => ModelType.fromJson(modelType))
          .toList();
    } else {
      throw Exception('Something error ');
    }
  }

  Future<List<ModelType>> getRatedMovies() async {
    final response = await http.get(Uri.parse(_ratingMoviesUrl));
    if (response.statusCode == 200) {
      final passRatingMovieData = json.decode(response.body)['results'] as List;

      return passRatingMovieData
          .map((modelType) => ModelType.fromJson(modelType))
          .toList();
    } else {
      throw Exception('Something error hi');
    }
  }
}
