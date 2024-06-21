import 'dart:collection';
import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:kalender/kalender.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:soft_studio_project/page_control.dart';
import 'models/task.dart';
import 'task_page.dart';
import 'package:get/get.dart';

class Event {
  final String title;
  final String? description;
  final Color? color;
     
  Event({required this.title, this.description, this.color});
}

class CalendarPage extends StatefulWidget {
  const CalendarPage({super.key});
  @override
  State<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends State<CalendarPage> {
  final titleController = TextEditingController();
  final detailsController = TextEditingController();
  UrgencyLevel dropdownValue = UrgencyLevel.Low;
  DateTime selectedDate = DateTime.now();

  final CalendarController<Event> calendarController = CalendarController(
    calendarDateTimeRange: DateTimeRange(
      start: DateTime(DateTime.now().year - 1),
      end: DateTime(DateTime.now().year + 1),
    ),
  );
  
  final CalendarEventsController<Event> eventController =
      CalendarEventsController<Event>();

  late ViewConfiguration currentConfiguration = viewConfigurations[0];
  List<ViewConfiguration> viewConfigurations = [
    CustomMultiDayConfiguration(
      name: 'Day',
      numberOfDays: 1,
      startHour: 6,
      endHour: 24,
    ),
    WeekConfiguration(),
    MonthConfiguration(),
  ];
  
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context, 
      initialDate: selectedDate,
      firstDate: DateTime(2015, 8), 
      lastDate: DateTime(2101)
    );
    if (picked != null && picked != selectedDate){
      setState(() {
        selectedDate = picked;
      });
    }
  }

  void _addToTaskList(String title, String description, DateTime date, UrgencyLevel urgency) {
      Get.find<TaskController>().addTask(title, description, date, urgency);
  }

  void _addNewEvent() {
    showModalBottomSheet(
      context: context, 
      isScrollControlled: true,
      builder: (context) {
        return SizedBox(
          height: MediaQuery.of(context).size.height / 2,
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                const Text("Add Task",
                style: TextStyle(fontSize: 24)),
                const Divider(
                  color: Colors.grey,
                  height: 20,
                  thickness: 1,
                  indent: 20,
                  endIndent: 20,
                ),
                TextField(
                  controller: titleController,
                  decoration: const InputDecoration(
                    labelText: 'Task Title',
                  ),
                ),
                TextField(
                  controller: detailsController,
                  decoration: const InputDecoration(
                    labelText: "Task Details",
                  ),
                ),
                ElevatedButton(
                  child: const Text('Select Date'),
                  onPressed: () => _selectDate(context),
                ),
                DropdownButton(
                  value: dropdownValue,
                  onChanged: (UrgencyLevel? newValue) {
                    if (newValue != null) {
                      setState((){
                        dropdownValue = newValue;
                      });
                    }
                  },
                  items: UrgencyLevel.values.map<DropdownMenuItem<UrgencyLevel>>((UrgencyLevel value) {
                    return DropdownMenuItem<UrgencyLevel>(
                      value: value,
                      child: Text(value.toString().split('.').last),
                    );
                  }).toList(),
                ),
                ElevatedButton(
                  child: const Text('Confirm'),
                  onPressed: () {
                    _addToTaskList(titleController.text, detailsController.text, selectedDate, dropdownValue);
                    Navigator.of(context).pop();
                  },
                )
              ]          )
          ),
        );
      });
  }

  @override
  void initState() {
    super.initState(); 
    Get.put(TaskController());
  }

  @override
  Widget build(BuildContext context) {
    final calendar = CalendarView<Event>(
      controller: calendarController,
      eventsController: eventController,
      viewConfiguration: currentConfiguration,
      tileBuilder: _tileBuilder,
      multiDayTileBuilder: _multiDayTileBuilder,
      scheduleTileBuilder: _scheduleTileBuilder,
      components: CalendarComponents(
        calendarHeaderBuilder: _calendarHeader,
      ),
      eventHandlers: CalendarEventHandlers(
        onEventTapped: _onEventTapped,
        onEventChanged: _onEventChanged,
        onCreateEvent: _onCreateEvent,
        onEventCreated: _onEventCreated,
      ),
    );

    return Scaffold(
      body: calendar,
      floatingActionButton: FloatingActionButton(
        onPressed: _addNewEvent,
        child: const Icon(Icons.add),
      ),
    );
  }

  CalendarEvent<Event> _onCreateEvent(DateTimeRange dateTimeRange) {
    return CalendarEvent(
      dateTimeRange: dateTimeRange,
      eventData: Event(
        title: 'New Event',
      ),
    );
  }

  Future<void> _onEventCreated(CalendarEvent<Event> event) async {
    // Add the event to the events controller.
    eventController.addEvent(event);

    // Deselect the event.
    eventController.deselectEvent();
  }

  Future<void> _onEventTapped(
    CalendarEvent<Event> event,
  ) async {
    if (isMobile) {
      eventController.selectedEvent == event
          ? eventController.deselectEvent()
          : eventController.selectEvent(event);
    }
  }

  Future<void> _onEventChanged(
    DateTimeRange initialDateTimeRange,
    CalendarEvent<Event> event,
  ) async {
    if (isMobile) {
      eventController.deselectEvent();
    }
  }

  Widget _tileBuilder(
    CalendarEvent<Event> event,
    TileConfiguration configuration,
  ) {
    final color = event.eventData?.color ?? Theme.of(context).colorScheme.primaryContainer;
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
      margin: EdgeInsets.zero,
      elevation: configuration.tileType == TileType.ghost ? 0 : 8,
      color: configuration.tileType != TileType.ghost
          ? color
          : color.withAlpha(100),
      child: Center(
        child: configuration.tileType != TileType.ghost
            ? Text(event.eventData?.title ?? 'New Event')
            : null,
      ),
    );
  }

  Widget _multiDayTileBuilder(
    CalendarEvent<Event> event,
    MultiDayTileConfiguration configuration,
  ) {
    final color = event.eventData?.color ?? Theme.of(context).colorScheme.primaryContainer;
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 2),
      elevation: configuration.tileType == TileType.selected ? 8 : 0,
      color: configuration.tileType == TileType.ghost
          ? color.withAlpha(100)
          : color,
      child: Center(
        child: configuration.tileType != TileType.ghost
            ? Text(event.eventData?.title ?? 'New Event')
            : null,
      ),
    );
  }

  Widget _scheduleTileBuilder(CalendarEvent<Event> event, DateTime date) {
    return DecoratedBox(
      decoration: BoxDecoration(
        color: event.eventData?.color ?? Theme.of(context).colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(event.eventData?.title ?? 'New Event'),
    );
  }

  Widget _calendarHeader(DateTimeRange dateTimeRange) {
    return Row(
      children: [
        DropdownMenu(
          onSelected: (value) {
            if (value == null) return;
            setState(() {
              currentConfiguration = value;
            });
          },
          initialSelection: currentConfiguration,
          dropdownMenuEntries: viewConfigurations
              .map((e) => DropdownMenuEntry(value: e, label: e.name))
              .toList(),
        ),
        const Spacer(),
        IconButton.filledTonal(
          onPressed: calendarController.animateToPreviousPage,
          icon: const Icon(Icons.navigate_before_rounded),
        ),
        
        IconButton.filledTonal(
          onPressed: () {
            calendarController.animateToDate(DateTime.now());
          },
          icon: const Icon(Icons.today),
        ),
        IconButton.filledTonal(
          onPressed: calendarController.animateToNextPage,
          icon: const Icon(Icons.navigate_next_rounded),
        ),
      ],
    );
  }

  bool get isMobile {
    return kIsWeb ? false : Platform.isAndroid || Platform.isIOS;
  }


}