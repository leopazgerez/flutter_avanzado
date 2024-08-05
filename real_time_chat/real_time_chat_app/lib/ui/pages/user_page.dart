import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:real_time_chat_app/services/auth_service.dart';

import '../../models/user_model.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  _UserPageState createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {
  late final RefreshController _refreshController;

  final userModels = [
    UserModel(uid: '1', name: 'María', email: 'test1@test.com', online: true),
    UserModel(
        uid: '2', name: 'Melissa', email: 'test2@test.com', online: false),
    UserModel(
        uid: '3', name: 'Fernando', email: 'test3@test.com', online: true),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _refreshController = RefreshController(initialRefresh: false);
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);
    return Scaffold(
        appBar: AppBar(
          title:const Text('Mi nombre', style: TextStyle(color: Colors.black87)),
          elevation: 1,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.black87),
            onPressed: () {
              Navigator.pushReplacementNamed(context, 'logInPage');
              AuthService.deleteToken();
            },
          ),
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 10),
              child: Icon(Icons.check_circle, color: Colors.blue[400]),
              // child: Icon( Icons.offline_bolt, color: Colors.red ),
            )
          ],
        ),
        body: SmartRefresher(
          controller: _refreshController,
          enablePullDown: true,
          onRefresh: _loadUserModels,
          header: WaterDropHeader(
            complete: Icon(Icons.check, color: Colors.blue[400]),
            waterDropColor: Colors.blue.withOpacity(0.7),
          ),
          child: _listViewUserModels(),
        ));
  }

  ListView _listViewUserModels() {
    return ListView.separated(
        physics: const BouncingScrollPhysics(),
        itemBuilder: (_, i) => _userModelListTile(userModels[i]),
        separatorBuilder: (_, i) => const Divider(),
        itemCount: userModels.length);
  }

  ListTile _userModelListTile(UserModel userModel) {
    return ListTile(
      title: Text(userModel.name!),
      subtitle: Text(userModel.email!),
      leading: CircleAvatar(
        child: Text(userModel.name!.substring(0, 2)),
        backgroundColor: Colors.blue[100],
      ),
      trailing: Container(
        width: 10,
        height: 10,
        decoration: BoxDecoration(
            color: userModel.online! ? Colors.green[300] : Colors.red,
            borderRadius: BorderRadius.circular(100)),
      ),
    );
  }

  _loadUserModels() async {
    await Future.delayed(const Duration(milliseconds: 1000));
    // if failed,use refreshFailed()
    _refreshController.refreshCompleted();
  }
}
