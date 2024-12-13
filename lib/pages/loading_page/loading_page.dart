import 'package:flutter/material.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';

import '../../data/colors.dart';
import '../../data/dimensions.dart';

class AdvancedLoading extends StatefulWidget {
  final int totalSteps;
  final int currentStep;
  const AdvancedLoading({
    super.key,
    required this.totalSteps,
    required this.currentStep,
  });

  @override
  State<AdvancedLoading> createState() => _AdvancedLoadingState();

}

class _AdvancedLoadingState extends State<AdvancedLoading> {
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
      color: _calculatePercent() == 1? backgroundColor : const Color(0xff1b1b1c),
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
                    lineHeight: 8,
                    percent: _calculatePercent() < 0? 0 : _calculatePercent(),
                    animateFromLastPercent: true,
                    alignment: MainAxisAlignment.center,
                    backgroundColor: _calculatePercent() < 0? Colors.red[300] : chatBackgroundColor,
                    animationDuration: 100,
                    barRadius: const Radius.circular(100),
                    progressColor: text100,
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
