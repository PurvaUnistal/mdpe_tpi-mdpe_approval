import 'dart:io';

import 'package:flutter/material.dart';

import 'enlarge_widge.dart';
import 'res/app_color.dart';
import 'res/environment_config.dart';

class ImageWidget extends StatelessWidget {
  final File imgFile;
  final String title;
  final String? star;
  final void Function() onPressed;

  const ImageWidget({
    super.key,
    required this.imgFile,
    this.star,
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return InkWell(
      onTap: onPressed,
      child: Card(
        child: SizedBox(
          width: size.width * 0.23,
          height: size.height * 0.12,
          child: imgFile.existsSync()
              ? Stack(
            clipBehavior: Clip.none,
            children: [
              Image.file(
                imgFile,
                fit: BoxFit.fill,
                width: size.width * 0.23,
                height: size.height * 0.12,
              ),
              Align(
                alignment: Alignment.center,
                child: Icon(
                  Icons.refresh,
                  color: EnvironmentConfig.of(context)!.primaryTheme,
                ),
              ),
              Positioned(
                top: -15,
                right: -20,
                child: IconButton(
                  icon: Icon(Icons.zoom_out_map, color: EnvironmentConfig.of(context)!.primaryTheme,),
                  onPressed: () async {
                    await showModalBottomSheet(
                      context: context,
                      isScrollControlled: true,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.zero,
                        ),
                      ),
                      builder: (_) => EnlargeWidget(
                        text: title,
                        photoPath: imgFile,
                      ),
                    );
                  },
                ),
              ),
            ],
          )
              : Icon(
            Icons.photo_camera_back_outlined,
            color:  EnvironmentConfig.of(context)!.primaryTheme,
          ),
        ),
      ),
    );
  }
}
