import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:nekidaem/presentation/theme.dart';

enum Fields { username, password }

class UpdatableTextFormField extends StatefulWidget {
  const UpdatableTextFormField({
    Key? key,
    required this.valueListenable,
    required this.focusNode,
    required this.textEditingController,
    required this.hintText,
    required this.field,
  }) : super(key: key);

  final ValueListenable<TextEditingValue> valueListenable;
  final FocusNode focusNode;
  final TextEditingController textEditingController;
  final String hintText;
  final Fields field;

  @override
  State<UpdatableTextFormField> createState() => _UpdatableTextFormFieldState();
}

class _UpdatableTextFormFieldState extends State<UpdatableTextFormField> {
  bool _usernameError = false;
  bool _passwordError = false;
  String? _errorText(Fields field) {
    if ((widget.focusNode.hasFocus && field == Fields.username) ||
        _usernameError) {
      _usernameError = true;
      if (widget.textEditingController.value.text.length < 4) {
        return 'minimum_is_four'.tr();
      }
    } else if ((widget.focusNode.hasFocus && field == Fields.password) ||
        _passwordError) {
      _passwordError = true;
      if (widget.textEditingController.value.text.length < 8) {
        return 'minimum_is_eight'.tr();
      }
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: widget.valueListenable,
      builder: (BuildContext context, TextEditingValue value, _) {
        return TextFormField(
          focusNode: widget.focusNode,
          controller: widget.textEditingController,
          textAlign: TextAlign.center,
          style: TextStyles.whiteText,
          decoration: InputDecoration(
            errorText: _errorText(widget.field),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
            ),
            enabledBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.grey,
              ),
              borderRadius: BorderRadius.circular(30.0),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: const BorderSide(
                color: AppColors.aquamarine,
              ),
              borderRadius: BorderRadius.circular(30.0),
            ),
            filled: true,
            hintStyle: TextStyles.greyText,
            hintText: widget.hintText,
            fillColor: AppColors.darkBlack,
          ),
        );
      },
    );
  }
}
