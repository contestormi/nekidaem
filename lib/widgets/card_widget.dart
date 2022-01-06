import 'package:flutter/material.dart';
import 'package:nekidaem/presentation/theme.dart';

class CardWidget extends StatelessWidget {
  const CardWidget({Key? key, required this.id, required this.textBody})
      : super(key: key);

  final int id;
  final String textBody;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 4),
      decoration: const BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.all(
          Radius.circular(4),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'ID: $id',
              style: TextStyles.whiteText,
            ),
            Text(
              textBody,
              style: TextStyles.whiteText,
            ),
          ],
        ),
      ),
    );
  }
}
