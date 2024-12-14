import 'package:flutter/material.dart';
import 'package:nom_order/models/theme/theme_setting.dart';

class FormSection extends StatelessWidget {
  final String title;
  final String? description;
  final Widget child;
  final ThemeSetting themeSetting;
  const FormSection({
    super.key,
    required this.title,
    this.description,
    required this.themeSetting,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 48),
        Text(
          title,
          style: TextStyle(
            fontSize: 16,
            color: themeSetting.titleOnBackground,
            fontWeight: FontWeight.bold,
          ),
        ),
        description != null? Column(
          children: [
            const SizedBox(height: 4),
            Text(
              description!,
              style: TextStyle(
                fontSize: 14,
                color: themeSetting.bodyOnBackground,
              ),
            ),
          ],
        ) : const SizedBox(),
        const SizedBox(height: 12),
        child,
      ],
    );
  }
}
