import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class DatePickerField extends StatefulWidget {
  const DatePickerField({
    super.key,
    required this.onDateChanged,
    this.textInputAction = TextInputAction.done,
    this.errorText,
  });

  final TextInputAction textInputAction;
  final ValueChanged<DateTime> onDateChanged;

  final String? errorText;

  @override
  State<DatePickerField> createState() => _DatePickerFieldState();
}

class _DatePickerFieldState extends State<DatePickerField> {
  final TextEditingController _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  DateTime? get _formattedDate {
    final date = DateFormat('MM/dd/yyyy').tryParse(_controller.text);

    if (date == null) return null;

    return date;
  }

  String _formatDate(DateTime date) => DateFormat('MM/dd/yyyy').format(date);

  void _showDatePicker(BuildContext context) {
    showDatePicker(
      context: context,
      initialDate: _formattedDate ?? DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    ).then((pickedDate) {
      if (pickedDate != null) {
        widget.onDateChanged(pickedDate);
        _controller.text = _formatDate(pickedDate);
      }
    });
  }

  void _onDateChanged(String value) {
    if (value.isEmpty) return;

    final date = DateFormat('MM/dd/yyyy').tryParse(value);

    if (date != null) {
      widget.onDateChanged(date);
    }
  }

  @override
  Widget build(BuildContext context) => TextField(
        decoration: InputDecoration(
          labelText: 'Date',
          hintText: 'mm/dd/yyyy',
          errorText: widget.errorText,
          suffixIcon: IconButton(
            icon: const Icon(Icons.calendar_today),
            color: Theme.of(context).primaryColor,
            onPressed: () => _showDatePicker(context),
          ),
        ),
        controller: _controller,
        keyboardType: TextInputType.datetime,
        textInputAction: widget.textInputAction,
        onChanged: _onDateChanged,
        inputFormatters: [
          FilteringTextInputFormatter.digitsOnly,
          LengthLimitingTextInputFormatter(8),
          _DateInputFormatter(),
        ],
      );
}

class _DateInputFormatter extends TextInputFormatter {
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

    // Add the separators
    if (formattedText.length > 2) {
      formattedText =
          '${formattedText.substring(0, 2)}/${formattedText.substring(2)}';
    }
    if (formattedText.length > 5) {
      formattedText =
          '${formattedText.substring(0, 5)}/${formattedText.substring(5)}';
    }

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(
        offset: formattedText.length,
      ),
    );
  }
}
