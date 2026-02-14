import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:untitled2/signup.dart';
import 'onboardingscreen.dart';

// ************************
// 1. الثوابت والألوان المستخدمة
// ************************
const Color kPrimaryColor = Color(0xffA5B5C1);
const Color kTextColor = Color(0xff200E32);
const Color kWhiteColor = Color(0xffFFFFFF);
const double kSpacing = 20.0;
const double kLargeSpacing = 40.0;
const double kButtonHeight = 50.0;
const double kSocialButtonWidth = 82.0;
const double kSocialButtonHeight = 55.0;


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool isPasswordVisible = false;
  bool isEmailValid = false;

  // دالة تحقق بسيطة من البريد الإلكتروني (RegExp)
  final RegExp _emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // الرجوع إلى شاشة البداية (onboarding)
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const onboarding()),
            );
          },
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(kSpacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch, // لتحسين التوزيع الأفقي
              children: [
                const SizedBox(height: kLargeSpacing),

                // صورة الشعار
                SvgPicture.asset("assets/images/Group 16204.svg", height: 80), // تحديد ارتفاع مناسب

                const SizedBox(height: 80), // تقليل الارتفاع لجعل Welcome أقرب

                const Text(
                  "Welcome",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 40,
                    fontFamily: "gilroy",
                    fontWeight: FontWeight.bold, // إضافة وزن خط
                  ),
                ),

                const SizedBox(height: kLargeSpacing),

                // ************************
                // نموذج تسجيل الدخول
                // ************************
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // حقل البريد الإلكتروني (Email)
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: _inputDecoration(
                          label: 'Email',
                          hint: 'Enter Email',
                          icon: Icons.email,
                          isValid: isEmailValid, // تمرير حالة التحقق
                        ),
                        onChanged: (value) {
                          setState(() {
                            isEmailValid = _emailRegex.hasMatch(value);
                          });
                        },
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter email';
                          } else if (!_emailRegex.hasMatch(value)) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: kLargeSpacing),

                      // حقل كلمة المرور (Password)
                      TextFormField(
                        controller: passwordController,
                        obscureText: !isPasswordVisible,
                        decoration: InputDecoration(
                          labelText: 'Password',
                          hintText: 'Enter Password',
                          prefixIcon: const Icon(Icons.lock, color: kTextColor),
                          suffixIcon: IconButton(
                            icon: Icon(
                              isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                              color: kTextColor,
                            ),
                            onPressed: () {
                              setState(() {
                                isPasswordVisible = !isPasswordVisible;
                              });
                            },
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12),
                            borderSide: const BorderSide(color: Color(0xFF707070)),
                          ),
                          contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0), // تحسين الهوامش
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          }
                          // يمكن إضافة شروط تعقيد هنا (مثل 6 أحرف على الأقل)
                          return null;
                        },
                      ),

                      const SizedBox(height: kSpacing),

                      // زر تسجيل الدخول (Login Button)
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            // ✅ نجاح التحقق: أظهر رسالة ثم انتقل إلى شريط التنقل
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: kPrimaryColor,
                                content: Row(
                                  children: [
                                    Icon(Icons.check_circle, color: kWhiteColor),
                                    SizedBox(width: 10),
                                    Text(
                                      "Login successful!",
                                      style: TextStyle(
                                        fontFamily: "gilroy pro",
                                        color: kWhiteColor,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );

                          }
                        },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size(double.infinity, kButtonHeight),
                          backgroundColor: kPrimaryColor,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        child: const Text(
                          "Login",
                          style: TextStyle(
                            fontSize: 18,
                            color: kWhiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),

                      const SizedBox(height: 15),

                      // نسيت كلمة المرور (Forgot Password)
                      Align(
                        alignment: Alignment.center, // تم تعديل Alignment لجعله في المنتصف
                        child: TextButton(
                          onPressed: () {},
                          child: const Text(
                            "Forgot your password?",
                            style: TextStyle(
                              color: kPrimaryColor,
                              fontFamily: "gilroy pro",
                            ),
                          ),
                        ),
                      ),

                      const SizedBox(height: kSpacing),

                      // التسجيل (Sign up)
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account? ", style: TextStyle(color: Colors.black54)),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(builder: (context) => const Signup()),
                              );
                            },
                            child: const Text(
                              "Sign up",
                              style: TextStyle(
                                color: kPrimaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: kLargeSpacing),

                      // أزرار التواصل الاجتماعي
                      Wrap(
                        spacing: 16,
                        alignment: WrapAlignment.center,
                        children: [
                          _buildSocialButton("assets/images/facebook (2).svg", label: "Facebook", onTap: () {}),
                          _buildSocialButton("assets/images/search (1).svg", label: "Google", onTap: () {}),
                          _buildSocialButton("assets/images/apple-logo.svg", label: "Apple", onTap: () {}),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// دالة مساعدة لتصميم حقل الإدخال (تم استخلاصها)
InputDecoration _inputDecoration({
  required String label,
  required String hint,
  required IconData icon,
  required bool isValid,
}) {
  return InputDecoration(
    labelText: label,
    hintText: hint,
    prefixIcon: Icon(icon, color: kTextColor),
    suffixIcon: isValid
        ? const Icon(Icons.check_circle, color: Colors.green)
        : null,
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: const BorderSide(color: Color(0xFF707070)),
    ),
    contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
  );
}


// دالة لبناء زر اجتماعي واحد
Widget _buildSocialButton(String assetPath, {required String label, required VoidCallback onTap}) {
  return InkWell(
    onTap: onTap,
    borderRadius: BorderRadius.circular(12),
    child: Container(
      height: kSocialButtonHeight,
      width: kSocialButtonWidth,
      decoration: BoxDecoration(
        color: kWhiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [BoxShadow(color: Colors.black.withValues(alpha: 0.05), blurRadius: 8, offset: const Offset(0, 4))],
      ),
      child: Tooltip(
        message: label,
        child: Center(
          child: SvgPicture.asset(
            assetPath,
            height: 30,
            package: null,
          ),
        ),
      ),
    ),
  );
}