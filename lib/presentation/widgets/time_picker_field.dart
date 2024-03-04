import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:notificator/core/data/models/time.dart';

class TimePickerField extends StatefulWidget {
  const TimePickerField({
    super.key,
    required this.onTimeChanged,
    this.textInputAction = TextInputAction.done,
    this.errorText,
  });

  final TextInputAction textInputAction;
  final ValueChanged<Time> onTimeChanged;

  final String? errorText;

  @override
  State<TimePickerField> createState() => _TimePickerFieldState();
}

class _TimePickerFieldState extends State<TimePickerField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  TimeOfDay? get _formattedTime {
    final date = DateFormat('hh:mm').tryParse(_controller.text);

    if (date == null) return null;

    return TimeOfDay.fromDateTime(date);
  }

  String _formatDate(TimeOfDay date) => DateFormat('hh:mm').format(
        DateTime.now().copyWith(hour: date.hour, minute: date.minute),
      );

  void _showTimePicker(BuildContext context) {
    showTimePicker(
      context: context,
      initialTime: _formattedTime ?? TimeOfDay.now(),
    ).then((pickedDate) {
      if (pickedDate != null) {
        widget.onTimeChanged(
          Time(hour: pickedDate.hour, minute: pickedDate.minute),
        );
        _controller.text = _formatDate(pickedDate);
      }
    });
  }

  void _onTimeChanged(String value) {
    if (value.isEmpty) return;

    final date = DateFormat('hh:mm').tryParse(value);

    if (date != null) {
      widget.onTimeChanged(Time(hour: date.hour, minute: date.minute));
    }
  }

  @override
  Widget build(BuildContext context) => TextField(
        decoration: InputDecoration(
          labelText: 'Time',
          hintText: 'hh:mm',
          errorText: widget.errorText,
          suffixIcon: IconButton(
            icon: const Icon(Icons.access_time_rounded),
            color: Theme.of(context).primaryColor,
            onPressed: () => _showTimePicker(context),
          ),
        ),
        controller: _controller,
        keyboardType: TextInputType.datetime,
        textInputAction: widget.textInputAction,
        onChanged: _onTimeChanged,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(4),
          _TimeInputFormatter(),
        ],
      );
}

class _TimeInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    // Save the previous cursor position
    final int beforeSelection = newValue.selection.start;

    // Remove any non-digits from the input
    String formattedText = newValue.text.replaceAll(RegExp(r'\D'), '');

    // Handle backspacing when deleting the separator
    if (beforeSelection > 1 && beforeSelection < formattedText.length) {
      formattedText = formattedText.substring(0, beforeSelection - 1) +
          formattedText.substring(beforeSelection);
    }

    // Add the separator
    if (formattedText.length > 2) {
      formattedText =
          '${formattedText.substring(0, 2)}:${formattedText.substring(2)}';
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(
        offset: formattedText.length,
      ),
    );
  }
}
