import 'package:flutter_screenutil/flutter_screenutil.dart';

extension ResponsiveFont on num {
  double rf({double max = 12}) {
    final scaled = sp;
    return scaled.clamp(
      toDouble(),
      toDouble() + max,
    );
  }
}
