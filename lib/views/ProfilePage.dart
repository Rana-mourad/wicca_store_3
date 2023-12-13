import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wicca_store_3/provider/ProfileProvider.dart';

class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
      ),
      body: ChangeNotifierProvider(
        create: (_) => ProfileProvider(),
        child: ProfileContent(),
      ),
    );
  }
}

class ProfileContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    ProfileProvider profileProvider = Provider.of<ProfileProvider>(context);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 50,

            //  backgroundImage: NetworkImage(profileProvider.user.imageUrl),
          ),
          SizedBox(height: 20),
          Text(
            'Name',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          TextField(
            controller: profileProvider.nameController,
            decoration: InputDecoration(
              hintText: 'Enter your name',
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Phone Number',
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          TextField(
            controller: profileProvider.phoneController,
            decoration: InputDecoration(
              hintText: 'Enter your phone number',
            ),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              profileProvider.updateData();
            },
            child: Text('Update Profile'),
          ),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              profileProvider.setImageToFirebase();
            },
            child: Text('Change Profile Image'),
          ),
        ],
      ),
    );
  }
}
