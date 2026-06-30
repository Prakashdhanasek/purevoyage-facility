import 'package:facility_management/app/theme/app_colors.dart';
import 'package:facility_management/app/theme/app_text_styles.dart';
import 'package:facility_management/widgets/fm_bottom_sheet.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

enum TextFieldType {
  text,
  email,
  password,
  date,
  dropdown,
  flag,
  time,
} // Time already added

class FMTextField extends StatefulWidget {
  final String? label;
  final FocusNode? focus;
  final String? placeholder;
  final TextEditingController controller;
  final bool isError;
  final String? errorText;
  final IconData? leadingIcon;
  final VoidCallback? onTrailingIconPressed;
  final Function(String)? onChanged;
  final TextInputType keyboardType;
  final TextFieldType fieldType;
  final bool isOptional;
  final List<dynamic>? dropdownItems;
  final Function(String?)? onDropdownChanged;
  final Function(String?)? onDateChanged;
  final bool showFlag;
  final String? Function(String?)? validator;
  final bool? showFloatingLabel;
  final bool search;
  final bool readOnly;
  final bool showBelowError;
  final bool multiSelectionDropDown;
  final Function()? onTap;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final int maxLines;
  final Color? borderColor;
  final IconData? trailingIcon;
  final InputDecoration? decoration;
  final String? initialValue;
  final TextCapitalization? textCapitalization;
  final DateFormat? dateFormat;
  final bool? asterikNeeded;
  final Function()? dropDownSelect;
  final List<TextInputFormatter>? inputFormatters;
  final bool futureDateAllowed;
  final bool pastDateAllowed;

  final bool needSearchBar;
  const FMTextField({
    super.key,
    this.label,
    this.placeholder,
    required this.controller,
    this.isError = false,
    this.focus,
    this.errorText,
    this.leadingIcon,
    this.onTrailingIconPressed,
    this.onChanged,
    this.keyboardType = TextInputType.text,
    this.fieldType = TextFieldType.text,
    this.isOptional = true,
    this.dropdownItems,
    this.onDropdownChanged,
    this.onDateChanged,
    this.showFlag = false,
    this.validator,
    this.showFloatingLabel = false,
    this.search = false,
    this.showBelowError = true,
    this.readOnly = false,
    this.multiSelectionDropDown = false,
    this.onTap,
    this.hintStyle,
    this.labelStyle,
    this.maxLines = 1,
    this.borderColor,
    this.trailingIcon,
    this.decoration,
    this.initialValue,
    this.textCapitalization,
    this.dateFormat,
    this.asterikNeeded = false,
    this.dropDownSelect,
    this.inputFormatters,
    this.futureDateAllowed = true,
    this.pastDateAllowed = true,

    this.needSearchBar = false,
  });

  @override
  State<FMTextField> createState() => _FMTextFieldState();
}

class _FMTextFieldState extends State<FMTextField> {
  bool _obscureText = true;
  String? selectedDropdownValue;
  List<String> _selectedDropDownList = <String>[];
  String? _validationError;
  List<dynamic> showDropDown = <dynamic>[];

  @override
  void initState() {
    super.initState();
    if (widget.fieldType == TextFieldType.dropdown &&
        widget.dropdownItems?.isNotEmpty == true) {
      selectedDropdownValue =
          widget.controller.text.isNotEmpty ? widget.controller.text : null;
    }
    if (widget.multiSelectionDropDown && widget.controller.text.isNotEmpty) {
      _selectedDropDownList = widget.controller.text.split(', ');
    }
  }

  void _validate(String? value) {
    if (widget.validator != null) {
      setState(() => _validationError = widget.validator!(value));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        if (widget.showFlag)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(
                color: AppColors.greyFontColorPrimary,
                borderRadius: BorderRadius.circular(4),
              ),
              child: const Text(
                'Required',
                style: TextStyle(
                  fontSize: 10,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        const SizedBox(height: 8),
        _buildTextField(),
        if (_validationError != null && widget.showBelowError)
          Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              _validationError!,
              style: appBarTitle.copyWith(color: Colors.red),
            ),
          ),
      ],
    );
  }

  Widget _buildTextField() {
    return Container(
      decoration: BoxDecoration(
        boxShadow: <BoxShadow>[
          BoxShadow(
            color: Colors.black.withValues(alpha: .05),
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
        borderRadius: BorderRadius.circular(24),
      ),
      child: TextFormField(
        controller: widget.controller,
        focusNode: widget.focus,
        obscureText:
            widget.fieldType == TextFieldType.password ? _obscureText : false,
        onChanged: (String value) {
          widget.onChanged?.call(value);
          _validate(value);
        },
        textCapitalization:
            widget.textCapitalization ?? TextCapitalization.none,
        onTap:
            widget.fieldType == TextFieldType.dropdown
                ? () => setState(() {
                  if (widget.dropdownItems != null) showModal(context);
                })
                : widget.onTap,
        inputFormatters: widget.inputFormatters,
        validator: widget.validator,
        keyboardType: _getKeyboardType(),
        style: appBarTitle.copyWith(color: AppColors.fmBlue900),
        readOnly: widget.fieldType == TextFieldType.dropdown || widget.readOnly,
        maxLines: widget.maxLines,
        decoration: InputDecoration(
          label: RichText(
            text: TextSpan(
              text: widget.label ?? '',
              style: bodyText.copyWith(
                color: AppColors.commonFontColorSecondary,
              ),
              children: <InlineSpan>[
                TextSpan(
                  text: widget.isOptional ? '' : '*',
                  style: bodyText.copyWith(color: AppColors.danger),
                ),
              ],
            ),
          ),
          floatingLabelBehavior: FloatingLabelBehavior.auto,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          hintText: widget.placeholder,
          hintStyle:
              widget.hintStyle ??
              appBarTitle.copyWith(
                color: AppColors.greyFontColorPrimary,
                fontSize: 14,
              ),
          filled: true,
          fillColor: AppColors.fmBlue50,
          prefixIcon:
              widget.leadingIcon != null
                  ? Padding(
                    padding: EdgeInsets.only(left: 12, right: 8),
                    child: Icon(
                      widget.leadingIcon,
                      color: AppColors.greyFontColorPrimary,
                      size: 20,
                    ),
                  )
                  : null,
          suffixIcon: _buildSuffixIcon(),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color:
                  _validationError != null || widget.isError
                      ? Colors.red
                      : widget.borderColor ?? AppColors.borderColor,
              width: _validationError != null || widget.isError ? 1 : 0,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color:
                  _validationError != null || widget.isError
                      ? Colors.red
                      : widget.borderColor ?? AppColors.borderColor,
              width: _validationError != null || widget.isError ? 1 : 0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              color:
                  _validationError != null || widget.isError
                      ? Colors.red
                      : widget.borderColor ?? AppColors.borderColor,
              width: _validationError != null || widget.isError ? 2 : 0,
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> popupContent(BuildContext context, Function setModalState) {
    return [
      Align(
        alignment: Alignment.topRight,
        child: Padding(
          padding: const EdgeInsets.only(right: 12.0, top: 8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: Text(
              'Done',
              style: const TextStyle(
                color: Colors.blue,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ),

      const SizedBox(height: 10),

      ...List<Widget>.generate(showDropDown.length, (int index) {
        final dynamic item = showDropDown[index];
        final bool isSelected = _selectedDropDownList.contains(item);

        return GestureDetector(
          onTap: () {
            setModalState(() {
              if (_selectedDropDownList.contains(item)) {
                _selectedDropDownList.remove(item);
                List<String> list = widget.controller.text.split(', ');
                list.remove(item);
                widget.controller.text = list.join(', ');
              } else {
                _selectedDropDownList.add(item);
                List<String> list =
                    widget.controller.text.isNotEmpty
                        ? widget.controller.text.split(', ')
                        : <String>[];
                list.add(item);
                widget.controller.text = list.join(', ');
              }
            });

            widget.onDropdownChanged?.call(item);
            widget.onChanged?.call(item);
          },
          child: Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.all(10),
            height: 48,
            decoration: BoxDecoration(
              color: AppColors.backgroundPrimary,
              border: Border.all(
                width: isSelected ? 2 : 1,
                color: isSelected ? AppColors.fmBlue800 : Colors.grey.shade300,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              item,
              style: bodyText.copyWith(
                color:
                    isSelected
                        ? AppColors.fmBlue800
                        : AppColors.commonFontColorPrimary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              ),
            ),
          ),
        );
      }),
    ];
  }

  void showModal(BuildContext context) {
    if (widget.dropDownSelect != null) widget.dropDownSelect!();
    showDropDown.clear();
    showDropDown.addAll(widget.dropdownItems!);
    customShowModalBottomSheet(
      context: context,
      inputWidget: StatefulBuilder(
        builder: (BuildContext context, Function setModalState) {
          return Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  widget.label != null
                      ? 'Select ${widget.label!.replaceAll('Select', '').trim()}'
                      : 'Select an Item',
                  style: sectionTitleInDetails,
                ),
                const SizedBox(height: 20),
                Container(
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * .75,
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        if (widget.needSearchBar)
                          TextFormField(
                            style: appBarTitle.copyWith(
                              color: AppColors.fmBlue900,
                            ),
                            onChanged: (String value) {
                              setModalState(() {
                                if (value.isEmpty) {
                                  showDropDown.clear();
                                  showDropDown.addAll(widget.dropdownItems!);
                                } else {
                                  showDropDown.clear();
                                  showDropDown =
                                      widget.dropdownItems!
                                          .where(
                                            (dynamic element) => element
                                                .toString()
                                                .toLowerCase()
                                                .contains(value.toLowerCase()),
                                          )
                                          .toList();
                                }
                              });
                            },
                            decoration: InputDecoration(
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 10,
                              ),
                              hintText:
                                  widget.label != null
                                      ? 'Search ${widget.label!.replaceAll('Select', '').trim()}'
                                      : 'Search Item',
                              hintStyle:
                                  widget.hintStyle ??
                                  appBarTitle.copyWith(
                                    color: AppColors.blackKindFontColor,
                                    fontSize: 14,
                                  ),
                              filled: true,
                              fillColor: AppColors.backgroundPrimary,

                              suffixIcon: IconButton(
                                icon: Icon(
                                  Icons.search,
                                  color: AppColors.greyFontColorPrimary,
                                  size: 20,
                                ),
                                onPressed: () {},
                              ),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: AppColors.borderColor,
                                  width: 1,
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: AppColors.borderColor,
                                  width: 1,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12),
                                borderSide: const BorderSide(
                                  color: AppColors.borderColor,
                                  width: 1,
                                ),
                              ),
                            ),
                          ),
                        const SizedBox(height: 8),
                        Wrap(
                          runSpacing: 8,
                          spacing: 8,
                          children:
                              showDropDown.isEmpty
                                  ? <Widget>[
                                    const Center(
                                      child: Text(
                                        'No items available to select',
                                        style: TextStyle(
                                          color: Colors.grey,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ),
                                  ]
                                  : widget.multiSelectionDropDown
                                  ? popupContent(context, setModalState)
                                  : List<Widget>.generate(showDropDown.length, (
                                    int index,
                                  ) {
                                    final dynamic item = showDropDown[index];
                                    final bool isSelected =
                                        widget.controller.text == item;

                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          selectedDropdownValue = item;
                                          widget.controller.text = item;
                                        });

                                        if (widget.onDropdownChanged != null) {
                                          widget.onDropdownChanged!(item);
                                        }

                                        if (widget.onChanged != null) {
                                          widget.onChanged!(item);
                                        }

                                        Navigator.pop(context);
                                      },
                                      child: Container(
                                        alignment: Alignment.center,
                                        padding: const EdgeInsets.all(10),
                                        height: 48,
                                        decoration: BoxDecoration(
                                          color: AppColors.backgroundPrimary,
                                          border: Border.all(
                                            width: isSelected ? 2 : 1,
                                            color:
                                                isSelected
                                                    ? AppColors.fmBlue800
                                                    : Colors.grey.shade300,
                                          ),
                                          borderRadius: BorderRadius.circular(
                                            12,
                                          ),
                                        ),
                                        child: Text(
                                          item,
                                          style: bodyText.copyWith(
                                            color:
                                                isSelected
                                                    ? AppColors.fmBlue800
                                                    : AppColors
                                                        .commonFontColorPrimary,
                                            fontWeight:
                                                isSelected
                                                    ? FontWeight.w600
                                                    : FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget? _buildSuffixIcon() {
    if (widget.search) {
      return const Icon(CupertinoIcons.search);
    }
    switch (widget.fieldType) {
      case TextFieldType.password:
        return IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: AppColors.greyFontColorPrimary,
            size: 20,
          ),
          onPressed: () => setState(() => _obscureText = !_obscureText),
        );
      case TextFieldType.date:
        return IconButton(
          icon: const Icon(
            Icons.calendar_today,
            color: AppColors.greyFontColorPrimary,
            size: 20,
          ),
          onPressed: widget.onTap ?? _selectDate,
        );
      case TextFieldType.email:
        return Padding(
          padding: EdgeInsets.only(right: 12),
          child: Icon(
            widget.trailingIcon ?? Icons.mail_outlined,
            color: AppColors.greyFontColorPrimary,
            size: 20,
          ),
        );
      case TextFieldType.dropdown:
        return IconButton(
          icon: Icon(
            Icons.arrow_drop_down,
            color: AppColors.greyFontColorPrimary,
            size: 20,
          ),
          onPressed:
              () => setState(() {
                if (widget.dropdownItems != null) showModal(context);
              }),
        );
      case TextFieldType.time:
        return IconButton(
          icon: const Icon(
            Icons.access_time,
            color: AppColors.greyFontColorPrimary,
            size: 20,
          ),
          onPressed: () => _selectTime(),
        );
      default:
        return widget.trailingIcon != null
            ? Padding(
              padding: EdgeInsets.only(right: 12),
              child: Icon(
                widget.trailingIcon,
                color: AppColors.greyFontColorPrimary,
                size: 20,
              ),
            )
            : null;
    }
  }

  TextInputType _getKeyboardType() {
    switch (widget.fieldType) {
      case TextFieldType.email:
        return TextInputType.emailAddress;
      case TextFieldType.date:
        return TextInputType.datetime;
      case TextFieldType.time:
        return TextInputType.datetime;
      default:
        return widget.keyboardType;
    }
  }

  Future<void> _selectDate() async {
    DateTime? selected = (widget.dateFormat ?? DateFormat('yyyy-MM-dd'))
        .tryParse(widget.controller.text);
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selected ?? DateTime.now(),
      firstDate: widget.pastDateAllowed ? DateTime(1900) : DateTime.now(),
      lastDate: widget.futureDateAllowed ? DateTime(2100) : DateTime.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.fmBlue700,
              onPrimary: AppColors.backgroundPrimary,
              onSurface: AppColors.commonIconColorPrimary,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(foregroundColor: AppColors.fmBlue700),
            ),
            dialogTheme: const DialogThemeData(backgroundColor: Colors.white),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      widget.controller.text = (widget.dateFormat ?? DateFormat('yyyy-MM-dd'))
          .format(picked);
      if (widget.onDateChanged != null) {
        widget.onDateChanged!(widget.controller.text);
      }
      _validate(widget.controller.text);
    }
  }

  Future<void> _selectTime() async {
    TimeOfDay? pickedTime = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
      builder: (BuildContext context, Widget? child) {
        return Theme(
          data: ThemeData.light().copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF4267B2),
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
            textButtonTheme: TextButtonThemeData(
              style: TextButton.styleFrom(
                foregroundColor: const Color(0xFF4267B2),
              ),
            ),
            dialogTheme: DialogThemeData(backgroundColor: Colors.white),
          ),
          child: child!,
        );
      },
    );
    if (pickedTime != null) {
      final DateTime now = DateTime.now();
      final DateTime combinedDateTime = DateTime(
        now.year,
        now.month,
        now.day,
        pickedTime.hour,
        pickedTime.minute,
      );
      widget.controller.text = DateFormat('HH:mm').format(combinedDateTime);
      _validate(widget.controller.text);
    }
  }
}
