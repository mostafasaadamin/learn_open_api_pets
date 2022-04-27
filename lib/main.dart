import 'package:dio/dio.dart';
import 'package:either_dart/either.dart';
import 'package:flutter/material.dart';
import 'package:openapi/openapi.dart';

void main() {
  // Either<int, String> value= getCityNameByCode(false);
  // if(value.isRight){
  //   print(value.right);
  // }
  // else{
  //   print(value.left.toString());
  // }

  runApp(const MyApp());
}
Either<int, String> getCityNameByCode(bool side) {
  if (side) {
    return Right("right is Called");
  } else {
    return Left(110);
  }
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(
          title: 'Flutter Demo Home Page',
          pets: PetApi(
              Dio(BaseOptions(baseUrl: "https://petstore.swagger.io/v2")),
              standardSerializers)),
    );
  }
}

class MyHomePage extends StatefulWidget {
  PetApi pets;

  MyHomePage({Key? key, required this.title, required this.pets})
      : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var petsData;
  bool isLoading = false;

  void _incrementCounter() {
    petsData=null;
    isLoading = true;
    setState(() {});
    petsData = widget.pets.getPetById(petId: 10).then((value) {
      setState(() {
        isLoading = false;
        petsData = value;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text("Returned Data"),
            SizedBox(
              height: 20,
            ),
            !isLoading
                ? Text(petsData.toString(),style: TextStyle(color: Colors.blue),)
                : CircularProgressIndicator(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
