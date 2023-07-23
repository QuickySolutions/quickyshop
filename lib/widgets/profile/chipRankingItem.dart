import 'package:flutter/material.dart';

class ChipRankingItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
      decoration: BoxDecoration(
          color: Color.fromARGB(255, 200, 200, 200).withOpacity(0.2),
          borderRadius: BorderRadius.circular(20)),
      child: Row(
        children: [
          Image(
              height: 15,
              width: 15,
              image: AssetImage('assets/icons/usability/trophy.png')),
          SizedBox(width: 5),
          Text(
            'Categoría: #1',
            style: TextStyle(fontSize: 12),
          )
        ],
      ),
    );
  }
}
