import 'package:flutter/material.dart';
import 'package:movies/Model/profile_response.dart';
import 'package:movies/Registeration/login_screen.dart';
import 'package:movies/profile_manager.dart';

class UpdateProfileScreen extends StatefulWidget {
  static const String routName = 'ProfileUpdateScreen';
  @override
  _UpdateProfileScreenState createState() => _UpdateProfileScreenState();
}

class _UpdateProfileScreenState extends State<UpdateProfileScreen> {
  int selectedAvatar = 0;
  final _formKey = GlobalKey<FormState>();

  late String name = "Guest";
  late String phone = "";


  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();

  Future<void> _fetchProfile() async {
    try {
      final profileResponse = await profileManager.getProfile();
      print("Profile Response: $profileResponse");

      if (profileResponse?.data != null) {
        setState(() {
          name = profileResponse?.data!.name ?? "Guest";
          phone = profileResponse?.data!.phone ?? "";
          selectedAvatar = profileResponse?.data!.avaterId ?? 1;

          _nameController.text = name;
          _phoneController.text = phone;



        });
      } else {
        print("No data found!");
        setState(() {

        });
      }
    } catch (e) {
      print("Error fetching profile: $e");
      setState(() {

      });
    }
  }


  Future<bool?> _showDeleteConfirmationDialog(BuildContext context) async {
    return showDialog<bool>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Confirm Delete"),
          content: Text("Are you sure you want to delete your account? This action cannot be undone."),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false); // User clicked "Cancel"
              },
              child: Text("Cancel"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pop(context, true); // User confirmed "Delete"
              },
              style: TextButton.styleFrom(foregroundColor: Colors.red),
              child: Text("Delete"),
            ),
          ],
        );
      },
    );
  }


  @override
  void initState() {
    super.initState();
    _fetchProfile();
  }

  final List<String> avatarList = [
    'assets/images/gamer1.png',
    'assets/images/gamer2.png',
    'assets/images/gamer3.png',
    'assets/images/gamer4.png',
    'assets/images/gamer5.png',
    'assets/images/gamer6.png',
    'assets/images/gamer7.png',
    'assets/images/gamer8.png',
    'assets/images/gamer9.png',
  ];

  void _showAvatarSelection() {
    showModalBottomSheet(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Container(
          decoration: BoxDecoration(
            color: Color(0XFF282A28),
          ),
          padding: EdgeInsets.all(16),
          child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
            ),
            itemCount: avatarList.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  setState(() {
                    selectedAvatar = index ;
                  });
                  Navigator.pop(context);
                },
                child:
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: selectedAvatar== index ? Color(0x90F6BD00): Colors.transparent,
                    shape: BoxShape.rectangle, // Make avatar circular
                    border: Border.all(
                      color: Color(0XFFF6BD00) ,
                      width: 2, // Highlight selected avatar
                    ),
                  ),
                  padding: EdgeInsets.all(8),
                  child: CircleAvatar(
                    backgroundImage: AssetImage(avatarList[index]),
                    radius: 40,
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text("Update Profile"),
        backgroundColor: Colors.black,
      ),
      body: Center(
        child:
            Form(
              key:_formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 3,
                    child: Column(
                      children: [
                        SizedBox(height: 16),
                        GestureDetector(
                          onTap: _showAvatarSelection,
                          child:  FutureBuilder<profileResponse?>(
                            future: profileManager.getProfile(),
                            builder :(context , snapshot){
                              if (snapshot.hasError) {
                                return Center(child: Text("Error loading profile", style: TextStyle(color: Colors.white)));
                              }
                              if (snapshot.hasData && snapshot.data?.data != null) {
                                int avatarId = snapshot.data!.data!.avaterId ?? 1;
                                return CircleAvatar(
                                  radius: 80,
                                  backgroundImage: AssetImage("assets/images/gamer${avatarId+1}.png"),
                                );
                              }
                              return Center(child: Text("No data available", style: TextStyle(color: Colors.white)));
                            },
                          ),
                        ),
                        SizedBox(height: 16),
                        TextFormField(
                          controller: _nameController,
                          decoration: InputDecoration(
                              hintText: "$name",
                              hintStyle: TextStyle( color: Colors.white),
                              filled: true,
                              fillColor: Color(0XFF282A28),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                              prefixIcon: Icon(Icons.person, color: Colors.white,)
                          ),
                          validator: (value) =>
                          value == null || value.isEmpty ? "Please enter your name" : null,
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 15),
                        TextFormField(
                          controller: _phoneController,
                          decoration: InputDecoration(
                              hintText:"$phone",
                              hintStyle: TextStyle( color: Colors.white),
                              filled: true,
                              fillColor: Color(0XFF282A28),
                              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
                              prefixIcon: ImageIcon(AssetImage('assets/images/Phone_Icon.png') , color: Colors.white,)
                          ),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value == null || value.isEmpty) return "Please enter your phone number";
                            if (!RegExp(r'^\+\d{10,15}$').hasMatch(value)) return "Invalid phone format";
                            return null;
                          },
                          style: TextStyle(color: Colors.white),
                        ),
                        SizedBox(height: 15),
                        Row(
                          children: [
                            SizedBox(width: 8),
                            Text("Reset Password" , style:TextStyle(color: Colors.white),),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: [
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: ()async{
                            bool? confirmDelete = await _showDeleteConfirmationDialog(context);
                            if (confirmDelete == true) {
                              await profileManager.deleteProfile();
                              Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0XFFE82626),
                            minimumSize: Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          ),
                          child: Text("Delete Account", style: TextStyle(color: Colors.white  , fontSize: 16)),
                        ),
                        SizedBox(height: 20),
                        ElevatedButton(
                          onPressed: ()async{
                            if (_formKey.currentState!.validate()) {
                              String? updatedName = _nameController.text;
                              String? updatedPhone = _phoneController.text;
                              await profileManager.updateProfile( updatedName, updatedPhone, selectedAvatar);
                              Navigator.pop(context, true);
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0XFFF6BD00),
                            minimumSize: Size(double.infinity, 50),
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                          ),
                          child: Text("Update Data", style: TextStyle(color: Colors.black  , fontSize: 16)),
                        ),
                      ],
                    ),
                  )

                ],
              ),
            ),
      ),
    );
  }
}




