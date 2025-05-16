import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class SignupScreen extends StatefulWidget {
  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _formKey = GlobalKey<FormState>();

  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final dobController = TextEditingController();

  String? selectedGender;
  String? selectedCountry;

  final List<String> genders = ['Male', 'Female', 'Other'];
  final List<String> countries = ['Nepal', 'India', 'USA', 'UK'];

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    usernameController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    dobController.dispose();
    super.dispose();
  }

  Widget _buildTextField(TextEditingController controller, String label,
      {bool isPassword = false, TextInputType keyboardType = TextInputType.text}) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        border: const OutlineInputBorder(),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) return 'Enter $label';
        if (label == 'Email' && !value.contains('@')) return 'Enter valid email';
        if (label == 'Password' && value.length < 6) return 'Minimum 6 characters';
        return null;
      },
    );
  }

  void _selectDOB() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime(2000),
      firstDate: DateTime(1950),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
      setState(() {
        dobController.text = formattedDate;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (passwordController.text != confirmPasswordController.text) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Passwords do not match")),
        );
        return;
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Account created successfully!")),
      );

      Future.delayed(const Duration(seconds: 1), () {
        Navigator.pop(context); // back to login
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: [Color(0xFFFFE082), Color(0xFFFFAB40)],
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
          ),
        ),
        padding: const EdgeInsets.all(20),
        child: SafeArea(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Center(
                    child: Text(
                      "MigX",
                      style: TextStyle(
                        fontSize: 42,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        letterSpacing: 2,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Center(
                    child: Text(
                      "Create your account",
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 30),

                  _buildTextField(fullNameController, 'Full Name'),
                  const SizedBox(height: 10),

                  _buildTextField(emailController, 'Email', keyboardType: TextInputType.emailAddress),
                  const SizedBox(height: 10),

                  _buildTextField(usernameController, 'Username'),
                  const SizedBox(height: 10),

                  TextFormField(
                    controller: dobController,
                    readOnly: true,
                    decoration: const InputDecoration(
                      labelText: 'Date of Birth',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.calendar_today),
                    ),
                    onTap: _selectDOB,
                    validator: (value) => value == null || value.isEmpty ? 'Select date of birth' : null,
                  ),
                  const SizedBox(height: 10),

                  _buildTextField(passwordController, 'Password', isPassword: true),
                  const SizedBox(height: 10),

                  _buildTextField(confirmPasswordController, 'Confirm Password', isPassword: true),
                  const SizedBox(height: 10),

                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Gender',
                      border: OutlineInputBorder(),
                    ),
                    value: selectedGender,
                    items: genders
                        .map((gender) => DropdownMenuItem(
                              value: gender,
                              child: Text(gender),
                            ))
                        .toList(),
                    onChanged: (value) => setState(() => selectedGender = value),
                    validator: (value) => value == null ? 'Select gender' : null,
                  ),
                  const SizedBox(height: 10),

                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Country',
                      border: OutlineInputBorder(),
                    ),
                    value: selectedCountry,
                    items: countries
                        .map((country) => DropdownMenuItem(
                              value: country,
                              child: Text(country),
                            ))
                        .toList(),
                    onChanged: (value) => setState(() => selectedCountry = value),
                    validator: (value) => value == null ? 'Select country' : null,
                  ),
                  const SizedBox(height: 20),

                  ElevatedButton(
                    onPressed: _submitForm,
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size.fromHeight(50),
                      backgroundColor: Colors.green,
                    ),
                    child: const Text("Sign Up", style: TextStyle(fontSize: 16)),
                  ),
                  const SizedBox(height: 15),

                  Center(
                    child: GestureDetector(
                      onTap: () => Navigator.pop(context),
                      child: const Text(
                        "Already have an account? Login",
                        style: TextStyle(color: Colors.white, decoration: TextDecoration.underline),
                      ),
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
