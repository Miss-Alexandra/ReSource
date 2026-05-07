import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

class TextStylesSheet extends StatelessWidget {
  final Function(String) onStyleChanged;
  const TextStylesSheet({super.key, required this.onStyleChanged});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _styleButton('H1', () => onStyleChanged('# ')),
          _styleButton('H2', () => onStyleChanged('## ')),
          _styleButton('H3', () => onStyleChanged('### ')),
          const SizedBox(width: 16),
          _styleButton('B', () => onStyleChanged('**'), isBold: true),
          _styleButton('I', () => onStyleChanged('*'), isItalic: true),
        ],
      ),
    );
  }
  
  Widget _styleButton(String label, VoidCallback onTap, {bool isBold = false, bool isItalic = false}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        child: Text(
          label,
          style: TextStyle(
            color: AppColors.primaryBlue,
            fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
            fontStyle: isItalic ? FontStyle.italic : FontStyle.normal,
          ),
        ),
      ),
    );
  }
}