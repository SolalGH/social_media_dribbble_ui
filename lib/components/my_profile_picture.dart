import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class MyProfilePicture extends StatelessWidget {
  final double size;
  final double? iconSize;
  final Color? color;
  final bool isEditable;
  final Offset badgeOffset;
  final Color? badgeColor;
  final double badgeSize;
  final void Function()? onTap;
  final String? profilePicture;
  const MyProfilePicture({
    super.key,
    required this.size,
    this.color,
    this.iconSize,
    this.isEditable = false,
    this.badgeOffset = const Offset(-25, 110),
    this.badgeColor,
    this.badgeSize = 10.0,
    this.onTap,
    this.profilePicture,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Badge(
        isLabelVisible: isEditable,
        backgroundColor: badgeColor ?? Colors.grey[500],
        label: const Icon(Icons.edit),
        offset: badgeOffset,
        padding: EdgeInsets.all(badgeSize),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(100.0),
          child: Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: color ?? Colors.grey[400],
              borderRadius: BorderRadius.circular(100.0),
            ),
            child: profilePicture == null || profilePicture == ""
                ? Icon(
                    Icons.camera_alt,
                    size: iconSize,
                  )
                : Transform.scale(
                    scale: 1.5,
                    child: CachedNetworkImage(
                      imageUrl: profilePicture!,
                      placeholder: (context, url) {
                        return Icon(
                          Icons.camera_alt,
                          size: iconSize,
                        );
                      },
                    ),
                  ),
          ),
        ),
      ),
    );
  }
}
