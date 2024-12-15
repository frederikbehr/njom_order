import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:nom_order/data/dimensions.dart';
import 'package:nom_order/db/help_request_db/help_request_db.dart';
import 'package:nom_order/models/help_request/help_request.dart';
import 'package:nom_order/models/theme/theme_setting.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:nom_order/widgets/buttons/subtle_button.dart';
import 'package:nom_order/widgets/dialogs/dialog_templates.dart';

import '../../loading/loading.dart';

class HelpBar extends StatefulWidget {
  final ThemeSetting themeSetting;
  final HelpRequestDB helpRequestDB;
  final String tableId;
  const HelpBar({
    super.key,
    required this.themeSetting,
    required this.helpRequestDB,
    required this.tableId,
  });

  @override
  State<HelpBar> createState() => _HelpBarState();
}

class _HelpBarState extends State<HelpBar> {

  Future onSendRequest() async => await widget.helpRequestDB.createRequest(widget.tableId);

  Future onRemoveRequest(HelpRequest request) async => await widget.helpRequestDB.deleteRequest(request);

  String getButtonTitle(bool loading, bool? waitingForWaiter) {
    if (loading) {
      return "...";
    } else if (waitingForWaiter == true) {
      return AppLocalizations.of(context)!.help_is_coming;
    } else {
      return AppLocalizations.of(context)!.call;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      color: widget.themeSetting.primaryColor,
      padding: EdgeInsets.fromLTRB(32, 16 + MediaQuery.paddingOf(context).top + 12, 44, 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Text(
                AppLocalizations.of(context)!.need_help,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: widget.themeSetting.titleOnColor,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                AppLocalizations.of(context)!.call_a_waiter,
                style: TextStyle(
                  fontSize: 16,
                  color: widget.themeSetting.bodyOnColor,
                ),
              ),
            ],
          ),
          StreamBuilder(
            stream: widget.helpRequestDB.getTableHelpRequestStreamReference(widget.tableId),
            builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
              final bool loading = snapshot.connectionState == ConnectionState.waiting;
              bool? isWaitingForHelp;
              if (!loading) {
                isWaitingForHelp = snapshot.data!.docs.isNotEmpty;
              }
              return SubtleButton(
                themeSetting: widget.themeSetting,
                onPressed: () {
                  if (!loading && isWaitingForHelp == false) {
                    onSendRequest();
                  } else {
                    onRemoveRequest(HelpRequest(id: snapshot.data!.docs.first.id, tableId: widget.tableId));
                  }
                },
                backgroundColor: widget.themeSetting.secondary,
                borderColor: widget.themeSetting.secondary,
                fontColor: widget.themeSetting.primaryColor,
                text: getButtonTitle(loading, isWaitingForHelp),
              );
            },
          ),
        ],
      ),
    );
  }
}
