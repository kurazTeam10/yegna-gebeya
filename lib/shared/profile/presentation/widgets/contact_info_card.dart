import 'package:flutter/material.dart';

class ContactInfoCard extends StatefulWidget {
  final IconData icon;
  final String title;
  final String value;
  final Color? backgroundColor;
  final VoidCallback? onTap;
  final ValueChanged<String>? onValueChanged;

  const ContactInfoCard({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
    this.backgroundColor,
    this.onTap,
    this.onValueChanged,
  });

  @override
  State<ContactInfoCard> createState() => _ContactInfoCardState();
}

class _ContactInfoCardState extends State<ContactInfoCard> {
  late TextEditingController _controller;
  bool _editing = false;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.value);
  }

  @override
  void didUpdateWidget(covariant ContactInfoCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.value != widget.value) {
      _controller.text = widget.value;
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: widget.onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 6, horizontal: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? Colors.purple.shade50,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(widget.icon, color: Colors.black87),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 4),
                  _editing
                      ? Row(
                          children: [
                            Expanded(
                              child: TextFormField(
                                controller: _controller,
                                autofocus: true,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.black87,
                                ),
                                decoration: const InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                    vertical: 8,
                                    horizontal: 8,
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                                onFieldSubmitted: (val) {
                                  setState(() {
                                    _editing = false;
                                  });
                                  if (widget.onValueChanged != null) {
                                    widget.onValueChanged!(val);
                                  }
                                },
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.check, size: 20),
                              onPressed: () {
                                setState(() {
                                  _editing = false;
                                });
                                if (widget.onValueChanged != null) {
                                  widget.onValueChanged!(_controller.text);
                                }
                              },
                            ),
                          ],
                        )
                      : Row(
                          children: [
                            Expanded(
                              child: Text(
                                _controller.text,
                                style: const TextStyle(
                                  fontSize: 13,
                                  color: Colors.black87,
                                ),
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.edit, size: 18),
                              onPressed: () {
                                setState(() {
                                  _editing = true;
                                });
                              },
                            ),
                          ],
                        ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
