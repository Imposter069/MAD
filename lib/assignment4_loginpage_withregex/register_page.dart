import 'package:flutter/material.dart';
import 'utility.dart';
import 'configurations.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => RegisterPageState();
}

class RegisterPageState extends State<RegisterPage> {
  final _useridcontroller = TextEditingController();
  final _passwordcontroller = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  String? _userIdErrorText;
  String? _passwordErrorText;
  String? _confirmPasswordErrorText;
  Widget? _emailValidationWidget;

  Widget _buildEmailValidationRichText(String text) {
    if (text.isEmpty) {
      return const Text('Please enter an email ID',
          style: TextStyle(color: Colors.red, fontSize: 12));
    }

    bool hasPrefix = RegExp(r'^[a-zA-Z0-9]+').hasMatch(text);
    bool hasAt = text.contains('@');

    bool hasDomainPrefix = false;
    bool hasDomainSuffix = false;

    if (hasAt) {
      List<String> parts = text.split('@');
      if (parts.length > 1) {
        String domain = parts[1];
        if (domain.contains('.')) {
          List<String> domainParts = domain.split('.');
          if (domainParts[0].isNotEmpty) hasDomainPrefix = true;
          if (domainParts.last.length >= 2) hasDomainSuffix = true;
        }
      }
    }

    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 12.0),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(fontSize: 13),
          children: [
            TextSpan(
              text: hasPrefix ? "✓ Username present\n" : "✗ Missing username\n",
              style: TextStyle(color: hasPrefix ? Colors.green : Colors.red),
            ),
            TextSpan(
              text: hasAt ? "✓ '@' present\n" : "✗ Missing '@'\n",
              style: TextStyle(color: hasAt ? Colors.green : Colors.red),
            ),
            TextSpan(
              text: hasDomainPrefix
                  ? "✓ Domain present\n"
                  : "✗ Missing domain\n",
              style:
              TextStyle(color: hasDomainPrefix ? Colors.green : Colors.red),
            ),
            TextSpan(
              text: hasDomainSuffix
                  ? "✓ Extension present"
                  : "✗ Missing extension",
              style:
              TextStyle(color: hasDomainSuffix ? Colors.green : Colors.red),
            ),
          ],
        ),
      ),
    );
  }

  void checkUniqueUserId() {
    setState(() {
      String userId = _useridcontroller.text;
      if (!Utility.validateEmail(userId)) {
        _emailValidationWidget = _buildEmailValidationRichText(userId);
        _userIdErrorText = null;
      } else {
        _emailValidationWidget = null;
        bool exists = Configurations.credentials
            .any((cred) => cred['userid'] == userId);
        _userIdErrorText =
        exists ? 'User ID already exists' : null;

        if (!exists) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('User ID available')),
          );
        }
      }
    });
  }

  void validate() {
    setState(() {
      String userId = _useridcontroller.text;
      if (!Utility.validateEmail(userId)) {
        _emailValidationWidget = _buildEmailValidationRichText(userId);
        _userIdErrorText = null;
      } else {
        _emailValidationWidget = null;
        if (Configurations.credentials
            .any((cred) => cred['userid'] == userId)) {
          _userIdErrorText = 'User ID already exists';
        } else {
          _userIdErrorText = null;
        }
      }

      String password = _passwordcontroller.text;
      if (password.isEmpty) {
        _passwordErrorText = 'Enter password';
      }
      else {
        _passwordErrorText = null;
      }

      _confirmPasswordErrorText =
      _confirmPasswordController.text != password
          ? 'Passwords do not match'
          : null;
    });

    if (_emailValidationWidget == null &&
        _userIdErrorText == null &&
        _passwordErrorText == null &&
        _confirmPasswordErrorText == null) {
      Configurations.credentials.add({
        'userid': _useridcontroller.text,
        'password': _passwordcontroller.text,
      });

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Registration Successful!')),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text("Create Account",
                  style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.teal)),

              const SizedBox(height: 25),

              TextField(
                controller: _useridcontroller,
                decoration: InputDecoration(
                  hintText: 'Enter email',
                  prefixIcon:
                  const Icon(Icons.email, color: Colors.teal),
                  suffixIcon: InkWell(
                    onTap: checkUniqueUserId,
                    child: const Padding(
                      padding: EdgeInsets.all(12),
                      child: Text("Check",
                          style: TextStyle(color: Colors.teal)),
                    ),
                  ),
                  errorText: _userIdErrorText,
                  filled: true,
                  fillColor: Colors.teal.shade50,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
              ),

              if (_emailValidationWidget != null)
                _emailValidationWidget!,

              const SizedBox(height: 20),

              TextField(
                controller: _passwordcontroller,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Password',
                  prefixIcon:
                  const Icon(Icons.lock, color: Colors.teal),
                  errorText: _passwordErrorText,
                  filled: true,
                  fillColor: Colors.teal.shade50,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
              ),

              const SizedBox(height: 20),

              TextField(
                controller: _confirmPasswordController,
                obscureText: true,
                decoration: InputDecoration(
                  hintText: 'Confirm Password',
                  prefixIcon:
                  const Icon(Icons.lock_outline, color: Colors.teal),
                  errorText: _confirmPasswordErrorText,
                  filled: true,
                  fillColor: Colors.teal.shade50,
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14)),
                ),
              ),

              const SizedBox(height: 30),

              SizedBox(
                height: 50,
                child: ElevatedButton(
                  onPressed: validate,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.teal),
                  child: const Text("Register"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}