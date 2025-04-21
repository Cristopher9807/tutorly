import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'home_script/home_screen.dart';
import 'home_script/widgets/home_screen_tutor.dart';
import 'user_session.dart';

class Congrats extends StatefulWidget {
  const Congrats({super.key});

  @override
  CongratsState createState() => CongratsState();
}

class CongratsState extends State<Congrats> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            child: Column(
              children: [
                SizedBox(
                  width: double.infinity,
                  child: Image.asset(
                    "assets/confetti.png",                  
                  ),
                ),
                SizedBox(height: 20.h),

                SizedBox(
                  width: 100.w,
                  height: 100.w,
                  child: Image.asset(
                    'assets/circle.png',
                    fit: BoxFit.fill,
                  ),
                ),
                SizedBox(height: 20.h),

                Text(
                  "¡Felicitaciones!",
                  style: TextStyle(
                    color: const Color(0xFF0F172A),
                    fontSize: 18.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 14.h),

                Text(
                  "Has ingresado correctamente. Ve a la página de inicio y empieza a explorar los cursos.",
                  style: TextStyle(
                    color: const Color(0xFF475569),
                    fontSize: 14.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 40.h),

                InkWell(
                  onTap: () {
                    Widget nextScreen;

                    if (UserSession.role == 'tutor') {
                      nextScreen = HomeScreenTutor();
                    } else {
                      nextScreen = HomeScreen(); // o HomeScreen() si esa es la pantalla para usuarios normales
                    }

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => nextScreen),
                    );
                  },

                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 14.h),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: const Color(0xFF0760FB),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x26000000),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Center(
                      child: Text(
                        "Ir a Inicio",
                        style: TextStyle(
                          color: const Color(0xFFFFFFFF),
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 30.h),
                SizedBox(height: 20.h),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
