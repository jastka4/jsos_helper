import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsos_helper/blocs/authentication/authentication.dart';
import 'package:jsos_helper/common/university.dart';
import 'package:jsos_helper/models/user.dart';
import 'package:jsos_helper/repositories/user_repository.dart';
import 'package:jsos_helper/ui/components/loading_indicator.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final UserRepository _userRepository = new UserRepository();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc _authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);

    return Scaffold(
      appBar: _buildAppBar(_authenticationBloc),
      body: Container(
        margin: EdgeInsets.only(top: 16.0),
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              Row(children: <Widget>[
                Expanded(child: _buildProfileInfo(_authenticationBloc))
              ]),
              Row(children: <Widget>[Expanded(child: _buildNewsFeed(context))]),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildAppBar(AuthenticationBloc _authenticationBloc) {
    return AppBar(
      title: Text('Home'),
      centerTitle: true,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.exit_to_app),
          tooltip: 'Logout',
          onPressed: () {
            _authenticationBloc.dispatch(LoggedOut());
          },
        ),
        IconButton(
          icon: const Icon(Icons.settings),
          tooltip: 'Settings',
          onPressed: () {
//                _authenticationBloc.dispatch(LoggedOut());
          },
        ),
      ],
    );
  }

  Widget _buildNewsFeed(BuildContext context) {
    return Card(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            child: Text('News',
                style: DefaultTextStyle.of(context).style.apply(
                      fontSizeFactor: 1.3,
                      fontWeightDelta: 3,
                    )),
            padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0),
          ),
          ListView.separated(
            primary: false,
            padding: EdgeInsets.all(16.0),
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: 5,
            itemBuilder: (BuildContext context, int index) {
              return _buildNewsCard(); // TODO - get data from the web
            },
          )
        ],
      ),
    );
  }

  Widget _buildProfileInfo(AuthenticationBloc _authenticationBloc) {
    return FutureBuilder<User>(
        future: _userRepository.getUser('pwr230115'),
        builder: (BuildContext context, AsyncSnapshot<User> snapshot) {
          if (snapshot.hasData) {
            User _user = snapshot.data;
            Uint8List _decodedImage = Base64Decoder().convert(_user.image);

            return Card(
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      'Profile',
                      style: DefaultTextStyle.of(context)
                          .style
                          .apply(fontSizeFactor: 1.3, fontWeightDelta: 3),
                    ),
                    const SizedBox(height: 16.0),
                    CircleAvatar(backgroundImage: MemoryImage(_decodedImage)),
                    Text('Name:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(_user.fullName),
                    Divider(),
                    Text('Student number:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(_user.studentNumber),
                    Divider(),
                    Text('University',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(_user.university.name),
                    Divider(),
                    Text('Degree:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(_user.degree),
                    Divider(),
                    Text('Faculty:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(_user.faculty),
                    Divider(),
                    Text('Subject',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(_user.subject),
                    Divider(),
                    Text('Sepcialization:',
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text(_user.specialization),
                  ],
                ),
              ),
            );
          } else {
            return LoadingIndicator();
          }
        });
  }

  Widget _buildNewsCard() {
    return InkWell(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text('Godziny pracy Sekcji Informatycznej'),
            const SizedBox(height: 8.0),
            Text('Data: 07.01.2020', style: TextStyle(color: Colors.grey))
          ]),
      onTap: () =>
          print('News tapped!'), // TODO - use FlutterWebviewPlugin to read news
    );
  }
}
