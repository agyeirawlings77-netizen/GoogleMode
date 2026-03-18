import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
class BottomSheetHandle extends StatelessWidget {
  const BottomSheetHandle({super.key});
  @override
  Widget build(BuildContext context) {
    return Center(child: Container(width: 40, height: 4, margin: const EdgeInsets.only(top: 12, bottom: 8), decoration: BoxDecoration(color: AppTheme.darkBorder, borderRadius: BorderRadius.circular(2))));
  }
}
