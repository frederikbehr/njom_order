import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nom_order/data/theme_setting.dart';
import 'dart:io' show Platform;

import '../../authentication/auth_service.dart';
import '../../widgets/custom_appbar.dart';
import '../register/register_text_field.dart';

class ForgotPasswordPage extends StatefulWidget {
  final String assumedEmail;
  final String? Function(String?) validator;
  final TextEditingController textEditingController;
  final AuthService authService;
  final ThemeSetting themeSetting;
  const ForgotPasswordPage({
    super.key,
    required this.assumedEmail,
    required this.validator,
    required this.textEditingController,
    required this.authService,
    required this.themeSetting,
  });

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey();

  Future submitForgotPassword() async {
    HapticFeedback.lightImpact();
    if (_formKey.currentState?.validate() ?? false) {
      //valid
      await widget.authService.forgotPassword(widget.textEditingController.text);
      showConfirmationDialog();
    } else {
      //invalid

    }
  }

  void showConfirmationDialog() {
    showAdaptiveDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return Dialog(
            backgroundColor: widget.themeSetting.dialog,
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 24),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      AppLocalizations.of(context)!.email_sent,
                      style: TextStyle(
                        height: 1.2,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: widget.themeSetting.textTitle,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      AppLocalizations.of(context)!.email_sent_confirmation,
                      style: TextStyle(
                        height: 1.2,
                        fontSize: 14,
                        color: widget.themeSetting.textBody,
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
                          Navigator.pop(context);
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
                              color: widget.themeSetting.textTitle,
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
      backgroundColor: widget.themeSetting.background,
      appBar: CustomAppBar(
        title: "",
        bottomBorder: false,
        backgroundColor: widget.themeSetting.background,
        leading: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(100),
            onTap: () async {
              HapticFeedback.lightImpact();
              FocusScope.of(context).unfocus();
              Navigator.pop(context);
            },
            child: SizedBox(
              child: Icon(
                Platform.isIOS? Icons.arrow_back_ios : Icons.arrow_back_rounded,
                size: 30,
                color: widget.themeSetting.textTitle,
              ),
            ),
          ),
        ),
        themeSetting: widget.themeSetting,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32.0),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                AppLocalizations.of(context)!.i_forgot_password,
                style: TextStyle(
                  height: 1.3,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: widget.themeSetting.textTitle,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 18),
              Text(
                AppLocalizations.of(context)!.password_recovery,
                style: TextStyle(
                  height: 1.3,
                  fontSize: 15,
                  color: widget.themeSetting.textBody,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 24),
              Form(
                key: _formKey,
                child: RegisterTextField(
                  onChanged: (val) {},
                  hintText: AppLocalizations.of(context)!.enter_email,
                  autoFocus: true,
                  onSubmitted: () => submitForgotPassword(),
                  textInputType: TextInputType.emailAddress,
                  textEditingController: widget.textEditingController,
                  obscureText: false,
                  validator: (val) => widget.validator(val),
                  focusNode: FocusNode(),
                  themeSetting: widget.themeSetting,
                ),
              ),
              const SizedBox(height: 24),
              Material(
                borderRadius: BorderRadius.circular(100),
                color: widget.themeSetting.dialog,
                child: InkWell(
                  borderRadius: BorderRadius.circular(100),
                  onTap: () => submitForgotPassword(),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                    child: Text(
                      AppLocalizations.of(context)!.send,
                      style: TextStyle(
                        height: 1.12,
                        fontSize: 17,
                        color: widget.themeSetting.textTitle,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
