import 'package:flutter/material.dart';

class SignForm extends StatefulWidget {
  const SignForm({super.key});

  @override
  State<SignForm> createState() => SignFormState();
}

class SignFormState extends State<SignForm> {
  String? email;
  String? password;
  final List<String?> errors = [];
  void addError({String? error}) {
    if (!errors.contains(error)) {
      setState(() {
        errors.add(error);
      });
    }
  }

  void removeError({String? error}) {
    if (errors.contains(error)) {
      setState(() {
        errors.remove(error);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final formkey = GlobalKey<FormState>();
    return Scaffold(
      body: Form(
        key: formkey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              keyboardType: TextInputType.emailAddress,
              onSaved: (_) => email = _,
              onChanged: (value) {
                if (value.isEmpty) {
                  removeError(error: "Please Enter your email");
                  // return "Please Enter your email";
                } else if (RegExp(r"^[a-zA-z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value)) {
                  removeError(error: "Please Enter Valid Email");
                }
                return;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  addError(error: "Please Enter your email");
                  return "Please Enter your email";
                } else if (!RegExp(r"^[a-zA-z0-9]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                    .hasMatch(value)) {
                  addError(error: "Please Enter Valid Email");
                  return "Please Enter Valid Email";
                }
                return null;
              },
              decoration: const InputDecoration(
                  labelText: "Email",
                  hintText: "Enter your email",
                  // If  you are using latest version of flutter then lable text and hint text shown like this
                  // if you r using flutter less then 1.20.* then maybe this is not working properly
                  floatingLabelBehavior: FloatingLabelBehavior.always),
            ),
            TextFormField(
              obscureText: true,
              onSaved: (newValue) => password = newValue,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  removeError(error: "Please Enter your password");
                  
                } else if (value.length >= 8) {
                  removeError(error: "Password is too short");
                }
                return;
              },
              validator: (value) {
                if (value!.isEmpty) {
                  addError(error: "Please Enter your password");
                  return "Please Enter your password";
                } else if (value.length < 8) {
                  addError(error: "Password is too short");
                  return "Password is too short";
                }
                return null;
              },
              decoration: const InputDecoration(
                labelText: "Password",
                hintText: "Enter your password",
                // If  you are using latest version of flutter then lable text and hint text shown like this
                // if your using flutter less then 1.20.* then maybe this is not working properly
                floatingLabelBehavior: FloatingLabelBehavior.always,
              ),
            ),
            // FormError(errors: errors),
            const SizedBox(height: 20),
            SizedBox(
                width: double.infinity,
                height: 56,
                child: TextButton(
                  style: TextButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)),
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.green,
                  ),
                  onPressed: () {
                    if (formkey.currentState!.validate()) {
                      formkey.currentState!.save();
                    }
                  },
                  child: const Text(
                    "Continue",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ))
          ],
        ),
      ),
    );
  }
}

class FormError extends StatelessWidget {
  const FormError({
    super.key,
    required this.errors,
  });

  final List<String?> errors;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
          errors.length, (index) => formErrorText(error: errors[index]!)),
    );
  }

  Row formErrorText({required String error}) {
    return Row(
      children: [
        const FlutterLogo(),
        const SizedBox(
          width: 10,
        ),
        Text(error),
      ],
    );
  }
}
