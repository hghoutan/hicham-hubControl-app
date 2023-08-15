import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui' as ui;

class Thermometer extends StatefulWidget {
  const Thermometer({super.key});

  @override
  State<Thermometer> createState() => _ThermometerPainterState();
}

class _ThermometerPainterState extends State<Thermometer> {
   ui.Image? image;
  @override
  void initState() {
    loadImage("assets/images/scale.png");
    super.initState();
  }

  Future loadImage(String path) async{
    final data = await rootBundle.load(path);
    final bytes = data.buffer.asUint8List();
    final image = await decodeImageFromList(bytes);
    setState(() {
      this.image = image;
    });
  }
   @override
  Widget build(BuildContext context) {
    return CustomPaint(
        foregroundPainter: image != null ? ThermometerPainter(image!) : null
    );
  }
}
class ThermometerPainter extends CustomPainter{

  late final ui.Image image;
  ThermometerPainter( this.image);

  @override
  void paint(Canvas canvas, Size size) {

    //region paints
    final c1Paint = Paint()
      ..color =  Colors.black87;
    final c2Paint = Paint()
      ..color = const Color(0xffffffff);

    final circle1Paint = Paint()
      ..color = Colors.black87;

    final circle2Paint = Paint()
      ..color = const Color(0xffffffff);

    //endregion

    //region First Container coordinates
    var c1A = Offset(size.width * 1/6, 0);
    var c1B = Offset(size.width * 5/6, size.height * 4.5/5);
    //endregion

    //region Second Container coordinates
    var c2A = Offset(size.width * 1.5/6, size.height * 2/5);
    var c2B = Offset(size.width * 4.5/6, size.height * 4.5/5);
    //endregion


    //region circle coordinate
    final center = Offset(size.width * .5, (size.height * 1/5) * 4.45);
    //endregion


    final rect1 = Rect.fromPoints(c1A, c1B);
    final rect2 = Rect.fromPoints(c2A, c2B);


    canvas.drawRRect(RRect.fromRectAndCorners(rect1,topRight:Radius.circular((size.width * 4/6 ) * .5 ),topLeft: Radius.circular((size.width * 4/6 ) * .5)), c1Paint);
    canvas.drawCircle(center, size.width * 1/2, circle1Paint);
    canvas.drawRRect(RRect.fromRectAndCorners(rect2,topRight:Radius.circular((size.width * 3/6 ) * .5 ),topLeft: Radius.circular((size.width * 3/6 ) * .5)), c2Paint);
    canvas.drawCircle(center, size.width * .40, circle2Paint);


  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}