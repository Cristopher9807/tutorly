import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tutorly/congrats.dart';

class BestNewCourses extends StatelessWidget {
  final List<Map<String, dynamic>> courses = [
    {
      "title": "Introducción a la fotografía y edición",
      "instructor": "Eleanor Pena",
      "duration": "2h 30m",
      "price": 14.99,
      "originalPrice": 29.99,
      "rating": 4.8,
      "numRatings": 1500,
      "image": "https://img.freepik.com/fotos-premium/mujer-corriendo-negocios-linea-haciendo-velas-boutique-tomando-fotos-marketing-linea_562859-2724.jpg",
    },
    {
      "title": "Machine Learning Básico",
      "instructor": "José Ramírez",
      "duration": "3h 15m",
      "price": 19.99,
      "originalPrice": 39.99,
      "rating": 4.7,
      "numRatings": 1800,
      "image": "https://img.freepik.com/fotos-premium/vas-lograr-exito-empresa_386167-7479.jpg",
    },
    {
      "title": "Introducción al diseño UX/UI Moderno",
      "instructor": "Lucía Fernández",
      "duration": "1h 45m",
      "price": 12.99,
      "originalPrice": 25.99,
      "rating": 4.9,
      "numRatings": 2000,
      "image": "https://virtual.javerianacali.edu.co/images/diplomado-en-diseno-ux-1024x539_980w.webp",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, top: 20.h, bottom: 10.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Los mejores cursos nuevos',
                  style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const Congrats()),
                  );
                },
                child: Text(
                  'Todas las materias >',
                  style: TextStyle(fontSize: 14.sp, color: Colors.blue),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          SizedBox(
            height: 230.h,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: courses.length,
              itemBuilder: (context, index) {
                return _buildCourseCard(courses[index]);
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCourseCard(Map<String, dynamic> course) {
    return Container(
      width: 180.w,
      margin: EdgeInsets.only(right: 10.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 6.r,
            offset: Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.vertical(top: Radius.circular(12.r)),
            child: Image.network(
              course["image"],
              height: 100.h,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          Padding(
            padding: EdgeInsets.all(10.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  course["title"],
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4.h),
                Text(
                  '${course["instructor"]} • ${course["duration"]}',
                  style: TextStyle(fontSize: 12.sp, color: Colors.grey),
                ),
                SizedBox(height: 6.h),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '\$${course["price"]}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    if (course["originalPrice"] > course["price"])
                      Text(
                        '\$${course["originalPrice"]}',
                        style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.grey,
                          fontSize: 12.sp,
                        ),
                      ),
                  ],
                ),
                Row(
                  children: [
                    Icon(Icons.star, color: Colors.amber, size: 16.sp),
                    SizedBox(width: 4.w),
                    Text(
                      '${course["rating"]} (${course["numRatings"]})',
                      style: TextStyle(fontSize: 12.sp),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
