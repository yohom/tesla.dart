library tesla;

import 'dart:async';
import 'dart:convert' hide json;
import 'dart:io';

part 'src/client.dart';
part 'src/summon.dart';
part 'src/streaming.dart';
part 'src/options.dart';

part 'src/types/vehicle.dart';
part 'src/types/all_vehicle_state.dart';
part 'src/types/charge_state.dart';
part 'src/types/climate_state.dart';
part 'src/types/drive_state.dart';
part 'src/types/gui_settings.dart';
part 'src/types/media_state.dart';
part 'src/types/speed_limit_mode.dart';
part 'src/types/seat_heater.dart';
part 'src/types/vehicle_state.dart';

const String _teslaClientId =
    "81527cff06843c8634fdc09e8ac0abefb46ac849f38fe1e431c2ef2106796384";
const String _teslaClientSecret =
    "c7257eb71a564034f9419ee651c7d0e5f7aa6bfbd18bafb5c5c033b093bb2fa3";

final Uri _teslaOwnersUrl = Uri.parse("https://owner-api.teslamotors.com/");
