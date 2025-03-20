import 'package:flutter/material.dart';

class CustomAutoSizeText extends StatelessWidget {
  const CustomAutoSizeText({
    this.maxLines,
    this.fontSize,
    this.color,
    this.fontWeight,
    this.textStyle,
    required this.data,
  });

  final String data;
  final Color? color;
  final double? fontSize;
  final int? maxLines;
  final FontWeight? fontWeight;
  final TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        double currentFontSize = fontSize ?? 14.0;
        TextStyle effectiveTextStyle = (textStyle ?? TextStyle()).copyWith(
          fontSize: currentFontSize,
          color: color,
          fontWeight: fontWeight,
        );

        return Text(
          data,
          softWrap: true,
          overflow: TextOverflow.ellipsis,
          maxLines: maxLines,
          style: effectiveTextStyle,
        );
      },
    );
  }
}
