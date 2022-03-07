
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:personal_app/components/custom-picker.dart';
import 'package:personal_app/data/area-data-jsonString.dart';
import 'package:personal_app/Modal/area-data-json.dart';

class JsonPickerPage extends StatefulWidget {

  @override
  _JsonPickerPageState createState() => _JsonPickerPageState();
}

class _JsonPickerPageState extends State<JsonPickerPage> {
  // 方案一
  List<dynamic> provAreaDataIdxs = [];//省市区的选择数据下标集合
  String provAreaName = '';// 省市区名称
  dynamic provAreaValue; //省市区选的数据id
  List<Map<String, dynamic>> resetAreaData = []; //省市区数据转换后的数据

  // 方案二
  List<dynamic> provAreaDataIdxs2 = [];//省市区的选择数据下标集合
  String provAreaName2 = '';// 省市区名称
  dynamic provAreaValue2; //省市区选的数据id
  List<Map<String, dynamic>> resetAreaData2 = []; //省市区数据转换后的数据


  @override
  void initState() {
    //方式1，因为数据是本地的数据，dart本身是没有dart数据格式，
    // 所以在定义json数据格式时，需要加上'''XXX''' 先包裹成字符串
    //所以需要解析成List ,真实的接口请求不需要这么处理
    List<dynamic> AreaDataJson = json.decode(areaDataJsonSting);//Json 改成小写，升级原因
    //需要注意的是 areaData 数据字段不是label 和value； 需要转化一下
    resetAreaData =recursionDataHandle(AreaDataJson);

    //方式 2
    List<dynamic> AreaDataJson2 = json.decode(areaDataJsonSting);
    List<dynamic> AreaDataDart2 = AreaDataJson2.map((item) =>
    new AreaDataToJson.fromJson(item)).toList();
    print(AreaDataDart2.toString()); //这里打印才发现AreaDataToJson类有问题，该网站不能对于这种树形结构的数据生成还存在问题，下面放开2层 即 省市是没问题的

    // // List<Map<String, dynamic>> AreaDataDart = AreaDataToJson.fromJson(AreaDataJson);
    //需要注意的是 areaData 数据字段不是label 和value； 需要转化一下
    resetAreaData2 =recursionDataHandle(AreaDataDart2);
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
                      Text('省市区选择方案1'),

                    ],
                  ),
                ),
                Text(provAreaName),
                Container(
                  height: 26.0,
                ),
                RaisedButton(
                  padding: EdgeInsets.all(0),
                  onPressed: () {
                    customPicker(context,
                        {"indexs":provAreaDataIdxs2, "initData": resetAreaData2, "colNum":2},
                            (opt) {
                          setState(() {
                            provAreaDataIdxs2 = opt['indexs'];
                            List names = opt['names'];
                            provAreaName2 = '';
                            for(int i = 0; i< names.length; i++) {
                              provAreaName2 += names[i]['label'] != '' ?  i== 0 ? names[i]['label'] : '/' + names[i]['label'] : '';
                            }
                            provAreaValue2 = names[names.length-1]['value'];//value 这里逻辑只需要取最后一个
                          });
                        });
                  },
                  child: Row(
                    children: [
                      Text('省市区选择方案2'),
                    ],
                  ),
                ),
                Text(provAreaName2),
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
        Map<String, dynamic> tmpData;
        try {
          tmpData = data?[i].toJson();
        } catch(e) {
          tmpData = data?[i];
        }

        resetData.add({
          'value': tmpData['id'],
          'label': tmpData['name'],
          'center': tmpData['center'],
          'level':  tmpData['level'],
          // 'children': data[i]['children'] ? recursionDataHandle(data[i]['children']): []
        });
        if(tmpData.containsKey('children')) { //是否包含key值children
          if(tmpData['children']?.length > 0)  {
            resetData[i]['children'] = recursionDataHandle(tmpData['children']);
          } else {
            resetData[i]['children'] = [];
          }
        }
      }
    }
    return resetData;
  }
}
