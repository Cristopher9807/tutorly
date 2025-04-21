import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'role_separator.dart';
import 'Onboarding3.dart';

class Onboarding2 extends StatefulWidget {
  const Onboarding2({Key? key}) : super(key: key);

  @override
  Onboarding2State createState() => Onboarding2State();
}

class Onboarding2State extends State<Onboarding2> {
  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w),
            child: Column(
              children: [
                SizedBox(height: 40.h),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 22.w),
                  child: Image.asset(
                    'assets/image.png',
                    fit: BoxFit.contain,
                  ),
                ),

                SizedBox(height: 24.h),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20.w),
                  child: Text(
                    "Encuentra el apoyo que necesitas",
                    style: TextStyle(
                      color: const Color(0xFF0760FB),
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),

                SizedBox(height: 16.h),

                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 16.w),
                  child: Text(
                    "Encuentra el tutor ideal para cada materia y resuelve tus dudas con sesiones personalizadas.",
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
                        border: Border.all(
                          color: const Color(0xFF0760FB),
                          width: 2.w,
                        ),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      width: 21.w,
                      height: 9.h,
                      decoration: BoxDecoration(
                        color: const Color(0xFF0760FB),
                        borderRadius: BorderRadius.circular(4.r),
                      ),
                    ),
                    SizedBox(width: 8.w),
                    Container(
                      width: 9.w,
                      height: 9.w,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF0760FB),
                          width: 2.w,
                        ),
                      ),
                    ),
                  ],
                ),

                SizedBox(height: 30.h),

                Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const RoleSeparator()),
                          );
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: const Color(0xFF0760FB),
                              width: 1.w,
                            ),
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
                    ),
                    SizedBox(width: 16.w),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const Onboarding3()),
                          );
                        },
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
                          child: Center(
                            child: Text(
                              "Continuar",
                              style: TextStyle(
                                color: const Color(0xFFFFFFFF),
                                fontSize: 14.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
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
