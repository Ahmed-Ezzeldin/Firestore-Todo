import 'package:firebase_mvvm/view/styles/app_colors.dart';
import 'package:flutter/material.dart';

enum Validator {
  required,
  email,
  username,
  phone,
  password,
  number,
  isMatch,
  minLength,
  maxLength,
}

enum BorderType {
  none,
  underline,
  outline,
}

class MainTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? hint;
  final String? label;
  final Widget? icon;
  final bool isObscure;
  final bool isReadOnly;
  final bool isAutofocus;
  final bool isFilled;
  final bool isDense;
  final Color? fillColor;
  final Color? cursorColor;
  final int maxLines;
  final double letterSpacing;
  final double borderRadius;
  final double borderWidth;
  final BorderType? borderType;
  final TextInputType keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final Validator? validator;
  final String? errorText;
  final String? matchedValue;
  final FocusNode? focusNode;
  final TextAlign? textAlign;
  final TextStyle? textStyle;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final TextInputAction textInputAction;
  final EdgeInsetsGeometry? contentPadding;
  final Function()? onTap;
  final Function(String? x)? onChanged;

  const MainTextField({
    Key? key,
    required this.controller,
    this.hint,
    this.label,
    this.icon,
    this.isObscure = false,
    this.isReadOnly = false,
    this.isAutofocus = false,
    this.isFilled = false,
    this.isDense = false,
    this.fillColor,
    this.cursorColor = AppColors.primaryColor,
    this.maxLines = 1,
    this.letterSpacing = 0,
    this.borderRadius = 10,
    this.borderWidth = 1.2,
    this.borderType = BorderType.outline,
    this.keyboardType = TextInputType.text,
    this.suffixIcon,
    this.prefixIcon,
    this.validator,
    this.errorText,
    this.matchedValue,
    this.focusNode,
    this.textAlign = TextAlign.start,
    this.textStyle,
    this.hintStyle,
    this.labelStyle,
    this.textInputAction = TextInputAction.next,
    this.contentPadding,
    this.onTap,
    this.onChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {

    InputBorder? border;
    InputBorder? enabledBorder;
    InputBorder? focusedBorder;
    InputBorder? errorBorder;

    switch (borderType!) {
      // ======================================================================= None Border
      /// "border:" in case text field has error and focused in the same time
      case BorderType.none:
        {
          border = InputBorder.none;
          enabledBorder = InputBorder.none;
          focusedBorder = InputBorder.none;
          errorBorder = InputBorder.none;
        }
        break;
      // ======================================================================= Underline Border
      case BorderType.underline:
        {
          border = UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: borderWidth));
          enabledBorder = UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey, width: borderWidth));
          focusedBorder =
              UnderlineInputBorder(borderSide: BorderSide(color: AppColors.primaryColor, width: borderWidth));
          errorBorder = UnderlineInputBorder(borderSide: BorderSide(color: Colors.red, width: borderWidth));
        }
        break;
      // ======================================================================= Outline Border
      case BorderType.outline:
        {
          border = OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: Colors.grey, width: borderWidth),
          );
          enabledBorder = OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: Colors.grey, width: borderWidth),
          );
          focusedBorder = OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: AppColors.primaryColor, width: borderWidth),
          );
          errorBorder = OutlineInputBorder(
            borderRadius: BorderRadius.circular(borderRadius),
            borderSide: BorderSide(color: Colors.red, width: borderWidth),
          );
        }
        break;
    }

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: TextFormField(
        controller: controller,
        cursorWidth: 1.5,
        cursorColor: cursorColor,
        cursorRadius: const Radius.circular(5),
        obscureText: isObscure,
        readOnly: isReadOnly,
        keyboardType: keyboardType,
        style: textStyle ?? TextStyle(fontSize: 14, letterSpacing: letterSpacing),
        maxLines: maxLines,
        autofocus: isAutofocus,
        focusNode: focusNode,
        textInputAction: textInputAction,
        textAlign: textAlign!,
        obscuringCharacter: "⁕", //  "●" , "*" , "⁕" , "◾"
        decoration: InputDecoration(
          isDense: isDense,
          filled: isFilled,
          fillColor: fillColor,
          focusColor: Colors.teal,
          icon: icon,
          hintText: hint,
          labelText: label,
          errorText: errorText,
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          hintStyle: hintStyle,
          labelStyle: labelStyle,
          contentPadding: contentPadding ?? const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          border: border,
          enabledBorder: enabledBorder,
          focusedBorder: focusedBorder,
          errorBorder: errorBorder,
        ),
        validator: (value) {
          switch (validator) {

            /// ============================================================================ [ Required ]
            case Validator.required:
              if (value!.trim().isEmpty) {
                return "Required";
              }
              return null;
            case Validator.username:
              RegExp regExp = RegExp(
                r"^(?=.{3,30}$)(?![._-])(?![0-9])(?!.*[._-]{2})[a-zA-Z0-9._-]+(?<![._-])$",
              );
              if (value!.trim().isEmpty) {
                return "Please enter your username";
              } else if (value.length < 3) {
                return "Minimum length is 3 characters";
              } else if (!regExp.hasMatch(value)) {
                return "Please enter valid username";
              }
              return null;

            /// ============================================================================ [ Email ]
            case Validator.email:
              RegExp regExp = RegExp(
                r"^(?=.{8,45}$)(?!.*[._]{2})(?![._])([a-zA-Z0-9._]+)@(?!.*[._]{2})([a-zA-Z0-9._]+(?<![._]))\.([a-zA-Z]{2,5})$",
              );
              if (value!.trim().isEmpty) {
                return "Please enter email address";
              } else if (!regExp.hasMatch(value)) {
                return "Please enter valid email address";
              }
              return null;

            /// ============================================================================ [ Password ]
            case Validator.password:
              if (value!.trim().isEmpty) {
                return "Please enter your password";
              } else if (value.length < 8) {
                return "Password is at lest 8 Char";
              }
              return null;

            /// ============================================================================ [ IsMatch ]
            case Validator.isMatch:
              if (value!.trim().isEmpty) {
                return "Required";
              } else if (value != matchedValue) {
                return "Password not matched";
              }
              return null;
            default:
              return null;
          }
        },
        onTap: onTap,
        onChanged: onChanged,
      ),
    );
  }
}
