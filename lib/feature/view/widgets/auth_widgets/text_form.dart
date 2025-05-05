import 'package:ecommerce_app/core/resources/color_manager.dart';
import 'package:ecommerce_app/core/resources/font_manager.dart';
import 'package:ecommerce_app/core/resources/style_manager.dart';
import 'package:ecommerce_app/core/resources/values_manager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  const CustomTextField({
    super.key,
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
    this.onChanged,
    this.onSubmitted,
    this.enabled = true,
    this.autofocus = false,
    this.textCapitalization = TextCapitalization.none,
    this.textAlign = TextAlign.start,
    this.maxLength,
    this.inputFormatters,
    this.errorText,
    this.helperText,
    this.counterText,
    this.filled = true,
    this.fillColor,
    this.borderRadius,
    this.contentPadding,
    this.focusedBorderColor,
    this.enabledBorderColor,
    this.errorBorderColor,
    this.focusedErrorBorderColor,
    this.borderWidth = 1.0,
    this.animationDuration = const Duration(milliseconds: 200),
    this.showErrorBorder = true,
    this.showFocusedBorder = true,
    this.showEnabledBorder = true,
    this.showFocusedErrorBorder = true,
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
  final void Function(String)? onChanged;
  final void Function(String)? onSubmitted;
  final bool enabled;
  final bool autofocus;
  final TextCapitalization textCapitalization;
  final TextAlign textAlign;
  final int? maxLength;
  final List<TextInputFormatter>? inputFormatters;
  final String? errorText;
  final String? helperText;
  final String? counterText;
  final bool filled;
  final Color? fillColor;
  final double? borderRadius;
  final EdgeInsetsGeometry? contentPadding;
  final Color? focusedBorderColor;
  final Color? enabledBorderColor;
  final Color? errorBorderColor;
  final Color? focusedErrorBorderColor;
  final double borderWidth;
  final Duration animationDuration;
  final bool showErrorBorder;
  final bool showFocusedBorder;
  final bool showEnabledBorder;
  final bool showFocusedErrorBorder;

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> with SingleTickerProviderStateMixin {
  late bool hidden = widget.isObscured;
  String? errorText;
  late AnimationController _animationController;
  late Animation<double> _animation;
  late Animation<Color?> _labelColorAnimation;
  late Animation<Color?> _borderColorAnimation;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: widget.animationDuration,
    );
    _animation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );
    _labelColorAnimation = ColorTween(
      begin: ColorManager.grey,
      end: ColorManager.primary,
    ).animate(_animation);
    _borderColorAnimation = ColorTween(
      begin: widget.enabledBorderColor ?? ColorManager.grey,
      end: widget.focusedBorderColor ?? ColorManager.primary,
    ).animate(_animation);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _handleFocusChange(bool hasFocus) {
    setState(() => _isFocused = hasFocus);
    if (hasFocus) {
      _animationController.forward();
    } else {
      _animationController.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.label != null)
          AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Padding(
                padding: const EdgeInsets.only(bottom: Insets.s4),
                child: Text(
                  widget.label!,
                  style: (widget.labelTextStyle ??
                          getMediumStyle(color: ColorManager.black)
                              .copyWith(fontSize: FontSize.s14))
                      .copyWith(
                    color: _labelColorAnimation.value,
                  ),
                ),
              );
            },
          ),
        Focus(
          onFocusChange: _handleFocusChange,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) {
              return Container(
                decoration: BoxDecoration(
                  color: widget.backgroundColor ??
                      ColorManager.darkGrey.withOpacity(.15),
                  borderRadius: BorderRadius.circular(
                    widget.borderRadius ?? Sizes.s8,
                  ),
                  boxShadow: _isFocused
                      ? [
                          BoxShadow(
                            color: (widget.focusedBorderColor ??
                                    ColorManager.primary)
                                .withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                child: TextFormField(
                  maxLines: widget.maxLines ?? 1,
                  controller: widget.controller,
                  focusNode: widget.focusNode,
                  readOnly: widget.readOnly,
                  enabled: widget.enabled,
                  autofocus: widget.autofocus,
                  textCapitalization: widget.textCapitalization,
                  textAlign: widget.textAlign,
                  maxLength: widget.maxLength,
                  inputFormatters: widget.inputFormatters,
                  style: getMediumStyle(color: ColorManager.black)
                      .copyWith(fontSize: FontSize.s16),
                  obscureText: hidden,
                  keyboardType: widget.textInputType,
                  obscuringCharacter: '*',
                  cursorColor: widget.cursorColor ?? ColorManager.black,
                  onTap: widget.onTap,
                  onChanged: widget.onChanged,
                  onFieldSubmitted: widget.onSubmitted,
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
                    filled: widget.filled,
                    fillColor: widget.fillColor ??
                        (widget.backgroundColor ??
                            ColorManager.darkGrey.withOpacity(.15)),
                    contentPadding: widget.contentPadding ??
                        EdgeInsets.all(Insets.s12),
                    hintText: widget.hint,
                    helperText: widget.helperText,
                    counterText: widget.counterText,
                    prefixIcon: widget.prefixIcon != null
                        ? AnimatedBuilder(
                            animation: _animation,
                            builder: (context, child) {
                              return IconTheme(
                                data: IconThemeData(
                                  color: _labelColorAnimation.value,
                                ),
                                child: widget.prefixIcon!,
                              );
                            },
                          )
                        : null,
                    suffixIcon: widget.isObscured
                        ? IconButton(
                            onPressed: () => setState(() => hidden = !hidden),
                            iconSize: Sizes.s24,
                            splashRadius: Sizes.s1,
                            isSelected: !hidden,
                            color: _labelColorAnimation.value,
                            selectedIcon: const Icon(Icons.visibility),
                            icon: const Icon(Icons.visibility_off),
                          )
                        : widget.suffixIcon != null
                            ? AnimatedBuilder(
                                animation: _animation,
                                builder: (context, child) {
                                  return IconTheme(
                                    data: IconThemeData(
                                      color: _labelColorAnimation.value,
                                    ),
                                    child: widget.suffixIcon!,
                                  );
                                },
                              )
                            : null,
                    hintStyle: widget.hintTextStyle ??
                        getRegularStyle(color: ColorManager.grey)
                            .copyWith(fontSize: FontSize.s14),
                    errorText: widget.errorText ?? errorText,
                    errorStyle: TextStyle(
                      fontSize: FontSize.s14,
                      color: ColorManager.error,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(
                        widget.borderRadius ?? Sizes.s16,
                      ),
                      borderSide: BorderSide(
                        color: _borderColorAnimation.value ??
                            widget.enabledBorderColor ??
                            ColorManager.black,
                        width: widget.borderWidth,
                      ),
                    ),
                    enabledBorder: widget.showEnabledBorder
                        ? OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              widget.borderRadius ?? Sizes.s16,
                            ),
                            borderSide: BorderSide(
                              color: widget.enabledBorderColor ??
                                  ColorManager.black,
                              width: widget.borderWidth,
                            ),
                          )
                        : null,
                    focusedBorder: widget.showFocusedBorder
                        ? OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              widget.borderRadius ?? Sizes.s16,
                            ),
                            borderSide: BorderSide(
                              color: widget.focusedBorderColor ??
                                  ColorManager.primary,
                              width: widget.borderWidth * 2,
                            ),
                          )
                        : null,
                    errorBorder: widget.showErrorBorder
                        ? OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              widget.borderRadius ?? Sizes.s16,
                            ),
                            borderSide: BorderSide(
                              color: widget.errorBorderColor ??
                                  ColorManager.error,
                              width: widget.borderWidth,
                            ),
                          )
                        : null,
                    focusedErrorBorder: widget.showFocusedErrorBorder
                        ? OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              widget.borderRadius ?? Sizes.s16,
                            ),
                            borderSide: BorderSide(
                              color: widget.focusedErrorBorderColor ??
                                  ColorManager.error,
                              width: widget.borderWidth * 2,
                            ),
                          )
                        : null,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}