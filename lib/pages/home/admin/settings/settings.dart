import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:nom_order/db/local_db.dart';
import 'package:nom_order/pages/home/admin/settings/settings_item.dart';
import 'package:nom_order/pages/home/admin/settings/settings_section.dart';
import 'package:nom_order/widgets/buttons/submit_button.dart';
import 'package:nom_order/widgets/buttons/subtle_button.dart';
import 'package:nom_order/widgets/custom_appbar.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nom_order/widgets/dialogs/dialog_templates.dart';

import '../../../../controller/controller.dart';

class Settings extends StatefulWidget {
  final Controller controller;
  const Settings({super.key, required this.controller});

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  late final DialogTemplates dialogTemplates = DialogTemplates(themeSetting: widget.controller.themeSetting);

  Future changeDeviceMode() async {
    await widget.controller.deviceDB.removeDeviceInfo();
    widget.controller.deviceInfo = null;
    reopenApp();
  }

  void reopenApp() => Phoenix.rebirth(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(
        title: AppLocalizations.of(context)!.settings,
        bottomBorder: false,
        themeSetting: widget.controller.themeSetting,
        leadingButton: true,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const SizedBox(height: 72),
            SettingsSection(
              title: AppLocalizations.of(context)!.account,
              settingsItems: [
                SettingsItem(
                  title: AppLocalizations.of(context)!.change_password,
                  themeSetting: widget.controller.themeSetting,
                  child: SubmitButton(
                    fontSize: 16,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    themeSetting: widget.controller.themeSetting,
                    onPressed: () {},
                    text: AppLocalizations.of(context)!.change,
                  ),
                ),
                SettingsItem(
                  title: AppLocalizations.of(context)!.sign_out,
                  themeSetting: widget.controller.themeSetting,
                  child: SubmitButton(
                    fontSize: 16,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    themeSetting: widget.controller.themeSetting,
                    onPressed: () {},
                    text: AppLocalizations.of(context)!.sign_out,
                  ),
                ),
              ],
              themeSetting: widget.controller.themeSetting,
            ),

            const SizedBox(height: 72),

            SettingsSection(
              title: AppLocalizations.of(context)!.app,
              settingsItems: [
                SettingsItem(
                  title: AppLocalizations.of(context)!.change_device_mode,
                  themeSetting: widget.controller.themeSetting,
                  child: SubmitButton(
                    fontSize: 16,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    themeSetting: widget.controller.themeSetting,
                    onPressed: () => changeDeviceMode(),
                    text: AppLocalizations.of(context)!.change,
                  ),
                ),
                SettingsItem(
                  title: AppLocalizations.of(context)!.system_language,
                  themeSetting: widget.controller.themeSetting,
                  child: SubmitButton(
                    fontSize: 16,
                    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    themeSetting: widget.controller.themeSetting,
                    onPressed: () {},
                    text: AppLocalizations.of(context)!.change,
                  ),
                ),
                SettingsItem(
                  title: AppLocalizations.of(context)!.support,
                  themeSetting: widget.controller.themeSetting,
                  child: Text(
                    AppLocalizations.of(context)!.contact_me_at,
                    style: TextStyle(
                      fontSize: 16,
                      color: widget.controller.themeSetting.bodyOnBackground,
                    ),
                  ),
                ),
              ],
              themeSetting: widget.controller.themeSetting,
            ),
          ],
        ),
      ),
    );
  }
}
