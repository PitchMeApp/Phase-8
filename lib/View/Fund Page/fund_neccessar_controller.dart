import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FundNacessaryController extends GetxController {
  final scrollController = FixedExtentScrollController();

  dynamic industryList;
  RxList checkItem = RxList([].obs);
  RxList getValueList = RxList([].obs);

  RxInt chengeIndexColor = 0.obs;

  RxString selectedValue = ''.obs;
  List data = [
    {'value': '<50K', 'divide_by': '5000', 'isSelected': false},
    {'value': '50K-100K', 'divide_by': '5000', 'isSelected': false},
    {'value': '100K-500K', 'divide_by': '100000', 'isSelected': false},
    {'value': '500K-1Mil', 'divide_by': '100000', 'isSelected': false},
    {'value': '1Mil-10Mil', 'divide_by': '500000', 'isSelected': false},
    {'value': '>10Mil', 'divide_by': '1000000', 'isSelected': false},
  ];

  onselectAmount(value, index) {
    //industryList.value.clear();

    for (var element in data) {
      if (value == element) {
        if (element['isSelected'] != true) {
          checkItem.value.add(element);

          element['isSelected'] = true;
          checkValue(value['value'], value['isSelected']);
        } else {
          element['isSelected'] = false;
          checkItem.value.remove(element);
          checkValue(value['value'], value['isSelected']);

          update();
        }

        update();
      }
    }
  }

  checkValue(index, isSelected) {
    // int firstNumber = 0;
    // int secondNumber = 0;

    switch (index) {
      case '<50K':
        // firstNumber = 5000;
        // secondNumber = 50000;
        // for (var i = firstNumber; i <= secondNumber; i++) {
        //   if (i % int.parse(divideBy) == 0) {
        //     industryList.add(i);
        //   }
        // }
        industryList = {
          {
            'range': "5.000",
            'value': '5.000',
          },
          {
            'range': "10.000",
            'value': '10.000',
          },
          {
            'range': "15.000",
            'value': '15.000',
          },
          {
            'range': "20.000",
            'value': '20.000',
          },
          {
            'range': "25.000",
            'value': '25.000',
          },
          {
            'range': "30.000",
            'value': '30.000',
          },
          {
            'range': "35.000",
            'value': '35.000',
          },
          {
            'range': "40.000",
            'value': '40.000',
          },
          {
            'range': "45.000",
            'value': '45.000',
          },
          // "5.000",
          // "10.000",
          // "15.000",
          // "20.000",
          // "25.000",
          // "30.000",
          // "35.000",
          // "40.000",
          // "45.000",
          //"50.000"
        };

        if (isSelected == true) {
          for (var element in industryList) {
            getValueList.add(element);
          }

          update();
        } else {
          for (var element in industryList) {
            getValueList.remove(element);
          }

          update();
        }

        break;
      case '50K-100K':
        industryList = {
          {
            'range': "50.000",
            'value': '50.000',
          },
          {
            'range': "55.000",
            'value': '55.000',
          },
          {
            'range': "60.000",
            'value': '60.000',
          },
          {
            'range': "65.000",
            'value': '65.000',
          },
          {
            'range': "70.000",
            'value': '70.000',
          },
          {
            'range': "75.000",
            'value': '75.000',
          },
          {
            'range': "80.000",
            'value': '80.000',
          },
          {
            'range': "85.000",
            'value': '85.000',
          },
          {
            'range': "90.000",
            'value': '90.000',
          },
          {
            'range': "95.000",
            'value': '95.000',
          },
          {
            'range': "100.000",
            'value': '100.000',
          },
          // "50.000",
          // "55.000",
          // "60.000",
          // "65.000",
          // "70.000",
          // "75.000",
          // "80.000",
          // "85.000",
          // "90.000",
          // "95.000",
          // "100.000"
        };

        if (isSelected == true) {
          for (var element in industryList) {
            getValueList.add(element);
          }

          update();
        } else {
          for (var element in industryList) {
            getValueList.remove(element);
          }

          update();
        }
        break;
      case '100K-500K':
        industryList = {
          {
            'range': "200.000",
            'value': '200.000',
          },
          {
            'range': "300.000",
            'value': '300.000',
          },
          {
            'range': "400.000",
            'value': '400.000',
          },
          {
            'range': "500.000",
            'value': '500.000',
          },
          // "100.000",
          // "200.000", "300.000", "400.000", "500.000"
        };

        if (isSelected == true) {
          for (var element in industryList) {
            getValueList.add(element);
          }

          update();
        } else {
          for (var element in industryList) {
            getValueList.remove(element);
          }

          update();
        }
        break;
      case '500K-1Mil':
        industryList = {
          {
            'range': "600.000",
            'value': '600.000',
          },
          {
            'range': "700.000",
            'value': '700.000',
          },
          {
            'range': "800.000",
            'value': '800.000',
          },
          {
            'range': "900.000",
            'value': '900.000',
          },
          {
            'range': "1Mil",
            'value': '1',
          },
          //"500.000",
          // "600.000",
          // "700.000",
          // "800.000",
          // "900.000",
          // "1Mil",
        };

        if (isSelected == true) {
          for (var element in industryList) {
            getValueList.add(element);
          }

          update();
        } else {
          for (var element in industryList) {
            getValueList.remove(element);
          }

          update();
        }
        break;
      case '1Mil-10Mil':
        industryList = {
          // {
          //   'range': "1Mil",
          //   'value': '1',
          // },
          {
            'range': "2Mil",
            'value': '2',
          },
          {
            'range': "3Mil",
            'value': '3',
          },
          {
            'range': "4Mil",
            'value': '4',
          },
          {
            'range': "5Mil",
            'value': '5',
          },
          {
            'range': "6Mil",
            'value': '6',
          },
          {
            'range': "7Mil",
            'value': '7',
          },
          {
            'range': "8Mil",
            'value': '8',
          },
          {
            'range': "9Mil",
            'value': '9',
          },
          {
            'range': "10Mil",
            'value': '10',
          },
          //"1Mil",
          //"2Mil",
          // "3Mil",
          // "4Mil",
          // "5Mil",
          // "6Mil",
          // "7Mil",
          // "8Mil",
          // "9Mil",
          // "10Mil"
        };

        if (isSelected == true) {
          for (var element in industryList) {
            getValueList.add(element);
          }

          update();
        } else {
          for (var element in industryList) {
            getValueList.remove(element);
          }

          update();
        }
        break;
      case '>10Mil':
        industryList = {
          {
            'range': "20Mil",
            'value': '20',
          },
          {
            'range': "30Mil",
            'value': '30',
          },
          {
            'range': "40Mil",
            'value': '40',
          },
          {
            'range': "50Mil",
            'value': '50',
          },
          {
            'range': "60Mil",
            'value': '60',
          },
          {
            'range': "70Mil",
            'value': '70',
          },
          {
            'range': "80Mil",
            'value': '80',
          },
          {
            'range': "90Mil",
            'value': '90',
          },
          {
            'range': "100Mil",
            'value': '100',
          },
          //"10Mil",
          // "20Mil",
          // "30Mil",
          // "40Mil",
          // "50Mil",
          // "60Mil",
          // "70Mil",
          // "80Mil",
          // "90Mil",
          // "100Mil"
        };

        if (isSelected == true) {
          for (var element in industryList) {
            getValueList.add(element);
          }

          update();
        } else {
          for (var element in industryList) {
            getValueList.remove(element);
          }

          update();
        }

        break;
      default:
    }
    // getValueList.sort((a, b) {
    //   return int.parse(a).compareTo(int.parse(b));
    // });
    // update();
  }
}
