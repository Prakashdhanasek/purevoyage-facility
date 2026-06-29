// ignore_for_file: library_private_types_in_public_api, file_names

import 'package:facility_management/app/theme/app_colors.dart';
import 'package:flutter/material.dart';

class CustomToggleButton extends StatefulWidget {
  final List<String> labels;
  final List<int> counts;
  final Function(int) onSelected;
  final int initialIndex;

  const CustomToggleButton({
    super.key,
    required this.labels,
    required this.counts,
    required this.onSelected,
    this.initialIndex = 0,
  });

  @override
  _CustomToggleButtonState createState() => _CustomToggleButtonState();
}

class _CustomToggleButtonState extends State<CustomToggleButton> {
  late int _selectedIndex;

  @override
  void initState() {
    super.initState();
    _selectedIndex = widget.initialIndex;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 311,
      height: 38,
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 3),
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: List.generate(widget.labels.length, (int index) {
          bool isSelected = _selectedIndex == index;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedIndex = index;
              });
              widget.onSelected(index);
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: <Widget>[
                  Text(
                    widget.labels[index],
                    style: TextStyle(
                      color: isSelected ? AppColors.fmBlue950 : Colors.black,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Container(
                    padding: const EdgeInsets.all(5),
                    decoration: BoxDecoration(
                      color:
                          isSelected
                              ? AppColors.fmBlue950
                              : AppColors.fmBlue500,
                      shape: BoxShape.circle,
                    ),
                    child: Text(
                      widget.counts[index].toString(),
                      style: const TextStyle(color: Colors.white, fontSize: 9),
                    ),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}
