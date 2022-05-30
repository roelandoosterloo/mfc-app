part of 'measurement_overview.dart';

class MeasurementStatistics extends StatelessWidget {
  final double? _currentWeight;
  final double? _targetWeight;
  final double? _totalWeightLost;

  const MeasurementStatistics({
    Key? key,
    double? currentWeight,
    double? targetWeight,
    double? totalWeightLost,
  })  : _currentWeight = currentWeight,
        _targetWeight = targetWeight,
        _totalWeightLost = totalWeightLost,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      primary: false,
      crossAxisCount: 2,
      shrinkWrap: true,
      padding: EdgeInsets.symmetric(horizontal: 30),
      crossAxisSpacing: 15,
      mainAxisSpacing: 15,
      children: [
        StatisticCard(
          title: "Huidige gewicht",
          subText: _currentWeight != null
              ? "${Formatter.formatDecimal(_currentWeight!)} kg"
              : "Niet beschikbaar",
          icon: Icons.monitor_weight_outlined,
          iconColor: Colors.white,
        ),
        if (_targetWeight != null)
          StatisticCard(
            title: "Streefgewicht",
            subText:
                "${_targetWeight != null ? Formatter.formatDecimal(_targetWeight) : "-"} kg",
            icon: Icons.flag_outlined,
            iconColor: Colors.white,
          ),
        if (_targetWeight == null)
          ElevatedButton(
            child: Text("VUL JE STREEFGEWICHT IN"),
            onPressed: () => BlocProvider.of<NavigationBloc>(context).add(
              NavigatedToProfile(),
            ),
          ),
        StatisticCard(
          title: "Totaal afgevallen",
          mainText: _totalWeightLost != null
              ? Formatter.formatDecimal(_totalWeightLost)
              : "-",
          subText: "kg",
          iconColor: Colors.white,
        )
      ],
    );
  }
}
