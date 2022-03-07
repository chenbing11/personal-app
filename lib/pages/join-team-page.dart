import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class JoinTeamPage extends StatefulWidget {

  @override
  _JoinTeamPageState createState() => _JoinTeamPageState();
}

class _JoinTeamPageState extends State<JoinTeamPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: false,
      child: CupertinoPageScaffold(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage("assets/backgroud.png"),
                    fit: BoxFit.cover)),
            child: Column(
              children: [
                Container(
                  padding: EdgeInsets.only(right: 15.0, left: 15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                            top: 24.0, bottom: 33.0, right: 0, left: 0),
                        child: Center(
                          child: Text(
                            '加入企业',
                            style: TextStyle(
                                fontSize: 20.0, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Image.asset("assets/join_crop.png"),
                      Container(
                        padding: EdgeInsets.only(top: 30.0),
                        child: Column(children: [
                          Text(
                            '邀请你加入',
                            style: TextStyle(
                              color: Color(0xff121933),
                              fontSize: 20.0,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 28.0),
                            child: _buildNextButton(),
                          ),
                          _buildCancelButton(),
                        ]),
                      ),
                    ],
                    // ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  ConstrainedBox _buildNextButton() {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: double.infinity, maxHeight: 54.0),
      child: CupertinoButton(
          padding: EdgeInsets.only(right: 15.0, left: 15.0),
          color: Color(0xff315EFB),
          borderRadius: const BorderRadius.all(Radius.circular(6.0)),
          disabledColor: Color(0xffE8EAF1),
          child: Text(
            '加入',
            style: TextStyle(
              fontSize: 20.0,
            ),
          ),
          onPressed: () => _agreeInvite()),
    );
  }

  ConstrainedBox _buildCancelButton() {
    return ConstrainedBox(
      constraints: BoxConstraints(minWidth: double.infinity, maxHeight: 54.0),
      child: CupertinoButton(
          padding: EdgeInsets.only(right: 15.0, left: 15.0),
          borderRadius: const BorderRadius.all(Radius.circular(6.0)),
          child: Text(
            '取消',
            style: TextStyle(
              fontSize: 20.0,
              color: Color(0xff707481),
            ),
          ),
          onPressed: () => _refuseInvite()),
    );
  }

  @override
  void dispose() {

    super.dispose();
  }

  _refuseInvite() async {
    // bool corpOwnRegister = await vm.refuseCrop();
    // if (corpOwnRegister) {
    //   if (await login_vm.checkTeam()) {
    //     Application.router.navigateTo(context, Routes.webview,
    //         replace: true, clearStack: true);
    //   } else {
    //     Application.router.navigateTo(context, Routes.createTeam,
    //         replace: false, clearStack: false);
    //   }
    // }
  }

  _agreeInvite() async {
    // bool corpOwnRegister = await vm.joinCrop();
    // if (corpOwnRegister) {
    //   Application.router.navigateTo(context, Routes.webview,
    //       replace: true, clearStack: false);
    // }
  }
}