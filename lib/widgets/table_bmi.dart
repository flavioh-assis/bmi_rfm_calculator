import 'package:flutter/material.dart';

class BmiValues {
  String imc;
  String classification;
  Color cellColor;

  BmiValues(this.imc, this.classification, this.cellColor);
}

class TableBmi extends StatelessWidget {
  const TableBmi({super.key});

  static List<BmiValues> values20to60YearsOld = [
    BmiValues('IMC(kg/m²)', 'Classificação', Colors.white),
    BmiValues('Abaixo de 18,5', 'Abaixo do peso', Colors.lightGreen),
    BmiValues('De 18,5 a 24,9', 'Peso ideal', Colors.green),
    BmiValues('De 25,0 a 29,9', 'Sobrepeso', Colors.orangeAccent),
    BmiValues('De 30,0 a 34,9', 'Obesidade grau I', Colors.orange),
    BmiValues('De 35,0 a 39,9', 'Obesidade grau II', Colors.deepOrange),
    BmiValues('40,0 ou mais', 'Obesidade grau III', Colors.red),
  ];

  static List<BmiValues> valuesPlus60YearsOld = [
    BmiValues('IMC(kg/m²)', 'Classificação', Colors.white),
    BmiValues('Abaixo de 21,9', 'Abaixo do peso', Colors.lightGreen),
    BmiValues('De 22,0 a 27,0', 'Peso ideal', Colors.green),
    BmiValues('De 27,1 a 30,0', 'Sobrepeso', Colors.orangeAccent),
    BmiValues('De 30,1 a 35,0', 'Obesidade grau I', Colors.orange),
    BmiValues('De 35,1, a 39,9', 'Obesidade grau II', Colors.deepOrange),
    BmiValues('40,0 ou mais', 'Obesidade grau III', Colors.red),
  ];

  @override
  Widget build(BuildContext context) {
    return Table(
      border: TableBorder.all(),
      children: [
        ...values20to60YearsOld.asMap().entries.map((entry) {
          var isHeader = entry.key == 0;

          return _createTableRow([entry.value.imc, entry.value.classification],
              entry.value.cellColor, isHeader);
        }),
      ],
    );
  }

  _createTableRow(List<String> cells, Color rowColor, bool isHeader) {
    return TableRow(
      children: cells.map((value) {
        return Container(
          color: rowColor,
          padding: const EdgeInsets.all(5),
          child: Text(
            value,
            style: TextStyle(
              fontWeight: isHeader ? FontWeight.w600 : FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
        );
      }).toList(),
    );
  }
}
