import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'Login Screen.dart';
import 'User Authentication.dart';

class ToDoList extends StatefulWidget {
  const ToDoList({super.key});
  @override
  State<ToDoList> createState() => ToDoListState();
}

class ToDoListState extends State<ToDoList> {
  TextEditingController _taskNameController = TextEditingController();
  TextEditingController _taskDescriptionController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  List<String> TaskName = [];
  List<String> TaskDescription = [];
  List<bool> TaskFinished = [];
  int filter = 0;
  List<String> SelectedDateList = [];
  List<String> SelectedTimeList = [];
  String? OneDate;
  String? OneTime;
  final UserAuthentication _userAuth = UserAuthentication();
  Future<void> addTask() async {
    TaskName.add(_taskNameController.text);
    TaskDescription.add(_taskDescriptionController.text);
    TaskFinished.add(false);
    SelectedDateList.add(OneDate.toString());
    SelectedTimeList.add(OneTime.toString());
    UpdatePref();
    setState(() {});
  }

  Future<void> UpdatePref() async {
    final pref = await SharedPreferences.getInstance();
    pref.setStringList("TaskName", TaskName);
    pref.setStringList("TaskDescription", TaskDescription);
    pref.setStringList(
      "TaskFinished",
      TaskFinished.map((e) => e.toString()).toList(),
    );
    pref.setStringList("TaskDate", SelectedDateList);
    pref.setStringList("TaskTime", SelectedTimeList);
  }

  Future<void> _loadData() async {
    final pref = await SharedPreferences.getInstance();

    final names = pref.getStringList("TaskName") ?? [];
    final desc = pref.getStringList("TaskDescription") ?? [];
    final doneStrings = pref.getStringList("TaskFinished") ?? [];
    final dates = pref.getStringList("TaskDate") ?? [];
    final times = pref.getStringList("TaskTime") ?? [];
    final done = doneStrings.map((e) => e == 'true').toList();

    // lists should match names.length
    while (desc.length < names.length) desc.add("");
    while (done.length < names.length) done.add(false);
    while (dates.length < names.length) dates.add("");
    while (times.length < names.length) times.add("");

    setState(() {
      TaskName = names;
      TaskDescription = desc;
      TaskFinished = done;
      SelectedDateList = dates;
      SelectedTimeList = times;
    });
  }

  Future<void> DatePicker() async {
    DateTime? datepicker = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      initialDate: DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (datepicker != null) {
      setState(() {
        String formatted = DateFormat('dd-MM-yyyy').format(datepicker);

        OneDate = formatted;
      });
    }
  }

  Future<void> TimePicker() async {
    TimeOfDay? timePicker = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
    if (timePicker != null) {
      setState(() {
        OneTime = timePicker.format(context);
      });
    }
  }

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  void _showTask() {
    showModalBottomSheet(
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
      backgroundColor: Colors.lightBlue,
      context: context,
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: ListView(
              children: [
                TextFormField(
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Task Name Required*";
                    }
                    return null;
                  },
                  controller: _taskNameController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    label: Text("Task Name"),
                    labelStyle: TextStyle(color: Colors.white),
                    floatingLabelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  cursorColor: Colors.lightBlue,
                  cursorErrorColor: Colors.lightBlue,
                ),
                const SizedBox(height: 10),
                TextFormField(
                  maxLength: 50,
                  maxLines: 3,
                  controller: _taskDescriptionController,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    label: Text("Task Description"),
                    labelStyle: TextStyle(color: Colors.white),
                    floatingLabelStyle: TextStyle(color: Colors.white),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white),
                    ),
                  ),
                  cursorColor: Colors.lightBlue,
                  cursorErrorColor: Colors.lightBlue,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      onPressed: () => DatePicker(),
                      icon: Icon(Icons.date_range, color: Colors.white),
                    ),
                    IconButton(
                      onPressed: () => TimePicker(),
                      icon: Icon(Icons.lock_clock, color: Colors.white),
                    ),
                    TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          addTask();
                          _loadData();
                          Navigator.pop(context);
                          _taskNameController.clear();
                          _taskDescriptionController.clear();
                          OneTime = null;
                          OneDate = null;
                          Fluttertoast.showToast(
                            msg: "Task Added",
                            backgroundColor: Colors.lightBlue,
                            textColor: Colors.white,
                          );
                        }
                      },

                      child: Text(
                        "Save",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Text(OneDate ?? "", style: TextStyle(color: Colors.white)),
                Text(OneTime ?? "", style: TextStyle(color: Colors.white)),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("To Do List"),
        backgroundColor: Colors.lightBlue,
        foregroundColor: Colors.white,
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              _showTask();
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),

      body: Column(
        children: [
          Padding(
            padding: EdgeInsetsGeometry.all(8),
            child: ToggleButtons(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text("Remaining Tasks"),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30),
                  child: Text("Finished Tasks"),
                ),
              ],
              isSelected: [filter == 0, filter == 1],
              onPressed: (index) {
                setState(() {
                  filter = index;
                });
              },
              selectedColor: Colors.white,
              fillColor: Colors.lightBlue,
              color: Colors.lightBlue,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: TaskName.length,
              itemBuilder: (context, index) {
                if ((filter == 0 && TaskFinished[index]) ||
                    (filter == 1 && !TaskFinished[index])) {
                  return SizedBox(); // Skip
                }
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    child: Column(
                      crossAxisAlignment: .start,
                      children: [
                        Text(TaskName[index]),
                        Text(TaskDescription[index]),
                        Text(SelectedDateList[index]),
                        Text(SelectedTimeList[index]), 
                        Row(
                          // mainAxisSize: .min,
                          children: [
                            TextButton(
                              onPressed: () {
                                setState(() {
                                  TaskFinished[index] = !TaskFinished[index];
                                  UpdatePref();
                                });
                              },
                              child: Text(
                                TaskFinished[index] ? "Undo" : "Finish",
                                style: TextStyle(color: Colors.lightBlue),
                              ),
                            ),
                            TextButton(
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) {
                                    return AlertDialog(
                                      title: Text("Delete ${TaskName[index]}"),
                                      content: Text(
                                        "Are you sure want to delete the task?",
                                        style: TextStyle(color: Colors.black45),
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () => Navigator.pop(context),
                                          child: Text(
                                            "Cancel",
                                            style: TextStyle(
                                              color: Colors.lightBlue,
                                            ),
                                          ),
                                        ),
                  
                                        TextButton(
                                          onPressed: () {
                                            setState(() {
                                              TaskName.removeAt(index);
                                              TaskDescription.removeAt(index);
                                              TaskFinished.removeAt(index);
                                              SelectedTimeList.removeAt(index);
                                              SelectedDateList.removeAt(index);
                                              UpdatePref();
                                              Navigator.pop(context);
                                              Fluttertoast.showToast(
                                                msg: "Task Deleted",
                                                backgroundColor: Colors.lightBlue,
                                                textColor: Colors.white,
                                              );
                                            });
                                          },
                                          child: Text(
                                            "Delete",
                                            style: TextStyle(color: Colors.red),
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              },
                              child: Text(
                                "Delete",
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _userAuth.Logout();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => sign_in())
          );
        },
        child:Text("LogOut")
      ),
    );
  }
}
