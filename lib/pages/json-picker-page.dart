
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

  List<dynamic> provAreaDataIdxs = [];//省市区的选择数据下标集合
  String provAreaName = '';// 省市区名称
  dynamic provAreaValue; //省市区选的数据id


  List<Map<String, dynamic>> resetAreaData = []; //省市区数据转换后的数据

  @override
  void initState() {
    //方式1，因为数据是本地的数据，dart本身是没有dart数据格式，
    // 所以在定义json数据格式时，需要加上'''XXX''' 先包裹成字符串
    //所以需要解析成List ,真实的接口请求不需要这么处理
    // List<dynamic> AreaDataJson = json.decode(areaDataJsonSting);//Json 改成小写，升级原因
    //需要注意的是 areaData 数据字段不是label 和value； 需要转化一下
    // // print(AreaDataJson.toString());
    // resetAreaData =recursionDataHandle(AreaDataJson);

    //方式
    List<dynamic> AreaDataJson =  json.decode(areaDataJsonSting);//Json 改成小写，升级原因
    List<dynamic> AreaDataDart = AreaDataJson.map((item) =>
    new AreaDataToJson.fromJson(item)).toList();
    print(AreaDataDart.toString());
    // List<dynamic> AreaDataDart = AreaDataJson.map((item) =>
    //  new AreaDataToJson.fromJson((item)=> {
    //     return item;
    //   }
    // )).toList();
    // List<dynamic> AreaDataDart = AreaDataJson.map((item) =>
    //     new AreaDataToJson.fromJson((item)).toList();
       //    =>  {
       //   if (item['children'] != null){
       //     item['children'] = item['children'].map((it) => new Children.fromJson(it)));
       //   }else {
       //
       //   }
       // }
       // ).toList();
    // print(AreaDataDart.toString());
    // // List<Map<String, dynamic>> AreaDataDart = AreaDataToJson.fromJson(AreaDataJson);
    //需要注意的是 areaData 数据字段不是label 和value； 需要转化一下
    // resetAreaData =recursionDataHandle(AreaDataDart);
    resetAreaData =recursionDataHandle(AreaDataJson);
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
    // print(data?.length);
    if(data?.length > 0) {
      for (var i = 0; i <data?.length; i++) {
        // print(data?[i].toJson());
        Map<String, dynamic> tmpData;
        tmpData = data?[i];
        // try {
        //   tmpData = data?[i].toJson();
        //   print(tmpData);
        // } catch(e) {
        //   tmpData = data?[i];
        //   // print(data?[i]);
        // }

        resetData.add({
          'value': tmpData['id'],
          'label': tmpData['name'],
          'center': tmpData['center'],
          'level':  tmpData['level'],
          // 'children': data[i]['children'] ? recursionDataHandle(data[i]['children']): []
        });
        // print(tmpData.containsKey('children'));
        if(tmpData.containsKey('children')) { //是否包含key值children
          // print(tmpData['children']?.length);
          if(tmpData['children']?.length > 0)  {
            resetData[i]['children'] = recursionDataHandle(tmpData['children']);
            // resetData[i]['children'] = [];
          } else {
            resetData[i]['children'] = [];
          }
        }
      }
    }
    return resetData;
  }
}
