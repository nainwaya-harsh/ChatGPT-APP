import 'package:chatgpt_integration/widgets/drop_down.dart';
import 'package:flutter/material.dart';

import '../constants/constants.dart';
import '../widgets/text_widget.dart';

class Services {
  static Future<void> showModalSheet({required BuildContext context}) async {
    await showModalBottomSheet(
        backgroundColor: scaffoldBackgroundColor,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(20), topRight: Radius.circular(20))),
        context: context,
        builder: (context) {
          return Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Flexible(
                    child: TextWidget(
                  label: "Chosen Model",
                  fontSize: 17,
                )),
                Flexible(child: ModelsDropDownWidget())
              ],
            ),
          );
        });
  }
}
