import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';

class VideoScreen extends StatefulWidget {
  const VideoScreen({Key? key}) : super(key: key);

  @override
  State<VideoScreen> createState() => _VideoScreenState();
}

class _VideoScreenState extends State<VideoScreen> {
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<List<Reference>> getImageReferences() async {
    final ListResult result = await _storage.ref('memorygame/').listAll();
    return result.items;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: FutureBuilder<List<Reference>>(
          future: getImageReferences(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator(); // Loading indicator
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final List<Reference>? imageReferences = snapshot.data;
      
              return ListView.builder(
                itemCount: imageReferences?.length,
                itemBuilder: (context, index) {
                  final imageReference = imageReferences?[index];
                  return FutureBuilder<String>(
                    future: imageReference?.getDownloadURL(),
                    builder: (context, urlSnapshot) {
                      if (urlSnapshot.connectionState == ConnectionState.waiting) {
                        return CircularProgressIndicator(); // Loading indicator
                      } else if (urlSnapshot.hasError) {
                        return Text('Error: ${urlSnapshot.error}');
                      } else {
                        final imageUrl = urlSnapshot.data;
                        return Image.network(imageUrl!);
                      }
                    },
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
