import 'package:facility_management/core/constants/assets_paths.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class SearchBarWidget extends StatelessWidget {
  final Function() onPressed;
  final String hinttext;
  final Color? bgColor;
  final Color? iconColor;
  final double? padding;
  final TextStyle? hintStyle;
  final TextEditingController controller;
  final Function(String)? onChanged;

  const SearchBarWidget({
    super.key,
    required this.onPressed,
    required this.hinttext,
    this.bgColor,
    this.iconColor,
    this.padding,
    this.hintStyle,
    required this.controller,
    this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(padding ?? 14.0),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Expanded(
                    child: TextField(
                      controller: controller,
                      onChanged: onChanged,
                      textAlign: TextAlign.start,
                      textAlignVertical: TextAlignVertical(y: 0.5),
                      decoration: InputDecoration(
                        hintText: hinttext,
                        hintStyle: hintStyle,
                        border: InputBorder.none,
                        suffixIcon: const Icon(CupertinoIcons.search),
                      ),
                    ),
                  ),

                  Visibility(
                    visible: false,
                    child: GestureDetector(
                      onTap: () {},
                      child: Image.asset(
                        AssetsPathConstants.audioIconImagePath,
                        height: 24,
                        width: 24,
                        fit: BoxFit.fill,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
