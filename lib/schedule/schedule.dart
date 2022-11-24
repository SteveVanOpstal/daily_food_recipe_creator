import 'package:daily_food_recipe_creator/graphql/queries/schedules_query.dart';
import 'package:daily_food_recipe_creator/schedule/recipe/recipe.dart';
import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:table_calendar/table_calendar.dart';

import '../graphql/graph_query.dart';

class ScheduleWidget extends StatefulWidget {
  ScheduleWidget({Key? key}) : super(key: key);

  @override
  _ScheduleWidgetState createState() => _ScheduleWidgetState();
}

class _ScheduleWidgetState extends State<ScheduleWidget> {
  DateTime _focusedDay = DateTime.now();
  DateTime _selectedDay = DateTime.now();
  String? _selectedRecipeId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Schedule'),
      ),
      body: GraphQueryWidget(
        query: schedulesQuery,
        builder: (
          QueryResult result, {
          Refetch? refetch,
          FetchMore? fetchMore,
        }) {
          if (result.isLoading || result.data == null) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          final schedules = result.data!['querySchedule'] as List;
          final firstDate = DateTime.parse(schedules.first['date']);
          final lastDate = DateTime.parse(schedules.last['date']);

          return Column(
            children: [
              TableCalendar(
                firstDay: firstDate.isAfter(DateTime.now())
                    ? DateTime.now()
                    : firstDate,
                lastDay: lastDate.add(Duration(days: 21)),
                focusedDay: _focusedDay,
                startingDayOfWeek: StartingDayOfWeek.monday,
                selectedDayPredicate: (day) {
                  return isSameDay(_selectedDay, day);
                },
                onDaySelected: (selectedDay, focusedDay) {
                  setState(() {
                    _selectedDay = selectedDay;
                    _focusedDay = focusedDay;
                    final selectedSchedule = schedules.firstWhere(
                      (schedule) => isSameDay(
                          DateTime.parse(schedule['date']), _selectedDay),
                      orElse: () => null,
                    );
                    _selectedRecipeId = selectedSchedule?['recipe']['id'];
                  });
                },
              ),
              RecipeWidget(
                recipeId: _selectedRecipeId,
              )
            ],
          );
        },
      ),
    );
  }
}
