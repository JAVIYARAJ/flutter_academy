import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../../core/constants/app_colors.dart';

/// Animated SVG-style progress ring that matches the HTML reference design.
/// Supports a track + indicator stroke with smooth fill animation.
class ProgressRing extends StatefulWidget {
  const ProgressRing({
    super.key,
    required this.progress,
    this.size = 160,
    this.strokeWidth = 10,
    this.trackColor = const Color(0xFFE7EEFF),
    this.label,
    this.sublabel,
    this.center,
  });

  /// 0.0 – 1.0
  final double progress;
  final double size;
  final double strokeWidth;
  final Color trackColor;

  /// Optional text inside the ring (e.g. "75%"). If null, [center] is used.
  final String? label;
  final String? sublabel;
  final Widget? center;

  @override
  State<ProgressRing> createState() => _ProgressRingState();
}

class _ProgressRingState extends State<ProgressRing>
    with SingleTickerProviderStateMixin {
  late AnimationController _ctrl;
  late Animation<double> _progressAnim;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _progressAnim = Tween<double>(begin: 0, end: widget.progress).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOutCubic),
    );
    _ctrl.forward();
  }

  @override
  void didUpdateWidget(ProgressRing oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.progress != widget.progress) {
      _progressAnim = Tween<double>(
        begin: _progressAnim.value,
        end: widget.progress,
      ).animate(CurvedAnimation(parent: _ctrl, curve: Curves.easeInOutCubic));
      _ctrl
        ..reset()
        ..forward();
    }
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          AnimatedBuilder(
            animation: _progressAnim,
            builder: (_, __) => CustomPaint(
              size: Size(widget.size, widget.size),
              painter: _RingPainter(
                progress: _progressAnim.value,
                strokeWidth: widget.strokeWidth,
                trackColor: widget.trackColor,
              ),
            ),
          ),
          if (widget.center != null)
            widget.center!
          else if (widget.label != null)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  widget.label!,
                  style: const TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: AppColors.onSurface,
                    height: 1,
                  ),
                ),
                if (widget.sublabel != null) ...[
                  const SizedBox(height: 2),
                  Text(
                    widget.sublabel!.toUpperCase(),
                    style: TextStyle(
                      fontFamily: 'Inter',
                      fontSize: 9,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.08 * 9,
                      color: AppColors.onSurfaceVariant,
                    ),
                  ),
                ],
              ],
            ),
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  _RingPainter({
    required this.progress,
    required this.strokeWidth,
    required this.trackColor,
  });

  final double progress;
  final double strokeWidth;
  final Color trackColor;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    // ── Track ────────────────────────────────────────────────────────────────
    final trackPaint = Paint()
      ..color = trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawCircle(center, radius, trackPaint);

    // ── Indicator ────────────────────────────────────────────────────────────
    final sweepAngle = 2 * math.pi * progress;
    const startAngle = -math.pi / 2; // top of circle

    final indicatorPaint = Paint()
      ..shader = LinearGradient(
        colors: [AppColors.primaryContainer, AppColors.secondaryFixedDim],
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      startAngle,
      sweepAngle,
      false,
      indicatorPaint,
    );
  }

  @override
  bool shouldRepaint(_RingPainter old) =>
      old.progress != progress ||
      old.strokeWidth != strokeWidth ||
      old.trackColor != trackColor;
}
