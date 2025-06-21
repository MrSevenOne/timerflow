import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:timerflow/config/theme/ligth_theme.dart';

class SessionInfoRow extends StatelessWidget {
  final String title;
  final String value;

  const SessionInfoRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title,style: GoogleFonts.pridi(textStyle: theme.textTheme.bodyLarge,color: mainColor),),
          Text(value,style: GoogleFonts.pridi(textStyle: theme.textTheme.bodyLarge),),
        ],
      ),
    );
  }
}
