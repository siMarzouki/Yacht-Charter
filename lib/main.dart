import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/services.dart';
import './yachts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Yacht Charter',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

const title = TextStyle(fontSize: 18, fontWeight: FontWeight.bold);
const details = TextStyle(fontSize: 14, fontWeight: FontWeight.w500);

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    //hide the Android Status Bar and bottom navigation
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    super.initState();
  }

  int _index = 0;
  double _period = 1;
  bool _jetSki = false;
  bool _flyboard = false;
  bool _giantPartyFlamingo = false;
  String _city = "Monaco";
  int _price = 1489;

  void updatePrice() {
    setState(() {
      _price =
          _period.toInt() * int.parse(yachts[_index]["dayPrice"].toString());
      if (_jetSki) _price += 360 * _period.toInt();
      if (_flyboard) _price += 500 * _period.toInt();
      if (_giantPartyFlamingo) _price += 79 * _period.toInt();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(255, 255, 255, 0.95),
      // A widget that positions its children relative to the edges of its box.
      //This class is useful if you want to overlap several children in a simple way.
      body: Stack(
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(70),
                bottomRight: Radius.circular(70)),
            child: Image.asset("assets/bg.jpg"),
          ),
          SingleChildScrollView(
            child: Container(
              margin: const EdgeInsets.only(bottom: 70, left: 30, right: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Stack(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(70)),
                        padding: const EdgeInsets.only(
                            top: 100, left: 20, right: 20, bottom: 30),
                        height: 300,
                        margin: const EdgeInsets.only(top: 130),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            //yacht Name
                            Text(
                              yachts[_index]["name"].toString(),
                              style: const TextStyle(
                                  fontSize: 32, fontWeight: FontWeight.bold),
                            ),
                            //yacht Description
                            Text(yachts[_index]["description"].toString(),
                                style: const TextStyle(
                                    fontSize: 13,
                                    color: Colors.grey,
                                    fontWeight: FontWeight.bold)),
                            //yackt Rating
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                for (int i = 0;
                                    i <
                                        int.parse(
                                            yachts[_index]["rate"].toString());
                                    i++)
                                  const Icon(
                                    Icons.star,
                                    color: Colors.orangeAccent,
                                  ),
                                for (int i = 0;
                                    i <
                                        5 -
                                            int.parse(yachts[_index]["rate"]
                                                .toString());
                                    i++)
                                  const Icon(
                                    Icons.star_border,
                                    color: Colors.orangeAccent,
                                  ),
                                const SizedBox(
                                  width: 10,
                                ),
                                //The number of reviewers
                                Text(
                                    "(${yachts[_index]["reviewers"].toString()})",
                                    style: const TextStyle(fontSize: 13))
                              ],
                            ),
                            const Divider(
                              color: Colors.black54,
                              height: 3,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                //Number Of Guests
                                Column(
                                  children: [
                                    Image.asset(
                                      "assets/guest.png",
                                      height: 30,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "${yachts[_index]["guests"].toString()} Guests",
                                      style: details,
                                    )
                                  ],
                                ),
                                //Number of cabins
                                Column(
                                  children: [
                                    Image.asset(
                                      "assets/cabin.png",
                                      height: 30,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "${yachts[_index]["cabins"].toString()} Cabins",
                                      style: details,
                                    )
                                  ],
                                ),
                                //number of crew
                                Column(
                                  children: [
                                    Image.asset(
                                      "assets/crew.png",
                                      height: 30,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                      "${yachts[_index]["crew"].toString()} Crew",
                                      style: details,
                                    )
                                  ],
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      //yacht Photo
                      Container(
                        margin: const EdgeInsets.only(top: 32),
                        child: Image.asset(
                          "assets/${yachts[_index]["photo"].toString()}.png",
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //back button
                      IconButton(
                          onPressed: () {
                            setState(() {
                              if (_index > 0) _index--;
                            });
                            updatePrice();
                          },
                          icon: Icon(
                            Icons.arrow_back,
                            color: _index == 0 ? Colors.grey : Colors.black,
                          )),
                      //next Button
                      IconButton(
                          onPressed: () {
                            setState(() {
                              if (_index < 2) _index++;
                            });
                            updatePrice();
                          },
                          icon: Icon(Icons.arrow_forward,
                              color: _index == 2 ? Colors.grey : Colors.black)),
                    ],
                  ),
                  //yacht Location
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        "Location ",
                        textAlign: TextAlign.left,
                        style: title,
                      ),
                      //A dropdown button lets the user select from a number of items.
                      // The button shows the currently selected item
                      //as well as an arrow that opens a menu for selecting another item.
                      DropdownButton<String>(
                        value: _city,
                        underline: Container(
                          height: 2,
                          color: Colors.grey,
                        ),
                        onChanged: (String? newValue) {
                          setState(() {
                            _city = newValue!;
                          });
                        },
                        items: <String>['Monaco', 'Ibiza', 'Malta', 'Turkey']
                            .map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Text(
                              value,
                              style: details,
                            ),
                          );
                        }).toList(),
                      )
                    ],
                  ),
                  //Number Of Days Slider
                  Padding(
                    padding: const EdgeInsets.all(4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: 250,
                          //Used to select from a range of values.
                          child: Slider(
                            min: 1,
                            max: 10,
                            divisions: 10,
                            value: _period,
                            activeColor: const Color.fromRGBO(0, 32, 175, 1),
                            inactiveColor:
                                const Color.fromRGBO(178, 40, 109, 0.8),
                            label: _period.toInt().toString(),
                            onChanged: (value) {
                              setState(() {
                                _period = value;
                              });
                              updatePrice();
                            },
                          ),
                        ),
                        Text(
                          "${_period.toInt()} Days",
                          style: details,
                        )
                      ],
                    ),
                  ),
                  const Text(
                    "Add-On ",
                    style: title,
                    textAlign: TextAlign.left,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          "assets/jet-ski.png",
                          height: 50,
                        ),
                        const Text(
                          "Jet Ski",
                          style: details,
                        ),
                        //A checkbox is a type of input component which holds the Boolean value.
                        // It is a GUI element that allows the
                        //user to choose multiple options from several selections.
                        Checkbox(
                            value: _jetSki,
                            activeColor: const Color.fromRGBO(178, 40, 109, 1),
                            onChanged: (value) {
                              setState(() {
                                _jetSki = value!;
                              });
                              updatePrice();
                            })
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          "assets/flyboard.png",
                          height: 50,
                        ),
                        const Text("Flyboard", style: details),
                        Checkbox(
                            value: _flyboard,
                            activeColor: const Color.fromRGBO(178, 40, 109, 1),
                            onChanged: (value) {
                              setState(() {
                                _flyboard = value!;
                              });
                              updatePrice();
                            })
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(4),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset(
                          "assets/flamingo.png",
                          height: 50,
                        ),
                        const Text("Giant Party Flamingo", style: details),
                        Checkbox(
                            activeColor: const Color.fromRGBO(178, 40, 109, 1),
                            value: _giantPartyFlamingo,
                            onChanged: (value) {
                              setState(() {
                                _giantPartyFlamingo = value!;
                              });
                              updatePrice();
                            })
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Positioned(
              bottom: 0,
              width: MediaQuery.of(context).size.width,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(35)),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          "Total",
                          style: TextStyle(color: Colors.black87),
                        ),
                        Row(
                          children: [
                            Text(
                              "  ${_price ~/ 1000},${(_price % 1000)} \$ ",
                              style: const TextStyle(
                                  color: Colors.indigo,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold),
                            ),
                            const Text(
                              "/Trip",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        )
                      ],
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(25),
                      child: TextButton(
                          style:
                              TextButton.styleFrom(backgroundColor: Colors.red),
                          onPressed: () {},
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 8),
                            child: Text(
                              "Go To Checkout",
                              style: TextStyle(color: Colors.white),
                            ),
                          )),
                    )
                  ],
                ),
              ))
        ],
      ),
    );
  }
}
