import 'package:flutter/material.dart';
import 'Onboarding1.dart';

class Intro extends StatefulWidget {
  const Intro({super.key});
  @override
  _IntroState createState() => _IntroState();
}

class _IntroState extends State<Intro> {
  @override
  void initState() {
    super.initState();
    // Ejemplo: Después de 3 segundos, navegar a la siguiente pantalla
    Future.delayed(const Duration(seconds: 3), () {
       Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => Onboarding1()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          height: double.infinity,
          child: Stack(
            fit: StackFit.expand,
            children: [
              // Imagen de fondo que se ajusta a cualquier dispositivo
              Image.network(
                "https://storage.googleapis.com/tagjs-prod.appspot.com/VuZ5hgGxQ3/yrydbd4g.png",
                fit: BoxFit.cover,
              ),
              // Elemento superpuesto: Indicador de carga centrado
              const Center(
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
