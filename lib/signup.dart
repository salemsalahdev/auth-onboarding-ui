import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'Login.dart'; // استيراد شاشة تسجيل الدخول

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

class Signup extends StatefulWidget {
  const Signup({super.key});

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController fullnameController = TextEditingController(); // تم تعديل الاسم
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController(); // حقل تأكيد كلمة المرور

  bool isPasswordVisible = false;
  bool isConfirmPasswordVisible = false; // لإظهار وإخفاء حقل تأكيد كلمة المرور
  bool isEmailValid = false;

  final RegExp _emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');

  @override
  void dispose() {
    emailController.dispose();
    fullnameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  // دالة مساعدة لتصميم حقل الإدخال
  InputDecoration _inputDecoration({
    required String label,
    required String hint,
    required IconData icon,
    bool isValid = false,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            // الرجوع إلى شاشة تسجيل الدخول (Home)
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const Home()), // يجب أن تكون const Home()
            );
          },
        ),
      ),

      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(kSpacing),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: kLargeSpacing),

                // صورة الشعار
                SvgPicture.asset("assets/images/Group 16204.svg", height: 80),

                const SizedBox(height: 80),

                const Text(
                  "Sign Up",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.black87,
                    fontSize: 40,
                    fontFamily: "gilroy",
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: kLargeSpacing),

                // ************************
                // نموذج التسجيل
                // ************************
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      // حقل الاسم الكامل (FullName)
                      TextFormField(
                        controller: fullnameController,
                        keyboardType: TextInputType.name,
                        decoration: _inputDecoration(
                          label: 'FullName',
                          hint: 'Enter your Full Name',
                          icon: Icons.account_circle,
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your full name';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: kSpacing),

                      // حقل البريد الإلكتروني (Email)
                      TextFormField(
                        controller: emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: _inputDecoration(
                          label: 'Email',
                          hint: 'Enter Email',
                          icon: Icons.email,
                          isValid: isEmailValid,
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

                      const SizedBox(height: kSpacing),

                      // حقل كلمة المرور (Password)
                      TextFormField(
                        controller: passwordController,
                        obscureText: !isPasswordVisible,
                        decoration: _passwordInputDecoration(
                          label: 'Password',
                          hint: 'Enter Password',
                          isVisible: isPasswordVisible,
                          onPressed: () {
                            setState(() {
                              isPasswordVisible = !isPasswordVisible;
                            });
                          },
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter password';
                          } else if (value.length < 6) {
                            return 'Password must be at least 6 characters';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: kSpacing),

                      // حقل تأكيد كلمة المرور (Confirm Password) - تم إضافته بدلاً من الحقل المكرر
                      TextFormField(
                        controller: confirmPasswordController,
                        obscureText: !isConfirmPasswordVisible,
                        decoration: _passwordInputDecoration(
                          label: 'Confirm Password',
                          hint: 'Confirm Password',
                          isVisible: isConfirmPasswordVisible,
                          onPressed: () {
                            setState(() {
                              isConfirmPasswordVisible = !isConfirmPasswordVisible;
                            });
                          },
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password';
                          } else if (value != passwordController.text) {
                            return 'Passwords do not match';
                          }
                          return null;
                        },
                      ),

                      const SizedBox(height: kLargeSpacing),

                      // زر التسجيل (Sign Up Button)
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                backgroundColor: kPrimaryColor,
                                content: Row(
                                  children: [
                                    Icon(Icons.check_circle, color: kWhiteColor),
                                    SizedBox(width: 10),
                                    Text(
                                      "Signup successful!",
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
                          "Sign Up",
                          style: TextStyle(
                            fontSize: 18,
                            color: kWhiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
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
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // دالة مساعدة لتصميم حقل كلمة المرور (للتجنب التكرار)
  InputDecoration _passwordInputDecoration({
    required String label,
    required String hint,
    required bool isVisible,
    required VoidCallback onPressed,
  }) {
    return InputDecoration(
      labelText: label,
      hintText: hint,
      prefixIcon: const Icon(Icons.lock, color: kTextColor),
      suffixIcon: IconButton(
        icon: Icon(
          isVisible ? Icons.visibility : Icons.visibility_off,
          color: kTextColor,
        ),
        onPressed: onPressed,
      ),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFF707070)),
      ),
      contentPadding: const EdgeInsets.symmetric(vertical: 16.0, horizontal: 10.0),
    );
  }
}

// دالة بناء زر اجتماعي واحد
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