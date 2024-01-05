import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:untitled1/screens/AuthScreen/loginscreen.dart';
import 'package:untitled1/screens/SplashScreen/splashscreen.dart';
import 'package:untitled1/screens/UserHomeScreen/Drawer%20Files/Drawer%20Page.dart';
import 'package:untitled1/screens/firstscreen.dart';
import 'package:untitled1/utils/notificationapi.dart';
import 'localdatabase/localdatabase.dart';
import 'screens/LabTechnicianScreen/Drawer Files/Drawer Page.dart';

String? token;
Future<void> _messageHandler(RemoteMessage message) async {
  print('background message ${message.notification!.body}');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseMessaging.onBackgroundMessage(_messageHandler);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String type = "";
  getData() async {
    final a = await LocalDatabase().getData(key: "type");
    setState(() {
      type = a;
    });
  }

  late FirebaseMessaging messaging;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
    messaging = FirebaseMessaging.instance;
    messaging.getToken().then((value) {
      print(value);
      token = value!;
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('A new onMessageOpenedApp event was published!');
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(builder: (_)=>ChatDetailPage()),
      // );
    });
    FirebaseMessaging.instance
        .getInitialMessage()
        .then((RemoteMessage? message) {
      if (message != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('hggbg')),
        );
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message recieved");
      print(event.notification!.body);
      NotificationApi.ShowNotification(
          title: event.notification!.title, body: event.notification!.body);
    });
    FirebaseMessaging.onMessageOpenedApp.listen((message) {
      print('Message clicked!');
      ScaffoldMessenger.of(context)
          .showSnackBar(const SnackBar(content: Text("message clicked")));
    });
    FirebaseMessaging.onMessage.listen((RemoteMessage event) {
      print("message recieved");
      print(event.notification!.body);
      print(event.notification!.body);
      NotificationApi.ShowNotification(
        title: event.notification!.title,
        body: event.notification!.body,
        payload: "",
      );
    });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'E-Repairing Assistant',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: type == "User"
            ? DrawerFile2()
            : type == "LabTechnician"
                ? DrawerFile()
                : const SplashScreen(),
        routes: {
          "/first": (_) => const FirstScreen(),
          '/login': (_) => LoginScreen()
        });
  }
}
