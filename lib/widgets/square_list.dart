import 'package:flutter/material.dart';

class SquareList extends StatelessWidget {
  const SquareList({
    super.key,
    required this.title,
    required this.description,
    required this.onPressed,
    required this.index,
    required this.totalItems,
  });

  final String title;
  final String description;
  final VoidCallback onPressed;
  final int index;
  final int totalItems;

  BorderRadius _getBorderRadius(int index, int totalItems) {
    return BorderRadius.only(
      topLeft: index == 0
          ? const Radius.circular(12)
          : const Radius.circular(4),
      topRight: index == 0
          ? const Radius.circular(12)
          : const Radius.circular(4),
      bottomLeft: index == totalItems - 1
          ? const Radius.circular(12)
          : const Radius.circular(4),
      bottomRight: index == totalItems - 1
          ? const Radius.circular(12)
          : const Radius.circular(4),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2.5, horizontal: 10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.deepOrange[100],
          borderRadius: _getBorderRadius(index, totalItems),
          boxShadow: [
            BoxShadow(
              color: Colors.deepOrange.withValues(alpha: 0.15),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: _getBorderRadius(index, totalItems),
            onTap: onPressed,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.deepOrange[300],
                      borderRadius: _getBorderRadius(index, totalItems),
                    ),
                    child: const Icon(
                      Icons.note_alt_outlined,
                      color: Colors.white,
                      size: 24,
                    ),
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
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          description,
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.grey[700],
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
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
