import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void main() {
  runApp(MaterialApp(
    home: DatePickerPage(),
  ));
}

class DatePickerPage extends StatefulWidget {
  @override
  _DatePickerPageState createState() => _DatePickerPageState();
}

class _DatePickerPageState extends State<DatePickerPage> {
  late TextEditingController _tanggalController;
  late DateTime selectedDate;

  @override
  void initState() {
    super.initState();
    _tanggalController = TextEditingController();
    selectedDate = DateTime.now();
  }

  @override
  void dispose() {
    _tanggalController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2010),
      lastDate: DateTime(2101),
    );
    if (pickedDate != null && pickedDate != selectedDate) {
      setState(() {
        selectedDate = pickedDate;
        _tanggalController.text =
            DateFormat('dd MMMM yyyy').format(selectedDate);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Date Picker Page'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Selected Date:',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            TextFormField(
              controller: _tanggalController,
              onTap: () => _selectDate(context),
              readOnly: true,
              decoration: InputDecoration(
                hintText: 'Selected Date',
                border: OutlineInputBorder(),
                suffixIcon: IconButton(
                  onPressed: () => _selectDate(context),
                  icon: Icon(Icons.calendar_today),
                ),
              ),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Navigasi ke halaman lain dengan membawa data tanggal yang disubmit
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ShowDatePage(selectedDate: selectedDate),
                  ),
                );
              },
              child: Text('Submit'),
            ),
          ],
        ),
      ),
    );
  }
}

class ShowDatePage extends StatelessWidget {
  final DateTime selectedDate;

  const ShowDatePage({Key? key, required this.selectedDate}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Submitted Date'),
      ),
      body: Center(
        child: Text(
          'Selected Date: ${DateFormat('dd MMMM yyyy').format(selectedDate)}',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
