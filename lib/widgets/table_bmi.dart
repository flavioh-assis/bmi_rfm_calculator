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

abstract class MinMax20To60YO {
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

enum Prefix { under, from, more }

getBmiRange(Prefix prefix, double fromValue, double toValue) {
  switch (prefix) {
    case Prefix.under:
      return 'Menos de ${doubleToText((toValue + 0.1))}';
    case Prefix.from:
      return 'De ${doubleToText(fromValue)} a ${doubleToText(toValue)}';
    default:
      return '${doubleToText(fromValue)} ou mais';
  }
}

List<BmiValues> values20to60YearsOld = [
  BmiValues(
    MinMax20To60YO.firstRange['min'],
    MinMax20To60YO.firstRange['max'],
    getBmiRange(
      Prefix.under,
      MinMax20To60YO.firstRange['min'],
      MinMax20To60YO.firstRange['max'],
    ),
    Classification.underweight['text'],
    Classification.underweight['color'],
  ),
  BmiValues(
    MinMax20To60YO.secondRange['min'],
    MinMax20To60YO.secondRange['max'],
    getBmiRange(
      Prefix.from,
      MinMax20To60YO.secondRange['min'],
      MinMax20To60YO.secondRange['max'],
    ),
    Classification.idealWeight['text'],
    Classification.idealWeight['color'],
  ),
  BmiValues(
    MinMax20To60YO.thirdRange['min'],
    MinMax20To60YO.thirdRange['max'],
    getBmiRange(
      Prefix.from,
      MinMax20To60YO.thirdRange['min'],
      MinMax20To60YO.thirdRange['max'],
    ),
    Classification.overweight['text'],
    Classification.overweight['color'],
  ),
  BmiValues(
    MinMax20To60YO.forthRange['min'],
    MinMax20To60YO.forthRange['max'],
    getBmiRange(
      Prefix.from,
      MinMax20To60YO.forthRange['min'],
      MinMax20To60YO.forthRange['max'],
    ),
    Classification.obesityI['text'],
    Classification.obesityI['color'],
  ),
  BmiValues(
    MinMax20To60YO.fifthRange['min'],
    MinMax20To60YO.fifthRange['max'],
    getBmiRange(
      Prefix.from,
      MinMax20To60YO.fifthRange['min'],
      MinMax20To60YO.fifthRange['max'],
    ),
    Classification.obesityII['text'],
    Classification.obesityII['color'],
  ),
  BmiValues(
    MinMax20To60YO.sixthRange['min'],
    MinMax20To60YO.sixthRange['max'],
    getBmiRange(
      Prefix.more,
      MinMax20To60YO.sixthRange['min'],
      MinMax20To60YO.sixthRange['max'],
    ),
    Classification.obesityIII['text'],
    Classification.obesityIII['color'],
  ),
];

class TableBmi extends StatelessWidget {
  const TableBmi({super.key});

  // static List<BmiValues> valuesPlus60YearsOld = [
  //   BmiValues('Abaixo de 21,9', 'Abaixo do peso', Colors.lightGreen),
  //   BmiValues('De 22,0 a 27,0', 'Peso ideal', Colors.green),
  //   BmiValues('De 27,1 a 30,0', 'Sobrepeso', Colors.orangeAccent),
  //   BmiValues('De 30,1 a 35,0', 'Obesidade grau I', Colors.orange),
  //   BmiValues('De 35,1, a 39,9', 'Obesidade grau II', Colors.deepOrange),
  //   BmiValues('40,0 ou mais', 'Obesidade grau III', Colors.red),
  // ];

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      children: [
        _createTableHeader(),
        ...values20to60YearsOld.asMap().entries.map((entry) {
          return _createTableRow([entry.value.imc, entry.value.classification],
              entry.value.cellColor);
        }),
      ],
    );
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
