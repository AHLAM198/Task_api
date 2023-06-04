import 'package:flutter/material.dart';

import '../../../core/constant/variables.dart';
import '../../../core/theme/app_colors.dart';
import '../../authentication/model/user.dart';
import 'package:age_calculator/age_calculator.dart';

class ProfileHeaderWidget extends StatelessWidget {
  const ProfileHeaderWidget({Key? key, required this.user}) : super(key: key);

  final User user;
  @override
  Widget build(BuildContext context) {
    final userBirthdate = DateTime.parse(user.birthDate.toString());
    DateDuration age = AgeCalculator.age(userBirthdate);

    final theme = Theme.of(context).textTheme;
    return Align(
      alignment: Alignment.center,
      child: Column(
        children: [
          Container(
            height: 100, width: 100,
            decoration: const BoxDecoration(
              color: lightColor,
              shape: BoxShape.circle,
              image: DecorationImage(image: AssetImage(profileImage), fit: BoxFit.cover,),),
          ),
          const SizedBox(height: 10,),
          const SizedBox(width: 30,),
          Text(user.name.toString(), style: theme.headlineLarge,),
          Text(user.email.toString(), style: theme.headlineSmall,),
          Text('+966 5 ${user.phoneNum.toString()}', style: theme.headlineSmall,),
          Text(age.toString() , style: theme.headlineSmall,),
        ],
      ),
    );
    // });
  }
}
