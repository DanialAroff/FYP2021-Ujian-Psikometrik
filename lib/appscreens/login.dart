// ignore_for_file: prefer_const_constructors, avoid_print
import 'package:flutter/material.dart';
import 'package:fyp1/services/auth.dart';
import 'package:fyp1/shared/constants.dart';
import 'package:fyp1/shared/loading.dart';
import '../shared/appcolors.dart';

class LoginPage extends StatefulWidget {
  final Function toggleView;

  const LoginPage({Key key, this.toggleView}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final AuthService _auth = AuthService();
  final _formKey = GlobalKey<FormState>();
  bool loading = false;

  // Text field state
  String email = '';
  String password = '';
  String error = '';

  @override
  Widget build(BuildContext context) {
    return loading ? Loading() : Scaffold(
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        left: false,
        right: false,
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/bg-login-3.png'),
              fit: BoxFit.cover,
            ),
          ),
          padding: EdgeInsets.all(10),
          child: Container(
            // height: MediaQuery.of(context).size.height * 0.75,
            margin: EdgeInsets.symmetric(horizontal: 12, vertical: 20),
            padding: EdgeInsets.all(10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(Radius.circular(10)),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  spreadRadius: 4,
                  blurRadius: 20,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Form(
              key: _formKey,
              child: ListView(
                children: <Widget>[
                  SizedBox(height: 20),
                  SizedBox(
                    height: 80,
                    child: Image.asset('assets/LOGO_SMK_DENGKIL.png'),
                  ),
                  Container(
                    alignment: Alignment.center,
                    padding: EdgeInsets.fromLTRB(12, 15, 12, 25),
                    child: const Text(
                      'Ujian Psikometrik',
                      style: TextStyle(
                        color: AppColors.text1,
                        fontWeight: FontWeight.bold,
                        fontSize: 28,
                        fontFamily: 'Nunito Sans',
                      ),
                    ),
                  ),

                  // text field for email (Emel)
                  Container(
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                    child: TextFormField(
                      validator: (val) =>
                          val.isEmpty ? 'Sila masukkan emel' : null,
                      onChanged: (val) {
                        setState(() => email = val);
                      },
                      textAlignVertical: TextAlignVertical.center,
                      style: TextStyle(
                        fontFamily: 'Nunito Sans',
                      ),
                      cursorColor: AppColors.cursor,
                      cursorWidth: 1.6,
                      controller: nameController,
                      decoration: emailInputDecoration,
                    ),
                  ),

                  Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                      child: TextFormField(
                        validator: (val) => val.length < 6
                            ? 'Sila masukkan kata laluan dengan panjang 6 karakter atau lebih'
                            : null,
                        onChanged: (val) {
                          setState(() => password = val);
                        },
                        textAlignVertical: TextAlignVertical.center,
                        style: TextStyle(
                          fontFamily: 'Nunito Sans',
                        ),
                        cursorColor: AppColors.cursor,
                        cursorWidth: 1.6,
                        obscureText: true,
                        controller: passwordController,
                        decoration: passwordInputDecoration,
                      )),

                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    height: 80,
                    padding: EdgeInsets.all(12),
                    child: SizedBox(
                      width: 60,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          primary: AppColors.primary,
                          elevation: 20,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          shadowColor: AppColors.primary.withOpacity(0.2),
                        ),
                        child: const Text(
                          'Log Masuk',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 19,
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        onPressed: () async {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (context) => StudentHomePage()));
                          if (_formKey.currentState.validate()) {
                            setState(() => loading = true);
                            dynamic result = await _auth
                                .logInWithEmailAndPassword(email, password);
                            if (result == null) {
                              setState(() {
                                error = 'Gagal log masuk';
                                loading = false;
                              });
                            } else {
                              debugPrint('LOGIN: ' + result.fullName + ' / ' + result.email);
                            }
                          }
                        },
                      ),
                    ),
                  ),
                  TextButton(
                      onPressed: () {
                        widget.toggleView();
                      },
                      child: const Text(
                        'Daftar Pengguna',
                        style: TextStyle(
                            color: AppColors.primary,
                            fontFamily: 'Nunito Sans',
                            fontWeight: FontWeight.bold),
                      )),
                  SizedBox(height: 12),
                  Text(
                    error,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontFamily: 'Nunito Sans',
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
