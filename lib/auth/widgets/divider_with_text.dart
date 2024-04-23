import 'package:flutter/material.dart';

class DividerWithText extends StatelessWidget {
  const DividerWithText({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Expanded(
            child: Divider(),
          ),
          SizedBox(width: 15),
          Text(
            'أو',
            style: TextStyle(
                fontSize: 16, fontWeight: FontWeight.w400, color: Colors.grey),
          ),
          SizedBox(width: 15),
          Expanded(
            child: Divider(),
          ),
        ],
      ),
    );
  }
}
