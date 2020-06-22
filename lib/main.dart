import 'package:Pokemon_App/pokemonDetail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'pokemon.dart';
import 'dart:convert';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Poke App",
      home: HomePage(),
      debugShowCheckedModeBanner:
          false, //! không hiện thị icon debug lên trên màn hình
    );
  }
}

class HomePage extends StatefulWidget {
  HomePage({Key key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var url =
      "https://raw.githubusercontent.com/Biuni/PokemonGO-Pokedex/master/pokedex.json";

  PokeHub pokeHub;
  @override
  void initState() {
    //! initState chỉ được tạo 1 lần khi ứng dụng được tạo
    //! đăng ký các luồng và đối tượng nào có thể thay đổi dữ liệu widget của chúng tôi.
    super.initState();
    fetchData(); //1nd work
    print("2nd work");
  }

  //! từ khóa async trước thân hàm để đánh dấu nó là bất đồng bộ.
  fetchData() async {
    var res = await http.get(url); //! khởi tạo res.
    //! để lấy dữ liệu từ flutter thì chúng ta có thể dùng await, tuy nhiên await phải đặt trong hàm async
    var decodedJson = jsonDecode(res.body);
    //! jsonDecode liên quan tới việc chuyển đổi chuỗi JSON thô.
    pokeHub = PokeHub.fromJson(decodedJson);
    print(pokeHub.toJson());
    setState(() {}); //! sử dụng để thay đổi trạng thái.
  }

  @override
  Widget build(BuildContext context) {
    //! xây dựng các cây Widget
    return Scaffold(
      appBar: new AppBar(
        title: Text('Pokemon'), //! tiêu đề của App
        backgroundColor: Colors.cyan, //! màu cho App
      ),
      body: pokeHub == null //todo: xử dụng toán tử 3 ngôi.
          ? Center(
              child:
                  CircularProgressIndicator(), //todo: nếu pokehub mà bằng Null thì hiện thị icon vòng tròn đang load dữ liệu.
            )
          : GridView.count(
              //! khởi tạo GridView
              crossAxisCount: 2, //! trên 1 hàng sẽ có 2 cột GridView
              children: pokeHub
                  .pokemon //! pokeHub truy cập tới pokemon và gọi toàn bộ các value
                  .map((poke) => Padding(
                        //! giúp tăng khoảng cách trong GridView
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          //! InkWell bắt sự kiện người dùng nhấn vào 1 ô textBox trong GridView
                          onTap: () {
                            //! bắt sự kiện onTap.
                            Navigator.push(
                                //! navigator giúp chuyển đổi qua lại giữa hai màn hình.
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PokemonDetail(
                                          //! chuyển tới màn hình Pokemon Detail
                                          pokemon:
                                              poke, //todo: data được truyền sang trang Pokemon Detail
                                        )));
                          },
                          child: Hero(
                            //! bắt sự kiện Animation khi chuyển tới màn hình Detail
                            tag: poke.img, //! animation ở đây sẽ là hình ảnh
                            child: Card(
                              //todo: card chứa Column trong Column chứa (image và text)
                              elevation:
                                  0.2, //! elevation là độ mờ của text trong Card
                              child: new Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: <Widget>[
                                  new Container(
                                    height: 100.0, //! chiều cao của image
                                    width: 100.0, //! chiều ngang của image
                                    decoration: BoxDecoration(
                                        image: DecorationImage(
                                            //! lấy ảnh từ đường link trên mạng, cần phải sử dụng NetworkImage.
                                            image: NetworkImage(
                                                poke.img))), //! read image
                                  ),
                                  Text(
                                    poke.name, //! tên của nhân vật pokemon
                                    style: TextStyle(
                                        //! xet Style cho text
                                        fontSize: 20.0,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ))
                  .toList(),
            ),
      drawer: Drawer(), 
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.cyan,
        child: Icon(Icons.refresh),
      ),
    );
  }
}
