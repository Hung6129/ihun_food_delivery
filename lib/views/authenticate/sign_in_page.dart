// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:ihun_commerce/features/authenticate/authenticate_repo.dart';

// import 'sign_in_bloc/sign_in_bloc.dart';
// import 'widgets/authenticate_widgets.dart';

// class SignInPage extends StatefulWidget {
//   const SignInPage({super.key});

//   @override
//   State<SignInPage> createState() => _SignInPageState();
// }

// class _SignInPageState extends State<SignInPage> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<SignInBloc, SignInState>(
//       builder: (context, state) => Scaffold(
//         body: SingleChildScrollView(
//           child: Padding(
//             padding: EdgeInsets.symmetric(horizontal: 18.w, vertical: 100.h),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 headerTitle('Welcome to', 'iHunECommerce'),
//                 CusTextFeild(
//                   onChange: (value) =>
//                       context.read<SignInBloc>().add(SignInEmail(value)),
//                   controller: _emailController,
//                   lblText: 'Enter your email',
//                   iconData: Icons.email,
//                 ),
//                 CusTextFeild(
//                   onChange: (value) =>
//                       context.read<SignInBloc>().add(SignInPassword(value)),
//                   controller: _passwordController,
//                   lblText: 'Enter your password',
//                   iconData: Icons.lock,
//                   txtfType: 'password',
//                 ),
//                 actionBtn(() {
//                   AuthenticateRepo(context: context)
//                       .handleSignIn('emailAndPassword');
//                 }, 'signIn'),
//                 SizedBox(
//                   height: 10.h,
//                 ),
//                 ForgotPassword(
//                   ontap: () {},
//                 ),
//                 otherSignIn(),
//                 SignInWithThirdParty(
//                     ggSignIn: () {
//                       AuthenticateRepo(context: context).handleSignInWithGoogle();
//                     },
//                     fbSignIn: () {}),
//                 const CusDivider(),
//                 const CusAuthNav(authNavType: 'signIn', navTo: '/sign_up')
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
