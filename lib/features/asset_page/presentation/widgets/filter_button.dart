import 'package:flutter/material.dart';

class FilterButton extends StatefulWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String text;
  final Color borderColor;
  final Color iconColor;
  final Color textColor;
  final Color activeBorderColor;
  final Color activeIconColor;
  final Color activeTextColor;

  const FilterButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.text,
    this.borderColor = Colors.grey,
    this.iconColor = Colors.grey,
    this.textColor = Colors.grey,
    this.activeBorderColor = Colors.blue,
    this.activeIconColor = Colors.white,
    this.activeTextColor = Colors.white,
  });

  @override
  _FilterButtonState createState() => _FilterButtonState();
}

class _FilterButtonState extends State<FilterButton> {
  bool isActive = false;

  void _handlePress() {
    setState(() {
      isActive = !isActive;
    });
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        backgroundColor: isActive ? widget.activeBorderColor : Colors.white ,
        shape: const ContinuousRectangleBorder(),
        side: BorderSide(
          width: 1,
          color: isActive ? widget.activeBorderColor : widget.borderColor,
        ),
      ),
      onPressed: _handlePress,
      child: Row(
        children: [
          Icon(
            widget.icon,
            color: isActive ? widget.activeIconColor : widget.iconColor,
          ),
          const SizedBox(width: 8.0),
          Text(
            widget.text,
            style: TextStyle(
              color: isActive ? widget.activeTextColor : widget.textColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
