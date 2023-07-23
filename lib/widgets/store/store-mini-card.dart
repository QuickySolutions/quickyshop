import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quickyshop/models/Store.dart';
import 'package:quickyshop/providers/app/appProvider.dart';

import '../../utils/Colors.dart';

class StoreMiniCard extends StatelessWidget {
  final bool isSelected;
  final Store store;
  const StoreMiniCard(
      {super.key, this.isSelected = false, required this.store});

  @override
  Widget build(BuildContext context) {
    final appProvider = Provider.of<AppProvider>(context);
    return GestureDetector(
      onTap: () {
        appProvider.selectStore(store);
      },
      child: Container(
        padding: EdgeInsets.all(10),
        width: 280,
        margin: EdgeInsets.only(right: 20),
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
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image(
                  height: double.infinity,
                  width: 100,
                  fit: BoxFit.cover,
                  image: NetworkImage(store.photo)),
            ),
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
