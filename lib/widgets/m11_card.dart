import 'package:flutter/material.dart';

class M11Card extends StatelessWidget {
  const M11Card({
    super.key,
    required this.child,
    this.removeWhiteShade = false,
  });
  final bool removeWhiteShade;

  final Widget child;
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color(0x40FFFFFF),
              gradient: const LinearGradient(
                colors: [
                  Color(0x3E67B18A),
                  Color(0x3E67B18A),
                  Color(0x3E22984E),
                ],
                stops: [0, 1, 1],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
              border: Border.all(color: Colors.white, width: 1.0),
              borderRadius: const BorderRadius.all(Radius.circular(10.0)),
              boxShadow: const [
                BoxShadow(color: Color(0x26000000), blurRadius: 10.0, offset: Offset(10, 10)),
                BoxShadow(color: Color(0xFFFFFFFF), blurRadius: 10.0, offset: Offset.zero),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              color: Color(0x7E1C8C4C),
              borderRadius: BorderRadius.all(Radius.circular(10.0)),
              boxShadow: [
                BoxShadow(color: Color(0x5B1C8C4C), blurRadius: 15.0, offset: Offset(0, 10), spreadRadius: 0.0),
              ],
            ),
          ),
          child,
        ],
      ),
    );
  }
}