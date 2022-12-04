// import 'package:flutter/material.dart';
// class SignIn extends StatefulWidget {
//   const SignIn({Key? key}) : super(key: key);
//
//   @override
//   State<SignIn> createState() => _SignInState();
// }
//
// class _SignInState extends State<SignIn> {
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: SingleChildScrollView(
//         child: Container(
//           height: MediaQuery.of(context).size.height - kToolbarHeight,
//           child: FractionallySizedBox(
//             widthFactor: 400,
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.center,
//               mainAxisAlignment: MainAxisAlignment.center,
//               mainAxisSize: MainAxisSize.min,
//               children: <Widget>[
//                 const Spacer(),
//                 //AppLogo(scaleFactor: widget.logoScaleFactor),
//                 const Spacer(),
//                 AppTextFormField(
//                   key: AppWidgetKeys.keys['SignInEmailField'],
//                   labelText: context.l10n().msgEmail,
//                   textInputAction: TextInputAction.next,
//                   focusNode: _emailFocus,
//                   onFieldSubmitted: (_) {
//                     fieldFocusChangeCallback(
//                       context,
//                       _emailFocus,
//                       _passwordFocus,
//                     );
//                   },
//                   keyboardType: TextInputType.emailAddress,
//                   controller: _emailController,
//                   validator: (_) => _emailController.text.trim().isNotEmpty &&
//                       !Validators.isValidEmail(state.email)
//                       ? context.l10n().msgEnterValidEmail
//                       : null,
//                 ),
//                 const SizedBox(height: 10.0),
//                 AppPassworFormField(
//                   key: AppWidgetKeys.keys['SignInPasswordField'],
//                   labelText: context.l10n().msgPassword,
//                   controller: _passwordController,
//                   textInputAction: TextInputAction.done,
//                   focusNode: _passwordFocus,
//                 ),
//                 const SizedBox(height: 15.0),
//                 GradientButton(
//                   key: AppWidgetKeys.keys['SignInSubmitButton'],
//                   gradient: AppTheme.widgetGradient,
//                   onPressed: state.isSignInButtonEnabled() ? _onFormSubmitted : null,
//                   child: Text(
//                     context.l10n().msgSignIn,
//                     style: state.isSignInButtonEnabled()
//                         ? AppTheme.buttonEnabledTextStyle
//                         : AppTheme.buttonDisabledTextStyle,
//                   ),
//                 ),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.end,
//                   children: <Widget>[
//                     FlatButton(
//                       key: AppWidgetKeys.keys['SignInForgotPasswordButton'],
//                       onPressed: () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute<void>(
//                             builder: (_) => ResetPasswordScreen(
//                               authRepository: widget._authRepository,
//                             ),
//                           ),
//                         );
//                       },
//                       child: Text(
//                         context.l10n().msgForgotPasswprd,
//                         style: TextStyle(
//                           color: Theme.of(context).primaryColor,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//                 if (kUseGoogleASignIn) ...<Widget>[
//                   Container(
//                     width: double.infinity,
//                     child: Padding(
//                       padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                       child: Row(
//                         children: <Widget>[
//                           Expanded(
//                             child: HorizontalLine(
//                               color: AppTheme.horizontalLineColor(
//                                   Theme.of(context).brightness),
//                             ),
//                           ),
//                           Padding(
//                             padding: const EdgeInsets.symmetric(horizontal: 16.0),
//                             child: Text(context.l10n().msgOr),
//                           ),
//                           Expanded(
//                             child: HorizontalLine(
//                               color: AppTheme.horizontalLineColor(
//                                 Theme.of(context).brightness,
//                               ),
//                             ),
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 15.0),
//                   Container(
//                     width: double.infinity,
//                     child: GoogleSignInButton(
//                       key: AppWidgetKeys.keys['SignInGoogleButton'],
//                       borderRadius: 6.0,
//                       darkMode: Theme.of(context).brightness == Brightness.dark,
//                       onPressed: () {
//                         context.bloc<SignInBloc>().add(
//                           const SignInEvent.googlePressed(),
//                         );
//                       },
//                     ),
//                   ),
//                 ],
//                 const Spacer(),
//                 FlatButton(
//                   key: AppWidgetKeys.keys['SignInSignUpButton'],
//                   onPressed: () {
//                     Navigator.push<void>(
//                       context,
//                       MaterialPageRoute<void>(
//                         builder: (_) => SignUpScreen(
//                           authRepository: widget._authRepository,
//                           analyticsService: widget._analyticsService,
//                         ),
//                       ),
//                     );
//                   },
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: <Widget>[
//                       Text(
//                         context.l10n().msgDontHaveAccount,
//                         style: const TextStyle(
//                           fontSize: 14,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                       const SizedBox(width: 10),
//                       Text(
//                         context.l10n().msgSignUp,
//                         style: TextStyle(
//                           color: Theme.of(context).primaryColor,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       )
//                     ],
//                   ),
//                 ),
//                 SizedBox(height: 20.0 / widget.widthFactor),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   },
//   );
//   }
// }
