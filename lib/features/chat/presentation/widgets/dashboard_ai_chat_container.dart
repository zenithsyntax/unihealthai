import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';
import 'ai_chat_widget.dart';

class DashboardAIChatContainer extends StatelessWidget {
  const DashboardAIChatContainer({super.key});

  @override
  Widget build(BuildContext context) {
    return AIChatWidget(
      patient: null, // General mode
      onBack: () => Navigator.of(context).pop(),
    );
  }
}
