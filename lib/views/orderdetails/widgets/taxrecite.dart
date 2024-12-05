import 'package:flutter/material.dart';
import 'package:ordering_system_admin/design_system/app_themes.dart';

class TaxRecite extends StatelessWidget {
  final void Function()? viewDoc;
  const TaxRecite({super.key, required this.viewDoc});

  @override
  Widget build(BuildContext context) {
    return Container(
      // height: MediaQuery.of(context).size.height * .1,
      margin: const EdgeInsets.only(bottom: 5),
      padding: const EdgeInsets.symmetric(horizontal: 15),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text(
            'Tax recite',
            style: AppTheme.orderDetailsTaxRecite,
          ),
          TextButton.icon(
              onPressed: viewDoc,
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
              ),
              icon: Icon(
                Icons.open_in_new,
                color: Colors.grey[600],
              ),
              iconAlignment: IconAlignment.end,
              label: const Text(
                'View document',
                style: AppTheme.orderDetailsTaxReciteViewDoc,
              )),
        ],
      ),
    );
  }
}


 // Row(
          //   mainAxisSize: MainAxisSize.min,
          //   children: [
          //     Text('View document',
          //         style: Theme.of(context)
          //             .textTheme
          //             .displayMedium!
          //             .copyWith(color: Colors.grey[600])),
          //     Icon(Icons.open_in_new, color: Colors.grey[600]),
          //   ],
          // )
