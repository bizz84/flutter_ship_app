import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_ship_app/src/constants/app_colors.dart';
import 'package:flutter_ship_app/src/constants/app_sizes.dart';
import 'package:flutter_ship_app/src/common_widgets/custom_checkmark.dart';
import 'package:flutter_ship_app/src/utils/string_hardcoded.dart';

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
    final isLight = Theme.of(context).brightness == Brightness.light;
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
                checkmarkColor: Colors.white,
                strokeWidth: 2.5,
              ),
            ),
            gapW24,
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AutoSizeText(
                    title,
                    style: Theme.of(context).textTheme.bodyMedium,
                    maxLines: 2,
                  ),
                  gapH4,
                  AutoSizeText(
                    '$completedCount of $totalCount completed'.hardcoded,
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 1,
                  ),
                ],
              ),
            ),
            gapW24,
            Icon(
              Icons.chevron_right,
              color: AppColors.greyShade500(isLight),
            ),
          ],
        ),
      ),
    );
  }
}
