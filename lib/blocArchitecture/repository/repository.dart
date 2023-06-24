import 'package:blocdocplay/blocArchitecture/dataprovider/dataprovider.dart';

class Repository {
  final DataProvider dataProvider;

  Repository(this.dataProvider);

  Future getAllDataThatMeetRequirements() async {
    final datasetA = await dataProvider.readData();
///TODO : CREATE A DATA CLASS THAT CAN HAS ALL THE DATA AND CAN FILTER DATA BY NAME FUNCTION
    return datasetA;
  }
}
