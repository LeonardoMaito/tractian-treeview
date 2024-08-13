import 'package:flutter/material.dart';

class CustomExpansionTile extends StatefulWidget {
  final Widget leading;
  final String title;
  final List<Widget> children;
  final bool initiallyExpanded;
  final bool expandable;
  final List<Widget>? additionalIcons;

  const CustomExpansionTile({
    super.key,
    required this.leading,
    required this.title,
    this.children = const [],
    this.initiallyExpanded = false,
    this.expandable = true,
    this.additionalIcons,
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
    if (widget.expandable) {
      setState(() {
        _isExpanded = !_isExpanded;
      });
    }
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
                if (widget.expandable && widget.children.isNotEmpty)
                  Icon(
                    _isExpanded ? Icons.expand_less : Icons.expand_more,
                  )
                else
                  const SizedBox(
                    width: 24.0, // Mesma largura do ícone de expansão
                  ),
                const SizedBox(width: 8.0),
                widget.leading,
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    widget.title,
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
                if (widget.additionalIcons != null) ...widget.additionalIcons!,
              ],
            ),
          ),
          if (_isExpanded && widget.expandable)
            Padding(
              padding: const EdgeInsets.only(left: 10.0), // Indentação maior para filhos
              child: Column(children: widget.children),
            ),
        ],
      ),
    );
  }
}
