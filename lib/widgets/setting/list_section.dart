import 'package:flutter/material.dart';

class ListSection extends StatelessWidget {
  const ListSection({
    super.key,
    required this.icons,
    required this.title,
    this.position = '',
  });

  final IconData icons;
  final String title;
  final String position;

  BorderRadius _getBorderRadius(String position) {
    return BorderRadius.only(
      topLeft: position == 'first'
          ? const Radius.circular(12)
          : Radius.circular(4),
      topRight: position == 'first'
          ? const Radius.circular(12)
          : Radius.circular(4),
      bottomLeft: position == 'last'
          ? const Radius.circular(12)
          : Radius.circular(4),
      bottomRight: position == 'last'
          ? const Radius.circular(12)
          : Radius.circular(4),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2.5),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.deepOrange[100],
          borderRadius: _getBorderRadius(position),
          // boxShadow: [
          //   BoxShadow(
          //     color: Colors.black.withValues(alpha: 0.15),
          //     blurRadius: 10,
          //     offset: const Offset(0, 4),
          //   ),
          // ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: _getBorderRadius(position),
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: EdgeInsets.all(4),
                    decoration: BoxDecoration(
                      borderRadius: _getBorderRadius(position),
                      color: Colors.deepOrange[200],
                    ),
                    child: Icon(icons, size: 24),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight(500),
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
