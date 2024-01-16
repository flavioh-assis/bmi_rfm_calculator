import 'package:flutter/material.dart';

import '/utils.dart';

class BmiValues {
  double min;
  double max;
  String imc;
  String classification;
  Color cellColor;

  BmiValues(this.min, this.max, this.imc, this.classification, this.cellColor);
}

abstract class Classification {
  static Map<String, dynamic> underweight = {
    'text': 'Abaixo do peso',
    'color': Colors.lightGreen
  };
  static Map<String, dynamic> idealWeight = {
    'text': 'Peso ideal',
    'color': Colors.green
  };
  static Map<String, dynamic> overweight = {
    'text': 'Sobrepeso',
    'color': Colors.orangeAccent
  };
  static Map<String, dynamic> obesityI = {
    'text': 'Obesidade grau I',
    'color': Colors.orange
  };
  static Map<String, dynamic> obesityII = {
    'text': 'Obesidade grau II',
    'color': Colors.deepOrange
  };
  static Map<String, dynamic> obesityIII = {
    'text': 'Obesidade grau III',
    'color': Colors.red
  };
}

abstract class MinMaxUntil60YO {
  static Map<String, dynamic> firstRange = {
    'min': 0.0,
    'max': 18.4,
  };
  static Map<String, dynamic> secondRange = {
    'min': 18.5,
    'max': 24.9,
  };
  static Map<String, dynamic> thirdRange = {
    'min': 25.0,
    'max': 29.9,
  };
  static Map<String, dynamic> forthRange = {
    'min': 30.0,
    'max': 34.9,
  };
  static Map<String, dynamic> fifthRange = {
    'min': 35.0,
    'max': 39.9,
  };
  static Map<String, dynamic> sixthRange = {
    'min': 40.0,
    'max': double.infinity,
  };
}

abstract class MinMaxPlus60YO {
  static Map<String, dynamic> firstRange = {
    'min': 0.0,
    'max': 21.9,
  };
  static Map<String, dynamic> secondRange = {
    'min': 22.0,
    'max': 27.0,
  };
  static Map<String, dynamic> thirdRange = {
    'min': 27.1,
    'max': 30.0,
  };
  static Map<String, dynamic> forthRange = {
    'min': 30.1,
    'max': 35.0,
  };
  static Map<String, dynamic> fifthRange = {
    'min': 35.1,
    'max': 39.9,
  };
  static Map<String, dynamic> sixthRange = {
    'min': 40.0,
    'max': double.infinity,
  };
}

enum Prefix { less, from, more }

enum AgeGroup { until60, plus60 }

getBmiRange(Prefix prefix, double fromValue, double toValue) {
  switch (prefix) {
    case Prefix.less:
      return 'Menos de ${doubleToText((toValue + 0.1))}';
    case Prefix.from:
      return 'De ${doubleToText(fromValue)} a ${doubleToText(toValue)}';
    default:
      return '${doubleToText(fromValue)} ou mais';
  }
}

List<BmiValues> valuesUntil60YearsOld = [
  BmiValues(
    MinMaxUntil60YO.firstRange['min'],
    MinMaxUntil60YO.firstRange['max'],
    getBmiRange(
      Prefix.less,
      MinMaxUntil60YO.firstRange['min'],
      MinMaxUntil60YO.firstRange['max'],
    ),
    Classification.underweight['text'],
    Classification.underweight['color'],
  ),
  BmiValues(
    MinMaxUntil60YO.secondRange['min'],
    MinMaxUntil60YO.secondRange['max'],
    getBmiRange(
      Prefix.from,
      MinMaxUntil60YO.secondRange['min'],
      MinMaxUntil60YO.secondRange['max'],
    ),
    Classification.idealWeight['text'],
    Classification.idealWeight['color'],
  ),
  BmiValues(
    MinMaxUntil60YO.thirdRange['min'],
    MinMaxUntil60YO.thirdRange['max'],
    getBmiRange(
      Prefix.from,
      MinMaxUntil60YO.thirdRange['min'],
      MinMaxUntil60YO.thirdRange['max'],
    ),
    Classification.overweight['text'],
    Classification.overweight['color'],
  ),
  BmiValues(
    MinMaxUntil60YO.forthRange['min'],
    MinMaxUntil60YO.forthRange['max'],
    getBmiRange(
      Prefix.from,
      MinMaxUntil60YO.forthRange['min'],
      MinMaxUntil60YO.forthRange['max'],
    ),
    Classification.obesityI['text'],
    Classification.obesityI['color'],
  ),
  BmiValues(
    MinMaxUntil60YO.fifthRange['min'],
    MinMaxUntil60YO.fifthRange['max'],
    getBmiRange(
      Prefix.from,
      MinMaxUntil60YO.fifthRange['min'],
      MinMaxUntil60YO.fifthRange['max'],
    ),
    Classification.obesityII['text'],
    Classification.obesityII['color'],
  ),
  BmiValues(
    MinMaxUntil60YO.sixthRange['min'],
    MinMaxUntil60YO.sixthRange['max'],
    getBmiRange(
      Prefix.more,
      MinMaxUntil60YO.sixthRange['min'],
      MinMaxUntil60YO.sixthRange['max'],
    ),
    Classification.obesityIII['text'],
    Classification.obesityIII['color'],
  ),
];
List<BmiValues> valuesPlus60YearsOld = [
  BmiValues(
    MinMaxPlus60YO.firstRange['min'],
    MinMaxPlus60YO.firstRange['max'],
    getBmiRange(
      Prefix.less,
      MinMaxPlus60YO.firstRange['min'],
      MinMaxPlus60YO.firstRange['max'],
    ),
    Classification.underweight['text'],
    Classification.underweight['color'],
  ),
  BmiValues(
    MinMaxPlus60YO.secondRange['min'],
    MinMaxPlus60YO.secondRange['max'],
    getBmiRange(
      Prefix.from,
      MinMaxPlus60YO.secondRange['min'],
      MinMaxPlus60YO.secondRange['max'],
    ),
    Classification.idealWeight['text'],
    Classification.idealWeight['color'],
  ),
  BmiValues(
    MinMaxPlus60YO.thirdRange['min'],
    MinMaxPlus60YO.thirdRange['max'],
    getBmiRange(
      Prefix.from,
      MinMaxPlus60YO.thirdRange['min'],
      MinMaxPlus60YO.thirdRange['max'],
    ),
    Classification.overweight['text'],
    Classification.overweight['color'],
  ),
  BmiValues(
    MinMaxPlus60YO.forthRange['min'],
    MinMaxPlus60YO.forthRange['max'],
    getBmiRange(
      Prefix.from,
      MinMaxPlus60YO.forthRange['min'],
      MinMaxPlus60YO.forthRange['max'],
    ),
    Classification.obesityI['text'],
    Classification.obesityI['color'],
  ),
  BmiValues(
    MinMaxPlus60YO.fifthRange['min'],
    MinMaxPlus60YO.fifthRange['max'],
    getBmiRange(
      Prefix.from,
      MinMaxPlus60YO.fifthRange['min'],
      MinMaxPlus60YO.fifthRange['max'],
    ),
    Classification.obesityII['text'],
    Classification.obesityII['color'],
  ),
  BmiValues(
    MinMaxPlus60YO.sixthRange['min'],
    MinMaxPlus60YO.sixthRange['max'],
    getBmiRange(
      Prefix.more,
      MinMaxPlus60YO.sixthRange['min'],
      MinMaxPlus60YO.sixthRange['max'],
    ),
    Classification.obesityIII['text'],
    Classification.obesityIII['color'],
  ),
];

List<BmiValues> getTableBmiValues(AgeGroup ageGroup) {
  return ageGroup == AgeGroup.until60
      ? valuesUntil60YearsOld
      : valuesPlus60YearsOld;
}

class TableBmi extends StatefulWidget {
  const TableBmi({super.key, required this.ageGroup});

  final AgeGroup ageGroup;

  @override
  State<TableBmi> createState() => _TableBmiState();
}

class _TableBmiState extends State<TableBmi> {
  @override
  Widget build(BuildContext context) {
    List<BmiValues> tableValues = getTableBmiValues(widget.ageGroup);

    return Table(
      border: TableBorder.all(),
      children: [
        _createTableHeader(),
        ..._createTableValues(tableValues),
      ],
    );
  }

  _createTableValues(List<BmiValues> values) {
    return values.asMap().entries.map((entry) {
      return _createTableRow(
          [entry.value.imc, entry.value.classification], entry.value.cellColor);
    });
  }

  _createTableRow(
    List<String> cells,
    Color rowColor, {
    FontWeight? fontWeight = FontWeight.normal,
  }) {
    return TableRow(
      children: cells.map((value) {
        return Container(
          color: rowColor,
          padding: const EdgeInsets.all(5),
          child: Text(
            value,
            style: TextStyle(
              fontWeight: fontWeight,
            ),
            textAlign: TextAlign.center,
          ),
        );
      }).toList(),
    );
  }

  _createTableHeader() {
    return _createTableRow(
      ['IMC(kg/m²)', 'Classificação'],
      Colors.white,
      fontWeight: FontWeight.w600,
    );
  }
}
