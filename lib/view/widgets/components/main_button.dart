import 'package:flutter/material.dart';

enum ButtonType { elevated, outlined, text, icon }

class MainButton extends StatelessWidget {
  final double? height;
  final double? width;
  final String title;
  final Widget? icon;
  final double? radius;
  final double? elevation;
  final Color? color;
  final ButtonType type;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry padding;
  final Function()? onPressed;
  final Function()? onLongPress;

  const MainButton({
    Key? key,
    this.height,
    this.width,
    this.title = "",
    this.radius = 0,
    this.elevation = 0,
    this.color,
    this.icon,
    this.type = ButtonType.elevated,
    this.textStyle = const TextStyle(
      fontSize: 16,
      fontWeight: FontWeight.normal,
    ),
    this.padding = const EdgeInsets.all(0),
    this.onPressed,
    this.onLongPress,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Color butColor = color == null ? Theme.of(context).primaryColor : color!;
    switch (type) {

      /// =================================================================================
      /// ==================================================================== [ Elevated ]
      case ButtonType.elevated:
        {
          return SizedBox(
            height: height,
            width: width,
            child: icon != null
                ? ElevatedButton.icon(
                    icon: icon!,
                    style: ElevatedButton.styleFrom(
                      primary: butColor,
                      elevation: elevation,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius!)),
                    ),
                    label: Padding(
                      padding: padding,
                      child: Text(
                        title,
                        style: textStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onPressed: onPressed,
                    onLongPress: onLongPress,
                  )
                : ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      primary: butColor,
                      elevation: elevation,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius!)),
                    ),
                    child: Padding(
                      padding: padding,
                      child: Text(
                        title,
                        style: textStyle,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onPressed: onPressed,
                    onLongPress: onLongPress,
                  ),
          );
        }

      /// =================================================================================
      /// ==================================================================== [ Outlined ]
      case ButtonType.outlined:
        {
          return SizedBox(
            height: height,
            width: width,
            child: icon != null
                ? OutlinedButton.icon(
                    icon: icon!,
                    style: OutlinedButton.styleFrom(
                      primary: butColor,
                      elevation: elevation,
                      side: BorderSide(color: butColor, style: BorderStyle.solid, width: 2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius!)),
                    ),
                    label: Padding(
                      padding: padding,
                      child: Text(
                        title,
                        style: textStyle!.copyWith(color: butColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onPressed: onPressed,
                    onLongPress: onLongPress,
                  )
                : OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      elevation: elevation,
                      side: BorderSide(color: butColor, style: BorderStyle.solid, width: 2),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius!)),
                    ),
                    child: Padding(
                      padding: padding,
                      child: Text(
                        title,
                        style: textStyle!.copyWith(color: butColor),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onPressed: onPressed,
                    onLongPress: onLongPress,
                  ),
          );
        }

      /// =================================================================================
      /// ======================================================================== [ Text ]
      case ButtonType.text:
        {
          return SizedBox(
            height: height,
            width: width,
            child: icon != null
                ? TextButton.icon(
                    icon: icon!,
                    style: TextButton.styleFrom(
                      primary: butColor,
                      elevation: elevation,
                      textStyle: textStyle,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius!)),
                    ),
                    label: Padding(
                      padding: padding,
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onPressed: onPressed,
                    onLongPress: onLongPress,
                  )
                : TextButton(
                    style: TextButton.styleFrom(
                      primary: butColor,
                      elevation: elevation,
                      textStyle: textStyle,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius!)),
                    ),
                    child: Padding(
                      padding: padding,
                      child: Text(
                        title,
                        textAlign: TextAlign.center,
                      ),
                    ),
                    onPressed: onPressed,
                    onLongPress: onLongPress,
                  ),
          );
        }

      /// =================================================================================
      /// ======================================================================== [ Icon ]
      case ButtonType.icon:
        {
          return IconButton(
            icon: icon!,
            color: butColor,
            padding: const EdgeInsets.all(8),
            onPressed: onPressed,
          );
        }

      /// =================================================================================
      /// ===================================================================== [ default ]
      default:
        return const Text("default!");
    }
  }
}
