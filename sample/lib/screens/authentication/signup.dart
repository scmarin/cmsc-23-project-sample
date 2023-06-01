import 'package:flutter/material.dart';
// import 'package:hao_are_you/providers/user_info_provider.dart';
import 'package:provider/provider.dart';
import 'package:sample/providers/entries_provider.dart';
import '../../models/model_user_info.dart';
import '../../providers/auth_provider.dart';

class SignupChooseUser extends StatelessWidget {
  const SignupChooseUser({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text("Sign Up"),
          leading: TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          )),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SignupPage(signupType: "Student")));
              },
              child: const Text("Sign Up as Student"),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => SignupPage(signupType: "Admin")));
              },
              child: const Text("Sign Up as Admin"),
            ),
            const SizedBox(height: 40),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) =>
                        SignupPage(signupType: "Entrance Monitor")));
              },
              child: const Text("Sign Up as Monitor"),
            ),
          ],
        ),
      ),
    );
  }
}

class SignupPage extends StatefulWidget {
  String signupType;
  SignupPage({super.key, required this.signupType});
  @override
  _SignupPageState createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  List<String> illnessesValues = [];

  final List<String> _illnesses = [
    "Hypertension",
    "Diabetes",
    "Tuberculosis",
    "Cancer",
    "Kidney Disease",
    "Cardiac Disease",
    "Autoimmune Disease",
    "Asthma",
    "Allergies"
  ];

  int allergyWidgetCount = 0;
  List<String> allergyList = [];
  List<Widget> allergyWidgetList = [];

  late UserInfoModel studentData;

  late UserInfoModel adminMonitorData;

  final _formKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController usernameController = TextEditingController();
  TextEditingController collegeController = TextEditingController();
  TextEditingController courseController = TextEditingController();
  TextEditingController studentnoController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController empNoController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController homeUnitController = TextEditingController();

  void clear() {
    nameController.clear();
    usernameController.clear();
    collegeController.clear();
    courseController.clear();
    studentnoController.clear();
    emailController.clear();
    passwordController.clear();
    empNoController.clear();
    positionController.clear();
    homeUnitController.clear();
  }

  @override
  Widget build(BuildContext context) {
    // Checkbox button

    final name = TextFormField(
      controller: nameController,
      decoration: const InputDecoration(
        hintText: "Name",
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter your name";
        }

        return null;
      },
    );

    final username = TextFormField(
      controller: usernameController,
      decoration: const InputDecoration(
        hintText: 'Username',
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter your username";
        }

        return null;
      },
    );

    final college = TextFormField(
      controller: collegeController,
      decoration: const InputDecoration(
        hintText: "College",
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter your college";
        }

        return null;
      },
    );

    final course = TextFormField(
      controller: courseController,
      decoration: const InputDecoration(
        hintText: 'Course',
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter your course";
        }

        return null;
      },
    );

    final studentno = TextFormField(
      controller: studentnoController,
      decoration: const InputDecoration(
        hintText: "Student No.",
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter your student number";
        } else if (!RegExp(r"^[0-9]{4}-[0-9]{5}$").hasMatch(value)) {
          return "Enter a valid student number";
        }

        return null;
      },
    );

    final email = TextFormField(
      controller: emailController,
      decoration: const InputDecoration(
        hintText: "Email",
      ),
      validator: (value) {
        if (!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(value!) ||
            value.isEmpty) {
          return ("Please enter a valid email");
        }
        return null;
      },
    );

    final password = TextFormField(
      controller: passwordController,
      obscureText: true,
      decoration: const InputDecoration(
        hintText: 'Password',
      ),
      validator: (value) {
        if (value!.isEmpty) {
          return "Please enter your password";
        } else if (value.length < 6) {
          return "Password must be at least 6 characters.";
        }

        return null;
      },
    );

    final empNo = TextFormField(
      controller: empNoController,
      decoration: const InputDecoration(
        hintText: 'Employee Number',
      ),
      validator: (value) {
        if (value == "" || value == null) {
          return "Please put your employee number";
        }
        return null;
      },
    );

    final position = TextFormField(
      controller: positionController,
      decoration: const InputDecoration(
        hintText: 'Position',
      ),
      validator: (value) {
        if (value == "" || value == null) {
          return "Please put your position";
        }
        return null;
      },
    );

    final homeUnit = TextFormField(
      controller: homeUnitController,
      decoration: const InputDecoration(
        hintText: 'Home Unit',
      ),
      validator: (value) {
        if (value == "" || value == null) {
          return "Please put your home unit";
        }
        return null;
      },
    );

    final illnesses = Column(
      children: _illnesses.map((String illness) {
        return Row(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5),
              child: Checkbox(
                value: illnessesValues.contains(illness),
                onChanged: (bool? value) {
                  if (value!) {
                    setState(() {
                      illnessesValues.add(illness);
                    });
                  } else {
                    setState(() {
                      illnessesValues.remove(illness);
                    });
                  }
                },
              ),
            ),
            Text(illness),
          ],
        );
      }).toList(),
    );

    Future<void> signUp(UserInfoModel userData) async {
      print("check sign up");
      String? result;
      result = await context
          .read<AuthProvider>()
          .signUp(emailController.text, passwordController.text, userData);

      if (result == "email-already-in-use") {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Email is already in use."),
            backgroundColor: Colors.red,
          ));
        }
        return;
      }
      context.read<EntriesProvider>().fetchEntries(result!);
      clear();
      Navigator.popUntil(context, ModalRoute.withName("/"));
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              "New ${widget.signupType.toLowerCase()} account has been created.")));
    }

    void makeAllergyTextFields(int allergyWidgetCount,
        List<Widget> allergyWidgetList, List<String> allergyList) {
      print(allergyList);
      allergyWidgetList.clear();
      for (int i = 0; i < allergyWidgetCount; i++) {
        print(allergyWidgetList);
        print(allergyList[i]);
        setState(() {
          allergyWidgetList.add(Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.55,
                child: TextFormField(
                  onChanged: (text) {
                    allergyList[i] = text;
                    print(allergyList);
                  },
                  decoration: const InputDecoration(hintText: "Add an allergy"),
                ),
              ),
              TextButton(
                  onPressed: () {
                    allergyList.removeAt(i);
                    print(allergyList);
                    allergyWidgetCount--;
                    makeAllergyTextFields(
                        allergyWidgetCount, allergyWidgetList, allergyList);
                  },
                  child: const Icon(Icons.delete_outline))
            ],
          ));
        });
      }
    }

    ;

    void ShowWarning(String warningTitle) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(warningTitle),
          duration: const Duration(seconds: 2),
        ),
      );
    }

    final backButton = Padding(
      padding: const EdgeInsets.symmetric(vertical: 16.0),
      child: ElevatedButton(
        onPressed: () async {
          Navigator.pop(context);
        },
        child: const Text('Back', style: TextStyle(color: Colors.white)),
      ),
    );

    List<Widget> studentSignUpForm() {
      return [
        const SizedBox(height: 32),
        const Text(
          "Sign Up",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        name,
        username,
        college,
        course,
        studentno,
        email,
        password,
        const SizedBox(height: 24),
        const Text(
          "Pre-existing Illness",
          textAlign: TextAlign.left,
          style: TextStyle(fontSize: 20),
        ),
        const SizedBox(height: 12),
        illnesses,
        if (illnessesValues.contains("Allergies"))
          Column(children: allergyWidgetList),
        if (illnessesValues.contains("Allergies"))
          TextButton(
              onPressed: () {
                allergyList.add("");
                allergyWidgetCount++;
                makeAllergyTextFields(
                    allergyWidgetCount, allergyWidgetList, allergyList);
              },
              child: const Icon(Icons.add_circle)),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              studentData = UserInfoModel(
                  name: nameController.text,
                  email: emailController.text,
                  entries: [],
                  status: "Cleared",
                  userType: "Student",
                  preExistingIllnesses: {
                    "Illnesses": illnessesValues,
                    "Allergies": allergyList
                  },
                  college: collegeController.text,
                  course: courseController.text,
                  studNo: studentnoController.text,
                  userName: usernameController.text);
              signUp(studentData);
            }
          },
          child: const Text("Sign up"),
        ),
        backButton,
      ];
    }

    List<Widget> adminMonitorSignUpForm() {
      return [
        const SizedBox(height: 32),
        const Text(
          "Sign Up",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
        ),
        name,
        empNo,
        position,
        homeUnit,
        email,
        password,
        const SizedBox(height: 10),
        ElevatedButton(
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              adminMonitorData = UserInfoModel(
                  name: nameController.text,
                  email: emailController.text,
                  entries: [],
                  status: "Cleared",
                  userType: widget.signupType,
                  preExistingIllnesses: {
                    "Illnessese": illnessesValues,
                    "Allergies": allergyList
                  },
                  empNo: empNoController.text,
                  homeUnit: homeUnitController.text,
                  position: positionController.text);
              print("hello");
              signUp(adminMonitorData);
            }
          },
          child: const Text("Sign Up"),
        ),
        backButton,
      ];
    }

    return Scaffold(
      backgroundColor: Colors.white,
      body: Form(
        key: _formKey,
        child: Center(
            child: ListView(
                shrinkWrap: true,
                padding: const EdgeInsets.only(left: 40.0, right: 40.0),
                children: (widget.signupType == "Student")
                    ? studentSignUpForm()
                    : adminMonitorSignUpForm())),
      ),
    );
  }
}
