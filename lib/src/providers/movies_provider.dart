import 'package:peliculas/src/models/actors_model.dart';
import 'package:peliculas/src/models/movie_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:async';

class MoviesProvider {
  String _apiKey = '42bf37df2f8754c30930d1931c28f7a7';
  String _url = 'api.themoviedb.org';
  String _language = 'es-ES';
  int _page = 0;
  bool _loading = false;

  List<Movie> _populares = [];

  final _popularStreamController = StreamController<List<Movie>>.broadcast();


  Function( List<Movie> ) get popularesSink => _popularStreamController.sink.add;

  Stream<List<Movie>> get popularesStream => _popularStreamController.stream;


  void disposeStreams() => _popularStreamController?.close();



  Future<List<Movie>> _processResp( Uri url ) async {

    final http.Response resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode( resp.body );

    final Movies movies = new Movies.fromJsonList( decodedData['results'] );

    return movies.items;

  }

  Future<List<Movie>> getNowPlaying() async{

    final url = Uri.https( _url , '3/movie/now_playing', {
      'api_key'  : _apiKey,
      'language' : _language
    } );

    return await _processResp( url );
  }

  Future<List<Movie>> getPopularMovies() async {

    if( _loading ) return [];
    _loading = true;

    _page++;

    final url = Uri.https( _url, '3/movie/popular', {
      'api_key' : _apiKey,
      'language' : _language,
      'page'     : _page.toString(),
    } );

    final resp = await _processResp( url );

    _populares.addAll( resp );

    popularesSink( _populares );

    _loading = false;

    return resp;

  }

  Future<List<Actor>> getCast( String id ) async{

    final url = Uri.https( _url, '3/movie/$id/credits', {
      'api_key' : _apiKey,
      'language' : _language,
    } );

    final http.Response resp = await http.get( url );

    final Map<String, dynamic> decodedData = json.decode( resp.body );

    final Cast casting = new Cast.fromJsonList( decodedData['cast'] );

    return casting.actors;

  }

  Future<List<Movie>> searchMovie( String query ) async{

    final url = Uri.https( _url , '3/search/movie', {
      'api_key'  : _apiKey,
      'language' : _language,
      'query'    : query
    } );

    return await _processResp( url );
  }

}