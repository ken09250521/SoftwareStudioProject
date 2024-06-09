library event_calendar;

import 'dart:math';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';
import 'bottom_bar.dart';
import 'theme_setting_page.dart';
import 'add_task.dart';
import 'theme_setting_page.dart';
import 'start_page.dart';



part 'color-picker.dart';

part 'timezone-picker.dart';

part 'appointment-editor.dart';

void main() => runApp(
  ChangeNotifierProvider(
    create: (context) => ThemeModel(),
    child: Consumer<ThemeModel>(
      builder: (context, themeModel, child) {
        return MaterialApp(
          
          theme: themeModel.currentTheme,
          home: const StartPage(),
        );
      }
    ),
  )
);

//ignore: must_be_immutable
class EventCalendar extends StatefulWidget {
  const EventCalendar({Key? key}) : super(key: key);

  @override
  EventCalendarState createState() => EventCalendarState();
}

List<Color> _colorCollection = <Color>[];
List<String> _colorNames = <String>[];
int _selectedColorIndex = 0;
int _selectedTimeZoneIndex = 0;
List<String> _timeZoneCollection = <String>[];
late DataSource _events;
Meeting? _selectedAppointment;
late DateTime _startDate;
late TimeOfDay _startTime;
late DateTime _endDate;
late TimeOfDay _endTime;
bool _isAllDay = false;
String _subject = '';
String _notes = '';

class EventCalendarState extends State<EventCalendar> {
  EventCalendarState();
  late List<String> eventNameCollection;
  late List<Meeting> appointments;
  CalendarController calendarController = CalendarController();

  @override
  void initState() {
    appointments = getMeetingDetails();
    _events = DataSource(appointments);
    _selectedAppointment = null;
    _selectedColorIndex = 0;
    _selectedTimeZoneIndex = 0;
    _subject = '';
    _notes = '';
    super.initState();
  }

  void _addObject(BuildContext context) {

    showModalBottomSheet(
      context: context,
      isScrollControlled: true, 
      builder: (context) => AddTask(),
      );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,

        body: Padding(
            padding: const EdgeInsets.fromLTRB(5, 40, 5, 5),
            child: getEventCalendar(_events, onCalendarTapped)
        ),
        floatingActionButton: Container(
          height: 70.0,
          width: 70.0,
          child: FloatingActionButton(
            foregroundColor: Theme.of(context).colorScheme.onSecondary, 
            backgroundColor: Theme.of(context).colorScheme.secondary,
            shape: const CircleBorder(),
            onPressed: () => _addObject(context),
            child: const Icon(Icons.add_outlined),
          ),
        ),
        bottomNavigationBar: null,
        bottomSheet: BottomBar(),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  SfCalendar getEventCalendar(
      CalendarDataSource _calendarDataSource,
      CalendarTapCallback calendarTapCallback) {
    return SfCalendar(
        view: CalendarView.week,
        controller: calendarController,
        allowedViews: const [CalendarView.week, CalendarView.timelineWeek, CalendarView.month],
        dataSource: _calendarDataSource,
        onTap: calendarTapCallback,
        appointmentBuilder: (context, calendarAppointmentDetails) {
          final Meeting meeting =
              calendarAppointmentDetails.appointments.first;
          return Container(
            color: meeting.background.withOpacity(0.8),
            child: Padding(
              padding: const EdgeInsets.all(4.0),
              child: Text(
                meeting.eventName,
                textAlign: TextAlign.center,
                style: 
                GoogleFonts.openSans(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
            ),
          );
        },
        initialDisplayDate: DateTime(DateTime.now().year, DateTime.now().month,
            DateTime.now().day, 0, 0, 0),
        monthViewSettings: const MonthViewSettings(
            appointmentDisplayMode: MonthAppointmentDisplayMode.appointment),
        timeSlotViewSettings: const TimeSlotViewSettings(
            minimumAppointmentDuration: Duration(minutes: 60)));
  }

  void onCalendarTapped(CalendarTapDetails calendarTapDetails) {
    if (calendarTapDetails.targetElement != CalendarElement.calendarCell &&
        calendarTapDetails.targetElement != CalendarElement.appointment) {
      return;
    }

    setState(() {
      _selectedAppointment = null;
      _isAllDay = false;
      _selectedColorIndex = 0;
      _selectedTimeZoneIndex = 0;
      _subject = '';
      _notes = '';
      if (calendarController.view == CalendarView.month) {
        calendarController.view = CalendarView.day;
      } else {
        if (calendarTapDetails.appointments != null &&
            calendarTapDetails.appointments!.length == 1) {
          final Meeting meetingDetails = calendarTapDetails.appointments![0];
          _startDate = meetingDetails.from;
          _endDate = meetingDetails.to;
          _isAllDay = meetingDetails.isAllDay;
          _selectedColorIndex =
              _colorCollection.indexOf(meetingDetails.background);
          _selectedTimeZoneIndex = meetingDetails.startTimeZone == ''
              ? 0
              : _timeZoneCollection.indexOf(meetingDetails.startTimeZone);
          _subject = meetingDetails.eventName == '(No title)'
              ? ''
              : meetingDetails.eventName;
          _notes = meetingDetails.description;
          _selectedAppointment = meetingDetails;
        } else {
          final DateTime date = calendarTapDetails.date!;
          _startDate = date;
          _endDate = date.add(const Duration(hours: 1));
        }
        _startTime =
            TimeOfDay(hour: _startDate.hour, minute: _startDate.minute);
        _endTime = TimeOfDay(hour: _endDate.hour, minute: _endDate.minute);

        if (_subject == 'AI Suggestion') {
          Navigator.push<Widget>(
          context,
          MaterialPageRoute(
              builder: (BuildContext context) => AppointmentEditor()),
          );
        }
      }
    });
  }

  List<Meeting> getMeetingDetails() {
    final List<Meeting> meetingCollection = <Meeting>[];
    eventNameCollection = <String>[];
    eventNameCollection.add('Computer Architecture');
    eventNameCollection.add('Data Structure');
    eventNameCollection.add('Software Studio');
    eventNameCollection.add('Probability');
    eventNameCollection.add('Table tennis');
    eventNameCollection.add('European Governments and Politics');
    eventNameCollection.add('How to learn and think history');
    eventNameCollection.add('Default study time');
    eventNameCollection.add('Default relax time');
    eventNameCollection.add('Additional task time');
    eventNameCollection.add('AI Suggestion');

    _colorCollection = <Color>[];
    _colorCollection.add(const Color(0xFF0F8644));
    _colorCollection.add(const Color(0xFF8B1FA9));
    _colorCollection.add(const Color(0xFFD20100));
    _colorCollection.add(const Color(0xFFFC571D));
    _colorCollection.add(const Color(0xFF85461E));
    //_colorCollection.add(const Color(0xFFFF00FF));
    _colorCollection.add(const Color(0xFF3D4FB5));
    _colorCollection.add(const Color(0xFFE47C73));
    _colorCollection.add(const Color(0xFF636363));
    _colorCollection.add(const Color.fromARGB(255, 255, 196, 35));
    _colorCollection.add(const Color.fromARGB(1, 129, 129, 129));

    _colorNames = <String>[];
    _colorNames.add('Green');
    _colorNames.add('Purple');
    _colorNames.add('Red');
    _colorNames.add('Orange');
    _colorNames.add('Caramel');
    //_colorNames.add('Magenta');
    _colorNames.add('Blue');
    _colorNames.add('Peach');
    _colorNames.add('Gray');
    _colorNames.add('Pale green');
    _colorNames.add('translucent gray');

    _timeZoneCollection = <String>[];
    _timeZoneCollection.add('Default Time');
    _timeZoneCollection.add('AUS Central Standard Time');
    _timeZoneCollection.add('AUS Eastern Standard Time');
    _timeZoneCollection.add('Afghanistan Standard Time');
    _timeZoneCollection.add('Alaskan Standard Time');
    _timeZoneCollection.add('Arab Standard Time');
    _timeZoneCollection.add('Arabian Standard Time');
    _timeZoneCollection.add('Arabic Standard Time');
    _timeZoneCollection.add('Argentina Standard Time');
    _timeZoneCollection.add('Atlantic Standard Time');
    _timeZoneCollection.add('Azerbaijan Standard Time');
    _timeZoneCollection.add('Azores Standard Time');
    _timeZoneCollection.add('Bahia Standard Time');
    _timeZoneCollection.add('Bangladesh Standard Time');
    _timeZoneCollection.add('Belarus Standard Time');
    _timeZoneCollection.add('Canada Central Standard Time');
    _timeZoneCollection.add('Cape Verde Standard Time');
    _timeZoneCollection.add('Caucasus Standard Time');
    _timeZoneCollection.add('Cen. Australia Standard Time');
    _timeZoneCollection.add('Central America Standard Time');
    _timeZoneCollection.add('Central Asia Standard Time');
    _timeZoneCollection.add('Central Brazilian Standard Time');
    _timeZoneCollection.add('Central Europe Standard Time');
    _timeZoneCollection.add('Central European Standard Time');
    _timeZoneCollection.add('Central Pacific Standard Time');
    _timeZoneCollection.add('Central Standard Time');
    _timeZoneCollection.add('China Standard Time');
    _timeZoneCollection.add('Dateline Standard Time');
    _timeZoneCollection.add('E. Africa Standard Time');
    _timeZoneCollection.add('E. Australia Standard Time');
    _timeZoneCollection.add('E. South America Standard Time');
    _timeZoneCollection.add('Eastern Standard Time');
    _timeZoneCollection.add('Egypt Standard Time');
    _timeZoneCollection.add('Ekaterinburg Standard Time');
    _timeZoneCollection.add('FLE Standard Time');
    _timeZoneCollection.add('Fiji Standard Time');
    _timeZoneCollection.add('GMT Standard Time');
    _timeZoneCollection.add('GTB Standard Time');
    _timeZoneCollection.add('Georgian Standard Time');
    _timeZoneCollection.add('Greenland Standard Time');
    _timeZoneCollection.add('Greenwich Standard Time');
    _timeZoneCollection.add('Hawaiian Standard Time');
    _timeZoneCollection.add('India Standard Time');
    _timeZoneCollection.add('Iran Standard Time');
    _timeZoneCollection.add('Israel Standard Time');
    _timeZoneCollection.add('Jordan Standard Time');
    _timeZoneCollection.add('Kaliningrad Standard Time');
    _timeZoneCollection.add('Korea Standard Time');
    _timeZoneCollection.add('Libya Standard Time');
    _timeZoneCollection.add('Line Islands Standard Time');
    _timeZoneCollection.add('Magadan Standard Time');
    _timeZoneCollection.add('Mauritius Standard Time');
    _timeZoneCollection.add('Middle East Standard Time');
    _timeZoneCollection.add('Montevideo Standard Time');
    _timeZoneCollection.add('Morocco Standard Time');
    _timeZoneCollection.add('Mountain Standard Time');
    _timeZoneCollection.add('Mountain Standard Time (Mexico)');
    _timeZoneCollection.add('Myanmar Standard Time');
    _timeZoneCollection.add('N. Central Asia Standard Time');
    _timeZoneCollection.add('Namibia Standard Time');
    _timeZoneCollection.add('Nepal Standard Time');
    _timeZoneCollection.add('New Zealand Standard Time');
    _timeZoneCollection.add('Newfoundland Standard Time');
    _timeZoneCollection.add('North Asia East Standard Time');
    _timeZoneCollection.add('North Asia Standard Time');
    _timeZoneCollection.add('Pacific SA Standard Time');
    _timeZoneCollection.add('Pacific Standard Time');
    _timeZoneCollection.add('Pacific Standard Time (Mexico)');
    _timeZoneCollection.add('Pakistan Standard Time');
    _timeZoneCollection.add('Paraguay Standard Time');
    _timeZoneCollection.add('Romance Standard Time');
    _timeZoneCollection.add('Russia Time Zone 10');
    _timeZoneCollection.add('Russia Time Zone 11');
    _timeZoneCollection.add('Russia Time Zone 3');
    _timeZoneCollection.add('Russian Standard Time');
    _timeZoneCollection.add('SA Eastern Standard Time');
    _timeZoneCollection.add('SA Pacific Standard Time');
    _timeZoneCollection.add('SA Western Standard Time');
    _timeZoneCollection.add('SE Asia Standard Time');
    _timeZoneCollection.add('Samoa Standard Time');
    _timeZoneCollection.add('Singapore Standard Time');
    _timeZoneCollection.add('South Africa Standard Time');
    _timeZoneCollection.add('Sri Lanka Standard Time');
    _timeZoneCollection.add('Syria Standard Time');
    _timeZoneCollection.add('Taipei Standard Time');
    _timeZoneCollection.add('Tasmania Standard Time');
    _timeZoneCollection.add('Tokyo Standard Time');
    _timeZoneCollection.add('Tonga Standard Time');
    _timeZoneCollection.add('Turkey Standard Time');
    _timeZoneCollection.add('US Eastern Standard Time');
    _timeZoneCollection.add('US Mountain Standard Time');
    _timeZoneCollection.add('UTC');
    _timeZoneCollection.add('UTC+12');
    _timeZoneCollection.add('UTC-02');
    _timeZoneCollection.add('UTC-11');
    _timeZoneCollection.add('Ulaanbaatar Standard Time');
    _timeZoneCollection.add('Venezuela Standard Time');
    _timeZoneCollection.add('Vladivostok Standard Time');
    _timeZoneCollection.add('W. Australia Standard Time');
    _timeZoneCollection.add('W. Central Africa Standard Time');
    _timeZoneCollection.add('W. Europe Standard Time');
    _timeZoneCollection.add('West Asia Standard Time');
    _timeZoneCollection.add('West Pacific Standard Time');
    _timeZoneCollection.add('Yakutsk Standard Time');

    //final DateTime today = DateTime.now();
    //final Random random = Random();


    // computer architecture
    meetingCollection.add(Meeting(from: DateTime(2024, 4, 9, 10, 10), to: DateTime(2024, 4, 9, 12, 0), background: _colorCollection[5], 
      startTimeZone: '', endTimeZone: '', description: '', isAllDay: false, eventName: eventNameCollection[0]));
    meetingCollection.add(Meeting(from: DateTime(2024, 4, 11, 10, 10), to: DateTime(2024, 4, 11, 12, 0), background: _colorCollection[5], 
      startTimeZone: '', endTimeZone: '', description: '', isAllDay: false, eventName: eventNameCollection[0]));

    // data structure
    meetingCollection.add(Meeting(from: DateTime(2024, 4, 8, 10, 10), to: DateTime(2024, 4, 8, 12, 0), background: _colorCollection[5], 
      startTimeZone: '', endTimeZone: '', description: '', isAllDay: false, eventName: eventNameCollection[1]));
    meetingCollection.add(Meeting(from: DateTime(2024, 4, 8, 18, 30), to: DateTime(2024, 4, 8, 20, 20), background: _colorCollection[5], 
      startTimeZone: '', endTimeZone: '', description: '', isAllDay: false, eventName: eventNameCollection[1]));
    meetingCollection.add(Meeting(from: DateTime(2024, 4, 10, 9, 0), to: DateTime(2024, 4, 10, 9, 50), background: _colorCollection[5], 
      startTimeZone: '', endTimeZone: '', description: '', isAllDay: false, eventName: eventNameCollection[1]));

    // probability
    meetingCollection.add(Meeting(from: DateTime(2024, 4, 10, 10, 10), to: DateTime(2024, 4, 10, 12, 0), background: _colorCollection[5], 
      startTimeZone: '', endTimeZone: '', description: '', isAllDay: false, eventName: eventNameCollection[3]));
    meetingCollection.add(Meeting(from: DateTime(2024, 4, 12, 10, 10), to: DateTime(2024, 4, 12, 11, 0), background: _colorCollection[5], 
      startTimeZone: '', endTimeZone: '', description: '', isAllDay: false, eventName: eventNameCollection[3]));

    // software studio
    meetingCollection.add(Meeting(from: DateTime(2024, 4, 9, 15, 30), to: DateTime(2024, 4, 9, 17, 20), background: _colorCollection[5], 
      startTimeZone: '', endTimeZone: '', description: '', isAllDay: false, eventName: eventNameCollection[2]));
    meetingCollection.add(Meeting(from: DateTime(2024, 4, 11, 15, 30), to: DateTime(2024, 4, 11, 17, 20), background: _colorCollection[5], 
      startTimeZone: '', endTimeZone: '', description: '', isAllDay: false, eventName: eventNameCollection[2]));

    // table tennis
    meetingCollection.add(Meeting(from: DateTime(2024, 4, 9, 8, 0), to: DateTime(2024, 4, 9, 9, 50), background: _colorCollection[5], 
      startTimeZone: '', endTimeZone: '', description: '', isAllDay: false, eventName: eventNameCollection[4]));

    // ge
    meetingCollection.add(Meeting(from: DateTime(2024, 4, 8, 13, 20), to: DateTime(2024, 4, 8, 15, 10), background: _colorCollection[5], 
      startTimeZone: '', endTimeZone: '', description: '', isAllDay: false, eventName: eventNameCollection[5]));
    meetingCollection.add(Meeting(from: DateTime(2024, 4, 10, 15, 30), to: DateTime(2024, 4, 10, 17, 20), background: _colorCollection[5], 
      startTimeZone: '', endTimeZone: '', description: '', isAllDay: false, eventName: eventNameCollection[6]));
    
    // default relax time
    for (int day = 0; day <= 6; day++) {
      meetingCollection.add(Meeting(from: DateTime(2024, 4, 7+day, 12, 0), to: DateTime(2024, 4, 7+day, 13, 10), background: _colorCollection[8], 
      startTimeZone: '', endTimeZone: '', description: '', isAllDay: false, eventName: eventNameCollection[8])); 
      meetingCollection.add(Meeting(from: DateTime(2024, 4, 7+day, 17, 20), to: DateTime(2024, 4, 7+day, 18, 20), background: _colorCollection[8], 
      startTimeZone: '', endTimeZone: '', description: '', isAllDay: false, eventName: eventNameCollection[8]));  
    }
    // default study time
    meetingCollection.add(Meeting(from: DateTime(2024, 4, 8, 15, 30), to: DateTime(2024, 4, 8, 17, 0), background: _colorCollection[0], 
      startTimeZone: '', endTimeZone: '', description: '', isAllDay: false, eventName: eventNameCollection[7]));
    meetingCollection.add(Meeting(from: DateTime(2024, 4, 11, 13, 10), to: DateTime(2024, 4, 11, 15, 10), background: _colorCollection[0], 
      startTimeZone: '', endTimeZone: '', description: '', isAllDay: false, eventName: eventNameCollection[7]));

    //AI suggestion
    meetingCollection.add(Meeting(from: DateTime(2024, 4, 7, 13, 20), to: DateTime(2024, 4, 7, 17, 20), background: _colorCollection[9], 
      startTimeZone: '', endTimeZone: '', description: '', isAllDay: false, eventName: eventNameCollection[10]));
    meetingCollection.add(Meeting(from: DateTime(2024, 4, 12, 14, 0), to: DateTime(2024, 4, 12, 17, 0), background: _colorCollection[9], 
      startTimeZone: '', endTimeZone: '', description: '', isAllDay: false, eventName: eventNameCollection[10]));
    meetingCollection.add(Meeting(from: DateTime(2024, 4, 13, 13, 20), to: DateTime(2024, 4, 13, 17, 20), background: _colorCollection[9], 
      startTimeZone: '', endTimeZone: '', description: '', isAllDay: false, eventName: eventNameCollection[10]));


    /*
    for (int month = -1; month < 2; month++) {
      for (int day = -5; day < 5; day++) {
        for (int hour = 9; hour < 18; hour += 5) {
          meetingCollection.add(Meeting(
            from: today
                .add(Duration(days: (month * 30) + day))
                .add(Duration(hours: hour)),
            to: today
                .add(Duration(days: (month * 30) + day))
                .add(Duration(hours: hour + 2)),
            background: _colorCollection[random.nextInt(9)],
            startTimeZone: '',
            endTimeZone: '',
            description: '',
            isAllDay: false,
            eventName: eventNameCollection[random.nextInt(7)],
          ));
        }
      }
    }
    */
    return meetingCollection;
  }
}

class DataSource extends CalendarDataSource {
  DataSource(List<Meeting> source) {
    appointments = source;
  }

  @override
  bool isAllDay(int index) => appointments![index].isAllDay;

  @override
  String getSubject(int index) => appointments![index].eventName;

  @override
  String getStartTimeZone(int index) => appointments![index].startTimeZone;

  @override
  String getNotes(int index) => appointments![index].description;

  @override
  String getEndTimeZone(int index) => appointments![index].endTimeZone;

  @override
  Color getColor(int index) => appointments![index].background;

  @override
  DateTime getStartTime(int index) => appointments![index].from;

  @override
  DateTime getEndTime(int index) => appointments![index].to;
}

class Meeting {
  Meeting(
      {required this.from,
      required this.to,
      this.background = Colors.green,
      this.isAllDay = false,
      this.eventName = '',
      this.startTimeZone = '',
      this.endTimeZone = '',
      this.description = ''});

  final String eventName;
  final DateTime from;
  final DateTime to;
  final Color background;
  final bool isAllDay;
  final String startTimeZone;
  final String endTimeZone;
  final String description;
}
