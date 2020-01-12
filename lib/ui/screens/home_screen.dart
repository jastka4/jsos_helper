import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsos_helper/blocs/authentication/authentication.dart';

class HomeScreen extends StatefulWidget {
  HomeScreen({Key key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final AuthenticationBloc _authenticationBloc =
        BlocProvider.of<AuthenticationBloc>(context);

    return Scaffold(
      appBar: AppBar(
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
      ),
      body: Container(
        margin: EdgeInsets.only(top: 16.0),
        padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Column(
          children: <Widget>[
            Row(children: <Widget>[
              Expanded(child: _buildNewsFeed(context)),
            ]),
          ],
        ),
      ),
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
              padding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0.0)),
          ListView.separated(
            padding: EdgeInsets.all(16.0),
            shrinkWrap: true,
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) {
              return _buildNewsCard(); // TODO - get data from the web
            },
          )
        ],
      ),
    );
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
