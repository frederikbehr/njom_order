import 'dart:io';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nom_order/pages/register/register_text_field.dart';
import 'package:nom_order/pages/register/sign_in_option_button.dart';
import 'package:nom_order/widgets/buttons/legalese_button.dart';
import 'package:nom_order/widgets/custom_appbar.dart';

import '../../authentication/auth_service.dart';
import '../../controller/controller.dart';
import '../../data/dimensions.dart';
import '../forgot_password/forgot_password_page.dart';


class Register extends StatefulWidget {
  final Controller controllerInstance;
  const Register({super.key, required this.controllerInstance});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _authService = AuthService();

  //design
  final double horizontalPadding = 48;

  int currentPage = 0;

  // fields and form
  final GlobalKey<FormState> _formKey = GlobalKey();

  final TextEditingController emailFieldController = TextEditingController();

  final FocusNode emailFocusNode = FocusNode();

  String emailField = "";

  final TextEditingController passwordFieldController = TextEditingController();

  String passwordField = "";

  final FocusNode passwordFocusNode = FocusNode();

  bool buttonIsLoading = false;

  late double boxHeight;

  late double registerWindowHeight;

  //controllers
  final PageController pageController = PageController(initialPage: 0);

  Future changePage(int page) async {
    HapticFeedback.lightImpact();
    currentPage = page;
    FocusScope.of(context).unfocus();
    pageController.animateToPage(
      page,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeIn,
    );
    await Future.delayed(const Duration(milliseconds: 100), () {});
    if (page != 0) {
      if (emailFieldController.text.isEmpty) {
        FocusScope.of(context).requestFocus(emailFocusNode);
      } else {
        FocusScope.of(context).requestFocus(passwordFocusNode);
      }
    }
  }

  String? validateEmail(String? email) {
    if (email != null) {
      final bool containsAt = email.contains("@");
      if (!containsAt) return AppLocalizations.of(context)!.remember_at;
      final bool containsDot = email.contains(".");
      if (!containsDot) return AppLocalizations.of(context)!.not_an_email;
      final bool min6Chars = email.length >= 6;
      if (!min6Chars) return AppLocalizations.of(context)!.email_too_short;
      return null;
    } else {
      return AppLocalizations.of(context)!.please_fill_email;
    }
  }

  String? validatePassword(String? password) {
    if (password != null) {
      final bool empty = password.isNotEmpty;
      if (!empty) return AppLocalizations.of(context)!.password_cannot_be_empty;
      final bool min6Chars = password.length >= 6;
      if (!min6Chars) return AppLocalizations.of(context)!.password_too_short;
      return null;
    } else {
      return AppLocalizations.of(context)!.please_fill_password;
    }
  }

  Future attemptSignIn() async {
    setState(() => buttonIsLoading = true);
    try {
      await _authService.signInWithEmailAndPassword(emailFieldController.text, passwordFieldController.text, context);
      setState(() => buttonIsLoading = false);
    } on FirebaseAuthException catch (signInError) {
      try {
        await _authService.registerWithEmailAndPassword(
          emailFieldController.text,
          passwordFieldController.text,
          context,
        );
        setState(() => buttonIsLoading = false);
      } catch(e) {
        setState(() => buttonIsLoading = false);
        showErrorDialog(signInError);
      }
      setState(() => buttonIsLoading = false);
    }
  }

  void showErrorDialog(FirebaseAuthException error) {
    showAdaptiveDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: widget.controllerInstance.themeSetting.dialog,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.something_went_wrong,
                      style: TextStyle(
                        height: 1.2,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: widget.controllerInstance.themeSetting.textTitle,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      error.message.toString().trim(),
                      style: TextStyle(
                        height: 1.2,
                        fontSize: 14,
                        color: widget.controllerInstance.themeSetting.textBody,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    Material(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.black,
                      child: InkWell(
                        borderRadius: BorderRadius.circular(100),
                        onTap: () {
                          HapticFeedback.lightImpact();
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          child: Text(
                            AppLocalizations.of(context)!.close,
                            style: TextStyle(
                              height: 1.2,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: widget.controllerInstance.themeSetting.textTitle,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.controllerInstance.themeSetting.background,
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.title,
        bottomBorder: true,
        themeSetting: widget.controllerInstance.themeSetting,
      ),
      body: SafeArea(
        child: SizedBox(
          width: width,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.bottom - MediaQuery.of(context).padding.top,
                maxHeight: MediaQuery.of(context).size.height - MediaQuery.of(context).padding.bottom - MediaQuery.of(context).padding.top,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      AnimatedOpacity(
                        opacity: currentPage == 1? 1 : 0,
                        curve: Curves.easeInOut,
                        duration: const Duration(milliseconds: 500),
                        child: Padding(
                          padding: const EdgeInsetsDirectional.only(start: 24),
                          child: Material(
                            color: Colors.transparent,
                            child: InkWell(
                              borderRadius: BorderRadius.circular(100),
                              onTap: () async {
                                changePage(0);
                              },
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(
                                  Platform.isIOS? Icons.arrow_back_ios : Icons.arrow_back_rounded,
                                  size: 30,
                                  color: widget.controllerInstance.themeSetting.secondary,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      /*Image.asset(
                        "assets/images/wordossLogo.png",
                        fit: BoxFit.fitHeight,
                        height: 32,
                      ),*/
                      const SizedBox(width: 30+16+8*2),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: PageView.builder(
                      controller: pageController,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: 2,
                      itemBuilder: (BuildContext context, int index) {
                        switch(index) {
                          case 0: return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              //General sign up content
                              Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 32),
                                    child: Column(
                                      children: [
                                        Text(
                                          AppLocalizations.of(context)!.sign_in,
                                          style: TextStyle(
                                            color: widget.controllerInstance.themeSetting.textTitle,
                                            height: 1.4,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 26,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          AppLocalizations.of(context)!.become_member_below,
                                          style: TextStyle(
                                            color: widget.controllerInstance.themeSetting.textBody,
                                            height: 1.2,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 48),
                                      ],
                                    ),
                                  ),
                                  RegisterTextField(
                                    onChanged: (val) => emailField = val,
                                    hintText: AppLocalizations.of(context)!.enter_email,
                                    autoFocus: false,
                                    onSubmitted: () => changePage(index + 1),
                                    textInputType: TextInputType.emailAddress,
                                    obscureText: false,
                                    validator: (val) => validateEmail(val),
                                    textEditingController: emailFieldController,
                                    focusNode: null,
                                    themeSetting: widget.controllerInstance.themeSetting,
                                    horizontalPadding: horizontalPadding,
                                  ),
                                  const SizedBox(height: 16),
                                  SignInOptionButton(
                                    horizontalPadding: horizontalPadding,
                                    signInOption: SignInOption.email,
                                    onPressed: () => changePage(index + 1),
                                    themeSetting: widget.controllerInstance.themeSetting,
                                  ),
                                ],
                              ),
                            ],
                          );
                          case 1: return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              //General sign up content
                              Column(
                                children: [
                                  Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 32),
                                    child: Column(
                                      children: [
                                        Text(
                                          emailFieldController.text.isEmpty? AppLocalizations.of(context)!.lets_get_started : AppLocalizations.of(context)!.one_more_thing,
                                          style: TextStyle(
                                            color: widget.controllerInstance.themeSetting.textTitle,
                                            height: 1.4,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 24,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 16),
                                        Text(
                                          emailFieldController.text.isEmpty? AppLocalizations.of(context)!.fill_in_credentials : AppLocalizations.of(context)!.fill_in_password,
                                          style: TextStyle(
                                            color: widget.controllerInstance.themeSetting.textBody,
                                            height: 1.2,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15,
                                          ),
                                          textAlign: TextAlign.center,
                                        ),
                                        const SizedBox(height: 32),
                                      ],
                                    ),
                                  ),
                                  Form(
                                    key: _formKey,
                                    child: Column(
                                      children: [
                                        RegisterTextField(
                                          onChanged: (val) {},
                                          hintText: AppLocalizations.of(context)!.enter_email,
                                          autoFocus: false,
                                          onSubmitted: () {
                                            FocusScope.of(context).unfocus();
                                            FocusScope.of(context).requestFocus(passwordFocusNode);
                                          },
                                          textInputType: TextInputType.emailAddress,
                                          textEditingController: emailFieldController,
                                          obscureText: false,
                                          validator: (val) => validateEmail(val),
                                          focusNode: emailFocusNode,
                                          themeSetting: widget.controllerInstance.themeSetting,
                                          horizontalPadding: horizontalPadding,
                                        ),
                                        const SizedBox(height: 16),
                                        RegisterTextField(
                                          onChanged: (val) {},
                                          hintText: AppLocalizations.of(context)!.enter_password,
                                          autoFocus: false,
                                          onSubmitted: () {
                                            FocusScope.of(context).unfocus();
                                            if (_formKey.currentState?.validate() ?? false) {
                                              //form validated
                                              attemptSignIn();
                                            }
                                          },
                                          textInputType: TextInputType.text,
                                          textEditingController: passwordFieldController,
                                          obscureText: true,
                                          validator: (val) => validatePassword(val),
                                          focusNode: passwordFocusNode,
                                          themeSetting: widget.controllerInstance.themeSetting,
                                          horizontalPadding: horizontalPadding,
                                        ),
                                        const SizedBox(height: 24),
                                        Padding(
                                          padding: const EdgeInsets.symmetric(horizontal: 72),
                                          child: Align(
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              AppLocalizations.of(context)!.password_requirements,
                                              style: TextStyle(
                                                fontSize: 14,
                                                height: 1.3,
                                                color: widget.controllerInstance.themeSetting.textBody,
                                              ),
                                              maxLines: 2,
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(height: 48),
                                  SignInOptionButton(
                                    signInOption: SignInOption.email,
                                    buttonIsLoading: buttonIsLoading,
                                    onPressed: () {
                                      if (_formKey.currentState?.validate() ?? false) {
                                        //form validated
                                        attemptSignIn();
                                      }
                                    },
                                    themeSetting: widget.controllerInstance.themeSetting,
                                    horizontalPadding: horizontalPadding,
                                  ),
                                  Align(
                                    alignment: Alignment.centerLeft,
                                    child: Container(
                                      margin: const EdgeInsets.symmetric(horizontal: 24),
                                      child: InkWell(
                                        onTap: () {
                                          HapticFeedback.lightImpact();
                                          Navigator.push(context, CupertinoPageRoute(
                                            builder: (BuildContext context) => ForgotPasswordPage(
                                              assumedEmail: emailFieldController.text,
                                              validator: validateEmail,
                                              textEditingController: emailFieldController,
                                              authService: _authService,
                                              themeSetting: widget.controllerInstance.themeSetting,
                                            ),
                                          ));
                                        },
                                        child: SizedBox(
                                          height: 70,
                                          child: Center(
                                            child: Text(
                                              AppLocalizations.of(context)!.i_forgot_password,
                                              style: TextStyle(
                                                height: 1.1,
                                                fontSize: 14,
                                                color: widget.controllerInstance.themeSetting.textBody,
                                              ),
                                              textAlign: TextAlign.start,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              //EULA in the bottom
                              LegaleseButton(themeSetting: widget.controllerInstance.themeSetting),
                            ],
                          );
                        }
                        return null;
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
