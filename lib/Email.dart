import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'education.dart';
import 'full_name.dart';
import 'user_session.dart';

class Email extends StatefulWidget {
  const Email({super.key});

  @override
  EmailState createState() => EmailState();
}

class EmailState extends State<Email> {
  String email = '';
  String password = '';
  String confirmPassword = '';
  String errorText = '';
  bool showPassword = false;
  bool showConfirmPassword = false;

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context, designSize: const Size(375, 812));

    bool isFormValid = email.isNotEmpty && password.isNotEmpty && confirmPassword.isNotEmpty && password == confirmPassword;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const FullName()),
                    );
                  },
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.arrow_back, color: Colors.blue),
                      SizedBox(width: 8.w),
                      const Text(
                        "Atrás",
                        style: TextStyle(color: Colors.blue, fontSize: 14),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                const Text(
                  "¿Cuál es tu correo electrónico?",
                  style: TextStyle(
                    color: Color(0xFF0F172A),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 20.h),
                const Text(
                  "Correo electrónico",
                  style: TextStyle(
                    color: Color(0xFF0F172A),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),
                _buildInputField(
                  hintText: "ejemplo@dominio.com",
                  onChanged: (value) {
                    setState(() {
                      email = value;
                    });
                  },
                ),
                SizedBox(height: 20.h),
                const Text(
                  "Contraseña",
                  style: TextStyle(
                    color: Color(0xFF0F172A),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),
                _buildInputField(
                  hintText: "********",
                  obscureText: !showPassword,
                  onChanged: (value) {
                    setState(() {
                      password = value;
                      errorText = '';
                    });
                  },
                  toggleVisibility: () => setState(() => showPassword = !showPassword),
                  isVisible: showPassword,
                ),
                SizedBox(height: 20.h),
                const Text(
                  "Confirmar contraseña",
                  style: TextStyle(
                    color: Color(0xFF0F172A),
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 10.h),
                _buildInputField(
                  hintText: "********",
                  obscureText: !showConfirmPassword,
                  onChanged: (value) {
                    setState(() {
                      confirmPassword = value;
                      errorText = '';
                    });
                  },
                  toggleVisibility: () => setState(() => showConfirmPassword = !showConfirmPassword),
                  isVisible: showConfirmPassword,
                ),
                SizedBox(height: 10.h),
                if (password != confirmPassword && confirmPassword.isNotEmpty)
                  const Text(
                    "Las contraseñas no coinciden",
                    style: TextStyle(color: Colors.red, fontSize: 12),
                  ),
                SizedBox(height: 30.h),
                InkWell(
                  onTap: isFormValid
                      ? () {
                          UserSession.email = email;
                          UserSession.password = password;
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (_) => const Education()),
                          );
                        }
                      : null,
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.r),
                      color: isFormValid ? const Color(0xFF0760FB) : Colors.grey,
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x26000000),
                          blurRadius: 4,
                          offset: Offset(0, 2),
                        ),
                      ],
                    ),
                    padding: EdgeInsets.symmetric(vertical: 16.h),
                    width: double.infinity,
                    child: const Center(
                      child: Text(
                        "Continuar",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputField({
    required String hintText,
    bool obscureText = false,
    required Function(String) onChanged,
    Function()? toggleVisibility,
    bool isVisible = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xFFCBD5E1), width: 1),
        borderRadius: BorderRadius.circular(10.r),
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(horizontal: 12.w),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              obscureText: obscureText,
              onChanged: onChanged,
              decoration: InputDecoration(
                hintText: hintText,
                border: InputBorder.none,
              ),
            ),
          ),
          if (toggleVisibility != null)
            IconButton(
              icon: Icon(
                isVisible ? Icons.visibility : Icons.visibility_off,
                color: Colors.grey,
              ),
              onPressed: toggleVisibility,
            )
        ],
      ),
    );
  }
}