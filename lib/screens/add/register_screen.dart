import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:j2m/main.dart';
import 'package:j2m/utils/api_connect.dart';
import 'package:j2m/models/agent_model.dart';
import '../home/home_screens.dart';
import 'package:http/http.dart' show Client;


final GlobalKey<ScaffoldState> _scaffoldState = GlobalKey<ScaffoldState>();

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();

}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _isLoading = false;
  ApiService _apiService = ApiService();
   
  bool _isFieldNameValid;
  bool _isFieldPasswordValid;
  bool _isFieldTelValid;
  TextEditingController _controllerName = TextEditingController();
  TextEditingController _controllerPassword = TextEditingController();
  TextEditingController _controllerTel = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldState,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black12),
        title: Text(
          "Ajouter Utilisateur",
          style: TextStyle(color: Colors.black26),
        ),
      ),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                _buildTextFieldName(),
                _buildTextFieldPassword(),
                _buildTextFieldAge(),
                Padding(
                  padding: const EdgeInsets.only(top: 8.0),
                  child: RaisedButton(
                    onPressed: () {
                      if (_isFieldNameValid == null ||
                          _isFieldPasswordValid == null ||
                          _isFieldTelValid == null ||
                          !_isFieldNameValid ||
                          !_isFieldPasswordValid ||
                          !_isFieldTelValid) {
                        _scaffoldState.currentState.showSnackBar(
                          SnackBar(
                            content: Text("Remplissez, tous les champs"),
                          ),
                        );
                        return;
                      }
                      setState(() => _isLoading = true);
                      String name = _controllerName.text.toString();
                      String password = _controllerPassword.text.toString();
                      int tel = int.parse(_controllerTel.text.toString());
                       
                      Agent user = Agent (name: name, password: password, tel: tel);
                      _apiService.getProfiles().then((isSuccess) {
                        setState(() => _isLoading = false);
                        if (isSuccess != null) {
                          Navigator.pop(_scaffoldState.currentState.context);
                        } else {
                          _scaffoldState.currentState.showSnackBar(SnackBar(
                            content: Text("Echec de connexion"),
                          ));
                        }
                      });
                    },
                    child: Text(
                      "Connexion".toUpperCase(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    ),
                    color: Colors.orange[600],
                  ),
                )
              ],
            ),
          ),
          _isLoading
              ? Stack(
                  children: <Widget>[
                    Opacity(
                      opacity: 0.3,
                      child: ModalBarrier(
                        dismissible: false,
                        color: Colors.grey,
                      ),
                    ),
                    Center(
                      child: CircularProgressIndicator(),
                    ),
                  ],
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _buildTextFieldName() {
    return TextField(
      controller: _controllerName,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Nom complet",
        errorText: _isFieldNameValid == null || _isFieldNameValid
            ? null
            : "Donnez le nom complet !",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldNameValid) {
          setState(() => _isFieldNameValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldPassword() {
    return TextField(
      controller: _controllerPassword,
      keyboardType: TextInputType.text,
      decoration: InputDecoration(
        labelText: "Password",
        errorText: _isFieldPasswordValid == null || _isFieldPasswordValid
            ? null
            : "Donnez, le mot de passe",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldPasswordValid) {
          setState(() => _isFieldPasswordValid = isFieldValid);
        }
      },
    );
  }

  Widget _buildTextFieldAge() {
    return TextField(
      controller: _controllerTel,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        labelText: "Age",
        errorText: _isFieldTelValid == null || _isFieldTelValid
            ? null
            : "Donnez votre numéro de téléphone",
      ),
      onChanged: (value) {
        bool isFieldValid = value.trim().isNotEmpty;
        if (isFieldValid != _isFieldTelValid) {
          setState(() => _isFieldTelValid = isFieldValid);
        }
      },
    );
  }
}