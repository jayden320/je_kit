import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/services.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:permission_handler/permission_handler.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';

import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'indicator_button.dart';
import '../foundation/screen.dart';
import 'toast.dart';

class PhotoViewer extends StatefulWidget {
  final int index;
  final List<String> urls;
  const PhotoViewer(this.urls, {this.index = 0, Key? key}) : super(key: key);

  @override
  _PhotoViewerState createState() => _PhotoViewerState();

  static Future showDialog(BuildContext context, List<String> urls, int index) {
    return showGeneralDialog(
      context: context,
      barrierDismissible: true,
      transitionDuration: const Duration(milliseconds: 250),
      barrierLabel: MaterialLocalizations.of(context).modalBarrierDismissLabel,
      pageBuilder: (BuildContext context, Animation<double> animation, Animation<double> secondaryAnimation) {
        return PhotoViewer(urls, index: index);
      },
    );
  }
}

class _PhotoViewerState extends State<PhotoViewer> {
  late int idx;
  int? len;
  PageController? _controller;
  File? _imageFile;

  @override
  void initState() {
    super.initState();
    idx = widget.index;
    len = widget.urls.length;
    _controller = PageController(initialPage: widget.index);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);

    fetchImage();
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
  }

  fetchImage() async {
    var url = widget.urls[idx];
    if (url.startsWith('http')) {
      _imageFile = await DefaultCacheManager().getSingleFile(url);
    } else {
      _imageFile = File(url);
    }
    setState(() {});
  }

  List<PhotoViewGalleryPageOptions> _buildItems() {
    return widget.urls.map((it) {
      return PhotoViewGalleryPageOptions(
        minScale: PhotoViewComputedScale.contained * 0.8,
        maxScale: PhotoViewComputedScale.covered * 1.1,
        imageProvider: ((it.startsWith('http:') || it.startsWith('https:'))
            ? CachedNetworkImageProvider(it)
            : FileImage(File(it))) as ImageProvider<Object>?,
      );
    }).toList();
  }

  _onPageChanged(index) {
    setState(() {
      idx = index;
    });
  }

  Future _saveImage() async {
    if (Platform.isAndroid) {
      PermissionStatus storagePermissionStatus = await Permission.storage.request();
      if (storagePermissionStatus != PermissionStatus.granted) {
        Toast.show('您尚未授予本应用数据存储权限,请在系统设置中打开。');
        return;
      }
    }

    var file = await DefaultCacheManager().getSingleFile(widget.urls[idx]);
    final result = await ImageGallerySaver.saveFile(file.path);
    if (result['isSuccess']) {
      Toast.show('已保存到系统相册');
    } else {
      Toast.show('保存失败');
    }
  }

  buildContent() {
    if (_imageFile == null) {
      return Container(
        alignment: AlignmentDirectional.center,
        child: const CircularProgressIndicator(),
      );
    }
    return Stack(
      alignment: Alignment.bottomRight,
      children: <Widget>[
        PhotoViewGallery(
          pageController: _controller,
          pageOptions: _buildItems(),
          onPageChanged: _onPageChanged,
          backgroundDecoration: const BoxDecoration(color: Colors.black),
        ),
        IndicatorButton(
          margin: EdgeInsets.only(bottom: Screen.bottomSafeHeight),
          onPressed: _saveImage,
          child: const Icon(
            Icons.file_download,
            color: Colors.white70,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        behavior: HitTestBehavior.translucent,
        child: buildContent(),
      ),
    );
  }
}
