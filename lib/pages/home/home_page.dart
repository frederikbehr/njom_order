import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:nom_order/pages/home/home_wrapper.dart';
import 'package:nom_order/pages/loading/step_loading.dart';
import 'package:nom_order/widgets/dialogs/dialog_templates.dart';

import '../../controller/controller.dart';
import '../../models/user/user_data.dart';

class HomePage extends StatefulWidget {
  final Controller controllerInstance;
  const HomePage({super.key, required this.controllerInstance});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // instances
  late final DialogTemplates dialogTemplates = DialogTemplates(themeSetting: widget.controllerInstance.themeSetting);

  // variables used with loading data
  bool _loading = true;
  int _loadingStep = 0;
  int fetchAttempts = 0;
  bool transitionedIn = false;

  @override
  void initState() {
    super.initState();
    loadData();
  }
  
  Future loadData() async {
    DateTime before = DateTime.now();
    String? uid = widget.controllerInstance.getUID();
    if (fetchAttempts >= 3) {
      dialogTemplates.showErrorDialog(context, Exception("Ran into trouble retrieving user data."));
    } else if (uid != null) {
      //logged in via authentication, but data is not fetched yet.
      updateLoadingStep(1);
      widget.controllerInstance.setUserDB();
      fetchAttempts++;
      UserData? userData = await widget.controllerInstance.getUserData();
      if (userData != null) {
        //user data fetched
        updateLoadingStep(2);
        widget.controllerInstance.setUserData(userData);
        await Future.delayed(const Duration(milliseconds: 120), () {});
        //show ui
        await widget.controllerInstance.setDeviceInfo();
        setIsLoading(false);
        await Future.delayed(const Duration(milliseconds: 50), () {});
        setState(() => transitionedIn = true);
      } else {
        updateLoadingStep(0);
        loadData();
      }
    } else {
      //not logged in
      dialogTemplates.showErrorDialog(context, Exception("No user logged in. Please try again..."));
      Phoenix.rebirth(context);
    }

    DateTime timeAfterLoad = DateTime.now();
    debugPrint("time taken to load app: ${timeAfterLoad!.difference(before!).inMilliseconds}");
  }

  void updateLoadingStep(int step) => setState(() => _loadingStep = step);

  void setIsLoading(bool isLoading) => setState(() => _loading = isLoading);

  String getTitle() {
    return "";
  }

  @override
  Widget build(BuildContext context) {
    return _loading? StepLoading(
      totalSteps: 4,
      currentStep: 2,
      themeSetting: widget.controllerInstance.themeSetting,
    ) : HomeWrapper(controller: widget.controllerInstance);
  }
}
