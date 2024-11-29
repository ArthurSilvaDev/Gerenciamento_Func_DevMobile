import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'screens/login_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  try {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "AIzaSyAS6KknnaB2dVZ_5IVRpfGd-Wz9fWACFNM",
        appId: "1:601482484427:android:f33e14cc5fa5e3f4dd594e",
        messagingSenderId: "601482484427",
        projectId: "my-app1-89f2d",
        databaseURL: "https://my-app1-89f2d-default-rtdb.firebaseio.com",
      ),
    );
    
    print('✅ Firebase inicializado com sucesso!');
    
    // Teste de conexão com o Realtime Database
    final ref = FirebaseDatabase.instance.ref();
    await ref.child('test').push().set({
      'message': 'Teste de conexão',
      'timestamp': ServerValue.timestamp,
    });
    
    print('✅ Conexão com Realtime Database estabelecida!');
    
  } catch (e) {
    print('❌ Erro na inicialização do Firebase: $e');
  }
  
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sistema de Funcionários',
      theme: ThemeData(
        primarySwatch: Colors.red,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LoginScreen(),
    );
  }
}
