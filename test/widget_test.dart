import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:photo_gallery_camera/main.dart';

void main() {
  testWidgets('App renders without crashing', (WidgetTester tester) async {
    await tester.pumpWidget(const PhotoGalleryCameraApp());
    await tester.pump();

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
