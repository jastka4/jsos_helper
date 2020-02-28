import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:jsos_helper/blocs/login/login.dart';
import 'package:jsos_helper/common/university.dart';

class LoginForm extends StatefulWidget {
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  final _usernameController = TextEditingController();
  final _passwordController = TextEditingController();

  List<DropdownMenuItem<University>> _dropDownMenuItems;
  University _currentUniversity;

  @override
  void initState() {
    _dropDownMenuItems = _getDropDownMenuItems();
    _currentUniversity = _dropDownMenuItems[0].value;
    super.initState();
  }

  List<DropdownMenuItem<University>> _getDropDownMenuItems() {
    List<DropdownMenuItem<University>> items = new List();
    for (University university in University.values) {
      items.add(new DropdownMenuItem(
          value: university, child: new Text(university.name)));
    }
    return items;
  }

  @override
  Widget build(BuildContext context) {
    final _loginBloc = BlocProvider.of<LoginBloc>(context);

    _onLoginButtonPressed() {
      _loginBloc.dispatch(LoginButtonPressed(
        username: _usernameController.text,
        password: _passwordController.text,
        university: _currentUniversity,
      ));
    }

    _onChangedDropDownItem(University selectedUniversity) {
      setState(() {
        _currentUniversity = selectedUniversity;
      });
    }

    return BlocListener(
      bloc: _loginBloc,
      listener: (context, state) {
        if (state is LoginFailure) {
          Scaffold.of(context).showSnackBar(
            SnackBar(
                content: Text('${state.error}'),
                backgroundColor: Colors.red[700]),
          );
        }
      },
      child: BlocBuilder<LoginEvent, LoginState>(
        bloc: _loginBloc,
        builder: (
          BuildContext context,
          LoginState state,
        ) {
          return Form(
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 10.0,
                      right: 10.0,
                    ),
                    child: Column(
                      children: <Widget>[
                        DropdownButtonHideUnderline(
                          child: DropdownButton(
                            value: _currentUniversity,
                            items: _dropDownMenuItems,
                            onChanged: _onChangedDropDownItem,
                          ),
                        ),
                        Divider(),
                        TextFormField(
                          decoration: InputDecoration(
                            icon: Icon(Icons.person_outline),
                            labelText: 'Username',
                            border: InputBorder.none,
                          ),
                          controller: _usernameController,
                        ),
                        Divider(),
                        TextFormField(
                          decoration: InputDecoration(
                            icon: Icon(Icons.lock_outline),
                            labelText: 'Password',
                            border: InputBorder.none,
                          ),
                          controller: _passwordController,
                          obscureText: true,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 25.0),
                RaisedButton(
                  onPressed:
                      state is! LoginLoading ? _onLoginButtonPressed : null,
                  child: Text('Login'),
                  shape: new RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                Container(
                  child: state is LoginLoading
                      ? CircularProgressIndicator()
                      : null,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
