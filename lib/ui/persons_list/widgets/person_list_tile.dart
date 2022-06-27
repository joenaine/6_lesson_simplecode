import 'package:joenaine/constants/app_colors.dart';
import 'package:joenaine/constants/app_styles.dart';
import 'package:joenaine/dto/person.dart';
import 'package:joenaine/generated/l10n.dart';
import 'package:joenaine/widgets/user_avatar.dart';
import 'package:flutter/material.dart';

class PersonListTile extends StatelessWidget {
  const PersonListTile(this.person, {Key? key}) : super(key: key);

  final Person person;

  Color _statusColor(String? status) {
    if (status == 'Dead') return Colors.red;
    if (status == 'Alive') return const Color(0xff00c48c);
    return Colors.grey;
  }

  String _statusLabel(String? status) {
    if (status == 'Dead') return S.current.dead;
    if (status == 'Alive') return S.current.alive;
    return S.current.noData;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        UserAvatar(
          person.image,
          margin: const EdgeInsets.only(right: 20.0),
        ),
        Expanded(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      _statusLabel(person.status).toUpperCase(),
                      style: AppStyles.s10w500.copyWith(
                        letterSpacing: 1.5,
                        color: _statusColor(
                          person.status,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      person.name ?? S.of(context).noData,
                      style: AppStyles.s16w500.copyWith(
                        height: 1.6,
                        leadingDistribution: TextLeadingDistribution.even,
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Expanded(
                    child: Text(
                      '${person.species ?? S.of(context).noData}, ${person.gender ?? S.of(context).noData}',
                      style: const TextStyle(
                        color: AppColors.neutral2,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        )
      ],
    );
  }
}
