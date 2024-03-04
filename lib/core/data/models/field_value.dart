import 'package:equatable/equatable.dart';

class FieldValue<T> extends Equatable {
  final T value;
  final String? error;

  const FieldValue({required this.value, this.error});

  FieldValue<T> copyWithValue(T value) =>
      FieldValue(value: value, error: error);

  FieldValue<T> copyWithError(String? error) =>
      FieldValue(value: value, error: error);

  @override
  List<Object?> get props => [value, error];
}
