import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:formativa_cine_favorite/views/favorite_view.dart';
import 'package:formativa_cine_favorite/views/login_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MaterialApp(
    title: "CineFormative",
    theme: ThemeData(
      primarySwatch: Colors.deepOrange,
      brightness: Brightness.dark,
    ),
    home: AuthStream(),
  ));
}

class AuthStream extends StatelessWidget {
  const AuthStream({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      //o listear está na mudança de status do usuário
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapShot){
        //se estiver logado, vai para HomeScreen
        if(snapShot.hasData){
          return FavoriteView();
        }
        //se não tiver logado
        return LoginView();
      },
    );
  }
}