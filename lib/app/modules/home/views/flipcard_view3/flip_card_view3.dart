import 'package:flipcard_game/app/data/data3.dart';
import 'package:flipcard_game/app/modules/home/views/flipcard_view3/flipcardgame3.dart';
import 'package:flutter/material.dart';

class FlipGameView3 extends StatefulWidget {
  @override
  _FlipGameView3State createState() => _FlipGameView3State();
}

class _FlipGameView3State extends State<FlipGameView3> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Column(
              children: [
                // Image
                Container(
                  height: MediaQuery.of(context).size.height * 0.4,
                  alignment: AlignmentDirectional.centerStart,
                  child: Row(
                    children: [
                      Image.asset(
                        "lib/app/assets/home.png",
                        fit: BoxFit.cover,
                        width: 200.0,
                        height: double.infinity,
                      ),
                      SizedBox(width: 8.0),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Perjuangan",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 40.0,
                              color: Colors.grey[800],
                            ),
                          ),
                          Text(
                            "Para",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 35.0,
                              color: Colors.grey[800],
                            ),
                          ),
                          Text(
                            "Pahlawan",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 35.0,
                              color: Colors.grey[800],
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 350.0),
            child: ListView.builder(
              itemCount: _list.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) => _list[index].goto,
                      ),
                    );
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Stack(
                      children: [
                        Container(
                          height: 100,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: _list[index].primarycolor,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                color: Colors.black45,
                                spreadRadius: 0.5,
                                offset: Offset(3, 4),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          height: 90,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: _list[index].secondarycolor,
                            borderRadius: BorderRadius.circular(30),
                            boxShadow: [
                              BoxShadow(
                                blurRadius: 4,
                                color: Colors.black12,
                                spreadRadius: 0.3,
                                offset: Offset(5, 3),
                              ),
                            ],
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Center(
                                child: Text(
                                  _list[index].name,
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 30,
                                    fontWeight: FontWeight.bold,
                                    shadows: [
                                      Shadow(
                                        color: Colors.black26,
                                        blurRadius: 2,
                                        offset: Offset(1, 2),
                                      ),
                                      Shadow(
                                        color: Colors.green,
                                        blurRadius: 2,
                                        offset: Offset(0.5, 2),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: genratestar(_list[index].noOfstar),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> genratestar(int no) {
    List<Widget> _icons = [];
    for (int i = 0; i < no; i++) {
      _icons.insert(
          i,
          Icon(
            Icons.star,
            color: Colors.yellow,
          ));
    }
    return _icons;
  }
}

class Details {
  String name;
  Color primarycolor;
  Color secondarycolor;
  Widget goto;
  int noOfstar;

  Details(
      {required this.name,
      required this.primarycolor,
      required this.secondarycolor,
      required this.noOfstar,
      required this.goto});
}

List<Details> _list = [
  Details(
    name: "EASY",
    primarycolor: Colors.green,
    secondarycolor: Colors.green[300]!,
    noOfstar: 1,
    goto: FlipCardGame3(Level.Easy),
  ),
  Details(
    name: "MEDIUM",
    primarycolor: Colors.orange,
    secondarycolor: Colors.orange[300]!,
    noOfstar: 2,
    goto: FlipCardGame3(Level.Medium),
  ),
  Details(
    name: "HARD",
    primarycolor: Colors.red,
    secondarycolor: Colors.red[300]!,
    noOfstar: 3,
    goto: FlipCardGame3(Level.Hard),
  ),
];
