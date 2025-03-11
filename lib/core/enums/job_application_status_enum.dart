import 'package:flutter/material.dart';

enum JobApplicationStatusEnum {
  all,
  pending,
  accepted,
  rejected,
}

extension JobApplicationStatusEnumExtension on JobApplicationStatusEnum {
  String get value {
    switch (this) {
      case JobApplicationStatusEnum.all:
        return 'all';
      case JobApplicationStatusEnum.pending:
        return 'pending';
      case JobApplicationStatusEnum.accepted:
        return 'accepted';
      case JobApplicationStatusEnum.rejected:
        return 'rejected';
    }
  }

  Color get color {
    switch (this) {
      case JobApplicationStatusEnum.all:
        return Colors.grey;
      case JobApplicationStatusEnum.pending:
        return Colors.orange;
      case JobApplicationStatusEnum.accepted:
        return Colors.green;
      case JobApplicationStatusEnum.rejected:
        return Colors.red;
    }
  }
}
