import 'dart:convert';

import 'package:cool_alert/cool_alert.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:http/http.dart';
import 'package:url_shortner/models/alert_item_model.dart';
import 'package:url_shortner/services/api_services.dart';

class HomePageController extends GetxController {
  TextEditingController urlController = TextEditingController();

  Future<AlertItemModel> shortenUrl() async {
    AlertItemModel alertItemModel =
        AlertItemModel(title: '', message: '', type: CoolAlertType.success);
    if (urlController.text.isEmpty) {
      alertItemModel.message = 'Please enter a URL';
      alertItemModel.type = CoolAlertType.error;
      alertItemModel.title = 'Error';
    } else {
      try {
        Response response = await ApiServices().getShortUrl(urlController.text);
        if (response.statusCode == 201) {
          alertItemModel.message = 'Shortened URL: ${jsonDecode(response.body)['short_url']}'  ;
          alertItemModel.type = CoolAlertType.success;
          alertItemModel.title = 'Success';
        } else {
          alertItemModel.message = jsonDecode(response.body)['error'].toString();
          alertItemModel.type = CoolAlertType.error;
          alertItemModel.title = 'Error';
        }
      } catch (e) {
        alertItemModel.message = e.toString();
        alertItemModel.type = CoolAlertType.error;
        alertItemModel.title = 'Error';
      }
    }
    return alertItemModel;
  }
}
