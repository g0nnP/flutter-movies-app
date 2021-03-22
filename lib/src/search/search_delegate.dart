import 'package:flutter/material.dart';
import 'package:peliculas/src/models/movie_model.dart';
import 'package:peliculas/src/providers/movies_provider.dart';

class DataSearch extends SearchDelegate{

  final moviesProvider = MoviesProvider();

  String selection = '';

  final List<String> movies = [
    'Spiderman',
    'Godzilla',
    'Capitan America',
    'Hulk',
    'Ariana Grande',
    'Te amo amor',
  ];

  final List<String> recentMovies = [
    'Spiderman',
    'Capitan América'
  ];

  @override
  List<Widget> buildActions(BuildContext context) => [
    IconButton(
      icon: Icon( Icons.clear ),
      onPressed: () => query = ''
    )
  ];

  @override
  IconButton buildLeading(BuildContext context)=> IconButton(
    icon: AnimatedIcon(
      icon: AnimatedIcons.menu_arrow,
      progress: transitionAnimation
    ),
    onPressed: () => close( context, null ),
  );

  @override
  Center buildResults(BuildContext context) => Center(
    child: Container(
      height: 100.0,
      width: 100.0,
      color: Colors.pinkAccent,
      child: Text( selection ),
    )
  );

  @override
  Widget buildSuggestions(BuildContext context) {
    // Son las sugerencias que aparencen cuando la persona escribe

    if( query.isEmpty ) {
      return Container(
        child: Center(
          child: Text( 'Buscar películas', style: Theme.of( context ).textTheme.headline5 ),
        ),
      );
    }

    return FutureBuilder(
      future: moviesProvider.searchMovie( query ),
      builder: (BuildContext context, AsyncSnapshot<List<Movie>> snapshot) {

        if( snapshot.hasData ) {

          final movies = snapshot.data;
          
          return ListView(
            children: movies.map( (movie) {
              return ListTile(
                leading: FadeInImage(
                  image: NetworkImage( movie.getPosterImg() ),
                  placeholder: AssetImage( 'assets/img/no-image.jpg' ),
                  width: 50,
                  fit: BoxFit.contain
                ),
                title: Text( movie.title ),
                subtitle: Text( movie.overview, overflow: TextOverflow.ellipsis ),
                onTap: (){
                  movie.uniqueId = '${movie.id}-search';
                  Navigator.pushNamed( context , 'detail', arguments: movie );
                },
              );
            } ).toList()
          );
        } else {
          return Center(
            child: CircularProgressIndicator()
          );
        }

      },
    );

  }

  /* final suggestedList = ( query.isEmpty ) ? recentMovies : movies.where(
      ( p ) => p.toLowerCase().startsWith( query.toLowerCase() )
      ).toList();

    return ListView.builder(
      itemCount: suggestedList.length,
      itemBuilder: ( context, i ) {
        return ListTile(
          leading: Icon( Icons.movie ),
          title: Text(suggestedList[i]),
          onTap: (){
            selection = suggestedList[i];
            showResults( context );
          },
        );
      },
    ); */

}