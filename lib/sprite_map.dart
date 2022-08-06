import 'package:flutter/material.dart';
import 'package:xml/xml.dart';

class SpriteMap {
  String name;
  double x;
  double y;
  double width;
  double height;
  SpriteMap(
      {required this.name,
      required this.x,
      required this.y,
      required this.width,
      required this.height});
  factory SpriteMap.fromXml(XmlElement xmlElement) {
    return SpriteMap(
        name: xmlElement.attributes
            .where((p0) => p0.name.local == "name")
            .first
            .value,
        x: double.tryParse(xmlElement.attributes
                .where((p0) => p0.name.local == "x")
                .first
                .value) ??
            0,
        y: double.tryParse(xmlElement.attributes
                .where((p0) => p0.name.local == "y")
                .first
                .value) ??
            0,
        width: double.tryParse(xmlElement.attributes
                .where((p0) => p0.name.local == "width")
                .first
                .value) ??
            0,
        height: double.tryParse(xmlElement.attributes
                .where((p0) => p0.name.local == "height")
                .first
                .value) ??
            0);
  }
}
