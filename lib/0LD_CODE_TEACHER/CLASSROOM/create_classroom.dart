import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:intl/intl.dart';
import 'classroom_screen.dart';

class CreateClassRoomScreen extends StatefulWidget {
  final String userId;
  final String code;
  const CreateClassRoomScreen({super.key, required this.userId, required this.code});

  @override
  State<CreateClassRoomScreen> createState() => _CreateClassRoomScreenState();
}

class _CreateClassRoomScreenState extends State<CreateClassRoomScreen> {
  final _formkey = GlobalKey<FormState>();
  var gradelevelController = TextEditingController();
  var startOfSYController = TextEditingController();
  var endOfSYController  = TextEditingController();
  var sectionController = TextEditingController();
  String? _selectedGrade;
  void addClassRoom() async {
  String documentId = FirebaseFirestore.instance.collection('classroom').doc().id;
  await FirebaseFirestore.instance.collection('classroom').doc(documentId).set({
    'Class Code': widget.code,
    'Teacher': widget.userId,
    'Grade': gradelevelController.text,
    'SY Start': startOfSYController.text,
    'SY End': endOfSYController.text,
    'Section': sectionController.text,
  });
  await FirebaseFirestore.instance.collection('Student').doc(documentId).set({
    'Class Code': widget.code,
    'Teacher': widget.userId,
    'Grade': gradelevelController.text,
    'Section': sectionController.text,
    'StudentList': [],
    'Student Request': [],
  });

  setState(() {
    EasyLoading.showSuccess('added successfully');
    Navigator.push(context, MaterialPageRoute(builder: (ctx){
      return ClassRoomScreen(userId: widget.userId,);
    }));
  });
}

  @override
  void initState() {
    startOfSYController.text = DateFormat('yyyy').format(DateTime.now());
    DateTime currentDate = DateTime.now();
    DateTime nextYearDate = DateTime(currentDate.year + 1, currentDate.month, currentDate.day);
    String nextYear = DateFormat('yyyy').format(nextYearDate);
    endOfSYController.text = nextYear;
    super.initState();
  }

  @override
  void dispose() {
    startOfSYController.dispose();
    endOfSYController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Form(
        key: _formkey,
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('ADD CLASSROOM'),
              SizedBox(height: 15,),
              Text('Class Room Code: ' + widget.code),
              Text('Grade Level'),            
              DropdownButtonFormField<String>(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required. Please select a grade level.';
                  }
                  return null;
                },
                value: _selectedGrade,
                onChanged: (String? newValue) {
                  if (newValue != null) {
                    setState(() {
                      gradelevelController.text = newValue;
                    });
                  }
                },
                items: [
                  DropdownMenuItem(
                    value: 'Grade 1',
                    child: Text('Grade 1'),
                  ),
                  DropdownMenuItem(
                    value: 'Grade 2',
                    child: Text('Grade 2'),
                  ),
                  DropdownMenuItem(
                    value: 'Grade 3',
                    child: Text('Grade 3'),
                  ),
                  DropdownMenuItem(
                    value: 'Grade 4',
                    child: Text('Grade 4'),
                  ),
                  DropdownMenuItem(
                    value: 'Grade 5',
                    child: Text('Grade 5'),
                  ),
                  DropdownMenuItem(
                    value: 'Grade 6',
                    child: Text('Grade 6'),
                  ),
                ],
                decoration: InputDecoration(
                  hintText: 'Please select grade level',
                  border: OutlineInputBorder(),
                ),
              ),
              SizedBox(height: 20,),
              Text('Section'),
              TextFormField(
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Required. Please enter Section.';
                  }
                  return null;
                },
                  controller: sectionController,
                  decoration: const InputDecoration(
                    hintText: 'Please enter Section',
                    border: OutlineInputBorder(),
                  ),
              ),
              SizedBox(height: 20,),
              Text('Start of School Year'),
              TextFormField(
                readOnly: true,
                  initialValue: startOfSYController.text,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
              ),
              SizedBox(height: 20,),
              Text('End of School Year'),
              TextFormField(
                readOnly: true,
                  controller: endOfSYController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                  ),
              ),
              SizedBox(height: 25,),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                  width: 150, 
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text('Cancel', style: TextStyle(color: Color(0xFF0043C3),),),
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color.fromARGB(255, 226, 220, 220)), ),
                  ),
                ),
                SizedBox(
                  width: 150, 
                  child: ElevatedButton(
                    onPressed: (){
                    if(_formkey.currentState!.validate()){
                      addClassRoom();
                    }
                    },
                    child: Text('Add'),
                    style: ButtonStyle(backgroundColor: MaterialStateProperty.all<Color>(Color(0xFF0043C3),), ),
                  ),
                ),
              ],
            )
            ],
          ),
        ),
        ),
      ),
    );
  }
}