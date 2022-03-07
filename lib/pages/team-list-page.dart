import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:personal_app/data/company-list.dart';


class TeamListPage extends StatefulWidget {

  @override
  _TeamListPageState createState() => _TeamListPageState();
}

class _TeamListPageState extends State<TeamListPage> {

  String str = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: Scaffold(
        body: LayoutBuilder(builder: (context, constraints) {
        return Container(
          height: MediaQuery.of(context).size.height,
          decoration: BoxDecoration(
            // color:  Color(0xFFFFFFFF),
            image: DecorationImage(
                image: AssetImage("assets/backgroud.png"),
                fit: BoxFit.cover),
          ),
          // padding: EdgeInsets.only(top: 30 ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding:  EdgeInsets.only(top: 50.0, bottom: 80.0, right: 0, left: 0),
                child: Center(
                  child: Text(
                    '团队和行业',
                    style: TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              Padding(
                padding:EdgeInsets.only(top: 0, bottom: 15, right: 0, left: 40),
                child: Text(
                    '请选择要登录的企业',
                    textAlign: TextAlign.left,
                    style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold),

                ),
              ),
              Container(
                margin: EdgeInsets.only(right: 30.0, left: 30.0, top:0),
                height: MediaQuery.of(context).size.height - 260,
                // width: MediaQuery.of(context).size.width * 0.8,
                // color: Color(0xFFFFFFFF),
                // color: Colors.orange,
                decoration: BoxDecoration(
                    color:  Color(0xFFFFFFFF),
                    // image: DecorationImage(
                    //     image: AssetImage("assets/backgroud.png"),
                    //     fit: BoxFit.cover),
                    borderRadius: BorderRadius.circular(6.0),
                    boxShadow: [
                      //卡片阴影
                      BoxShadow(
                        color: Color(0x69BABCE2),
                        offset: Offset(2.0, 2.0),
                        blurRadius: 10.0,
                      )
                    ],
                ),
                child: Scrollbar( // 显示进度条
                  child: SingleChildScrollView(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: Column(
                        //动态创建一个List<Widget>
                        children: CompanyList
                        //每一个字母都用一个Text显示,字体为原来的两倍
                            .map((c) => _buildListItem(c))
                            .toList(),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
        );
      }
    )
    )
    );
  }

  Widget _buildListItem(item){
    return Container(
      padding: EdgeInsets.only(right: 10, left: 10, top: 10, bottom: 20),
      child: Container(
        child: InkWell(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.max,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                // mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Expanded(
                    child: Text(item['Value'],
                      style: TextStyle(
                          fontSize: 20.0,
                          color: Color(0xff121933)
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    flex: 1,
                  ),
                  // Expanded(child: SizedBox()),//自动扩展挤压
                ],
              ),
              // Divider( color: Color(0xffD9DBE8)),
            ],
          ),
          onTap: () {
            print(item['Key']);

          },
        ),
      ),
    );
  }


  @override
  void dispose() {

    super.dispose();
  }
}