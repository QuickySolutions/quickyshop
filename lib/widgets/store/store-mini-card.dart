import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickyshop/models/Store.dart';
import 'package:quickyshop/providers/app/appProvider.dart';

import '../../utils/Colors.dart';

class StoreMiniCard extends StatelessWidget {
  final bool isSelected;
  final bool showImage;
  final Store store;
  final void Function()? onTap;
  const StoreMiniCard(
      {super.key,
      required this.showImage,
      required this.onTap,
      this.isSelected = false,
      required this.store});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: MediaQuery.of(context).size.width,
        padding: EdgeInsets.all(10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
            boxShadow: [
              isSelected
                  ? BoxShadow(
                      color: QuickyColors.primaryColor,
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 1),
                    )
                  : BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 1),
                    )
            ]),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            showImage
                ? Container(
                    width: MediaQuery.of(context).size.width * 0.25,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image(
                          height: 100,
                          width: 100,
                          fit: BoxFit.cover,
                          image: NetworkImage(store.photo)),
                    ),
                  )
                : Container(),
            SizedBox(width: 5),
            Expanded(
              child: Container(
                padding: EdgeInsets.only(top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      store.name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(fontWeight: FontWeight.w700),
                    ),
                    SizedBox(height: 10),
                    Text(
                      store.category,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
