import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
class AvatarWidget extends StatelessWidget {
  final String? imageUrl;
  final String? name;
  final double radius;
  final Color? backgroundColor;
  const AvatarWidget({super.key, this.imageUrl, this.name, this.radius = 24, this.backgroundColor});
  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? AppTheme.primaryColor.withOpacity(0.15);
    final initials = name?.isNotEmpty == true ? name![0].toUpperCase() : '?';
    return CircleAvatar(radius: radius, backgroundColor: bg, backgroundImage: imageUrl?.isNotEmpty == true ? NetworkImage(imageUrl!) : null, child: imageUrl?.isEmpty != false ? Text(initials, style: TextStyle(color: AppTheme.primaryColor, fontSize: radius * 0.65, fontWeight: FontWeight.w700)) : null);
  }
}
