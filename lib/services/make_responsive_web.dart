import 'package:flutter/material.dart';

class MakeResponsiveWeb extends StatelessWidget {
  final ImageProvider image;
  final Widget child;

  const MakeResponsiveWeb({
    Key? key,
    required this.image,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth > 600) {
          // Desktop layout
          return Row(
            children: [
              Expanded(
                child: DisplayImage(image: image),
              ),
              Expanded(
                child: Center(child: child),
              ),
            ],
          );
        } else {
          // Mobile layout
          return child;
        }
      },
    );
  }
}

class DisplayImage extends StatelessWidget {
  final ImageProvider image;

  const DisplayImage({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Spacer(),
        SizedBox(
          width: MediaQuery.of(context).size.width / 3,
          child: Material(
            elevation: 10,
            borderRadius: const BorderRadius.all(Radius.circular(10)),
            child: ClipRRect(
              borderRadius: const BorderRadius.all(Radius.circular(10)),
              child: Image(
                image: image,
                fit: BoxFit.cover,
                height: 400,
              ),
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}
