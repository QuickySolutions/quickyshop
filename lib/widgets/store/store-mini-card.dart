import 'package:flutter/material.dart';

import '../../utils/Colors.dart';

class StoreMiniCard extends StatelessWidget {
  final bool isSelected;
  const StoreMiniCard({super.key, this.isSelected = false});

  @override
  Widget build(BuildContext context) {
    int completeSize = 70;
    return Container(
      width: 100,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            isSelected
                ? BoxShadow(
                    color: Colors.grey.withOpacity(0.5), //color of shadow
                    spreadRadius: 2, //spread radius
                    blurRadius: 2, // blur radius
                    offset: Offset(0, 1), // changes position of shadow
                    //first paramerter of offset is left-right
                    //second parameter is top to down
                  )
                : BoxShadow()
          ]),
      margin: EdgeInsets.only(right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(alignment: Alignment.center, children: [
            SizedBox(
              height: (completeSize + 10),
              width: (completeSize + 10),
              child: CircularProgressIndicator(
                backgroundColor: QuickyColors.greyColor,
                strokeWidth: 3,
                color: QuickyColors.primaryColor,
                value: .30,
              ),
            ),
            ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(100)),
                child: Image(
                  height: completeSize.toDouble(),
                  width: completeSize.toDouble(),
                  fit: BoxFit.cover,
                  image: NetworkImage(
                      'https://cnnespanol.cnn.com/wp-content/uploads/2022/09/220912105429-01-burger-king-signs-021522-file-full-169.jpg?quality=100&strip=info'),
                )),
          ]),
          SizedBox(height: 10),
          Text(
            'LGV',
            style: TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }
}
