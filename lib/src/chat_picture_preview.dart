import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_openim_widget/flutter_openim_widget.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:photo_view/photo_view.dart';

/*class ChatPicturePreview extends StatefulWidget {
  const ChatPicturePreview({
    Key? key,
    required this.tag,
    required this.url,
    this.localizations = const UILocalizations(),
    this.onDownload,
  }) : super(key: key);
  final String url;
  final String tag;
  final Future<bool> Function(String)? onDownload;
  final UILocalizations localizations;

  @override
  _ChatPicturePreviewState createState() => _ChatPicturePreviewState();
}

class _ChatPicturePreviewState extends State<ChatPicturePreview> {
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Color(0xFF000000),
      child: Stack(
        children: [
          Container(
            child: PhotoView(
              // onTapDown: (context, details, value) => Navigator.pop(context),
              imageProvider: CachedNetworkImageProvider(widget.url),
              // disableGestures: false,
              // gaplessPlayback: true,
              // enableRotation: true,
              heroAttributes: PhotoViewHeroAttributes(tag: widget.tag),
              // customSize: Size(200.w, 400.h),
              loadingBuilder: (BuildContext context, ImageChunkEvent? event) {
                return Container(
                  height: 20.0,
                  width: 20.0,
                  child: CupertinoActivityIndicator(),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: Color(0xFF999999),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ChatIcon.error(width: 80.w, height: 70.h),
                      SizedBox(
                        height: 19.h,
                      ),
                      Text(
                        widget.localizations.picLoadError,
                        style: TextStyle(color: Colors.white, fontSize: 18.sp),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          Positioned(
            top: 40.h,
            left: 30.w,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  color: Color(0xFFFFFFFF).withOpacity(0.23),
                  // color: Colors.blue,
                  // borderRadius: BorderRadius.circular(16),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.close),
              ),
            ),
          ),
          Positioned(
            top: 676.h,
            width: 375.w,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () async {
                    bool? success = await widget.onDownload?.call(widget.url);
                  },
                  child: Container(
                    width: 100.w,
                    height: 30.h,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Color(0xFFFFFFFF).withOpacity(0.23),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Text(
                      widget.localizations.download,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}*/

class ChatPicturePreview extends StatelessWidget {
  const ChatPicturePreview({
    Key? key,
    required this.tag,
    this.url,
    this.file,
    this.onDownload,
  }) : super(key: key);
  final String? url;
  final File? file;
  final String tag;
  final Future<bool> Function(String)? onDownload;

  @override
  Widget build(BuildContext context) {
    ImageProvider? provider;
    if (null != url && url!.isNotEmpty) {
      provider = CachedNetworkImageProvider(url!);
    } else if (null != file) {
      provider = FileImage(file!);
    }

    return Material(
      color: Color(0xFF000000),
      child: Stack(
        children: [
          null != provider
              ? PhotoView(
                  // onTapDown: (context, details, value) => Navigator.pop(context),
                  imageProvider: provider,
                  // disableGestures: false,
                  // gaplessPlayback: true,
                  // enableRotation: true,
                  heroAttributes: PhotoViewHeroAttributes(
                    tag: tag,
                    // placeholderBuilder: (context, heroSize, child) => Center(
                    //   child: CupertinoActivityIndicator(),
                    // ),
                  ),
                  // customSize: Size(200.w, 400.h),
                  loadingBuilder: (context, event) => Center(
                    child: Container(
                      width: 20.0,
                      height: 20.0,
                      child: CircularProgressIndicator(
                        value: event == null
                            ? 0
                            : event.cumulativeBytesLoaded /
                                event.expectedTotalBytes!,
                      ),
                    ),
                  ),
                  errorBuilder: (context, error, stackTrace) => _errorView(),
                )
              : _errorView(),
          Positioned(
            top: 40.h,
            left: 30.w,
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                  // color: Color(0xFFFFFFFF).withOpacity(0.23),
                  color: Colors.grey.withOpacity(0.5),
                  // color: Colors.blue,
                  // borderRadius: BorderRadius.circular(16),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.close, color: Colors.white),
              ),
            ),
          ),
          if (null != url && url!.isNotEmpty)
            Positioned(
              top: 676.h,
              width: 375.w,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () async {
                      bool? success = await onDownload?.call(url!);
                    },
                    child: Container(
                      width: 100.w,
                      height: 30.h,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        // color: Color(0xFFFFFFFF).withOpacity(0.23),
                        color: Colors.grey.withOpacity(0.5),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Text(
                        UILocalizations.download,
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }

  Widget _errorView() => Container(
        width: 375.w,
        color: Color(0xFF999999),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconUtil.error(width: 80.w, height: 70.h),
            SizedBox(
              height: 19.h,
            ),
            Text(
              UILocalizations.picLoadError,
              style: TextStyle(color: Colors.white, fontSize: 18.sp),
            )
          ],
        ),
      );
}
