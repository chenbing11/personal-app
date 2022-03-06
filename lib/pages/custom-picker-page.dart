

import 'package:flutter/material.dart';
import 'package:personal_app/components/custom-picker.dart';

import 'package:personal_app/data/industries-data.dart';
import 'package:personal_app/data/area-data.dart';


class CustomPickerPage extends StatefulWidget {

  @override
  _CustomPickerPageState createState() => _CustomPickerPageState();
}

class _CustomPickerPageState extends State<CustomPickerPage> {

  List<dynamic> areaDataIdxs = [];//省市的选择数据下标集合
  String areaName = '';// 省市名称
  dynamic areaValue; //省市选的数据id

  List<dynamic> provAreaDataIdxs = [];//省市区的选择数据下标集合
  String provAreaName = '';// 省市区名称
  dynamic provAreaValue; //省市区选的数据id

  String industryName=''; //行业名称
  List<dynamic> industryIdxs = [];//选择行业的下标集合
  dynamic industryValue; //行业选的数据id

  List<dynamic> resetAreaData = []; //省市区数据转换后的数据

  @override
  void initState() {
    //需要注意的是 areaData 数据字段不是label 和value； 需要转化一下
    resetAreaData =recursionDataHandle(areaData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("自定义数据选择器"),
      ),
      body: Center(
        child: GestureDetector(
          onTap: (){

          },
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                RaisedButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    customPicker(context,
                        {"indexs":industryIdxs, "initData": industriesData, "colNum":2},
                            (opt) {
                          setState(() {
                            industryIdxs = opt['indexs'];
                            List names = opt['names'];
                            industryName = '';
                            for(int i = 0; i< names.length; i++) {
                              industryName += names[i]['label'] != '' ?  i== 0 ? names[i]['label'] : '/' + names[i]['label'] : '';
                            }
                            industryValue = names[names.length-1]['value'];//value 这里逻辑只需要取最后一个
                          });
                          // vm.setIndustryIdxs(industryIdxs);
                        });
                  },
                  child: Row(
                    children: [
                      Text('行业选择选择'),
                    ],
                  ),
                ),
                Text(industryName),
                Container(
                  height: 18.0,
                ),
                SizedBox(height:8.0),
                RaisedButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    customPicker(context,
                        {"indexs":areaDataIdxs, "initData": resetAreaData, "colNum":2},
                            (opt) {
                          setState(() {
                            areaDataIdxs = opt['indexs'];
                            List names = opt['names'];
                            areaName = '';
                            for(int i = 0; i< names.length; i++) {
                              areaName += names[i]['label'] != '' ?  i== 0 ? names[i]['label'] : '/' + names[i]['label'] : '';
                            }
                            areaValue = names[names.length-1]['value'];//value 这里逻辑只需要取最后一个
                          });
                        });
                  },
                  child: Row(
                    children: [
                      Text('省市选择(需要重新组装字段)'),

                    ],
                  ),
                ),
                Text(areaName),
                Container(
                  height: 26.0,
                ),
                RaisedButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    customPicker(context,
                        {"indexs":provAreaDataIdxs, "initData": resetAreaData, "colNum":3},
                            (opt) {
                          setState(() {
                            provAreaDataIdxs = opt['indexs'];
                            List names = opt['names'];
                            provAreaName = '';
                            for(int i = 0; i< names.length; i++) {
                              provAreaName += names[i]['label'] != '' ?  i== 0 ? names[i]['label'] : '/' + names[i]['label'] : '';
                            }
                            provAreaValue = names[names.length-1]['value'];//value 这里逻辑只需要取最后一个
                          });
                        });
                  },
                  child: Row(
                    children: [
                      Text('省市区选择(需要重新组装字段)'),

                    ],
                  ),
                ),
                Text(provAreaName),
                Container(
                  height: 26.0,
                ),
              ]
          ),
        ),
      ),
    );
  }

  //数据格式转换
  recursionDataHandle(data) {
    List<Map<String, dynamic>> resetData = [];
    if(data?.length > 0) {
      for (var i = 0; i <data?.length; i++) {
        resetData.add({
          'value': data[i]['id'],
          'label': data[i]['name'],
          'center': data[i]['center'],
          'level':  data[i]['level'],
          // 'children': data[i]['children'] ? recursionDataHandle(data[i]['children']): []
        });
        if(data[i].containsKey('children')) { //是否包含key值children
          if(data[i]['children']?.length > 0)  {
            resetData[i]['children'] = recursionDataHandle(data[i]['children']);
          } else {
            resetData[i]['children'] = [];
          }
        }
      }
    }
    return resetData;
  }
}
