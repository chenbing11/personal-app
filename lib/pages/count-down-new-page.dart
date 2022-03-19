

import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';


class CountDownNewPage extends StatefulWidget {

  @override
  _CountDownNewPageState createState() => _CountDownNewPageState();
}

class _CountDownNewPageState extends State<CountDownNewPage> {
  StreamController<String> controller =StreamController();
  String data = ''; //实时显示的值
  dynamic _timer = null;//定义一个计时器
  int timerNumer = 3; //倒计时总数（单位为秒）

  @override
  void initState() {
    super.initState();
    setStream();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("倒计时"),
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
                    setStream(); //再次点击需要重置流，否则提示bad state
                    buildRedisterSuccDialog(context); //打开定时器弹窗
                  },
                  child: Row(
                    children: [
                      Text('倒计时弹窗'),
                    ],
                  ),
                ),
                Text(
                  data,
                  style: TextStyle(fontSize: 28),
                  textAlign: TextAlign.center,
                ),
                Container(
                  height: 18.0,
                ),
              ]
          ),
        ),
      ),
    );
  }

  //登录成功倒计时弹窗
  void buildRedisterSuccDialog(BuildContext context) {
    setState(() {
      controller.add(data = timerNumer.toString());// 流中添加元素
    });
    // controller.add(data = timerNumer.toString());// 流中添加元素
    startCountDown(
      timerNumer,
      (value) {
        setState(() {
          controller.add(data = value);
        });

      },
      () { //定时器结束
        setState(() {
         controller.add(data = '0');
        });
        Navigator.of(context).pop(true); //关闭对话框
      }
    );//倒计时

    showCupertinoDialog(
      context: context,
      builder: (BuildContext context) {
        return CupertinoAlertDialog(
          title: Text(
            '倒计时',
            style: TextStyle(fontWeight: FontWeight.bold, ),
          ),
          content:  Container(
              child: Column(
                  children:[
                    SizedBox(height:12.0),
                    Text(
                        '倒计时文本1',
                        style: TextStyle(fontSize: 10.0,
                            color: Color(0xff333333)),
                        textAlign: TextAlign.center
                    ),
                    SizedBox(height:4.0),
                  ]
              )
          ),
          actions: <Widget>[
            Container(
                child: StreamBuilder<String>(
                    stream: controller.stream,
                    initialData: '',
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      return FlatButton(
                          child: Text("倒计时（${snapshot.data}）" , style: TextStyle(
                            fontSize: 20.0,
                            color: Color(0xff315efb),
                          ),),
                          onPressed: () async {
                            Navigator.of(context).pop(true); //关闭对话框
                            clearTimer();//清除定时器
                            //to do
                          }
                      );
                    }
                )
            ),
          ],
        );
      },
    );
  }



  /**
    * 倒计时方法，
    * setValueFun 每间隔一秒执行回调重置值；
    * callBackFun定时器结束是的回调函数
  */

  void startCountDown(int time, Function setValueFun, Function callBackFun) {
    // 重新计时的时候要把之前的清除掉
    clearTimer();
    if (time <= 0) {
      return;
    }
    var countTime = time;
    const repeatPeriod = const Duration(seconds: 1);
    _timer = Timer.periodic(repeatPeriod, (timer) {
      if (countTime <= 0) {
        clearTimer();
        //倒计时结束，可以在这里做相应的操
        callBackFun(); //定时器结束时的回调函数
        return;
      }
      countTime--;
      //外面传进来的单位是秒，所以需要根据总秒数，计算小时，分钟，秒
      int hour = (countTime ~/ 3600) % 24;
      int minute = countTime % 3600 ~/60;
      int second = countTime % 60;

      String str = '';
      if (hour > 0) {
        str = str + hour.toString()+':';
      }

      if(minute > 0) {
        if (minute / 10 < 1) {//当只有个位数时，给前面加“0”，实现效果：“:01”,":02"
          str = str + '0' + minute.toString() + ":";
        } else {
          str = str + minute.toString() + ":";
        }
      }
      if (second / 10 < 1) {
        if(hour == 0 && minute == 0) {
          str = str + second.toString();
        } else {
          str = str + '0' + second.toString();
        }
      } else {
        str = str + second.toString();
      }
      setValueFun(str);
    });
  }

  //清除倒计时
  void clearTimer(){
    if (_timer != null) {
      // if (_timer.isActive) {
      _timer.cancel();
      _timer = null;
      // }
    }
  }

  // 重设置 数据流
  void setStream () {
    data = '';
    //第一步：构造数据数据的控制器，用于往流中添加数据
    controller = StreamController();
  }

  @override
  void dispose() {
    super.dispose();
    clearTimer();
  }
}
