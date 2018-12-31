library tesla;

import 'dart:async';
import 'dart:convert' hide json;
import 'dart:io';

part 'src/client.dart';
part 'src/vehicle.dart';
part 'src/summon.dart';
part 'src/streaming.dart';
part 'src/heater.dart';

const String _teslaClientId = "81527cff06843c8634fdc09e8ac0abefb46ac849f38fe1e431c2ef2106796384";
const String _teslaClientSecret = "c7257eb71a564034f9419ee651c7d0e5f7aa6bfbd18bafb5c5c033b093bb2fa3";

final Uri _teslaOwnersUrl = Uri.parse("https://owner-api.teslamotors.com/");
