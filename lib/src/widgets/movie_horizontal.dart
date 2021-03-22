import 'package:flutter/material.dart';
import 'package:peliculas/src/models/movie_model.dart';

// ignore: must_be_immutable
class MovieHorizontal extends StatelessWidget {

  List<Movie> movies = [];
  final Function nextPage;
  
  MovieHorizontal( { @required this.movies, @required this.nextPage } );


  final _pageController = new PageController(
      initialPage: 1,
      viewportFraction: 0.3
  );

  @override
  Widget build(BuildContext context) {

    _pageController.addListener(() {
      if( _pageController.position.pixels >= _pageController.position.maxScrollExtent-200 ) {
        nextPage();
      }
    });

    final _screenSize = MediaQuery.of( context ).size;

    return Container(
      height: _screenSize.height * 0.2,
      child: PageView.builder(
        pageSnapping: false,
        controller: _pageController,
        /* children: _cards( context ), */
        itemCount: movies.length,
        itemBuilder: ( context, i ) =>  _createHorizontalCards( context, movies[i] ),
      ),
    );
  }

  GestureDetector _createHorizontalCards( BuildContext ctx, Movie movie ) {

    movie.uniqueId = '${ movie.id }-horizontal';

    final card = Container(
        margin: EdgeInsets.only( right: 15.0 ),
        child: Column(
          children: <Widget>[
            Hero(
              tag: movie.uniqueId,
              child: ClipRRect(
                borderRadius: BorderRadius.circular( 10.0 ),
                child: FadeInImage(
                  image: NetworkImage( movie.getPosterImg() ),
                  placeholder: AssetImage( 'assets/img/no-image.jpg'),
                  fit: BoxFit.cover,
                  height: 96.0,
                ),
              ),
            ),
            SizedBox(
              height: 5.0,
            ),
            Text( movie.title, overflow: TextOverflow.ellipsis, style: Theme.of(ctx).textTheme.caption, ),   
          ],
        ),
      );

    return GestureDetector(
      child: card,
      onTap: () {
        Navigator.pushNamed( ctx, 'detail', arguments: movie );
      }
    );

  }

}