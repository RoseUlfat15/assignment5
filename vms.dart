import 'dart:io';

String enterEmail = "";
String enterPassword = "";
List<Map<String, String>> adminList = [
  {"email": "admin1@gmail.com", "password": "admin1"},
  {"email": "admin2@gmail.com", "password": "admin2"},
  {"email": "admin3@gmail.com", "password": "admin3"},
  {"email": "admin4@gmail.com", "password": "admin4"},
  {"email": "admin5@gmail.com", "password": "admin5"},
];
List<Map<String, String>> userList = [
  {"email": "abc123@gmail.com", "password": "abc123"},
  {"email": "xyz345@gmail.com", "password": "xyz345"},
];
List<Map<String, dynamic>> patientRecord = [
  {
    "Name": "Ali",
    "Address": "karachi",
    "ContactNo": 033245,
    "Age": 25,
    "Gender": "male",
    "Patient_ID": 122,
    "Blood_Group": "B+",
    "FirstVaccineDate": "2022-07-10", //YYYY-MM-DD
    "SecondVaccineDate": "",
  },
  {
    "Name": "Farwa",
    "Address": "Nazimabad",
    "ContactNo": 033456,
    "Age": 16,
    "Gender": "female",
    "Patient_ID": 110,
    "Blood_Group": "O+",
    "FirstVaccineDate": "2021-12-30",
    "SecondVaccineDate": "",
  },
  {
    "Name": "Mariam",
    "Address": "Hussainabad",
    "ContactNo": 033789,
    "Age": 20,
    "Gender": "female",
    "Patient_ID": 150,
    "Blood_Group": "A-",
    "FirstVaccineDate": "2023-07-21",
    "SecondVaccineDate": "",
  },
  {
    "Name": "Muhammad",
    "Address": "PECHS",
    "ContactNo": 033159,
    "Age": 30,
    "Gender": "male",
    "Patient_ID": 120,
    "Blood_Group": "AB+",
    "FirstVaccineDate": "2020-04-28",
    "SecondVaccineDate": "",
  },
];

void main() {
  print("*****COVID VACCINE MANAGMENT SYSTEM*****");
  print("LOGIN AS ADMIN OR USER?");
  print("FOR LOGIN AS ADMIN PRESS 'A'");
  print("FOR LOGIN AS USER PRESS 'U'");
  var enterTheValue = stdin.readLineSync()!;
  if (enterTheValue == "A" || enterTheValue == "a") {
    admin();
  } else if (enterTheValue == "U" || enterTheValue == "u") {
    user();
  } else {
    print("PLEASE SELECT ANY ONE OPTION");
  }
}

int loginAttempts = 0;
admin() {
  bool credentialsMatch = false;
  while (!credentialsMatch && loginAttempts < 3) {
    stdout.write("Enter your email: ");
    enterEmail = stdin.readLineSync()!;

    stdout.write("Enter your password: ");
    enterPassword = stdin.readLineSync()!;

    bool credentialsMatch = false;
    for (var user in adminList) {
      if (user["email"] == enterEmail && user["password"] == enterPassword) {
        credentialsMatch = true;
        break;
      }
    }
    if (credentialsMatch) {
      print("Login successful!");
      while (true) {
        print("\n Select an Option");
        print("1 for Viewing Patient Record");
        print("2 for Adding Patient");
        print("3 for Suggesting Vaccine");
        print("4 for Viewing First and Second Dose Date");
        print("5 for deleting Patient Record");
        print("6 for Logout");
        String option = stdin.readLineSync()!;
        switch (option) {
          case "1":
            print("===PATIENT RECORD===");
            print("$patientRecord");
            break;
          case "2":
            print("===ADD PATIENT RECORD===");
            stdout.write("ENTER NAME :- ");
            String Name = stdin.readLineSync()!;
            stdout.write("ENTER Address :- ");
            String Address = stdin.readLineSync()!;
            stdout.write("ENTER ContactNo :- ");
            int ContactNo = int.parse(stdin.readLineSync()!);
            stdout.write("ENTER Age :- ");
            int Age = int.parse(stdin.readLineSync()!);
            stdout.write("ENTER Gender :- ");
            String Gender = stdin.readLineSync()!;
            stdout.write("ENTER Patient_ID :- ");
            String Patient_ID = stdin.readLineSync()!;
            stdout.write("ENTER Blood_Group :- ");
            String Blood_Group = stdin.readLineSync()!;
            addPatient(
                Name: Name,
                Address: Address,
                ContactNo: ContactNo,
                Age: Age,
                Gender: Gender,
                Patient_ID: Patient_ID,
                Blood_Group: Blood_Group);
            print("Patient added successfully!");
            print(patientRecord);
            break;
          case "3":
            //Suggest vaccines for each patient
            print("===FOLLOWING VACCINE IS SUGGESTED FOR YOU===");
            for (var patient in patientRecord) {
              suggestingVaccine(patient);
            }
            break;
          case "4":
            // Display first and second vaccine dates for a patient
            stdout.write("Enter Patient ID: ");
            String patientID = stdin.readLineSync()!;
            displayVaccineDates(patientID);
            break;
          case "5":
            // Delete patient record by Patient ID
            stdout.write("Enter Patient ID to delete: ");
            String patientIDToDelete = stdin.readLineSync()!;
            deletePatientRecord(patientIDToDelete);
            break;
          case "6":
            print("Logging Out");
            return;
          default:
            print("Please Select an Option");
        }
      }
    } else {
      loginAttempts++;
      int remainingAttempts = 3 - loginAttempts;
      print(
          "Invalid email or password. Remaining attempts: $remainingAttempts");
    }
  }
  if (!credentialsMatch) {
    print("You have exceeded the maximum login attempts.");
  }
}

addPatient(
    {required String Name,
    required String Address,
    required int ContactNo,
    required int Age,
    required String Gender,
    required String Patient_ID,
    required String Blood_Group}) {
  Map<String, dynamic> newPatientRecord = {
    "Name": Name,
    "Address": Address,
    "ContactNo": ContactNo,
    "Age": Age,
    "Gender": Gender,
    "Patient_ID": Patient_ID,
    "Blood_Group": Blood_Group
  };
  patientRecord.add(newPatientRecord);
}

suggestingVaccine(Map<String, dynamic> patient) {
  String name = patient["Name"];
  int age = patient["Age"];
  if (age >= 18 && age <= 45) {
    print("$name: Suggested vaccine - Sinopharm");
  } else if (age > 45 && age <= 60) {
    print("$name: Suggested vaccine - Sinovac");
  } else if (age > 60) {
    print("$name: Suggested vaccine - CanSino");
  } else {
    print("$name: No specific vaccine is suggested for this age group.");
  }
}

displayVaccineDates(String patientID) {
  int searchPatientID = int.parse(patientID);

  var patient = patientRecord.firstWhere(
    (patient) => patient["Patient_ID"] == searchPatientID,
    orElse: () => Map<String, dynamic>.from({}),
  );

  if (patient.isNotEmpty) {
    String firstVaccineDate = patient["FirstVaccineDate"];
    if (firstVaccineDate.isEmpty) {
      print("Vaccine date not available for this patient.");
    } else {
      DateTime firstDate = DateTime.parse(firstVaccineDate);
      DateTime secondDate = firstDate
          .add(Duration(days: 21)); // Assuming a 21-day gap between doses
      String formattedSecondDate =
          "${secondDate.year}-${secondDate.month}-${secondDate.day}";

      patient["SecondVaccineDate"] = formattedSecondDate;
      print("First Vaccine Date: $firstVaccineDate");
      print("Second Vaccine Date: $formattedSecondDate");
    }
  } else {
    print("Patient with ID $patientID not found.");
  }
}

deletePatientRecord(String patientID) {
  int searchPatientID = int.parse(patientID);

  bool isPatientFound = false;
  patientRecord.removeWhere((patient) {
    if (patient["Patient_ID"] == searchPatientID) {
      isPatientFound = true;
      return true;
    }
    return false;
  });

  if (isPatientFound) {
    print("Patient with ID $patientID has been deleted.");
  } else {
    print("Patient with ID $patientID not found.");
  }
}

user() {
  print("Already Registered? if yes! enter Login If NOT then enter Signup");
  var loginOrSignup = stdin.readLineSync()!;
  if (loginOrSignup == "Login" ||
      loginOrSignup == "login" ||
      loginOrSignup == "LOGIN") {
    stdout.write("Enter your email: ");
    enterEmail = stdin.readLineSync()!;
    stdout.write("Enter your password: ");
    enterPassword = stdin.readLineSync()!;
    bool credentialsMatch = false;
    for (var user in userList) {
      if (user["email"] == enterEmail && user["password"] == enterPassword) {
        credentialsMatch = true;
        break;
      }
    }
    if (credentialsMatch) {
      print("Login successful!");
    } else {
      print("Invalid email or password.");
    }
  } else if (loginOrSignup == "Signup" ||
      loginOrSignup == "signup" ||
      loginOrSignup == "SIGNUP" ||
      loginOrSignup == "signUp" ||
      loginOrSignup == "SignUp") {
    stdout.write("Enter your email: ");
    enterEmail = stdin.readLineSync()!;
    stdout.write("Enter your password: ");
    enterPassword = stdin.readLineSync()!;
    Map<String, String> user = {
      "email": enterEmail,
      "password": enterPassword,
    };
    userList.add(user);
    // print("$userList");
  }
}
