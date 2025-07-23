import 'package:flutter/material.dart';
import 'package:flutter_web_gorouter_example/router/app_router.dart';

void main() {
  runApp(const MyApp6());
}

class MyApp6 extends StatelessWidget {
  const MyApp6({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false, // Remove o banner de debug
      title: 'Flutter sss com Drawer Persistente',
      routerConfig: routes, // Conecta o GoRouter à aplicação
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Inter', // Usando a fonte Inter conforme instruído
      ),
    );
  }
}
