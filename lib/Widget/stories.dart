import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:medium_app/blogs/apiSinglePage.dart';
import 'package:medium_app/config/palette.dart';
import 'package:medium_app/models/models.dart';
import 'package:medium_app/Widget/profile_avatar.dart';
//import 'package:flutter_facebook_responsive_ui/widgets/responsive.dart';

class Stories extends StatelessWidget {
  final User currentUser;
  final List<Story> stories;

  const Stories({Key key, @required this.currentUser, @required this.stories})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200.0,
      child: ListView.builder(
          padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 8.0),
          scrollDirection: Axis.horizontal,
          itemCount: 1 + stories.length,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: _StoryCard(isAddStory: true, currentUser: currentUser),
              );
            }
            final Story story = stories[index - 1];
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 4.0),
              child: _StoryCard(story: story),
            );
          }),
    );
  }
}

class _StoryCard extends StatelessWidget {
  final bool isAddStory;
  final User currentUser;
  final Story story;

  const _StoryCard(
      {Key key, this.isAddStory = false, this.story, this.currentUser})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
       Navigator.push(context, MaterialPageRoute(builder: (context) => ApiSinglePage(blogId: '32332323223',)));
      },
      child: Stack(
        children: [

          ClipRRect(
              borderRadius: BorderRadius.circular(12.0),
              child: CachedNetworkImage(
                imageUrl: isAddStory ? currentUser.imageUrl : story.imageUrl,
                height: double.infinity,
                width: 110.0,
                fit: BoxFit.cover,
              )

          ),
          Container(
            height: double.infinity,
            width: 110.0,
            decoration: BoxDecoration(
              gradient: Palette.storyGradient,
              borderRadius: BorderRadius.circular(12.0),

            ),
          ),

          Positioned(
            bottom: 8.0,
            left: 8.0,
            right: 8.0,
            child: Text('This is the first post by me and the fdjkdfjkd',
              style:const TextStyle(
                  color: Colors.white,fontWeight: FontWeight.bold,fontFamily: 'Josefin Sans'
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          )
        ],
      ),
    );



  }
}
