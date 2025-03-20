import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/font_manager.dart';
import 'package:ecommerce_app/core/resources/style_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    this.controller,
    this.focusNode,
    this.nextFocus,
    this.label,
    this.hint,
    this.isObscured = false,
    this.iconData,
    this.textInputType = TextInputType.text,
    this.backgroundColor,
    this.hintTextStyle,
    this.labelTextStyle,
    this.cursorColor,
    this.readOnly = false,
    this.validation,
    this.onTap,
    this.maxLines,
    this.prefixIcon,
    this.borderBackgroundColor,
    this.suffixIcon,
  });

  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final bool isObscured;
  final String? label;
  final String? hint;
  final TextInputType textInputType;
  final IconData? iconData;
  final Color? backgroundColor;
  final Color? borderBackgroundColor;
  final TextStyle? hintTextStyle;
  final TextStyle? labelTextStyle;
  final Color? cursorColor;
  final bool readOnly;
  final int? maxLines;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final String? Function(String?)? validation;
  final void Function()? onTap;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool hidden = widget.isObscured;
  String? errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        widget.label != null
            ? Padding(
                padding: const EdgeInsets.only(top: Insets.s2),
                child: Text(
                  widget.label!,
                  style: widget.labelTextStyle ??
                      getMediumStyle(color: ColorManager.black)
                          .copyWith(fontSize: FontSize.s14),
                ),
              )
            : const SizedBox(),
        Container(
          margin: EdgeInsets.only(top: Insets.s5),
          decoration: BoxDecoration(
            color: widget.backgroundColor ??
                ColorManager.darkGrey.withOpacity(.15),
            borderRadius: BorderRadius.circular(Sizes.s8),
            border: Border.all(
              color: widget.borderBackgroundColor ?? ColorManager.transparent,
            ),
          ),
          clipBehavior: Clip.antiAliasWithSaveLayer,
          child: TextFormField(
            
            maxLines: widget.maxLines ?? 1,
            controller: widget.controller,
            focusNode: widget.focusNode,
            readOnly: widget.readOnly,
            style: getMediumStyle(color: ColorManager.black)
                .copyWith(fontSize: FontSize.s16), 
            obscureText: hidden,
            keyboardType: widget.textInputType,
            obscuringCharacter: '*',
            cursorColor: widget.cursorColor ?? ColorManager.black,
            onTap: widget.onTap,
            onEditingComplete: () {
              widget.focusNode?.unfocus();
              if (widget.nextFocus != null) {
                FocusScope.of(context).requestFocus(widget.nextFocus);
              }
            },
            textInputAction: widget.nextFocus == null
                ? TextInputAction.done
                : TextInputAction.next,
            validator: (value) {
              if (widget.validation == null) {
                setState(() => errorText = null);
              } else {
                setState(() => errorText = widget.validation!(value));
              }
              return errorText;
            },
            decoration: InputDecoration(
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Sizes.s14),
                borderSide: BorderSide(
                  color: ColorManager.primary,
                  width: 2.0, 
                ),
              ),
              
              contentPadding: EdgeInsets.all(Insets.s12),
              hintText: widget.hint,
              
              prefixIcon: widget.prefixIcon,
              suffixIcon: widget.isObscured
                  ? IconButton(
                      onPressed: () => setState(() => hidden = !hidden),
                      iconSize: Sizes.s24,
                      splashRadius: Sizes.s1,
                      isSelected: !hidden,
                      color: widget.cursorColor,
                      selectedIcon: const Icon(Icons.visibility),
                      icon: const Icon(Icons.visibility_off),
                    )
                  : widget.suffixIcon,
              hintStyle: widget.hintTextStyle ??
                  getRegularStyle(color: ColorManager.grey)
                      .copyWith(fontSize: FontSize.s14),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(Sizes.s16),
                borderSide: BorderSide(
                  color: ColorManager.black,
                  width: 8.0, 
                  strokeAlign: BorderSide.strokeAlignInside,
                ),
              ),
              errorStyle: TextStyle(
                fontSize: FontSize.s14,
                color: ColorManager.error,
              ),
            ),
            
          ),
        ),
        
      ],
    );
  }
}