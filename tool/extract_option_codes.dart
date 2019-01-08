import 'dart:convert';
import 'dart:io';

const String teslaApiDocsOptionCodesMarkdownUrl = "https://raw.githubusercontent.com/timdorr/tesla-api/master/docs/vehicle/optioncodes.md";

main() async {
  var client = new HttpClient();
  var request = await client.getUrl(Uri.parse(teslaApiDocsOptionCodesMarkdownUrl));
  var response = await request.close();

  print(r"""
part of tesla;

class OptionCode {
  final String code;
  final String description;

  const OptionCode(this.code, this.description);

  @override
  String toString() => "OptionCode(${code}, ${description})";
""");

  var codes = <String>[];

  await for (var line in response.transform(const Utf8Decoder()).transform(const LineSplitter())) {
    if (!line.startsWith("| ")) {
      continue;
    }

    if (line.startsWith("| Code") || line.startsWith("| :")) {
      continue;
    }

    var parts = line.split("| ").map((x) => x.trim()).where((x) => x.isNotEmpty).toList();

    var code = parts[0];
    var description = parts[1];

    print("  static const OptionCode ${code} = const OptionCode(${json.encode(code)}, ${json.encode(description)});");
    codes.add(code);
  }

  print("");
  print("  static const List<OptionCode> values = const <OptionCode>[");

  while (codes.isNotEmpty) {
    var sub = codes.take(codes.length > 8 ? 8 : codes.length).join(", ");
    codes.removeRange(0, (codes.length > 8 ? 8 : codes.length));
    print("    ${sub}${codes.length > 0 ? ',' : ''}");
  }

  print("  ];");

  print("""

  static OptionCode lookup(String code) {
    return values.firstWhere((c) => c.code == code, orElse: () => null);
  }""");

  print("}");

  exit(0);
}
