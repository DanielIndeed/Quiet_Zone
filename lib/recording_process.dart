// ignore_for_file: non_constant_identifier_names, unused_local_variable, prefer_final_fields, avoid_print, unused_field

import 'dart:async';
import 'dart:convert';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:lottie/lottie.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'home.dart';
import 'package:noise_meter/noise_meter.dart';
import 'utils/style/text.dart';
import 'utils/Navig_bar/navig_bar.dart';
import 'dart:math';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

void main() => runApp(const MaterialApp(home: RecordingProcess()));

class RecordingProcess extends StatefulWidget {
  const RecordingProcess({Key? key}) : super(key: key);

  @override
  State<RecordingProcess> createState() => _RecordingProcessState();
}

class _RecordingProcessState extends State<RecordingProcess> {
  double k = 0;
  double val_dB = 0;
  late double avgValdB;
  double p = 0;
  double val_dB_2 = 0;
  String val_dB_to_print = '';
  String url = '';
  double avgValDb_to_send = 0;
  var data = '';
  String rows = '';
  String response = '';
  int? val_age;
  int _counter = 0;

  @override
  void initState() {
    super.initState();
    getAge();
    openDb();
    AwesomeNotifications().initialize(
      'resource://drawable/ic_stat_name',
      [
        NotificationChannel(
          channelKey: 'high_importance_channel',
          channelName: 'Basic Notifications',
          playSound: true,
          onlyAlertOnce: true,
          defaultColor: Colors.red,
          importance: NotificationImportance.High,
          channelShowBadge: true,
          channelDescription: 'something',
        ),
      ],
      debug: true,
    );
    _noiseMeter = NoiseMeter(onError);
    start();
    dummy_data();
    dummy_data();
    dummy_data();
    dummy_data();
  }

  @override
  void dispose() {
    _noiseSubscription?.cancel();
    super.dispose();
    stop();
  }

  bool _isRecording = false;
  StreamSubscription<NoiseReading>? _noiseSubscription;
  late NoiseMeter _noiseMeter;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: const Color.fromARGB(255, 0, 0, 0),
        ),
        home: Scaffold(
          body: Column(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    Container(
                      margin: EdgeInsets.zero,
                      alignment: Alignment.center,
                      padding: const EdgeInsets.only(top: 55),
                      child: Image.asset(
                        'assets/logo quiet zone.png',
                        height: 160,
                        width: 160,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.zero,
                      alignment: Alignment.center,
                      child:
                          Lottie.asset('assets/animation1_1.mp4.lottie.json'),
                    ),
                    Container(
                      alignment: AlignmentGeometry.lerp(
                          Alignment.centerLeft, Alignment.centerRight, 0.47),
                      padding: const EdgeInsets.only(top: 12),
                      margin: EdgeInsets.zero,
                      child: Text(
                        _isRecording ? '${val_dB_to_print}dB' : 'Sleeping',
                        style: appText(),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      height: 120,
                      child: iconButtonWidget(),
                    ),
                  ],
                ),
              ),
            ],
          ),
          bottomNavigationBar: Container(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 16),
            child: BottomNav(),
          ),
        ));
  }

  IconButton iconButtonWidget() {
    return IconButton(
      icon: Image.asset('assets/stop_button.png'),
      iconSize: 150,
      padding: EdgeInsets.only(bottom: 40),
      onPressed: () {
        stop();
        Navigator.push(
          this.context,
          MaterialPageRoute(builder: (context) => const Home()),
        );
      },
    );
  }

  Future getData(url) async {
    final uri = Uri.parse(url);
    Response response = await get(uri);
    return response.body;
  }

  void onData(NoiseReading noiseReading) async {
    setState(() {
      if (!_isRecording) {
        _isRecording = true;
      }
    });
    k++;
    val_dB = (val_dB + noiseReading.meanDecibel);
    if (k % 10 == 0) {
      val_dB_2 = (val_dB / k);
      p++;
      final db = await openDb();
      final batch = db.batch();
      batch.insert('decibel_dataset', {'number': val_dB_2.toDouble()});
      val_dB_to_print = await getMean();
      await batch.commit();
      if (p % 5 == 0 && _counter == 0) {
        var avgValdB = await getMean();
        var rows = await getRows();
        print(avgValdB);
        print(rows);
        print(val_age);
        sendValue(avgValdB, rows, val_age);
        p = 0;
      }
      k = 0;
      val_dB = 0;
    }
  }

  void onError(Object error) {
    print(error.toString());
    _isRecording = false;
  }

  void start() async {
    try {
      _noiseSubscription = _noiseMeter.noiseStream.listen(onData);
    } catch (err) {
      print(err);
    }
  }

  void stop() async {
    try {
      if (_noiseSubscription != null) {
        _noiseSubscription!.cancel();
        _noiseSubscription = null;
        deletedata();
      }
      setState(() {
        _isRecording = false;
      });
    } catch (err) {
      print('stopRecorder error: $err');
    }
  }

  Future<void> sendValue(avgValdB, rows, val_age) async {
    print(avgValdB);
    print(rows);
    print(val_age);
    print('sendValue');
    final url =
        "https://quietzone.pythonanywhere.com/response?avg_val_dB=$avgValdB&k=$rows&val_age=$val_age";
    response = await getData(url);
    print(response);
    if (response != 'Negative') {
      notification_sender();
    } else {
      print('negative');
    }
  }

  Timer? _timer_req;
  Timer? _timer_recom;

  void setTimer_Req() {
    _counter = 10;
    _timer_req = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
          print(_counter);
        } else {
          _timer_req?.cancel();
        }
      });
    });
  }

  void setTimer_Recom() {
    _counter = 21600;
    _timer_recom = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        if (_counter > 0) {
          _counter--;
          print(_counter);
        } else {
          _timer_req?.cancel();
        }
      });
    });
  }

  notification_sender() async {
    var decoded_response = jsonDecode(response);
    print(decoded_response['response']);
    if (decoded_response['response'] == 'Required') {
      print('Required 2');
      notification_for_required();
      setTimer_Req();
    } else if (decoded_response == 'Recommended') {
      print('Recommended 2');
      notification_for_recommended();
      setTimer_Recom();
    } else {
      print('Not sleeping ${decoded_response}');
    }
  }

  Future<void> getAge() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    val_age = pref.getInt('val_age');
  }
}

Future<void> notification_for_required() async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      channelKey: 'high_importance_channel',
      id: createUniqueId(),
      title: 'Earplugs are required',
      body:
          'If not available, withdrawal from the environment is also an option',
      notificationLayout: NotificationLayout.BigPicture,
      bigPicture: 'asset://assets/2.png',
    ),
  );
}

Future<void> notification_for_recommended() async {
  await AwesomeNotifications().createNotification(
    content: NotificationContent(
      id: createUniqueId(),
      channelKey: 'high_importance_channel',
      title: 'Earplugs are recommended',
      body:
          'If not available, withdrawal from the environment is also an option',
      bigPicture: 'asset://assets/1.png',
      largeIcon: 'asset://assets/1.png',
      notificationLayout: NotificationLayout.BigPicture,
    ),
  );
}

int createUniqueId() {
  return DateTime.now().millisecondsSinceEpoch.remainder(100000);
}

Future<Database> openDb() async {
  final databasesPath = await getDatabasesPath();
  final path = join(databasesPath, 'my_database.db');

  return openDatabase(path, onCreate: (db, version) {
    return db.execute(
        'CREATE TABLE decibel_dataset (id INTEGER PRIMARY KEY, number INTEGER)');
  }, version: 1);
}

Future<void> insertNumber(number) async {
  final db = await openDb();
  final batch = db.batch();
  batch.insert('decibel_dataset', {'number': number});
  await batch.commit();
}

Future<void> deletedata() async {
  final db = await openDb();
  final batch = db.batch();
  batch.delete('decibel_dataset');
  await batch.commit();
}

int random(int min, int max) {
  return min + Random().nextInt(max - min);
}

void dummy_data() async {
  var randomNumber = 0;
  for (int i = 1; i <= 50; i++) {
    randomNumber = random(110, 120);
    await insertNumber(randomNumber);
  }
}

Future<String> getMean() async {
  final db = await openDb();
  final result = await db.rawQuery('SELECT AVG(number) FROM decibel_dataset');
  if (result.isNotEmpty) {
    final mean = result.first.values.first as num?;
    return mean?.toStringAsFixed(2) ?? '0.00';
  } else {
    return '0.00';
  }
}

Future<String> getRows() async {
  final db = await openDb();
  final result = await db.rawQuery('SELECT COUNT(*) FROM decibel_dataset');
  if (result.isNotEmpty) {
    final rows = result.first.values.first as num?;
    return rows?.toStringAsFixed(2) ?? '0.00';
  } else {
    return '0.00';
  }
}
