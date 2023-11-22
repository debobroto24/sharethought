import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sharethought/styles/kcolor.dart';
import 'package:sharethought/styles/ktext_style.dart';

class PostList extends StatefulWidget {
  const PostList({
    super.key,
    required this.postList,
    required this.width,
  });

  final List<Map<String, String>> postList;
  final double width;

  @override
  State<PostList> createState() => _PostListState();
}

class _PostListState extends State<PostList> {
  @override
  Widget build(BuildContext context) {
    print("outoput is");
    print(widget.postList.length);
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: widget.postList.length,
      itemBuilder: (context, index) {
        return PostCard(index, context);
      },
    );
  }

  Padding PostCard(int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListTile(
            leading: CircleAvatar(
                radius: 30.0,
                child: Image.asset("assets/images/profilepic.png")),
            title: Text(
              "Shinna",
              style: ktextStyle.font20(Kcolor.baseBlack),
            ),
            subtitle: Text(
              "1 dec 2023",
              style: ktextStyle.font18(Kcolor.blackbg),
            ),
            trailing: IconButton(
              icon: const Icon(Icons.more_vert, size: 20),
              onPressed: () {
                dialogBoxOpen(context);
              },
            ),
          ),
          // text
          if (widget.postList[index]['text'] != null &&
              widget.postList[index]['text']!.isNotEmpty) ...{
            Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Text(
                widget.postList[index]['text']!,
                style: ktextStyle.font18(Kcolor.black),
              ),
            )
          },

          const SizedBox(height: 10),

          Image.asset(
            "assets/images/error-image.png",
            width: widget.width,
            fit: BoxFit.fitWidth,
            height: MediaQuery.of(context).size.height * .2,
          ),

          Divider(color: Kcolor.baseGrey),
          const Divider(
            color: Kcolor.baseBlack,
            indent: 20,
            endIndent: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Wrap(
              // Spacing between items
              // runSpacing: 8.0, // Spacing between lines
              children: [
                const Icon(
                  Icons.favorite_outline_outlined,
                  size: 30,
                ),
                Text('20'),
                SizedBox(width: 20),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pushNamed("/commentsection");
                  },
                  // child: Icon(Icons.comment_outlined, size: 30,)
                  child: Image.asset("assets/images/comment.png",
                      width: 30, height: 30),
                ),
                Text('230'),
              ],
            ),
          ),
          const Divider(
            color: Kcolor.baseBlack,
            indent: 20,
            endIndent: 20,
          )

          // Image.asset("assets/images/error-image.png")
        ],
      ),
    );
  }

  Future<dynamic> dialogBoxOpen(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        child: ListView(
          padding: const EdgeInsets.symmetric(
            vertical: 16,
          ),
          shrinkWrap: true, // shrinkWrap true work like span
          children: ['Delete', 'Edit']
              .map(
                (e) => InkWell(
                  onTap: () {},
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    child: Text(e),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
