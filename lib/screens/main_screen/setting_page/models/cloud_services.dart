import 'package:flutter/material.dart';

class CloudServices {
  String headname;
  String tailname;
  Icon icon;

  CloudServices({required this.headname, required this.tailname, required this.icon});
}

List<CloudServices> cloudServices = [
  CloudServices(headname: 'Xiaomi Cloud', tailname: 'Turn on sync with the cloud', icon: Icon(Icons.arrow_forward_ios)),
  CloudServices(headname: 'Deleted notes in the cloud', tailname: '', icon: Icon(Icons.arrow_forward_ios))
];
