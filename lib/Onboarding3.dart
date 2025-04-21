import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'role_separator.dart';

class Onboarding3 extends StatefulWidget {
  const Onboarding3({Key? key}) : super(key: key);

  @override
  Onboarding3State createState() => Onboarding3State();
}

class Onboarding3State extends State<Onboarding3> {
  @override
  Widget build(BuildContext context) {
    // Inicializa ScreenUtil
    ScreenUtil.init(context, designSize: const Size(375, 812));

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 60.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 41.w),
                child: Image.asset(
                  "assets/lesson.png",
                  fit: BoxFit.contain,
                  height: 250.h,
                ),
              ),
              SizedBox(height: 40.h),

              Text(
                "Impulsa tu aprendizaje",
                style: TextStyle(
                  color: const Color(0xFF0760FB),
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 47.w),
                child: Text(
                  "Aprender nunca ha sido tan fácil. Conéctate con expertos, mejora tus habilidades y alcanza tus objetivos académicos.",
                  style: TextStyle(
                    color: const Color(0xFF475569),
                    fontSize: 14.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 24.h),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: 9.w,
                    height: 9.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFF0760FB), width: 2.w),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Container(
                    width: 9.w,
                    height: 9.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: const Color(0xFF0760FB), width: 2.w),
                    ),
                  ),
                  SizedBox(width: 8.w),
                  Container(
                    width: 21.w,
                    height: 9.w,
                    decoration: BoxDecoration(
                      color: const Color(0xFF0760FB),
                      borderRadius: BorderRadius.circular(4.r),
                    ),
                  ),
                ],
              ),

              SizedBox(height: 30.h),

              Padding(
                padding: EdgeInsets.symmetric(horizontal: 24.w),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RoleSeparator())),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: const Color(0xFF0760FB), width: 1.w),
                          borderRadius: BorderRadius.circular(10.r),
                          color: const Color(0xFFCDE6FE),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0x12344054),
                              blurRadius: 2.r,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.symmetric(vertical: 17.h),
                        width: 157.w,
                        child: Center(
                          child: Text(
                            "Saltar",
                            style: TextStyle(
                              color: const Color(0xFF0760FB),
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),

                    InkWell(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const RoleSeparator())),
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10.r),
                          color: const Color(0xFF0760FB),
                          boxShadow: [
                            BoxShadow(
                              color: const Color(0x12344054),
                              blurRadius: 2.r,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.symmetric(vertical: 17.h),
                        width: 157.w,
                        child: Center(
                          child: Text(
                            "Continuar",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 30.h),
            ],
          ),
        ),
      ),
    );
  }
}
