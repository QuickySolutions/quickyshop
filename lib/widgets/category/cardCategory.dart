import 'package:flutter/material.dart';

import '../../utils/Colors.dart';

class CategoryItem extends StatelessWidget {
  final String image;
  final String text;
  final void Function()? onTap;
  final bool? selected;
  const CategoryItem(
      {super.key,
      required this.image,
      required this.text,
      this.selected = false,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 140,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          decoration: BoxDecoration(
            border: selected!
                ? Border.all(color: QuickyColors.primaryColor, width: 3)
                : Border.all(width: 0, color: Colors.transparent),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.2),
                spreadRadius: 2,
                blurRadius: 2,
                offset: Offset(0, 3), // changes position of shadow
              ),
            ],
            color: Colors.white,
          ),
          child: Column(
            children: [
              ClipRRect(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                  child: Image(
                    errorBuilder: (context, error, stackTrace) {
                      return Image(
                          image: AssetImage('assets/images/not-available.png'));
                    },
                    height: 90,
                    fit: BoxFit.cover,
                    image: NetworkImage(image),
                  )),
              SizedBox(height: 10),
              Text(text,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      overflow: TextOverflow.ellipsis))
            ],
          ),
        ),
      ),
    );
  }
}
