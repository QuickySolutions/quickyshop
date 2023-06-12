import 'package:flutter/material.dart';

class ButtonLeadButton extends StatelessWidget {
  const ButtonLeadButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width * 0.90,
        child: Stack(
          children: [
            Positioned(
              child: Container(
                margin: EdgeInsets.only(top: 10, bottom: 10),
                height: 65,
                width: double.infinity,
                child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      elevation: 0,
                      backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        side: BorderSide(color: Colors.black),
                        borderRadius: BorderRadius.circular(100),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, '/home');
                    },
                    child: Text(
                      'Agregar tienda',
                      style: TextStyle(
                          fontSize: 17,
                          color: Colors.black,
                          fontWeight: FontWeight.w500),
                    )),
              ),
            ),
            Positioned(
                left: -15,
                top: 0,
                bottom: 0,
                child: Image(
                    fit: BoxFit.cover,
                    height: 100,
                    width: 100,
                    image:
                        AssetImage('assets/icons/usability/buttonplus.png'))),
          ],
        ));
  }
}
