import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:audio_manager/audio_manager.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:async';
import 'dart:io';
import 'dart:core';

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
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  DateTime now = DateTime.now();
  String title1 = "Başlık";
  String title2 = "title2";
  bool playing5 = false;
  String _platformVersion = 'Unknown';
  bool isPlaying = false;
  Duration _duration = Duration();
  Duration _position = Duration();
  double _slider = 0.0;
  double _sliderVolume = 0.0;
  String _error = "";
  num curIndex = 0;
  PlayMode playMode = AudioManager.instance.playMode;

  String urlfile = "assets/S1.mp3";
  var audioManagerInstance = AudioManager.instance;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

 void setupAudio(){
   //String title5=audioManagerInstance.isPlaying.toString();
   AudioManager.instance.onEvents((events, args) {
     print("$events, $args");
     setState(() {
       if (events == AudioManagerEvents.start) {
         //title1 = audioManagerInstance.duration.toString();
         title1="start";
       }
     });
   }); }

  void setupAudio1(){
    //String title5=audioManagerInstance.isPlaying.toString();
    AudioManager.instance.onEvents((events, args) {
      print("$events, $args");
      setState(() {
        if (events == AudioManagerEvents.stop) {
          if (args == null) {
            //title1 = audioManagerInstance.duration.toString();
            title1 = "pause";
          }
        }
      });
    }); }



  void initState() {
    super.initState();
    setupAudio1();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title1),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /*Text(
              now.day.toString(),style: TextStyle(fontSize: 40.0,color: Colors.deepPurple,fontWeight: FontWeight.values[0]),
            ),
            Text(
              now.day.toString(),style: TextStyle(fontSize: 40.0,color: Colors.deepPurple,fontWeight: FontWeight.bold),
            ),*/
            ElevatedButton(
                onPressed: () {
                  audioManagerInstance
                      .start("assets/S1.mp3", "song title",
                          desc: "description",
                          auto: true,
                          cover: "assets/resim0.jpg")
                      .then((err) {
                    print(err);
                  });
                  print("song");
                },
                child: Text('song')),
            /*ElevatedButton(
                onPressed: (){
                  audioManagerInstance.stop().then((err) {
                    print(err);
                  });
                  print("stop");
                }, child:Text('stop')),
*/
            GestureDetector(
              onTap: () {
                audioManagerInstance.stop();
                print('stop35');
              },
              child: Container(
                width: 100,
                height: 50,
                color: Colors.red,
              ),
            ),
            SizedBox(
              height: 10.0,
            ),
            GestureDetector(
              //onTap: () { print("Container was tapped"); },
              onTap: () {
                audioManagerInstance
                    .start(urlfile, "song title",
                        desc: "description",
                        auto: true,
                        cover: "assets/resim0.jpg")
                    .then((err) {
                  print(err);
                });
                AudioManager.instance.onEvents((events, args) {
                  print("$events, $args");
                  setState(() {
                    if (events == AudioManagerEvents.timeupdate) {
                      title1 = audioManagerInstance.position.toString();
                    }
                  });
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
              onTap: () {
                //audioManagerInstance.start(urlfile, "title",desc: "",auto:true,cover:"assets/resim0.jpg");
                //audioManagerInstance.playOrPause();
                audioManagerInstance.toPause();
                //audioManagerInstance.playOrPause();
                print('Pause');
              },
              child: Text(
                'Pause',
                style: TextStyle(fontSize: 30.0),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  audioManagerInstance.toPause();
                  audioManagerInstance.playOrPause();
                  setState(() {
                    //_position=audioManagerInstance.position;
                    //_duration=audioManagerInstance.duration;
                    //title1 = _duration.toString();
                  });
                },
                child: Text('DENEME')),
            IconButton(
                icon: Icon(
                  Icons.stop,
                  color: Colors.black,
                  size: 50.0,
                ),
                onPressed: () => AudioManager.instance.stop()),
            IconButton(
              onPressed: () async {
                audioManagerInstance.toPause();
                playing5 = await AudioManager.instance.playOrPause();
                print(playing5);
              },
              padding: const EdgeInsets.all(0.0),
              icon: Icon(
                playing5 ? Icons.pause : Icons.play_arrow,
                size: 48.0,
                color: Colors.black,
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    //_position=audioManagerInstance.position;
                    //_duration=audioManagerInstance.duration;
                    //title1=audioManagerInstance.isPlaying.toString();
                    // audioManagerInstance.release();
                    AudioManager.instance.onEvents((events, args) {
                      if (events == AudioManagerEvents.start) {
                        title1 = "timestop";
                      } else {
                        title1 = "Hatalı";
                      };
                      //print(events);
                      //print(events.index);
                      //print(events.runtimeType);
                      //print(args);
                      //print("$events, $args");
                    });
                    // title1=audioManagerInstance.onEvents((events, args) { })
                    //title1=_position.toString();
                  });
                },
                child: Text('Status')),
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
