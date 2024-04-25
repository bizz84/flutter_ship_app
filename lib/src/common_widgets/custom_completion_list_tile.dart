import 'package:flutter/material.dart';
import 'package:flutter_ship_app/src/constants/app_sizes.dart';
import 'package:flutter_ship_app/src/common_widgets/custom_checkmark.dart';

class CustomCompletionListTile extends StatelessWidget {
  const CustomCompletionListTile({
    super.key,
    required this.title,
    required this.completedCount,
    required this.totalCount,
    required this.onTap,
  });
  final String title;
  final int completedCount;
  final int totalCount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(
            horizontal: Sizes.p20, vertical: Sizes.p12),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              width: Sizes.p24,
              height: Sizes.p24,
              child: CustomCheckmark(
                value: completedCount / totalCount,
                fillColor: Theme.of(context).colorScheme.secondary,
                strokeWidth: 2.5,
              ),
            ),
            gapW24,
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
                gapH4,
                Text(
                  '$completedCount of $totalCount completed',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
            const Spacer(),
            const Icon(
              Icons.chevron_right,
              // TODO: what color to use here?
              color: Colors.black45,
            ),
          ],
        ),
      ),
    );
  }
}
