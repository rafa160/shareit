import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';

class CustomFormBuilderDropdown extends StatelessWidget {
  final String text;
  final TextInputAction action;
  final TextInputType type;
  final bool obscureText;
  final String hint;
  final bool enabled;
  final FormFieldValidator<String> validator;
  final String initialValue;
  final Function onChanged;
  final int maxLength;
  final List<DropdownMenuItem<String>> items;

  const CustomFormBuilderDropdown({Key key, this.text, this.action, this.type, this.obscureText, this.validator,this.hint, this.enabled,this.initialValue, this.onChanged, this.maxLength, this.items}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      decoration: BoxDecoration(
        color:Colors.green[200],
        borderRadius: BorderRadius.circular(10),
      ),
      child: FormBuilderDropdown(
        onChanged: onChanged,
        enabled: enabled,
        initialValue: initialValue,
        name: text,
        isExpanded: true,
        validator: validator,
        elevation: 4,
        items: items,
        decoration: InputDecoration(
          errorStyle: TextStyle(fontSize: 10, color: Colors.redAccent),
          counterText: '',
          hintText: hint,
          border: InputBorder.none,
          focusedBorder: InputBorder.none,
          enabledBorder: InputBorder.none,
          errorBorder: InputBorder.none,
          disabledBorder: InputBorder.none,
        ),
      ),
    );
  }
}
