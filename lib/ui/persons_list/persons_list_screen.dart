import 'package:flutter/material.dart';
import 'package:joenaine/constants/app_colors.dart';
import 'package:joenaine/constants/app_styles.dart';
import 'package:joenaine/dto/person.dart';
import 'package:joenaine/generated/l10n.dart';
import 'package:joenaine/repo/repo_persons.dart';
import 'package:joenaine/ui/persons_list/widgets/vmodel.dart';
import 'package:joenaine/widgets/app_nav_bar.dart';
import 'package:provider/provider.dart';

import 'widgets/person_grid_tile.dart';
import 'widgets/search_field.dart';
import 'widgets/person_list_tile.dart';

part 'widgets/_list_view.dart';
part 'widgets/_grid_view.dart';

class PersonsListScreen extends StatelessWidget {
  const PersonsListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: const AppNavBar(current: 0),
        body: ChangeNotifierProvider(
          create: (context) => PersonsListVModel(
            repo: Provider.of<RepoPersons>(context, listen: false),
          ),
          builder: (context, _) {
            final personsTotal =
                context.watch<PersonsListVModel>().filteredList.length;
            return Column(
              children: [
                SearchField(
                  onChanged: (value) {
                    Provider.of<PersonsListVModel>(context, listen: false)
                        .filter(
                      value.toLowerCase(),
                    );
                  },
                ),
                Padding(
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
                          Provider.of<PersonsListVModel>(
                            context,
                            listen: false,
                          ).switchView();
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: Consumer<PersonsListVModel>(
                    builder: (context, vmodel, _) {
                      if (vmodel.isLoading) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            CircularProgressIndicator(),
                          ],
                        );
                      }
                      if (vmodel.errorMessage != null) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(vmodel.errorMessage!),
                            ),
                          ],
                        );
                      }
                      if (vmodel.filteredList.isEmpty) {
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Flexible(
                              child: Text(S.of(context).personsListIsEmpty),
                            ),
                          ],
                        );
                      }
                      return vmodel.isListView
                          ? _ListView(
                              personsList: vmodel.filteredList,
                            )
                          : _GridView(
                              personsList: vmodel.filteredList,
                            );
                    },
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
