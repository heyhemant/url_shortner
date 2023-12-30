// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_shortner/controllers/home_page_controller.dart';
import 'package:url_shortner/models/alert_item_model.dart';
import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late HomePageController controller;
  @override
  void initState() {
    controller = Get.put(HomePageController());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('URL Shortner')),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Please Enter URL to Shorten',
              style: TextStyle(fontSize: 25),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: controller.urlController,
              decoration: const InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Enter URL',
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () async {
                  AlertItemModel response = await controller.shortenUrl();
                  CoolAlert.show(
                      context: context,
                      type: response.type,
                      text: response.message,
                      title: response.title,
                      confirmBtnText: 'Copy URL',
                      onConfirmBtnTap: () async {
                        await Clipboard.setData(ClipboardData(
                            text: response.message
                                .replaceAll('Shortened URL: ', '')));
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                              content: Text('Link copied to clipboard!')),
                        );
                      });
                },
                child: const Text('Shorten URL'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
