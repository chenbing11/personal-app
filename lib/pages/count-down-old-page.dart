import 'package:flutter/material.dart';
import 'dart:async';
import 'package:flutter/cupertino.dart';

class CountDownOldPage extends StatefulWidget {
  @override
  _CountDownOldPageState createState() => _CountDownOldPageState();
}

class _CountDownOldPageState extends State<CountDownOldPage> {
  String data = ''; // 实时显示的值
  dynamic _timer = null;//定义一个计时器
  int timerNumer = 3; //倒计时总数（单位为秒）

  @override
  void initState() {
    super.initState();
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
                    data = '';
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
      data = timerNumer.toString();
    });
    startCountDown(
      timerNumer,
      (value) {
        setState(() {
          data = value;
        });
      },
      () { //定时器结束
        setState(() {
           data = '0';
        });
        Navigator.of(context).pop(true); //关闭对话框
      }
    );//倒计时

    // 这里有坑，必须是 StreamBuilder 数据流的形式，直接设置setState 数据不行
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
                child: FlatButton(
                          child: Text("倒计时（$data）" , style: TextStyle(
                            fontSize: 20.0,
                            color: Color(0xff315efb),
                          ),),
                          onPressed: () async {
                            Navigator.of(context).pop(true); //关闭对话框
                            clearTimer();//清除定时器
                            //to do
                          }
                      ),
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

  @override
  void dispose() {
    super.dispose();
    clearTimer();
  }
}
