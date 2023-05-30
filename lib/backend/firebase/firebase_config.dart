import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

Future initFirebase() async {
  if (kIsWeb) {
    await Firebase.initializeApp(
        options: FirebaseOptions(
            apiKey: "AIzaSyALBcnsWhiIypcTwV-pelb4V3vrpimTitU",
            authDomain: "cari-dokter-app.firebaseapp.com",
            projectId: "cari-dokter-app",
            storageBucket: "cari-dokter-app.appspot.com",
            messagingSenderId: "147052948122",
            appId: "1:147052948122:web:30f8cc7cb4d08035118d23"));
  } else {
    await Firebase.initializeApp();
  }
}
