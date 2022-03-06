import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_custom_dialog/flutter_custom_dialog.dart';

/**
 * params 里面目前支持参数
 * indexs 指多个列的数组下标，如果是初始的时候可以传空数组 [],代码会自动处理成每个下标为0
 * colNum 指多少列
 * initData 传入的初始数据
 */
YYDialog customPicker(BuildContext context, params, Function onConfirm) {
  return YYDialog().build(context)
    ..gravity = Gravity.bottom
    ..gravityAnimationEnable = true
    ..backgroundColor = Colors.transparent
    ..widget(ChooseList(params: params, onConfirm: onConfirm,))
    ..show();
}

class ChooseList extends StatefulWidget {
  final Function onConfirm;

  final params;

  const ChooseList({Key ?key, this.params, required this.onConfirm,}) : super(key: key);

  @override
  _ChooseListState createState() => _ChooseListState();
}

class _ChooseListState extends State<ChooseList> {

  List<dynamic> colIndex=[]; //数组下标集合

  List<dynamic> colContentList = []; //所有列实时的数据源

  final List<FixedExtentScrollController> scrollController = [];

  @override
  void initState() {
    super.initState();
    final indexs = widget.params['indexs'];
    final colNum = widget.params['colNum'];
    if (scrollController.length == 0) {
      if(indexs.length == 0) { //没选择数据的时候是这个逻辑
        for (int i = 0; i < colNum; i++) { // colNum 表示多少列
          scrollController.add(FixedExtentScrollController(initialItem: 0));
        }
      } else { // 选择完数据的时候
        for (int i = 0; i < colNum; i++) {
          scrollController.add(FixedExtentScrollController(initialItem: indexs[i]));
        }
      }
    }
    initIndexs(indexs, colNum);
    colContentList = initData(colIndex, colNum, widget.params['initData']);
  }

  //初始化下标
  void initIndexs(indexs,colNum) {
    if(indexs.length ==0){
      for (int i = 0; i < colNum; i++) {
        colIndex.add(0);
      }
    } else { // 选中之后再次进来
      colIndex = indexs;
    }
  }

  /**
   * industriesData 数据源
   *
   * */
  initData(indexs, colNum, initData) {
    var dataList = []; //最终的各列的数据
    var level = 0;
    for(var i = 0; i < colNum; i++) {
      dataList.add([]);
    }
    recursionDataHandle(indexs, colNum, initData, level,dataList);
    return dataList;
  }

  /**
   * 递归执行函数
   */
  void recursionDataHandle(indexs, colNum, initData, level,dataList) {
    for(var i = 0; i < initData.length; i++) {
      if(level != colNum) {
        dataList[level].add({"value": initData[i]['value'], "label": initData[i]['label']});
      } else { //已经执行n层
        return ;
      }
    }
    //处理下一级的数据
    var levelData =  initData?[indexs[level]];
    if(levelData !=null  && levelData['children'] != null && levelData['children'].length>0) { //递归
      level++; //层级加1
      recursionDataHandle(indexs, colNum, initData[indexs[level-1]]['children'], level, dataList);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 280,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.vertical(
            top: Radius.circular(16)),
        color: Colors.white,
      ),
      child: Column(
        children: [
          vGap(10),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center, //横轴居中对齐(默认)
              children: [
                GestureDetector( //手势
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                      width: 30.0,
                      height: 30.0,
                      child: Text(
                        "取消",
                        style: TextStyle(
                            color: Colors.grey,
                            fontSize: 14),
                      )
                  ),
                ),
                Text(
                  "",
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                    var names = getAllNames();
                    widget.onConfirm({'indexs':colIndex, "names":names });
                  },
                  child: Container(
                      width: 30.0,
                      height: 30.0,
                      child: Text(
                        "确定",
                        style: TextStyle(
                            color: Colors.blueAccent,
                            fontSize: 14),
                      )
                  ),
                )
              ],
            ),
          ),
          vGap(10),
          Row(
              children: cuputedScroll()
          )
        ],
      ),
    );
  }

  Widget buildCity(
      {List<dynamic> ? list,
        FixedExtentScrollController ? scroll,
        int ? columnNum,
        Function ? onSelected}) {
    return Expanded(
      flex: 1,
      child: Container(
          height: 230,
          child: list?.length != 0
              ? CupertinoPicker.builder(
            scrollController: scroll,
            itemExtent: 30,
            diameterRatio: 3,
            squeeze: 0.8,
            onSelectedItemChanged: (int _index) {
              selectdeHandel(_index, columnNum);
            },
            itemBuilder: (context, index) {
              return Center(
                  child: Text(
                    "${list?[index]['label']}",
                    style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600),
                  ));
            },
            childCount: list?.length,
          )
              : Container()),
    );
  }

  // 纵向间距
  static SizedBox vGap(double height){
    return SizedBox(
      height: height,
    );
  }

  // 计算 scroll的列
  cuputedScroll () {
    List<Widget> buildCitys =[];
    for(var i =0; i< colContentList.length; i++ ){
      buildCitys.add(buildCity(list: colContentList[i], scroll: scrollController[i],columnNum: i));
    }
    return buildCitys;
  }

  // 滑动某一列的列的时候
  selectdeHandel(int _index, columnNum) {
    for(var i = columnNum; i< colIndex.length; i++) {
      setState(() {
        if(i== columnNum) {
          colIndex[i] = _index;
        } else {
          colIndex[i] = 0;
        }
      });
    }
    var tmpData  = initData(colIndex, widget.params['colNum'],  widget.params['initData']);
    setState(() {
      colContentList = tmpData;
    });
    if(columnNum !=colIndex.length-1) { //不是最后一列，滚动前一列，则后面每一列都需要滚动第一个元素位置上
      if (scrollController[columnNum+1].hasClients) {
        scrollController[columnNum+1].jumpTo(0.0);
      }
    }
  }

  //获取选择的数据
  getAllNames() {
    List<dynamic> names = [];
    for(var i = 0; i < colContentList.length; i++) {
      if(colContentList[i].length >0) {
        names.add(colContentList[i][colIndex[i]]);
      }
    }
    return names;
  }
}