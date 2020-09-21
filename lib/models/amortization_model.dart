import '../util/time_convert.dart';

class AmortizationList {
  final List<AmortizationModel> amortizationList;
  AmortizationList({this.amortizationList});
  factory AmortizationList.fromJson(List<dynamic> parsedJson) {
    List<AmortizationModel> amortizationList = List<AmortizationModel>();
    amortizationList =
        parsedJson.map((i) => AmortizationModel.fromJson(i)).toList();
    return AmortizationList(amortizationList: amortizationList);
  }
}

class AmortizationModel {
  final String nrocta;
  final String fchaprog;
  final String vlorcta;
  final String intres;
  final String cptal;
  final String seguro;
  final String pndntertotal;

  AmortizationModel(
      {this.nrocta,
      this.fchaprog,
      this.vlorcta,
      this.intres,
      this.cptal,
      this.seguro,
      this.pndntertotal});
  factory AmortizationModel.fromJson(Map<String, dynamic> json) {
    return AmortizationModel(
      nrocta: json['nrocta'],
      fchaprog: fechaConvert(json['fchaprog']),
      vlorcta: json['vlorcta'],
      intres: json['intres'],
      cptal: json['cptal'],
      seguro: json['seguro'],
      pndntertotal: json['pndntertotal'],
    );
  }
}
