import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tutorly/congrats.dart';
import '../filtre/filtre_screen.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  @override
  Widget build(BuildContext context) {
    // Inicializamos screen util para responsividad
    ScreenUtil.init(context, designSize: const Size(375, 812));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Barra de búsqueda
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10.r),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withAlpha(20),
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: TextField(
              decoration: InputDecoration(
                hintText: "Buscar",
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => FiltersScreen()),
                    );
                  },
                ),
                border: InputBorder.none,
                contentPadding: EdgeInsets.all(14.h),
              ),
            ),
          ),
        ),

        SizedBox(height: 30.h),

        // Sección "Tutoría en vivo"
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Tutoría en vivo",
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Congrats()),
                  );
                },
                child: Text(
                  "Todas las materias >",
                  style: TextStyle(fontSize: 14.sp, color: Colors.blue),
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 10.h),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              _buildLiveCard(
                title: "Mat 116",
                subtitle: "19 Tutor",
                color1: Colors.red,
                color2: Colors.orange,
              ),
              SizedBox(width: 10.w),
              _buildLiveCard(
                title: "Arqui 116",
                subtitle: "15 Tutor",
                color1: const Color.fromARGB(255, 0, 109, 199),
                color2: Colors.blueAccent,
              ),
            ],
          ),
        ),

        SizedBox(height: 38.h),

        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                padding: EdgeInsets.all(16.w),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12.r),
                  gradient: const LinearGradient(
                    colors: [Color(0xFF8B5CF6), Color(0xFF0760FB)],
                  ),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Obtén la oferta de tu ",
                            style: TextStyle(color: Colors.black, fontSize: 16.sp),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Text(
                              "vida",
                              style: TextStyle(
                                color: Colors.yellow,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Text(
                            "Acceso a todos los cursos",
                            style: TextStyle(color: Colors.black, fontSize: 14.sp),
                          ),
                          SizedBox(height: 10.h),
                          ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                            ),
                            child: Text(
                              "Canjear ahora",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16.sp,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 100.w),
                  ],
                ),
              ),
              Positioned(
                right: -10.w,
                top: -25.h,
                child: Image.asset(
                  "assets/men.png",
                  width: 180.w,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLiveCard({
    required String title,
    required String subtitle,
    required Color color1,
    required Color color2,
  }) {
    return Expanded(
      child: Container(
        padding: EdgeInsets.all(12.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.r),
          gradient: LinearGradient(colors: [color1, color2]),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(color: Colors.white, fontSize: 14.sp, fontWeight: FontWeight.bold),
            ),
            Text(
              subtitle,
              style: TextStyle(color: Colors.white, fontSize: 12.sp),
            ),
          ],
        ),
      ),
    );
  }
}
