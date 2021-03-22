import 'package:flutter/material.dart';
import 'package:peliculas/src/pages/movie_details_page.dart';

import 'src/pages/home_page.dart';
 
void main() => runApp(MyApp());
 
class MyApp extends StatelessWidget {
  @override
  MaterialApp build(BuildContext context) => MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Películas',
      initialRoute: '/',
      routes: {
        '/' : (context) => HomePage(),
        'detail' : (context) => MovieDetail(),
      },
    );
}