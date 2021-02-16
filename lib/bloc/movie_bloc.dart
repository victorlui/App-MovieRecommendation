import 'package:flutter/foundation.dart';
import 'package:movie_recomendation/model/movie_reponse.dart';
import 'package:movie_recomendation/repositories/repository.dart';
import 'package:rxdart/subjects.dart';

class MovieBloc {
   final UserRepository _repository = UserRepository();

   final BehaviorSubject<MovieResponse> _subject = BehaviorSubject<MovieResponse>();

   getMovie(int genre, int miniImdb) async {
     MovieResponse response = await _repository.getMovie(genre,miniImdb);
     _subject.sink.add(response);
   }

   void drainStream(){
     _subject.value = null;
   }

   @mustCallSuper
   void dispose() async{
     await _subject.drain();
     _subject.close();
   }

   BehaviorSubject<MovieResponse> get subject => _subject;

}

final movieBloc = MovieBloc();