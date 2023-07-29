import 'package:flutter/cupertino.dart';

class Thermo extends ImplicitlyAnimatedWidget {
  const Thermo({
    super.key,
    super.curve,
    required this.color,
    required this.value,
    required super.duration,
    super.onEnd,
  });

  final Color color;
  final double value;

  @override
  AnimatedWidgetBaseState<Thermo> createState() => _ThermoState();
}

class _ThermoState extends AnimatedWidgetBaseState<Thermo> {
  ColorTween? _color;
  Tween<double>? _value;

  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: FittedBox(
        child: CustomPaint(
          size: const Size(18, 63),
          painter: _ThermoPainter(
            color: _color!.evaluate(animation)!,
            value: _value!.evaluate(animation),
          ),
        ),
      ),
    );
  }

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _color = visitor(_color, widget.color, (dynamic v) => ColorTween(begin: v)) as ColorTween?;
    _value = visitor(_value, widget.value, (dynamic v) => Tween<double>(begin: v)) as Tween<double>?;
  }
}

class _ThermoPainter extends CustomPainter {
  _ThermoPainter({
    required this.color,
    required this.value,
  });

  final Color color;
  final double value;

  @override
  void paint(Canvas canvas, Size size) {

    const bulbRadius = 6.0;
    const smallRadius = 3.0;
    const border = 1.0;
    final rect = (Offset.zero & size);
    final innerRect = rect.deflate(size.width / 2 - bulbRadius);
    final r1 = Alignment.bottomCenter.inscribe(const Size(2 * smallRadius, bulbRadius * 2), innerRect);
    final r2 = Alignment.center.inscribe(Size(2 * smallRadius, innerRect.height), innerRect);

    final bulb = Path()..addOval(Alignment.bottomCenter.inscribe(Size.square(innerRect.width), innerRect));
    final outerPath = Path()
      ..addOval(Alignment.bottomCenter.inscribe(Size.square(innerRect.width), innerRect).inflate(border))
      ..addRRect(RRect.fromRectAndRadius(r2, const Radius.circular(smallRadius)).inflate(border));

    final scaleRect = Rect.fromPoints(innerRect.topLeft, innerRect.bottomRight - const Offset(0, 2 * bulbRadius));
    Iterable<Offset> generatePoints() sync* {
      for (int i = 0; i < 11; i++) {
        final t = i / 10;
        final point = i.isOdd?
        Offset.lerp(scaleRect.bottomLeft, scaleRect.topLeft, t)! :
        Offset.lerp(scaleRect.bottomRight, scaleRect.topRight, t)!;
        yield point;
        yield point.translate(i.isOdd? 2 : -2, 0);
      }
    }

    final valueRect = Rect.lerp(r1, r2, value)!;
    final valuePaint = Paint()..color = color;

}

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}