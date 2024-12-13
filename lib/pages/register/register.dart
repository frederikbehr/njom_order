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
import 'package:nom_order/widgets/dialogs/dialog_templates.dart';

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
  late final DialogTemplates dialogTemplates = DialogTemplates(
    themeSetting: widget.controllerInstance.themeSetting,
  );

  //design
  final double horizontalPadding = 48;

  // fields and form
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController emailFieldController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  String emailField = "";
  final TextEditingController passwordFieldController = TextEditingController();
  String passwordField = "";
  final FocusNode passwordFocusNode = FocusNode();
  bool buttonIsLoading = false;

  //controllers
  final PageController pageController = PageController(initialPage: 0);

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
      await widget.controllerInstance.authService.signInWithEmailAndPassword(emailFieldController.text, passwordFieldController.text, context);
      setState(() => buttonIsLoading = false);
    } on FirebaseAuthException catch (e) {
      try {
        await widget.controllerInstance.authService.registerWithEmailAndPassword(
          emailFieldController.text,
          passwordFieldController.text,
          context,
        );
        setState(() => buttonIsLoading = false);
      } catch(e) {
        setState(() => buttonIsLoading = false);
        dialogTemplates.showErrorDialog(context, e as Exception);
        //showErrorDialog(signInError);
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
                        color: widget.controllerInstance.themeSetting.titleOnBackground,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 16),
                    Text(
                      error.message.toString().trim(),
                      style: TextStyle(
                        height: 1.2,
                        fontSize: 14,
                        color: widget.controllerInstance.themeSetting.bodyOnBackground,
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
                              color: widget.controllerInstance.themeSetting.titleOnBackground,
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
        bottomBorder: false,
        themeSetting: widget.controllerInstance.themeSetting,
      ),
      body: SafeArea(
        child: SizedBox(
          width: width,
          child: SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: height - MediaQuery.of(context).padding.bottom - MediaQuery.of(context).padding.top,
                maxHeight: height - MediaQuery.of(context).padding.bottom - MediaQuery.of(context).padding.top,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const SizedBox(height: 48),
                  Expanded(
                    child: Column(
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
                                      color: widget.controllerInstance.themeSetting.titleOnBackground,
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
                                      color: widget.controllerInstance.themeSetting.bodyOnBackground,
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
                                          color: widget.controllerInstance.themeSetting.bodyOnBackground,
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
                                        authService: widget.controllerInstance.authService,
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
                                          color: widget.controllerInstance.themeSetting.bodyOnBackground,
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
