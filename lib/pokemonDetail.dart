import 'package:Pokemon_App/pokemon.dart';
import 'package:flutter/material.dart';

class PokemonDetail extends StatelessWidget {
  final Pokemon pokemon; //! truyền vào nhận dữ liệu data
  PokemonDetail({this.pokemon}); //! constructer
  bodyWidget(BuildContext context) => Stack( //! sử dụng stack để đè nên nhau.
        children: <Widget>[
          Positioned( //? gần giống với card, cần tìm hiểu
            left: 10.0,
            height: MediaQuery.of(context).size.height / 1.5,
            width: MediaQuery.of(context).size.width - 20,
            top: MediaQuery.of(context).size.width * 0.1,
            child: new Container(
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0)),
                child: new Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    SizedBox(
                      height: 120,
                    ),
                    new Text(pokemon.name,
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25.0)),
                    Text(
                      "Height: ${pokemon.height}",
                    ),
                    Text("Height: ${pokemon.weight}"),
                    Text("Type"),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: pokemon.type
                          .map((e) => FilterChip(
                              backgroundColor: Colors.yellow,
                              label: Text(e),
                              onSelected: (b) {}))
                          .toList(),
                    ),
                    Text("Weakness",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25.0)),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: pokemon.weaknesses
                          .map((e) => FilterChip(
                              backgroundColor: Colors.red,
                              label: Text(e),
                              onSelected: (b) {}))
                          .toList(),
                    ),
                    Text("Next Evolution",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25.0)),
                    new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: pokemon.nextEvolution
                          .map((n) => FilterChip(
                              backgroundColor: Colors.green,
                              label: Text(n.name),
                              onSelected: (b) {}))
                          .toList(),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter, //! hình ảnh được đặt lên trên đầu.
            child: Hero( //! lấy image từ bên main sang
                tag: pokemon.img,
                child: Container(
                  height: 200.0,
                  width: 200.0,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(pokemon.img), fit: BoxFit.cover)),
                )),
          )
        ],
      );
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.cyan,
      appBar: new AppBar(
        backgroundColor: Colors.cyan,
        title: Center(child: Text(pokemon.name)),
      ),
      body: bodyWidget(context),
    );
  }
}
