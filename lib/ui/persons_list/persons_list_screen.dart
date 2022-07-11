import 'package:flutter/material.dart';
import 'package:joenaine/bloc/persons/bloc_persons.dart';
import 'package:joenaine/constants/app_colors.dart';
import 'package:joenaine/constants/app_styles.dart';
import 'package:joenaine/dto/person.dart';
import 'package:joenaine/generated/l10n.dart';
import 'package:joenaine/widgets/app_nav_bar.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'widgets/person_grid_tile.dart';
import 'widgets/person_list_tile.dart';
import 'widgets/search_field.dart';

part 'widgets/_grid_view.dart';
part 'widgets/_list_view.dart';

class PersonsListScreen extends StatelessWidget {
  const PersonsListScreen({Key? key}) : super(key: key);

  static final isListView = ValueNotifier(true);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const AppNavBar(current: 0),
        body: Column(
          children: [
            SearchField(
              onChanged: (value) {
                BlocProvider.of<BlocPersons>(context).add(
                  EventPersonsFilterByName(value),
                );
              },
            ),
            BlocBuilder<BlocPersons, StateBlocPersons>(
              builder: (context, state) {
                var personsTotal = 0;
                if (state is StatePersonsData) {
                  personsTotal = state.data.length;
                }
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          S
                              .of(context)
                              .personsTotal(personsTotal)
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
                          isListView.value = !isListView.value;
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            Expanded(
              child: BlocBuilder<BlocPersons, StateBlocPersons>(
                builder: (context, state) {
                  if (state is StatePersonsLoading) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        CircularProgressIndicator(),
                      ],
                    );
                  }
                  if (state is StatePersonsError) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          child: Text(state.error),
                        ),
                      ],
                    );
                  }
                  if (state is StatePersonsData) {
                    if (state.data.isEmpty) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Flexible(
                            child: Text(S.of(context).personsListIsEmpty),
                          ),
                        ],
                      );
                    } else {
                      return ValueListenableBuilder<bool>(
                        valueListenable: isListView,
                        builder: (context, isListViewMode, _) {
                          return isListViewMode
                              ? _ListView(personsList: state.data)
                              : _GridView(personsList: state.data);
                        },
                      );
                    }
                  }
                  //если состояние любое другое
                  return const SizedBox.shrink();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
