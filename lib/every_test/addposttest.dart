import 'package:flutter/Material.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
  class AddPostPageTest extends StatefulWidget {
  @override
  _AddPostPageTestState createState() => _AddPostPageTestState();
}

class _AddPostPageTestState extends State<AddPostPageTest> {
  List<XFile> _selectedImages = [];
  TextEditingController _textEditingController = TextEditingController();

  Future<void> _pickImages() async {
    List<XFile>? result = await ImagePicker().pickMultiImage();
    if (result != null && result.isNotEmpty) {
      setState(() {
        _selectedImages = result;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add Post'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            
            ElevatedButton(
              onPressed: _pickImages,
              child: Text('Select Images'),
            ),
            SizedBox(height: 16),
            Expanded(
              child: _selectedImages.isNotEmpty
                  ? StaggeredGridView.countBuilder(
                      crossAxisCount: 2,
                      mainAxisSpacing: 4.0,
                      crossAxisSpacing: 4.0,
                      itemCount: _selectedImages.length,
                      staggeredTileBuilder: (int index) => StaggeredTile.fit(1),
                      itemBuilder: (BuildContext context, int index) {
                        print(_selectedImages);
                        return Image.file(
                          File(_selectedImages[index].path),
                          fit: BoxFit.cover,
                        );
                      },
                    )
                  : Center(
                      child: Text('No Images Selected'),
                    ),
            ),
            SizedBox(height: 16),
            TextField(
              controller: _textEditingController,
              decoration: InputDecoration(
                hintText: 'Add text...',
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Implement your logic to save post with images and text
                // You can access _selectedImages and _textEditingController.text here
              },
              child: Text('Post'),
            ),
          ],
        ),
      ),
    );
  }
}