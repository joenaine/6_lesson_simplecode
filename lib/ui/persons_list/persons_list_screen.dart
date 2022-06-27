import 'package:flutter/material.dart';
import 'package:joenaine/constants/app_colors.dart';
import 'package:joenaine/constants/app_styles.dart';
import 'package:joenaine/dto/person.dart';
import 'package:joenaine/generated/l10n.dart';
import 'package:joenaine/widgets/app_nav_bar.dart';

import 'widgets/person_grid_tile.dart';
import 'widgets/search_field.dart';
import 'widgets/person_list_tile.dart';

part 'widgets/_list_view.dart';
part 'widgets/_grid_view.dart';

class PersonsListScreen extends StatefulWidget {
  const PersonsListScreen({Key? key}) : super(key: key);

  @override
  State<PersonsListScreen> createState() => _PersonsListScreenState();
}

class _PersonsListScreenState extends State<PersonsListScreen> {
  var isListView = true;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const AppNavBar(current: 0),
        body: Column(
          children: [
            const SearchField(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12.0),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      S
                          .of(context)
                          .personsTotal(_personsList.length)
                          .toUpperCase(),
                      style: AppStyles.s10w500.copyWith(
                        letterSpacing: 1.5,
                        color: AppColors.neutral2,
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.grid_view),
                    iconSize: 28.0,
                    color: AppColors.neutral2,
                    onPressed: () {
                      setState(() {
                        isListView = !isListView;
                      });
                    },
                  ),
                ],
              ),
            ),
            Expanded(
              child: isListView
                  ? _ListView(personsList: _personsList)
                  : _GridView(personsList: _personsList),
            ),
          ],
        ),
      ),
    );
  }
}

final _list = [
  const Person(
    name: 'Рик Санчез',
    species: 'Человек',
    status: 'Alive',
    gender: 'Мужской',
  ),
  const Person(
    name: 'Алан Райс',
    species: 'Человек',
    status: 'Dead',
    gender: 'Мужской',
  ),
  const Person(
    name: 'Саммер Смит',
    species: 'Человек',
    status: 'Alive',
    gender: 'Женский',
  ),
  const Person(
    name: 'Морти Смит',
    species: 'Человек',
    status: 'Alive',
    gender: 'Мужской',
  ),
];

final _personsList = [
  ..._list,
  ..._list,
  ..._list,
  ..._list,
];
