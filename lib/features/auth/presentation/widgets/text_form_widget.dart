import 'package:flutter/material.dart';

class TextFormWidget extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final Widget icon;
  final FocusNode focusNode;
  final String? Function(String?)? validator;
  const TextFormWidget({
    required this.controller,
    required this.labelText,
    required this.icon,
    required this.focusNode,
    this.validator, // optional
    super.key,
  });

  @override
  State<TextFormWidget> createState() => _TextFormWidgetState();
}

class _TextFormWidgetState extends State<TextFormWidget> {
  bool _isFocused = false;
  bool isVisible = false;

  @override
  void initState() {
    super.initState();
    widget.focusNode.addListener(_handleFocusChange);
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = widget.focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    widget.focusNode.removeListener(_handleFocusChange);
    widget.focusNode.dispose();
    super.dispose();
  }

  String? _defaultValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'required';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    return Container(
      margin: EdgeInsets.only(bottom: height * 0.02),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: _isFocused
            ? [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 8,
                  offset: Offset(0, 3),
                ),
              ]
            : [],
      ),
      child: TextFormField(
        focusNode: widget.focusNode,
        controller: widget.controller,
        obscureText: isVisible,
        decoration: InputDecoration(
          labelText: widget.labelText,
          prefixIcon: widget.icon,
          suffixIcon:
              widget.labelText == 'PASSWORD' ||
                  widget.labelText == 'CONFIRM PASSWORD'
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      isVisible = !isVisible;
                    });
                  },
                  icon: isVisible
                      ? Icon(Icons.visibility)
                      : Icon(Icons.visibility_off),
                )
              : null,
        ),
        validator: widget.validator ?? _defaultValidator,
      ),
    );
  }
}
