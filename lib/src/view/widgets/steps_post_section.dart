import 'package:flutter/material.dart';
import 'package:food_recipe_final/core/constants.dart';
import 'package:food_recipe_final/src/providers/settings_manager.dart';
import 'package:provider/provider.dart';

class StepsPostSection extends StatelessWidget {
  const StepsPostSection({
    Key? key,
    required this.steps,
  }) : super(key: key);
  final List steps;
  @override
  Widget build(BuildContext context) {
    final settingsManager =
        Provider.of<SettingsManager>(context, listen: false);
    return Padding(
      padding: const EdgeInsets.all(14.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Instructions",
            style: Theme.of(context).textTheme.headline2,
          ),
          const SizedBox(height: 20),
          MediaQuery.removePadding(
            removeTop: true,
            context: context,
            child: ListView.separated(
              separatorBuilder: ((context, index) =>
                  const SizedBox(height: 14)),
              itemCount: steps.length,
              itemBuilder: (context, index) {
                int i = index + 1;
                return Row(
                  textBaseline: TextBaseline.alphabetic,
                  crossAxisAlignment: CrossAxisAlignment.baseline,
                  children: [
                    Container(
                      width: 20,
                      height: 24,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.all(
                          Radius.circular(4),
                        ),
                        color: settingsManager.darkMode
                            ? Colors.white
                            : kOrangeColor,
                      ),
                      child: Center(
                        child: Text(
                          '$i',
                          style: TextStyle(
                            color: settingsManager.darkMode
                                ? kOrangeColor
                                : Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        "${steps[index]}",
                        style: Theme.of(context).textTheme.headline3!.copyWith(
                              height: 1.6,
                              fontSize: 15,
                            ),
                      ),
                    ),
                  ],
                );
              },
              physics: const NeverScrollableScrollPhysics(),
              primary: false,
              shrinkWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
