import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:audio_manager/audio_manager.dart';


void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String urlfile="assets/S1.mp3";
  var audioManagerInstance = AudioManager.instance;


  void _incrementCounter() {
    setState(() {
      _counter++;
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
            ElevatedButton(
                onPressed: (){
                  audioManagerInstance.start("assets/S1.mp3","song title",
                      desc: "description",
                      auto: true,
                      cover: "assets/resim0.jpg")
                      .then((err) {
                    print(err);
                  });
                  print("song");
                }, child:Text('song')),
            /*ElevatedButton(
                onPressed: (){
                  audioManagerInstance.stop().then((err) {
                    print(err);
                  });
                  print("stop");
                }, child:Text('stop')),
*/
            GestureDetector(
              onTap: (){
                audioManagerInstance.stop();
                print('stop35');
              },
              child: Container(
                width: 100,
                height: 50,
                color: Colors.red,
              ),
            ),
            SizedBox(height: 10.0,),
            GestureDetector(
              //onTap: () { print("Container was tapped"); },
              onTap: () {
                audioManagerInstance.start(urlfile,"song title",
                    desc: "description",
                    auto: true,
                    cover: "assets/resim0.jpg")
                    .then((err) {
                  print(err);
                });
              },
              child: Container(
                width: 100,
                height: 50,
                color: Colors.deepPurple,
                child: Text('başlık'),
              ),
            ),
            GestureDetector(
              onTap: (){
                //audioManagerInstance.start(urlfile, "title",desc: "",auto:true,cover:"assets/resim0.jpg");
                audioManagerInstance.playOrPause();
                print('Pause');
              },
              child: Text('Pause',style: TextStyle(fontSize: 30.0),),
            ),
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headline4,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
