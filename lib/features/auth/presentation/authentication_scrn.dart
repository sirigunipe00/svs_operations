import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:svs_operations/core/core.dart';
import 'package:svs_operations/features/auth/presentation/bloc/auth/auth_cubit.dart';
import 'package:svs_operations/features/auth/presentation/bloc/sign_in/sign_in_cubit.dart';
import 'package:svs_operations/widgets/dialogs/app_dialogs.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool obscurePassword = true;
  bool rememberMe = false;
  bool showPswd = false;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void togglePswd() => setState(() {
        showPswd = !showPswd;
      });

  void login() {
    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please enter Email/Employee ID and Password'),
        ),
      );
      return;
    }
    debugPrint('Email: $email');
    debugPrint('Password: $password');
    debugPrint('Remember Me: $rememberMe');
  }

  void loginWithOtp() {
    debugPrint('Login with OTP');
  }

  void forgotPassword() {
    debugPrint('Forgot Password');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F8FA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 17),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 100,
              ),
              // Padding(
              //   padding: const EdgeInsets.symmetric(horizontal: 17),
              //   child: const SizedBox(height: 34),
              // ),

              _buildSvsLogo(),
              const SizedBox(height: 7),
              const Text(
                'SVS Operations',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 3),
              const Text(
                'Sign in to continue',
                style: TextStyle(
                    fontSize: 14,
                    color: Colors.black,
                    fontWeight: FontWeight.w400),
              ),
              const SizedBox(height: 50),
              _buildLoginCard(),
              // const SizedBox(height: 25),

              // const Spacer(),
              const SizedBox(height: 40),
              _buildFooter(),

              const SizedBox(height: 25),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSvsLogo() {
    return Image.asset('assets/images/svs_logo.png');
  }

  Widget _buildLoginCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(14, 13, 14, 18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: const Color(0xFFE1E7ED),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Email or Employee ID',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          _buildTextField(
            controller: emailController,
            hintText: 'e.g. employee@company.com',
            icon: Icons.email_outlined,
            keyboardType: TextInputType.emailAddress,
          ),
          const SizedBox(height: 12),
          const Text(
            'Password',
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 4),
          _buildTextField(
            controller: passwordController,
            hintText: 'Enter Password',
            icon: Icons.lock_outline,
            obscureText: obscurePassword,
            suffixIcon: IconButton(
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(
                minWidth: 35,
                minHeight: 35,
              ),
              icon: Icon(
                obscurePassword
                    ? Icons.visibility_outlined
                    : Icons.visibility_off_outlined,
                size: 18,
                color: const Color(0xFF168FD0),
              ),
              onPressed: () {
                setState(() {
                  obscurePassword = !obscurePassword;
                });
              },
            ),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              SizedBox(
                width: 20,
                height: 20,
                child: Checkbox(
                  value: rememberMe,
                  activeColor: const Color(0xFF168FD0),
                  side: const BorderSide(
                    color: Color(0xFFD9DEE5),
                    width: 1,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(3),
                  ),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onChanged: (value) {
                    setState(() {
                      rememberMe = value ?? false;
                    });
                  },
                ),
              ),
              const SizedBox(width: 4),
              const Text(
                'Remember me',
                style: TextStyle(
                    fontSize: 10,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ),
              const Spacer(),
              TextButton(
                onPressed: forgotPassword,
                style: TextButton.styleFrom(
                  padding: EdgeInsets.zero,
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                ),
                child: const Text(
                  'Forgot Password',
                  style: TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF168FD0),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            height: 40,
            child: BlocConsumer<SignInCubit, SignInState>(
              listener: (context, state) {
                state.maybeWhen(
                  orElse: () {},
                  success: context.cubit<AuthCubit>().authCheckRequested,
                  failure: (failure) => AppDialog.showErrorDialog(
                    context,
                    title: failure.title,
                    content: failure.error,
                    onTapDismiss: context.close,
                  ),
                );
              },
              builder: (context, state) {
                return ElevatedButton(
                  onPressed: () => context
                      .cubit<SignInCubit>()
                      .login(emailController.text, passwordController.text),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF168FD0),
                    foregroundColor: Colors.white,
                    elevation: 2,
                    shadowColor: const Color(0x55168FD0),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: state.isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(),
                        )
                      : const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                );
              },
            ),
          ),
          const SizedBox(height: 16),
          // Center(
          //   child: TextButton(
          //     onPressed: loginWithOtp,
          //     style: TextButton.styleFrom(
          //       padding: EdgeInsets.zero,
          //       minimumSize: Size.zero,
          //       tapTargetSize: MaterialTapTargetSize.shrinkWrap,
          //     ),
          //     child: const Text(
          //       'Login with OTP',
          //       style: TextStyle(
          //         fontSize: 12,
          //         fontWeight: FontWeight.w500,
          //         color: Color(0xFF008DD2),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    bool obscureText = false,
    Widget? suffixIcon,
    TextInputType? keyboardType,
  }) {
    return SizedBox(
      height: 40,
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: const TextStyle(
          fontSize: 11,
          color: Color(0xFF202938),
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: const TextStyle(
            fontSize: 10,
            color: Colors.black,
          ),
          prefixIcon: Icon(
            icon,
            size: 17,
            color: const Color(0xFF168FD0),
          ),
          prefixIconConstraints: const BoxConstraints(
            minWidth: 36,
            minHeight: 36,
          ),
          suffixIcon: suffixIcon,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 10,
            vertical: 0,
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(
              color: Color(0xFFDCE3EA),
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(
              color: Color(0xFFDCE3EA),
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(6),
            borderSide: const BorderSide(
              color: Color(0xFF168FD0),
              width: 1,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 25),
      child: Column(
        children: [
          Image.asset('assets/images/easycloud_logo.jpeg',
              height: 70, width: 100),
          const Text(
            'Copyrights reserved to EasyCloud ©2026',
            style: TextStyle(
                fontSize: 10,
                color: Color(0xFF78869A),
                fontWeight: FontWeight.w400),
          ),
        ],
      ),
    );
  }
}
