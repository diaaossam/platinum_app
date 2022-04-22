import 'package:comment_box/comment/comment.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:platinum_app/components/app_text.dart';
import 'package:platinum_app/components/custom_text_form_field.dart';
import 'package:platinum_app/models/car_model.dart';
import 'package:platinum_app/models/comeent_model.dart';
import 'package:platinum_app/screens/details/cubit/details_cubit.dart';
import 'package:platinum_app/screens/details/cubit/details_state.dart';
import 'package:video_player/video_player.dart';
import '../../../components/custom_button.dart';
import '../../../shared/helper/mangers/size_config.dart';
import '../../../shared/helper/methods.dart';
import 'product_description.dart';
import 'top_rounded_container.dart';
import 'product_images.dart';

class Body extends StatefulWidget {
  final CarModel? carModel;
  var commentController = TextEditingController();

  Body({Key? key, required this.carModel}) : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

class _BodyState extends State<Body> {
  VideoPlayerController? _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(widget.carModel!.video ?? '')
      ..initialize().then((_) {});
  }

//Ok
  @override
  Widget build(BuildContext context) {
    return BlocProvider<DetailsCubit>(
      create: (BuildContext context) => DetailsCubit()
        ..getCarDetails(id: "${widget.carModel!.id}")
        ..getComments(carid: widget.carModel!.id??''),
      child: BlocConsumer<DetailsCubit, DetailsState>(
        listener: (context, state) {
          if (state is AddCarToFavSuccess) {
            showSnackBar(context, 'Car Added To Favourite List');
          } else if (state is RemoveCarFromFavSuccess) {
            showSnackBar(context, 'Car Removed From Favourite List ');
          }
          if(state is GetCCommentSuccess){
            widget.commentController.clear();
          }
        },
        builder: (context, state) {
          DetailsCubit cubit = DetailsCubit.get(context);
          return state is GetCarModelLoading
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : ListView(
                  children: [
                    ProductImages(carModel: cubit.carModel!),
                    SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: 200,
                      child: _controller!.value.isPlaying
                          ? Container(
                              padding: EdgeInsets.symmetric(horizontal: 50),
                              height: 200,
                              child: _controller!.value.isInitialized
                                  ? AspectRatio(
                                      aspectRatio: 16.0 / 21.0,
                                      child: VideoPlayer(_controller!),
                                    )
                                  : Center())
                          : Image.asset('assets/images/vedio.png'),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(10.0),
                    ),
                    IconButton(
                      color: Colors.black,
                      onPressed: () {
                        setState(() {
                          if (_controller!.value.isPlaying) {
                            _controller!.pause();
                          } else {
                            _controller!.play();
                          }
                        });
                      },
                      icon: Icon(
                          _controller!.value.isPlaying
                              ? Icons.pause
                              : Icons.play_arrow,
                          size: 40),
                    ),
                    SizedBox(
                      height: getProportionateScreenHeight(20.0),
                    ),
                    TopRoundedContainer(
                      color: Colors.white,
                      child: Column(
                        children: [
                          ProductDescription(
                            carModel: cubit.carModel!,
                          ),
                          TopRoundedContainer(
                            color: Color(0xFFF6F7F9),
                            child: Column(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(15.0),
                                  child: buildComentBox(
                                      widget.commentController,
                                      DetailsCubit.get(context),
                                      widget.carModel!.id ?? ''),
                                ),
                                SizedBox(
                                  height: getProportionateScreenHeight(20.0),
                                ),
                                /* TopRoundedContainer(
                            color: Colors.white,
                            child: Padding(
                                padding: EdgeInsets.only(
                                  left:
                                  SizeConfigManger.screenWidth * 0.15,
                                  right:
                                  SizeConfigManger.screenWidth * 0.15,
                                  bottom: getProportionateScreenWidth(40),
                                  top: getProportionateScreenWidth(15),
                                ),
                                child: CustomButton(
                                  press: () {},
                                  text: 'Buy This Car',
                                )),
                          ),*/
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
        },
      ),
    );
  }

  Widget buildComentBox(TextEditingController commentController, DetailsCubit cubit, String carId) {

    return Container(
      height: 250.0,
      child: Column(
        children: [
          AppText(text: 'Comments'),
          SizedBox(height: 10),
          Expanded(
            child: ListView.separated(
              separatorBuilder: (index,context)=>SizedBox(height: 15.0,),
                itemBuilder: (context, index) =>
                    AppText(text: '${cubit.commentList[index].comment}', textSize: 23),
                itemCount: cubit.commentList.length,
                shrinkWrap: true),
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                child: CustomTextFormField(
                  controller: commentController,
                  hintText: 'n',
                  lableText: 'Write Your Comment here',
                ),
              ),
              IconButton(
                  onPressed: () {
                    if (commentController.text.isNotEmpty) {
                      cubit.sendComment(
                          commentModel: CommentModel(
                              comment: commentController.text,
                              carId: carId,
                              senderId: FirebaseAuth.instance.currentUser!.uid));
                    }
                  },
                  icon: Icon(Icons.send))
            ],
          ),
        ],
      ),
    );
  }

/* Widget buildComentBox(commentController) {
    return CommentBox(
        commentController: commentController,
        backgroundColor: Colors.black,
        textColor: Colors.white,
        sendWidget: Icon(Icons.send_sharp, size: 30, color: Colors.white),
        userImage:,
        child: commentChild(filedata),
        labelText: 'Write a comment...',
        withBorder: false,
        errorText: 'Comment cannot be blank',
        sendButtonMethod: () {
          setState(() {
            var value = {
              'name': 'New User',
              'pic': 'https://lh3.googleusercontent.com/a-/AOh14GjRHcaendrf6gU5fPIVd8GIl1OgblrMMvGUoCBj4g=s400',
              'message': commentController.text
            };
            //filedata.insert(0, value);
          });
          commentController.clear();
          FocusScope.of(context).unfocus();
        }
    );
  }*/
}
