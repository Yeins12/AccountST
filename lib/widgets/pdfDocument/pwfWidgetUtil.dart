import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

PdfColor green = PdfColor.fromHex('#21b674');
PdfColor lightGreen = PdfColor.fromHex('#c5e7c6');

Future myPageTheme(PdfPageFormat format) async {
  return pw.PageTheme(
    pageFormat: format.applyMargin(
        right: 0,
        left: 0,
        top: 0.05 * PdfPageFormat.cm,
        bottom: 0.05 * PdfPageFormat.cm),
    buildBackground: (pw.Context context) {
      return pw.FullPage(
        ignoreMargins: true,
        child: pw.CustomPaint(
          size: PdfPoint(format.width, format.height),
          painter: (PdfGraphics canvas, PdfPoint size) {
            context.canvas
              ..setColor(lightGreen)
              ..moveTo(0, size.y)
              ..lineTo(0, size.y - 150)
              ..lineTo(60, size.y)
              ..fillPath()
              ..setColor(green)
              ..moveTo(0, size.y)
              ..lineTo(0, size.y - 50)
              ..lineTo(50, size.y)
              ..fillPath()
              ..setColor(lightGreen)
              ..moveTo(30, size.y)
              ..lineTo(100, size.y - 50)
              ..lineTo(100, size.y)
              ..fillPath()
              ..moveTo(size.x, 0)
              ..lineTo(size.x, 100)
              ..lineTo(size.x - 30, 0)
              ..fillPath()
              ..setColor(green)
              ..moveTo(size.x, 0)
              ..lineTo(size.x, 100)
              ..lineTo(size.x - 100, 0)
              ..fillPath()
              ..setColor(lightGreen)
              ..moveTo(size.x - 30, 0)
              ..lineTo(size.x - 100, 50)
              ..lineTo(size.x - 100, 0)
              ..fillPath();
          },
        ),
      );
    },
  );
}
