// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// import '../authenticate_repo.dart';
// import 'sign_up_bloc/sign_up_bloc.dart';
// import 'widgets/authenticate_widgets.dart';

// class SignUpPage extends StatefulWidget {
//   const SignUpPage({super.key});

//   @override
//   State<SignUpPage> createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignUpPage> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _usernameController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _reTypePasswordController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SignUpBloc, SignUpState>(
//       builder: (context, state) => Scaffold(
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 100.h),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 headerTitle('Sign up to enter', 'iHunEcommerce'),
//                 CusTextFeild(
//                     onChange: (value) {
//                       context.read<SignUpBloc>().add(UserNameEvent(value));
//                     },
//                     controller: _usernameController,
//                     lblText: 'Enter your username',
//                     iconData: Icons.person),
//                 CusTextFeild(
//                     onChange: (value) {
//                       context.read<SignUpBloc>().add(EmailEvent(value));
//                     },
//                     controller: _emailController,
//                     lblText: 'Enter your email',
//                     iconData: Icons.email_rounded),
//                 CusTextFeild(
//                     onChange: (value) {
//                       context.read<SignUpBloc>().add(PasswordEvent(value));
//                     },
//                     controller: _passwordController,
//                     lblText: 'Enter your passwod',
//                     txtfType: 'password',
//                     iconData: Icons.password_rounded),
//                 CusTextFeild(
//                     onChange: (value) {
//                       context.read<SignUpBloc>().add(RePasswordEvent(value));
//                     },
//                     controller: _reTypePasswordController,
//                     lblText: 'Retype your passwod',
//                     txtfType: 'password',
//                     iconData: Icons.password_rounded),
//                 SizedBox(
//                   height: 20.h,
//                 ),
//                 actionBtn(() {
//                   AuthenticateRepo(context: context).handleSignUp();
//                 }, ''),
//                 ForgotPassword(
//                   ontap: () {},
//                 ),
//                 const CusDivider(),
//                 const CusAuthNav(authNavType: 'signUp', navTo: '/')
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
