import 'package:flutter/material.dart';

class CustomExpansionTile extends StatefulWidget {
  final Widget leading;
  final String title;
  final List<Widget> children;
  final bool initiallyExpanded;

  const CustomExpansionTile({
    super.key,
    required this.leading,
    required this.title,
    required this.children,
    this.initiallyExpanded = false,
  });

  @override
  _CustomExpansionTileState createState() => _CustomExpansionTileState();
}

class _CustomExpansionTileState extends State<CustomExpansionTile> {
  bool _isExpanded = false;

  @override
  void initState() {
    super.initState();
    _isExpanded = widget.initiallyExpanded;
  }

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          InkWell(
            onTap: _toggleExpansion,
            child: Row(
              children: [
                if(widget.children.isNotEmpty)
                Icon(
                  _isExpanded ? Icons.expand_less : Icons.expand_more,
                ),
                const SizedBox(width: 8.0),
                widget.leading,
                const SizedBox(width: 8.0),
                Expanded(child: Text(widget.title, style: TextStyle(fontSize: 16),)),
              ],
            ),
          ),
          if (_isExpanded)
            Padding(
              padding: const EdgeInsets.only(left: 10.0),
              child: Column(children: widget.children),
            ),
        ],
      ),
    );
  }
}