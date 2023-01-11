import 'package:cardiotoxicity/dbHelper.dart';
import 'package:flutter/material.dart';

class UserData extends StatefulWidget {
  const UserData({super.key});

  @override
  UserDataState createState() => UserDataState();
}

class UserDataState extends State<UserData> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: FutureBuilder(
        //Here you have to pass your username and password to display the user data
        future: DBHelper.fetchUser('', ''),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index) {
                  //Displaying All User Data From Database
                  return Card(
                    child: Column(
                      children: [
                        ListTile(
                          trailing: Text('${snapshot.data!['weight']}Kg'),
                          leading: Text('${snapshot.data!['id']}'),
                          title: Text(
                              '${snapshot.data!['name']} ${snapshot.data!['surname']} \n${snapshot.data!['gender']} - ${snapshot.data!['birthdate']}'),
                          subtitle: Text('${snapshot.data!['email']}'),
                        ),
                        Text(
                            'Username: ${snapshot.data!['username']}\nPassword: ${snapshot.data!['password']}'),
                      ],
                    ),
                  );
                });
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
