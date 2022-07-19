import 'package:blood_db/Screens/home/search_page.dart';
import 'package:blood_db/Screens/home/view_data.dart';
import 'package:blood_db/bloc/cubit/db_cubit.dart';
import 'package:blood_db/constants.dart';
import 'package:blood_db/model/student.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final searchController = TextEditingController();
  List<Student> studentList = [];
  String dropdownvaluebloods = 'All';
  var itemsbloods = ['All', 'A+', 'A-', 'AB+', 'AB-', 'B+', 'B-', 'O+', 'O-'];
  @override
  void initState() {
    super.initState();
    BlocProvider.of<DbCubit>(context).fetchDB();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kPrimaryLightColor,
        title: const Text(
          'Home',
          style: TextStyle(color: Colors.black),
        ),
        actions: [
          IconButton(
            onPressed: () => Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => SearchPage(),
              ),
            ),
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                width: double.infinity,
                height: 40,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(5)),
                child: Center(
                  child: TextField(
                    onChanged: (value) {
                      BlocProvider.of<DbCubit>(context).filterDb(query: value);
                    },
                    controller: searchController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.search),
                      suffixIcon: IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          searchController.clear();
                        },
                      ),
                      hintText: 'Search...',
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  const Text(
                    "Filter By:-",
                    style: TextStyle(fontSize: 20),
                  ),
                  const SizedBox(
                    width: 15,
                  ),
                  DropdownButton(
                    dropdownColor: kPrimaryLightColor,
                    // Initial Value
                    value: dropdownvaluebloods,

                    // Down Arrow Icon
                    icon: const Icon(Icons.keyboard_arrow_down),

                    // Array list of items
                    items: itemsbloods.map((String itemsbloods) {
                      return DropdownMenuItem(
                        value: itemsbloods,
                        child: Text(itemsbloods),
                      );
                    }).toList(),
                    // After selecting the desired option,it will
                    // change button value to selected value
                    onChanged: (String? newValue) {
                      setState(() {
                        dropdownvaluebloods = newValue!;
                      });
                    },
                  ),
                ],
              ),
              BlocBuilder<DbCubit, DbState>(
                builder: (context, state) {
                  if (state is DbLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (state is DbLoaded) {
                    studentList = state.student;
                    if (studentList.isEmpty) {
                      return const Center(
                        child: Text('No data is Found'),
                      );
                    }
                    return ListTileTheme(
                      tileColor: const Color.fromARGB(255, 217, 214, 238),
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: studentList.length,
                        itemBuilder: (context, index) => Card(
                          elevation: 5.0,
                          child: Column(
                            children: [
                              const SizedBox(
                                height: 12,
                              ),
                              ListTile(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0)),
                                title: Text(studentList[index].name),
                                trailing: Text(studentList[index].bloodGroup),
                                onTap: () {
                                  Navigator.of(context).push(MaterialPageRoute(
                                      builder: (context) => ViewData(
                                            name: studentList[index].name,
                                            phone: studentList[index].mobile,
                                            year: studentList[index].year,
                                            department:
                                                studentList[index].department,
                                            bloodGroup:
                                                studentList[index].bloodGroup,
                                            address: studentList[index].address,
                                          )));
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                  return Container();
                },
              ),
            ],
          ),
        ),
        // <-- wrap this around
        // child: Column(
        //   children: const [
        //     ProfileBar(),
        //   ],
        // ),
      ),
    );
  }
}
