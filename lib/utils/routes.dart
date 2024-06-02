import 'package:flutter/material.dart';
import 'package:praktikum06/ui/favorit.dart';
import 'package:praktikum06/ui/home_screen.dart';
import 'package:praktikum06/ui/login.dart';
import 'package:praktikum06/ui/notifikasi.dart';
import 'package:praktikum06/ui/profile.dart';
import 'package:praktikum06/ui/register.dart';
import 'package:praktikum06/ui/search_screen.dart';
import 'package:praktikum06/ui/genre_screen.dart';

MaterialPageRoute _pageRoute(
    {required Widget body, required RouteSettings settings}) =>
    MaterialPageRoute(builder: (_) => body, settings: settings);

Route? generateRoute(RouteSettings settings) {
  Route? _route;
  final _args = settings.arguments;
  switch (settings.name) {
    case rLogin:
      _route = _pageRoute(body: LoginScreen(), settings: settings);
      break;
    case rRegister:
      _route = _pageRoute(body: RegisterScreen(), settings: settings);
      break;
    case rHome:
      _route = _pageRoute(body: HomeScreen(), settings: settings);
      break;
    case rProfile:
      _route = _pageRoute(body: ProfileScreen(), settings: settings);
      break;
    case rFavorite:
      _route = _pageRoute(body: FavoriteScreen(), settings: settings);
      break;
    case rNotification:
      _route = _pageRoute(body: NotificationScreen(), settings: settings);
      break;
    case rSearch:
      _route = _pageRoute(body: SearchScreen(query: _args as String), settings: settings);
      break;
    case rGenre:
      _route = _pageRoute(body: GenreScreen(), settings: settings);
      break;
  }
  return _route;
}

const String rLogin = '/login';
const String rRegister = '/register';
const String rHome = '/home';
const String rProfile = '/profile';
const String rFavorite = '/favorite';
const String rNotification = '/notification';
const String rSearch = '/search';
const String rGenre = '/genre';

final GlobalKey<NavigatorState> NAV_KEY = GlobalKey<NavigatorState>();
