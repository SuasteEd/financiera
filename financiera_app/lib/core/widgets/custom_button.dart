// ignore_for_file: must_be_immutable
import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  final String? text;
  final VoidCallback onPressed;
  final bool? isLoading;
  final bool? block;
  final double? height;
  final Widget? leading;
  final Widget? trailing;
  final Color? color;
  final Color? texTcolor;
  final Widget? body;
  final double? verticalPadding;
  final double? width;
  final double? margin;
  final double? fontSize;

  CustomButtonWidget({
    super.key,
    this.text,
    required this.onPressed,
    this.isLoading = false,
    this.block = false,
    this.height,
    this.leading,
    this.trailing,
    this.color,
    this.body,
    this.verticalPadding,
    this.width,
    this.margin,
    this.fontSize,
    this.texTcolor,
  });

  bool singleTap = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding ?? 0),
      child: InkWell(
        onTap: () {
          if (block! || isLoading!) return;
          Function.apply(onPressed, []);
          singleTap = true;
          Future.delayed(const Duration(seconds: 2)).then((_) {
            singleTap = false;
          });
        },
        child: Container(
          margin: EdgeInsets.only(bottom: margin ?? 0),
          height: height ?? size.height * 0.06,
          width: width ?? double.infinity,
          decoration: BoxDecoration(
            color: Colors.black,
            // color: _getColor(),
            borderRadius: BorderRadius.circular(6),
            // border: type! == ButtonType.outline
            //     ? Border.all(color: Colors.black)
            //     : null,
          ),
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: Center(
            child: isLoading!
                ? const CircularProgressIndicator(
                    color: Colors.white,
                  )
                : body ??
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Visibility(
                          visible: leading != null,
                          child: Row(
                            children: [
                              leading ?? const SizedBox(),
                              const SizedBox(width: 8),
                            ],
                          ),
                        ),
                        Text(
                          text ?? '',
                          style: TextStyle(
                            fontFamily: 'Univers',
                            color: texTcolor,
                            fontSize: fontSize ?? size.width * 0.03,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        Visibility(
                          visible: trailing != null,
                          child: Row(
                            children: [
                              const SizedBox(width: 8),
                              trailing ?? const SizedBox(),
                            ],
                          ),
                        ),
                      ],
                    ),
          ),
        ),
      ),
    );
  }

  // Color _getColor() {
  //   if (block!) return AppColors.gray;
  //   if (color != null) return color!;
  //   if (type! == ButtonType.outline) return Colors.transparent;
  //   return AppColors.primary;
  // }
}
