import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:project/widget/bottom.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isChecked = false;
  bool _isLoginMode = true;
  bool _passwordVisible = false;
  bool _confirmPasswordVisible = false;
  final _formKey = GlobalKey<FormState>();

  // Khởi tạo các TextEditingController ở cấp instance
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    // Hủy các controller để tránh rò rỉ bộ nhớ
    _emailController.dispose();
    _phoneController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _togglePasswordVisibility() {
    setState(() {
      _passwordVisible = !_passwordVisible;
    });
  }

  void _toggleConfirmPasswordVisibility() {
    setState(() {
      _confirmPasswordVisible = !_confirmPasswordVisible;
    });
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    final emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    if (!emailRegex.hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your phone number';
    }
    final phoneRegex = RegExp(r'^\d{10}$');
    if (!phoneRegex.hasMatch(value)) {
      return 'Please enter a valid 10-digit phone number';
    }
    return null;
  }

  String? _validatePassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 6) {
      return 'Password must be at least 6 characters';
    }
    final passwordRegex = RegExp(r'^[a-zA-Z0-9]+$');
    if (!passwordRegex.hasMatch(value)) {
      return 'Password cannot contain special characters';
    }
    return null;
  }

  String? _validateConfirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }
    if (value != password) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              SizedBox(height: _isLoginMode ? 0 : 25.w),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextField(
                      "Email",
                      Icons.email,
                      false,
                      null,
                      _emailController,
                      _validateEmail,
                    ),
                    if (!_isLoginMode) ...[
                      SizedBox(height: 16.w),
                      _buildTextField(
                        "Phone Number",
                        Icons.phone,
                        false,
                        null,
                        _phoneController,
                        _validatePhone,
                      ),
                    ],
                    SizedBox(height: 16.w),
                    _buildTextField(
                      "Password",
                      Icons.lock,
                      !_passwordVisible,
                      _togglePasswordVisibility,
                      _passwordController,
                      _validatePassword,
                    ),
                    if (!_isLoginMode) ...[
                      SizedBox(height: 16.w),
                      _buildTextField(
                        "Confirm Password",
                        Icons.lock,
                        !_confirmPasswordVisible,
                        _toggleConfirmPasswordVisibility,
                        _confirmPasswordController,
                        (value) => _validateConfirmPassword(value, _passwordController.text),
                      ),
                    ],
                    SizedBox(height: 16.w),
                    if (_isLoginMode) ...[
                      _buildRememberForgot(),
                      SizedBox(height: 30.w),
                    ] else
                      SizedBox(height: 30.w),
                    _buildActionButton(_emailController, _passwordController),
                    SizedBox(height: 16.w),
                    _buildToggleOption(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Stack(
      children: [
        Image.asset(
          _isLoginMode ? 'assets/images/login.png' : 'assets/images/signup.png',
          fit: BoxFit.fitWidth,
          width: double.infinity,
          height: _isLoginMode ? 400.w : 250.w,
        ),
        Positioned(
          bottom: _isLoginMode ? 40.w : 10.w,
          left: 16.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                _isLoginMode ? "Sign In" : "Sign Up",
                style: TextStyle(fontSize: 30.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 8.w),
              Container(
                height: 4.w,
                width: 100.w,
                decoration: BoxDecoration(
                  color: Color(0xffff8383),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildTextField(
    String label,
    IconData icon,
    bool obscureText,
    Function? toggleVisibility,
    TextEditingController controller,
    String? Function(String?) validator,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label),
        SizedBox(height: 4.w),
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          validator: validator,
          decoration: InputDecoration(
            hintText: "Enter your $label",
            prefixIcon: Icon(icon),
            suffixIcon:
                label.contains("Password")
                    ? IconButton(
                      icon: Icon(obscureText ? Icons.visibility : Icons.visibility_off),
                      onPressed: () {
                        if (toggleVisibility != null) {
                          toggleVisibility();
                        }
                      },
                    )
                    : null,
            enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.redAccent)),
            focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
            errorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
            focusedErrorBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          ),
        ),
      ],
    );
  }

  Widget _buildRememberForgot() {
    return Row(
      children: [
        Checkbox(
          value: _isChecked,
          activeColor: Colors.redAccent,
          onChanged: (value) => setState(() => _isChecked = value ?? false),
        ),
        Text("Remember me"),
        Spacer(),
        Text(
          "Forgot Password?",
          style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget _buildActionButton(
    TextEditingController emailController,
    TextEditingController passwordController,
  ) {
    return ElevatedButton(
      onPressed: () {
        if (_formKey.currentState!.validate()) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => const CustomBottomNavigationBar()),
          );
        }
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xffff8383),
        padding: EdgeInsets.symmetric(vertical: 16.w),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Center(
        child: Text(
          _isLoginMode ? "Login" : "Create Account",
          style: TextStyle(fontSize: 16.sp, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildToggleOption() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(_isLoginMode ? "Don't have an account?" : "Already have an account?"),
        SizedBox(width: 8.w),
        GestureDetector(
          onTap: () {
            setState(() {
              _isLoginMode = !_isLoginMode;
            });
          },
          child: Text(
            _isLoginMode ? "Sign Up" : "Sign In",
            style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }
}
