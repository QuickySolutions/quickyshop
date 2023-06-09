import 'dart:io';

import 'package:flutter/material.dart';
// import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../providers/photo/photo_provider.dart';
import '../../providers/store/store_provider.dart';
import '../../utils/Colors.dart';
import '../../utils/general_methods.dart';

class ProfileUser extends StatefulWidget {
  final double? height;
  final double? width;
  final void Function()? onTap;
  final bool? showAddButton;
  final bool? showCloseSession;
  final bool? editPicture;
  final void Function()? onClose;

  const ProfileUser(
      {super.key,
      this.height = 60,
      this.onClose,
      this.width = 60,
      this.editPicture = false,
      this.onTap,
      this.showCloseSession = false,
      this.showAddButton = false});

  @override
  State<ProfileUser> createState() => _ProfileUserState();
}

class _ProfileUserState extends State<ProfileUser> {
  late File imageFile;
  bool pickedImage = false;

  /// Get from gallery
  // _getFromGallery() async {
  //   final providerPhoto = Provider.of<PhotoProvider>(context, listen: false);
  //   PickedFile? pickedFile = await ImagePicker().getImage(
  //     source: ImageSource.gallery,
  //     maxWidth: 1800,
  //     maxHeight: 1800,
  //   );
  //   if (pickedFile != null) {
  //     providerPhoto.setImage(File(pickedFile.path));
  //     providerPhoto.setPicketPicture(true);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final photoProvider = Provider.of<PhotoProvider>(context);
    final storeProvider = Provider.of<StoreProvider>(context);
    return GestureDetector(
      onTap: widget.onTap,
      child: Container(
          child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            height: (widget.height! + 10),
            width: (widget.width! + 10),
            child: CircularProgressIndicator(
              backgroundColor: QuickyColors.greyColor,
              strokeWidth: 3,
              color: QuickyColors.primaryColor,
              value: .30,
            ),
          ),
          ClipRRect(
            borderRadius: BorderRadius.all(Radius.circular(100)),
            child: widget.editPicture! && photoProvider.pickedPicture
                ? Image.file(
                    photoProvider.photo!,
                    width: widget.width,
                    height: widget.height,
                    fit: BoxFit.cover,
                  )
                : Image(
                    width: widget.width,
                    height: widget.height,
                    fit: BoxFit.cover,
                    image: getProfile(storeProvider)),
          ),
          !widget.editPicture! && widget.showAddButton!
              ? Positioned(
                  bottom: 0,
                  right: 0,
                  child: Image(
                    height: 30,
                    width: 30,
                    image: AssetImage('assets/icons/usability/plusButton.png'),
                  ),
                )
              : Container(),
          widget.editPicture!
              ? Positioned(
                  bottom: 0,
                  right: 5,
                  child: GestureDetector(
                    onTap: () {
                      //_getFromGallery();
                    },
                    child: CircleAvatar(
                      radius: 15,
                      backgroundColor: QuickyColors.primaryColor,
                      child: Icon(
                        Icons.edit,
                        color: Colors.white,
                        size: 15,
                      ),
                    ),
                  ))
              : Container(),
          widget.showCloseSession!
              ? Positioned(
                  top: 0,
                  right: 0,
                  child: GestureDetector(
                    onTap: () => {
                      Navigator.pushNamedAndRemoveUntil(
                          context, "/principal", (r) => false)
                    },
                    child: Image(
                      height: 35,
                      width: 35,
                      image: AssetImage(
                          'assets/icons/usability/exitAppCircular.png'),
                    ),
                  ),
                )
              : Container()
        ],
      )),
    );
  }
}
