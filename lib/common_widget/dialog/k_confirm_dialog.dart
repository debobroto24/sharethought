
import 'package:flutter/material.dart';
import 'package:sharethought/styles/ktext_style.dart';
import 'package:sharethought/styles/kcolor.dart';

import '../button/k_border-btn.dart';
import '../button/k_button.dart';
class KConfirmDialog extends StatelessWidget {
  final String? message;
  final String? subMessage;
  final VoidCallback? onDelete;
  final VoidCallback? onCancel;

  const KConfirmDialog({this.subMessage, this.message, this.onDelete, this.onCancel, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print("inside k confirm");
    return Dialog(
      backgroundColor: Kcolor.appBackground,
      insetPadding: const EdgeInsets.all(8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
      child: SizedBox(
        height: 250,
        width: double.infinity,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '$message',
                  style: ktextStyle.font18(Kcolor.blackbg), 
                  // style: KtextStyle.copyWith(color: .blackbg),
                ),
                const SizedBox(height: 16),
                Text(
                  '$subMessage',
                  style: ktextStyle.font20(Kcolor.blackbg..withOpacity(0.6))
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                Row(
                  children: [
                    Flexible(
                      child: KBorderButton(title: 'Cancel', onTap: onCancel),
                    ),
                    const SizedBox(width: 16),
                    Flexible(
                      child: KButton(
                        title: 'Delete',
                        onTap: onDelete,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
