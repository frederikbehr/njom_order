import 'package:flutter/material.dart';
import 'package:nom_order/models/theme/theme_setting.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import '../../data/dimensions.dart';

class StepLoading extends StatefulWidget {
  final int totalSteps;
  final int currentStep;
  final ThemeSetting themeSetting;
  const StepLoading({
    super.key,
    required this.totalSteps,
    required this.currentStep,
    required this.themeSetting,
  });

  @override
  State<StepLoading> createState() => _StepLoadingState();

}

class _StepLoadingState extends State<StepLoading> {
  bool transitionedIn = false;

  double _calculatePercent() {
    final double result = widget.currentStep / widget.totalSteps;
    if (result >= 0 && 1 >= result) {
      return result;
    } else {
      return -1;
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => setState(() => transitionedIn = true));
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      color: widget.themeSetting.background,
      duration: const Duration(milliseconds: 500),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(height: MediaQuery.of(context).size.height*0.1),
            Image.asset(
              'assets/images/logo.png',
              width: MediaQuery.of(context).size.width/3,
              filterQuality: FilterQuality.medium,
              fit: BoxFit.fitWidth,
              color: widget.themeSetting.primaryColor,
            ),
            AnimatedOpacity(
              opacity: transitionedIn? 1 : 0,
              duration: const Duration(seconds: 1),
              curve: Curves.easeIn,
              child: Column(
                children: [
                  LinearPercentIndicator(
                    width: width/2,
                    animation: true,
                    lineHeight: 16,
                    percent: _calculatePercent() < 0? 0 : _calculatePercent(),
                    animateFromLastPercent: true,
                    alignment: MainAxisAlignment.center,
                    backgroundColor: widget.themeSetting.shadow,
                    animationDuration: 100,
                    barRadius: const Radius.circular(100),
                    progressColor: widget.themeSetting.secondary,
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height*0.2),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
