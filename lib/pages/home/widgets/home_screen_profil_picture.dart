import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/cubit/profil_picture_cubit.dart';
import 'package:todo/shared/screen_adaption.dart';

class HomeScreenProfilPicture extends StatelessWidget {
  const HomeScreenProfilPicture({Key? key, required this.onClick})
      : super(key: key);

  final VoidCallback onClick;

  @override
  Widget build(BuildContext context) {
    double radiusinPixel = 25;
    bool imageSlected;
    return BlocBuilder<ProfilPictureCubit, String>(
      builder: (context, imagePath) {
        if (imagePath != "") {
          imageSlected = true;
        } else {
          imageSlected = false;
        }
        return Align(
          alignment: Alignment.centerRight,
          child: GestureDetector(
            onTap: onClick,
            child: CircleAvatar(
                radius: radiusinPixel * sW(context),
                foregroundImage: imageSlected
                    ? AssetImage(imagePath)
                    : AssetImage("assets/img/img.jpg")),
          ),
        );
      },
    );
  }
}
