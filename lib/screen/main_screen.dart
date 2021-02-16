import 'package:eva_icons_flutter/eva_icons_flutter.dart';
import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:movie_recomendation/bloc/movie_bloc.dart';
import 'package:movie_recomendation/model/item.dart';
import 'package:movie_recomendation/screen/card_back_screen.dart';
import 'package:movie_recomendation/screen/card_front_screen.dart';
import 'package:movie_recomendation/style/theme.dart' as Style;

class MainScreen extends StatefulWidget {
  MainScreen({Key key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();

  bool clicked = false;
  Item _selectedGenre;
  Item _selectedScore;

  List<Item> genres;
  List<Item> scores;

  @override
  void initState() {
    scores = [
      Item(title: 'Any Score', value: null),
      Item(title: '5', value: 5),
      Item(title: '6', value: 6),
      Item(title: '7', value: 7),
      Item(title: '8', value: 8),
    ];

    genres = [
      Item(title: "All Genres", value: null),
      Item(title: "Action", value: 5),
      Item(title: "Animation", value: 6),
      Item(title: "Anime", value: 39),
      Item(title: "Comedy", value: 9),
      Item(title: "Drama", value: 3),
      Item(title: 'Horror', value: 19)
    ];

    _selectedGenre = genres[0];
    _selectedScore = scores[0];

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text(
          'What Should I Watch',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Style.Colors.mainColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Container(
          child: FlipCard(
            key: cardKey,
            flipOnTouch: false,
            front: CardFrontScreen(),
            back: CardBackScreen() ,
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 100.0,
        padding: EdgeInsets.all(15.0),
        color: Colors.white,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            clicked
                ? Container()
                : Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Genre',
                            style: TextStyle(
                                color: Style.Colors.mainColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 5.0),
                            height: 30.0,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              border: Border.all(
                                  color: Style.Colors.mainColor, width: 1.0),
                            ),
                            child: Theme(
                              data: ThemeData(canvasColor: Colors.white),
                              child: DropdownButton<Item>(
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Style.Colors.mainColor,
                                ),
                                isExpanded: false,
                                underline: Container(),
                                hint: Text("", style: TextStyle()),
                                value: _selectedGenre,
                                onChanged: (Item newValue) {
                                  setState(() {
                                    _selectedGenre = newValue;
                                  });
                                },
                                items: genres.map((Item filter) {
                                  return DropdownMenuItem<Item>(
                                    value: filter,
                                    child: Row(
                                      children: [
                                        Text(filter.title,
                                            style: TextStyle(
                                                color: Style.Colors.mainColor,
                                                fontSize: 14.0))
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Main Score',
                            style: TextStyle(
                                color: Style.Colors.mainColor,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0),
                          ),
                          SizedBox(
                            height: 5.0,
                          ),
                          Container(
                            padding: const EdgeInsets.only(left: 5.0),
                            height: 30.0,
                            decoration: BoxDecoration(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(5.0)),
                              border: Border.all(
                                  color: Style.Colors.mainColor, width: 1.0),
                            ),
                            child: Theme(
                              data: ThemeData(canvasColor: Colors.white),
                              child: DropdownButton<Item>(
                                icon: Icon(
                                  Icons.arrow_drop_down,
                                  color: Style.Colors.mainColor,
                                ),
                                isExpanded: false,
                                underline: Container(),
                                hint: Text("", style: TextStyle()),
                                value: _selectedScore,
                                onChanged: (Item newValue) {
                                  setState(() {
                                    _selectedScore = newValue;
                                  });
                                },
                                items: scores.map((Item filter) {
                                  return DropdownMenuItem<Item>(
                                    value: filter,
                                    child: Row(
                                      children: [
                                        Text(filter.title,
                                            style: TextStyle(
                                                color: Style.Colors.mainColor,
                                                fontSize: 14.0))
                                      ],
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
            clicked
                ? Container(
                    height: 40.0,
                    child: RaisedButton(
                      color: Style.Colors.mainColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      onPressed: () {
                        setState(() {
                          clicked = false;
                        });
                        movieBloc..drainStream();
                        cardKey.currentState.toggleCard();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.arrow_back_ios_outlined,
                              color: Colors.white)
                        ],
                      ),
                    ),
                  )
                : Container(
                    height: 40.0,
                    child: RaisedButton(
                      color: Style.Colors.mainColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8.0)),
                      onPressed: () {
                        movieBloc
                          ..getMovie(
                              _selectedGenre.value, _selectedScore.value);
                        setState(() {
                          clicked = true;
                        });
                        cardKey.currentState.toggleCard();
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(EvaIcons.search, color: Colors.white),
                          SizedBox(
                            width: 5.0,
                          ),
                          Text(
                            'Suggest',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12.0),
                          )
                        ],
                      ),
                    ),
                  )
          ],
        ),
      ),
    );
  }
}
