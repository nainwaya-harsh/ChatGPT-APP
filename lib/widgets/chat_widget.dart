import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:chatgpt_integration/constants/constants.dart';
import 'package:chatgpt_integration/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ChatWidget extends StatelessWidget {
  const ChatWidget({super.key, required this.msg, required this.chatIndex});

  final String msg;
  final int chatIndex;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          color: chatIndex == 0 ? scaffoldBackgroundColor : cardColor,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  chatIndex == 0
                      ? 'assets/images/person.png'
                      : 'assets/images/chatgpt.png',
                  height: 30,
                  width: 30,
                ),
                SizedBox(
                  width: 8,
                ),
                Expanded(child:chatIndex==0? TextWidget(label: msg):DefaultTextStyle(style: TextStyle(
        color:  Colors.white,
        fontSize: 18,
        fontWeight: FontWeight.w400,
      ),child: AnimatedTextKit(isRepeatingAnimation: false,repeatForever: false,displayFullTextOnTap: true,totalRepeatCount: 1,animatedTexts: [TyperAnimatedText(msg.trim())]))),
                chatIndex == 0
                    ? const SizedBox.shrink()
                    : Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Icon(
                            Icons.thumb_up_alt_outlined,
                            color: Colors.white,
                          ),
                          Icon(
                            Icons.thumb_down_alt_outlined,
                            color: Colors.white,
                          )
                        ],
                      )
              ],
            ),
          ),
        )
      ],
    );
  }
}
