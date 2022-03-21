import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mobileapp/core/components/exporting_packages.dart';
import 'package:http/http.dart' as http;
import 'package:mobileapp/core/data/app_data.dart';
import 'package:mobileapp/core/data/image_list.dart';
import 'package:mobileapp/models/obekt_model.dart';
import 'package:mobileapp/services/obekt_services.dart';
import 'package:mobileapp/widgets/dialogs/comment_dialog.dart';
import 'package:mobileapp/widgets/images_page_view.dart';
import 'package:mobileapp/widgets/rating_bar_widget.dart';
import 'package:share_plus/share_plus.dart';

class ObjectDetailsPage extends StatefulWidget {
  final Obekt place;

  const ObjectDetailsPage({Key? key, required this.place}) : super(key: key);

  @override
  State<ObjectDetailsPage> createState() => _ObjectDetailsPageState();
}

class _ObjectDetailsPageState extends State<ObjectDetailsPage> {
  bool isComment = false;

  late Obekt _place;

  @override
  initState() {
    super.initState();
    _place = widget.place;
  }

  List comment = [];
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0.0,
        actions: [
          IconButton(
              onPressed: _onShareButtonPressed,
              icon: const Icon(CupertinoIcons.share)),
        ],
      ),
      floatingActionButton: _commentButton(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: getHeight(410),
              width: getWidth(375),
              // TODO: if server will be worked, Image list must be changed
              child: ImagesPageView(imageList: ImageList.images),
            ),
            Padding(
              padding: MyEdgeInsets.all(15.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RatingBarWidget(
                    rating: _place.reyting!.toDouble(),
                    users: _place.users!,
                  ),
                  MySizedBox(height: 4.0),
                  Text(
                    widget.place.nameRu!,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                    style: AppTextStyle.medium(size: 18.0),
                  ),
                  MySizedBox(height: 17.0),
                  _buildLink(AppIcons.call, widget.place.tell!,
                      'tel:${widget.place.tell!.replaceAll('-', '')}',
                      labelColor: AppColors.black),
                  MySizedBox(height: 10.0),
                  _buildLink(
                    AppIcons.location,
                    'Расположение на карте',
                    widget.place.karta!,
                    iconColor: AppColors.red,
                  ),
                  MySizedBox(height: 10.0),
                  _buildLink(
                      AppIcons.link, widget.place.site!, widget.place.site!),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: getHeight(9.5)),
                    child: Divider(
                      thickness: getWidth(1),
                    ),
                  ),
                  Text(
                    widget.place.informRu!,
                    style: AppTextStyle.regular(height: 2.1),
                  ),
                ],
              ),
            ),
            isComment ? commentfunc(context, sendMessage) : SizedBox()
          ],
        ),
      ),
    );
  }

  void _onShareButtonPressed() async {
    String name = widget.place.nameEn!;
    String phone = widget.place.tell!;
    String text =
        '🗺 $name \n📞 $phone \n📱 Install App: ${AppData.playStoreLink}';
    await Share.share(text);
  }

  Row _buildLink(
    String assetIcon,
    String label,
    String link, {
    Color iconColor = AppColors.black,
    Color labelColor = AppColors.linkColor,
  }) {
    return Row(
      children: [
        SvgPicture.asset(assetIcon, height: getHeight(15.0), color: iconColor),
        MySizedBox(width: 15.0),
        UrlTextWidget(text: label, url: link, color: labelColor)
      ],
    );
  }

  Column commentfunc(BuildContext context, VoidCallback funcComment) {
    return Column(
      children: [
        Container(
          alignment: Alignment.center,
          // color: Colors.red,
          height: getHeight(45),
          width: MediaQuery.of(context).size.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: getWidth(8)),
                child: SvgPicture.asset(AppIcons.commentperson),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.72,
                child: TextFormFieldWidget(
                  controller: _commentController,
                ),
              ),
              InkWell(
                onTap: funcComment,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: getWidth(8)),
                  child: SvgPicture.asset(AppIcons.send),
                ),
              )
            ],
          ),
        ),
        Container(
          width: getWidth(288),
          padding: const EdgeInsets.all(8.0),
          height: getHeight(400),
          child: ListView.builder(
            reverse: true,
            itemBuilder: (context, i) {
              return Container(
                child: Row(
                  children: [
                    CircleAvatar(
                      child: Text(
                        comment[i]['user'][0],
                      ),
                    ),
                    SizedBox(
                      width: getWidth(10),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "${comment[i]['user']}",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        Text("${comment[i]['name']}"),
                      ],
                    ),
                  ],
                ),
              );
            },
            itemCount: comment.length,
          ),
        )
      ],
    );
  }

  sendMessage() async {
    if (GetStorage().read('token') == null) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SignInPage()));
    } else {
      await ObektSevices().addCommentToObekt(
          gitId: widget.place.id.toString(),
          commentText: _commentController.text);
      onCommentPressed();
      setState(() {});
    }
  }

  void onCommentPressed() async {
    try {
      var headers = {
        'object_id': '${widget.place.id}',
      };
      var request = http.Request('GET',
          Uri.parse('https://ucharteam-tourism.herokuapp.com/v1/api/comment'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        var res = await response.stream.bytesToString();
        comment = jsonDecode(res)['data'];
        isComment = true;

        setState(() {});
        print(comment.toString());
      } else {
        print(response.reasonPhrase);
      }
    } catch (e) {
      print(e.toString());
    }
  }

  FloatingActionButton _commentButton() => FloatingActionButton(
        onPressed: _onCommentButtonPressed,
        backgroundColor: AppColors.black,
        child: SvgPicture.asset(AppIcons.comment),
      );

  void _onCommentButtonPressed() {
    showModalBottomSheet(
        context: context,
        builder: (_) => CommentListDialog(headers: {'object_id': _place.id!}));
  }
}
