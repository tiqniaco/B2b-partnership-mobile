import '/core/enums/alarm_repetition_type_enum.dart';
import '/core/enums/alarm_status_enum.dart';
import 'package:equatable/equatable.dart';

class AlarmModel extends Equatable {
  final int id;
  final String title;
  final String description;
  final AlarmStatusEnum status;
  final String date;
  final String weekday;
  final String time;
  final int numberPerTime;
  final AlarmRepetitionTypeEnum type;

  const AlarmModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.date,
    required this.weekday,
    required this.time,
    required this.numberPerTime,
    required this.type,
  });

  factory AlarmModel.fromMap(Map<String, dynamic> map) {
    return AlarmModel(
      id: map['id'] as int,
      title: map['title'] as String,
      description: map['description'] as String,
      status: AlarmStatusEnum.values.firstWhere(
        (e) => e.name == map['status'],
      ),
      date: map['date'] as String,
      weekday: map['weekday'] as String,
      time: map['time'] as String,
      numberPerTime: map['numberPerTime'] as int,
      type: AlarmRepetitionTypeEnum.values.firstWhere(
        (e) => e.name == map['type'],
      ),
    );
  }

  AlarmModel copyWith({
    int? id,
    String? title,
    String? description,
    AlarmStatusEnum? status,
    String? date,
    String? time,
    int? numberPerTime,
    AlarmRepetitionTypeEnum? type,
  }) {
    return AlarmModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      date: date ?? this.date,
      weekday: date ?? weekday,
      time: time ?? this.time,
      numberPerTime: numberPerTime ?? this.numberPerTime,
      type: type ?? this.type,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status.name,
      'date': date,
      'weekday': weekday,
      'time': time,
      'numberPerTime': numberPerTime,
      'type': type.name,
    };
  }

  @override
  List<Object?> get props => [
        id,
        title,
        description,
        date,
        weekday,
        time,
        numberPerTime,
        type,
      ];
}
