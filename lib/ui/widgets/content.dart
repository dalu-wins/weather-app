import 'package:flutter/material.dart';
import 'package:weather_app/ui/home_page_state.dart';
import 'package:weather_app/ui/widgets/animations.dart';

class MainContent {
  String city = "San Francisco";
  String temperature = "18°";
  String tempMin = "12°";
  String tempMax = "22°";
  String condition = "clear";

  String sunrise = "06:00";
  String sunset = "18:00";

  String forecastTime0 = "--:--";
  String forecastTemperature0 = "-°";
  String forecastCondition0 = "undefined";

  String forecastTime1 = "--:--";
  String forecastTemperature1 = "-°";
  String forecastCondition1 = "undefined";

  String forecastTime2 = "--:--";
  String forecastTemperature2 = "-°";
  String forecastCondition2 = "undefined";

  String forecastTime3 = "--:--";
  String forecastTemperature3 = "-°";
  String forecastCondition3 = "undefined";

  String forecastTime4 = "--:--";
  String forecastTemperature4 = "-°";
  String forecastCondition4 = "undefined";

  CustomScrollView build(MyHomePageState homepage) {
    return CustomScrollView(
      slivers: <Widget>[
        appBar(homepage),
        body(homepage.context),
      ],
    );
  }

  SliverAppBar appBar(MyHomePageState homepage) {
    return SliverAppBar.large(
      pinned: true,
      toolbarHeight: 80,
      collapsedHeight: 80,
      backgroundColor: Theme.of(homepage.context).colorScheme.background,
      surfaceTintColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: const EdgeInsets.only(left: 32, right: 32, bottom: 8),
        centerTitle: false,
        expandedTitleScale: 1.4,
        collapseMode: CollapseMode.none,
        title: showCurrentTemperatureAndCity(homepage.context),
      ),
      actions: [
        IconButton(
          onPressed: homepage.updateWeatherInfo,
          icon: const Icon(Icons.location_on),
        ),
      ],
    );
  }

  Row showCurrentTemperatureAndCity(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 16),
          child: Text(
            temperature,
            style: TextStyle(
                fontSize: 26,
                color: Theme.of(context).colorScheme.onBackground),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              "$tempMin / $tempMax",
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
            Text(
              city,
              style: TextStyle(
                fontSize: 12,
                color: Theme.of(context).colorScheme.onBackground,
              ),
            ),
          ],
        ),
      ],
    );
  }

  SliverToBoxAdapter body(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          children: [
            showAnimation(),
            showSunriseAndSunset(context),
            showForecast(context),
          ],
        ),
      ),
    );
  }

  Padding showAnimation() {
    return Padding(
      padding: const EdgeInsets.only(top: 32, bottom: 32),
      child: AnimationHandler.getConditionAnimation(condition),
    );
  }

  Padding showSunriseAndSunset(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 12,
        bottom: 48,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Column(
            children: [
              Text(
                sunrise,
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              Text(
                "sunrise",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ],
          ),
          Column(
            children: [
              Text(
                sunset,
                style: TextStyle(
                  fontSize: 20,
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
              Text(
                "sunset",
                style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Column showForecast(BuildContext context) {
    return Column(
      children: [
        Align(
          alignment: Alignment.bottomLeft,
          child: Text(
            "FORECAST",
            textAlign: TextAlign.left,
            style: TextStyle(
              color: Theme.of(context).colorScheme.onBackground,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(
            top: 12,
            bottom: 32,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 32,
                    child: AnimationHandler.getConditionAnimation(
                      forecastCondition0,
                      animated: false,
                    ),
                  ),
                  SizedBox(
                    height: 32,
                    child: AnimationHandler.getConditionAnimation(
                      forecastCondition1,
                      animated: false,
                    ),
                  ),
                  SizedBox(
                    height: 32,
                    child: AnimationHandler.getConditionAnimation(
                      forecastCondition2,
                      animated: false,
                    ),
                  ),
                  SizedBox(
                    height: 32,
                    child: AnimationHandler.getConditionAnimation(
                      forecastCondition3,
                      animated: false,
                    ),
                  ),
                  SizedBox(
                    height: 32,
                    child: AnimationHandler.getConditionAnimation(
                      forecastCondition4,
                      animated: false,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 32,
                    child: Text(
                      forecastTime0,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                    child: Text(
                      forecastTime1,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                    child: Text(
                      forecastTime2,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                    child: Text(
                      forecastTime3,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                    child: Text(
                      forecastTime4,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 32,
                    child: Text(
                      forecastTemperature0,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                    child: Text(
                      forecastTemperature1,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                    child: Text(
                      forecastTemperature2,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                    child: Text(
                      forecastTemperature3,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                    child: Text(
                      forecastTemperature4,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 32,
                    child: Text(
                      forecastCondition0,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                    child: Text(
                      forecastCondition1,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                    child: Text(
                      forecastCondition2,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                    child: Text(
                      forecastCondition3,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 32,
                    child: Text(
                      forecastCondition4,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.onBackground,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
