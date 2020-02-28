import 'package:collection/collection.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jsos_helper/blocs/authentication/authentication.dart';
import 'package:jsos_helper/common/color_helper.dart';
import 'package:jsos_helper/models/calendar_event.dart';
import 'package:jsos_helper/repositories/calendar_repository.dart';
import 'package:jsos_helper/repositories/storage_repository.dart';
import 'package:jsos_helper/ui/components/custom_card.dart';
import 'package:table_calendar/table_calendar.dart';

// TODO - use an external API to get holidays per country
// TODO - add user repository to get calendars by user?
final Map<DateTime, List> _holidays = {
  DateTime(2020, 1, 1): ['New Year\'s Day'],
  DateTime(2020, 1, 6): ['Epiphany'],
  DateTime(2020, 2, 14): ['Valentine\'s Day'],
  DateTime(2020, 4, 21): ['Easter Sunday'],
  DateTime(2020, 4, 22): ['Easter Monday'],
};

class CalendarScreen extends StatefulWidget {
  final String title;
  final StorageRepository storageRepository;

  CalendarScreen({
    Key key,
    @required this.title,
    @required this.storageRepository,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() =>
      _CalendarScreenState(storageRepository: storageRepository);
}

class _CalendarScreenState extends State<CalendarScreen>
    with TickerProviderStateMixin {
  Map<DateTime, List> _events;
  List _selectedEvents;
  AnimationController _animationController;
  CalendarController _calendarController;

  final StorageRepository storageRepository;
  final CalendarRepository _calendarRepository;

  _CalendarScreenState({@required this.storageRepository})
      : _calendarRepository =
            CalendarRepository(storageRepository: storageRepository);

  Future updateCalendarEvents(DateTime first, DateTime last) async {
    _events = {};
    final List<CalendarEvent> eventsList =
        await _calendarRepository.getCalendarEvents(first, last);
    setState(() {
      _events = groupBy(
          eventsList,
          (event) => DateTime(event.startDateTime.year,
              event.startDateTime.month, event.startDateTime.day));
    });
  }

  @override
  void initState() {
    super.initState();
    final _selectedDay = DateTime.now();
    final _firstDayOfMonth = DateTime(_selectedDay.year, _selectedDay.month, 1);
    final _lastDayOfMonth =
        DateTime(_selectedDay.year, _selectedDay.month + 1, 1);

    _events = {};
    _selectedEvents = _events[_selectedDay] ?? [];
    updateCalendarEvents(_firstDayOfMonth, _lastDayOfMonth);

    _calendarController = CalendarController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 400),
    );

    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _calendarController.dispose();
    super.dispose();
  }

  void _onDaySelected(DateTime day, List events) {
    print('CALLBACK: _onDaySelected');
    setState(() {
      _selectedEvents = events;
    });
  }

  void _onVisibleDaysChanged(
      DateTime first, DateTime last, CalendarFormat format) {
    print('CALLBACK: _onVisibleDaysChanged');
    final _firstDayOfMonth = DateTime(first.year, first.month, 1);
    final _lastDayOfMonth = DateTime(last.year, last.month + 1, 1);
    updateCalendarEvents(_firstDayOfMonth, _lastDayOfMonth);
  }

  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc _authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.exit_to_app),
            tooltip: 'Logout',
            onPressed: () {
              _authenticationBloc.dispatch(LoggedOut());
            },
          ),
        ],
      ),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          _buildTableCalendar(),
          const SizedBox(height: 8.0),
          const SizedBox(height: 8.0),
          Expanded(child: _buildEventList()),
        ],
      ),
    );
  }

  // Simple TableCalendar configuration (using Styles)
  Widget _buildTableCalendar() {
    return TableCalendar(
      calendarController: _calendarController,
      events: _events,
      holidays: _holidays,
      startingDayOfWeek: StartingDayOfWeek.monday,
      calendarStyle: CalendarStyle(
        selectedColor: Colors.deepOrange[400],
        todayColor: Colors.deepOrange[200],
        markersColor: Colors.brown[700],
        outsideDaysVisible: false,
      ),
      headerStyle: HeaderStyle(
        formatButtonTextStyle:
            TextStyle().copyWith(color: Colors.white, fontSize: 15.0),
        formatButtonDecoration: BoxDecoration(
          color: Colors.deepOrange[400],
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      onDaySelected: _onDaySelected,
      onVisibleDaysChanged: _onVisibleDaysChanged,
      builders: CalendarBuilders(
        markersBuilder: (context, date, events, holidays) {
          final children = <Widget>[];

          if (events.isNotEmpty) {
            children.add(
              Positioned(
                right: 1,
                bottom: 1,
                child: _buildEventsMarker(date, events),
              ),
            );
          }

          if (holidays.isNotEmpty) {
            children.add(
              Positioned(
                right: -2,
                top: -2,
                child: _buildHolidaysMarker(),
              ),
            );
          }

          return children;
        },
      ),
    );
  }

  Widget _buildEventsMarker(DateTime date, List events) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _calendarController.isSelected(date)
            ? Colors.brown[500]
            : _calendarController.isToday(date)
                ? Colors.brown[300]
                : Colors.blue[400],
      ),
      width: 16.0,
      height: 16.0,
      child: Center(
        child: Text(
          '${events.length}',
          style: TextStyle().copyWith(
            color: Colors.white,
            fontSize: 12.0,
          ),
        ),
      ),
    );
  }

  Widget _buildHolidaysMarker() {
    return Icon(
      Icons.home,
      size: 20.0,
      color: Colors.blueGrey[800],
    );
  }

  Widget _buildEventList() {
    var formatter = new DateFormat('Hm');

    return ListView(
      children: _selectedEvents
          .map(
            (event) => CustomCard(asideWidgets: <Widget>[
              Text(formatter.format(event.startDateTime)),
              Text(formatter.format(event.endDateTime)),
            ], leftWidgets: <Widget>[
              Text(event.name),
              Text(
                event.lecturer,
                overflow: TextOverflow.ellipsis,
              ),
            ], rightWidgets: <Widget>[
              Text(
                event.classroom,
                overflow: TextOverflow.ellipsis,
              ),
              Text(describeEnum(event.eventType))
            ], color: ColorHelper.getEventColor(event.eventType)),
          )
          .toList(),
    );
  }
}
