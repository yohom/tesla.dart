part of tesla;

class OptionCode {
  final String code;
  final String description;

  const OptionCode(this.code, this.description);

  @override
  String toString() => "OptionCode(${code}, ${description})";

  static const OptionCode MDLS = const OptionCode("MDLS", "Model S");
  static const OptionCode MDLX = const OptionCode("MDLX", "Model X");
  static const OptionCode MDL3 = const OptionCode("MDL3", "Model 3");
  static const OptionCode RENA =
      const OptionCode("RENA", "Region: North America");
  static const OptionCode RENC = const OptionCode("RENC", "Region: Canada");
  static const OptionCode REEU = const OptionCode("REEU", "Region: Europe");
  static const OptionCode AD02 = const OptionCode("AD02", "NEMA 14-50");
  static const OptionCode AD04 = const OptionCode("AD04", "European 3-Phase");
  static const OptionCode AD05 =
      const OptionCode("AD05", "European 3-Phase, IT");
  static const OptionCode AD06 =
      const OptionCode("AD06", "Schuko (1 phase, 230V 13A)");
  static const OptionCode AD07 =
      const OptionCode("AD07", "Red IEC309 (3 phase, 400V 16A)");
  static const OptionCode ADPX2 =
      const OptionCode("ADPX2", "Type 2 Public Charging Connector");
  static const OptionCode ADX8 =
      const OptionCode("ADX8", "Blue IEC309 (1 phase, 230V 32A)");
  static const OptionCode AF00 = const OptionCode("AF00", "No HEPA Filter");
  static const OptionCode AF02 = const OptionCode("AF02", "HEPA Filter");
  static const OptionCode AH00 = const OptionCode("AH00", "No Accessory Hitch");
  static const OptionCode APE1 = const OptionCode("APE1", "Enhanced Autopilot");
  static const OptionCode APF0 =
      const OptionCode("APF0", "Autopilot Firmware 2.0 Base");
  static const OptionCode APF1 =
      const OptionCode("APF1", "Autopilot Firmware 2.0 Enhanced");
  static const OptionCode APF2 =
      const OptionCode("APF2", "Full Self-Driving Capability");
  static const OptionCode APH0 =
      const OptionCode("APH0", "Autopilot 2.0 Hardware");
  static const OptionCode APH2 =
      const OptionCode("APH2", "Autopilot 2.0 Hardware");
  static const OptionCode APH3 =
      const OptionCode("APH3", "Autopilot 2.5 Hardware");
  static const OptionCode APPA =
      const OptionCode("APPA", "Autopilot 1.0 Hardware");
  static const OptionCode APPB = const OptionCode("APPB", "Enhanced Autopilot");
  static const OptionCode AU00 = const OptionCode("AU00", "No Audio Package");
  static const OptionCode AU01 =
      const OptionCode("AU01", "Ultra High Fidelity Sound");
  static const OptionCode BC0B =
      const OptionCode("BC0B", "Tesla Black Brake Calipers");
  static const OptionCode BC0R =
      const OptionCode("BC0R", "Tesla Red Brake Calipers");
  static const OptionCode BCMB =
      const OptionCode("BCMB", "Black Brake Calipers");
  static const OptionCode BP00 = const OptionCode("BP00", "No Ludicrous");
  static const OptionCode BP01 =
      const OptionCode("BP01", "Ludicrous Speed Upgrade");
  static const OptionCode BR00 =
      const OptionCode("BR00", "No Battery Firmware Limit");
  static const OptionCode BR03 =
      const OptionCode("BR03", "Battery Firmware Limit (60kWh)");
  static const OptionCode BR05 =
      const OptionCode("BR05", "Battery Firmware Limit (75kWh)");
  static const OptionCode BS00 =
      const OptionCode("BS00", "General Production Flag");
  static const OptionCode BS01 =
      const OptionCode("BS01", "Special Production Flag");
  static const OptionCode BT37 = const OptionCode("BT37", "75 kWh (Model 3)");
  static const OptionCode BT40 = const OptionCode("BT40", "40 kWh");
  static const OptionCode BT60 = const OptionCode("BT60", "60 kWh");
  static const OptionCode BT70 = const OptionCode("BT70", "70 kWh");
  static const OptionCode BT85 = const OptionCode("BT85", "85 kWh");
  static const OptionCode BTX4 = const OptionCode("BTX4", "90 kWh");
  static const OptionCode BTX5 = const OptionCode("BTX5", "75 kWh");
  static const OptionCode BTX6 = const OptionCode("BTX6", "100 kWh");
  static const OptionCode BTX7 = const OptionCode("BTX7", "75 kWh");
  static const OptionCode BTX8 = const OptionCode("BTX8", "85 kWh");
  static const OptionCode CC04 =
      const OptionCode("CC04", "Seven Seat Interior");
  static const OptionCode CDM0 =
      const OptionCode("CDM0", "No CHAdeMO Charging Adaptor");
  static const OptionCode CH00 =
      const OptionCode("CH00", "Standard Charger (40 Amp)");
  static const OptionCode CH01 =
      const OptionCode("CH01", "Dual Chargers (80 Amp)");
  static const OptionCode CH04 =
      const OptionCode("CH04", "72 Amp Charger (Model S/X)");
  static const OptionCode CH05 =
      const OptionCode("CH05", "48 Amp Charger (Model S/X)");
  static const OptionCode CH07 =
      const OptionCode("CH07", "48 Amp Charger (Model 3)");
  static const OptionCode COL0 = const OptionCode("COL0", "Signature");
  static const OptionCode COL1 = const OptionCode("COL1", "Solid");
  static const OptionCode COL2 = const OptionCode("COL2", "Metallic");
  static const OptionCode COL3 = const OptionCode("COL3", "Tesla Multi-Coat");
  static const OptionCode COUS =
      const OptionCode("COUS", "Country: United States");
  static const OptionCode CW00 =
      const OptionCode("CW00", "No Cold Weather Package");
  static const OptionCode CW02 =
      const OptionCode("CW02", "Subzero Weather Package");
  static const OptionCode DA00 = const OptionCode("DA00", "No Autopilot");
  static const OptionCode DA01 =
      const OptionCode("DA01", "Active Safety (ACC,LDW,SA)");
  static const OptionCode DA02 =
      const OptionCode("DA02", "Autopilot Convenience Features");
  static const OptionCode DCF0 =
      const OptionCode("DCF0", "Autopilot Convenience Features (DCF0)");
  static const OptionCode DRLH = const OptionCode("DRLH", "Left Hand Drive");
  static const OptionCode DRRH = const OptionCode("DRRH", "Right Hand Drive");
  static const OptionCode DSH5 = const OptionCode("DSH5", "PUR Dash Pad");
  static const OptionCode DSH7 =
      const OptionCode("DSH7", "Alcantara Dashboard Accents");
  static const OptionCode DSHG = const OptionCode("DSHG", "PUR Dash Pad");
  static const OptionCode DU00 = const OptionCode("DU00", "Drive Unit - IR");
  static const OptionCode DU01 =
      const OptionCode("DU01", "Drive Unit - Infineon");
  static const OptionCode DV2W = const OptionCode("DV2W", "Rear-Wheel Drive");
  static const OptionCode DV4W = const OptionCode("DV4W", "All-Wheel Drive");
  static const OptionCode FG00 =
      const OptionCode("FG00", "No Exterior Lighting Package");
  static const OptionCode FG01 =
      const OptionCode("FG01", "Exterior Lighting Package");
  static const OptionCode FG02 =
      const OptionCode("FG02", "Exterior Lighting Package");
  static const OptionCode FMP6 = const OptionCode("FMP6", "FMP6");
  static const OptionCode FR01 = const OptionCode("FR01", "Base Front Row");
  static const OptionCode FR03 = const OptionCode("FR03", "FR03");
  static const OptionCode FR04 = const OptionCode("FR04", "FR04");
  static const OptionCode HC00 =
      const OptionCode("HC00", "No Home Charging installation");
  static const OptionCode HC01 =
      const OptionCode("HC01", "Home Charging Installation");
  static const OptionCode HP00 = const OptionCode("HP00", "No HPWC Ordered");
  static const OptionCode HP01 = const OptionCode("HP01", "HPWC Ordered");
  static const OptionCode IDBA =
      const OptionCode("IDBA", "Dark Ash Wood Decor");
  static const OptionCode IDBO =
      const OptionCode("IDBO", "Figured Ash Wood Decor");
  static const OptionCode IDCF = const OptionCode("IDCF", "Carbon Fiber Decor");
  static const OptionCode IDOM =
      const OptionCode("IDOM", "Matte Obeche Wood Decor");
  static const OptionCode IDOG =
      const OptionCode("IDOG", "Gloss Obeche Wood Decor");
  static const OptionCode IDLW = const OptionCode("IDLW", "Lacewood Decor");
  static const OptionCode IDPB = const OptionCode("IDPB", "Piano Black Decor");
  static const OptionCode IN3PB =
      const OptionCode("IN3PB", "All Black Premium Interior");
  static const OptionCode INBBW = const OptionCode("INBBW", "White");
  static const OptionCode INBFP = const OptionCode("INBFP", "Classic Black");
  static const OptionCode INBPP = const OptionCode("INBPP", "Black");
  static const OptionCode INBTB =
      const OptionCode("INBTB", "Multi-Pattern Black");
  static const OptionCode INFBP = const OptionCode("INFBP", "Black Premium");
  static const OptionCode INLPC = const OptionCode("INLPC", "Cream");
  static const OptionCode INLPP =
      const OptionCode("INLPP", "Black / Light Headliner");
  static const OptionCode INWPT = const OptionCode("INWPT", "Tan Interior");
  static const OptionCode IVBPP =
      const OptionCode("IVBPP", "All Black Interior");
  static const OptionCode IVBSW =
      const OptionCode("IVBSW", "Ultra White Interior");
  static const OptionCode IVBTB =
      const OptionCode("IVBTB", "All Black Interior");
  static const OptionCode IVLPC = const OptionCode("IVLPC", "Vegan Cream");
  static const OptionCode IX00 =
      const OptionCode("IX00", "No Extended Nappa Leather Trim");
  static const OptionCode IX01 =
      const OptionCode("IX01", "Extended Nappa Leather Trim");
  static const OptionCode LLP1 = const OptionCode("LLP1", "LLP1");
  static const OptionCode LP01 =
      const OptionCode("LP01", "Premium Interior Lighting");
  static const OptionCode LT00 = const OptionCode("LT00", "Vegan interior");
  static const OptionCode LT01 = const OptionCode("LT01", "Standard interior");
  static const OptionCode LT1B = const OptionCode("LT1B", "LT1B");
  static const OptionCode LT3W = const OptionCode("LT3W", "LT3W");
  static const OptionCode LT4B = const OptionCode("LT4B", "LT4B");
  static const OptionCode LT4C = const OptionCode("LT4C", "LT4C");
  static const OptionCode LT4W = const OptionCode("LT4W", "LT4W");
  static const OptionCode LT5C = const OptionCode("LT5C", "LT5C");
  static const OptionCode LT5P = const OptionCode("LT5P", "LT5P");
  static const OptionCode ME02 = const OptionCode("ME02", "Memory Seats");
  static const OptionCode MI00 =
      const OptionCode("MI00", "2015 Production Refresh");
  static const OptionCode MI01 =
      const OptionCode("MI01", "2016 Production Refresh");
  static const OptionCode MI02 =
      const OptionCode("MI02", "2017 Production Refresh");
  static const OptionCode MT305 =
      const OptionCode("MT305", "Mid Range Rear-Wheel Drive");
  static const OptionCode PA00 = const OptionCode("PA00", "No Paint Armor");
  static const OptionCode PBCW = const OptionCode("PBCW", "Catalina White");
  static const OptionCode PBSB = const OptionCode("PBSB", "Sierra Black");
  static const OptionCode PBT8 = const OptionCode("PBT8", "Performance 85kWh");
  static const OptionCode PF00 =
      const OptionCode("PF00", "No Performance Legacy Package");
  static const OptionCode PF01 =
      const OptionCode("PF01", "Performance Legacy Package");
  static const OptionCode PI00 =
      const OptionCode("PI00", "No Premium Interior");
  static const OptionCode PI01 =
      const OptionCode("PI01", "Premium Upgrades Package");
  static const OptionCode PK00 =
      const OptionCode("PK00", "LEGACY No Parking Sensors");
  static const OptionCode PMAB =
      const OptionCode("PMAB", "Anza Brown Metallic");
  static const OptionCode PMBL =
      const OptionCode("PMBL", "Obsidian Black Multi-Coat");
  static const OptionCode PMMB =
      const OptionCode("PMMB", "Monterey Blue Metallic");
  static const OptionCode PMMR = const OptionCode("PMMR", "Multi-Coat Red");
  static const OptionCode PMNG =
      const OptionCode("PMNG", "Midnight Silver Metallic");
  static const OptionCode PMSG =
      const OptionCode("PMSG", "Sequoia Green Metallic");
  static const OptionCode PMSS =
      const OptionCode("PMSS", "San Simeon Silver Metallic");
  static const OptionCode PMTG =
      const OptionCode("PMTG", "Dolphin Grey Metallic");
  static const OptionCode PPMR =
      const OptionCode("PPMR", "Muir Red Multi-Coat");
  static const OptionCode PPSB = const OptionCode("PPSB", "Deep Blue Metallic");
  static const OptionCode PPSR = const OptionCode("PPSR", "Signature Red");
  static const OptionCode PPSW =
      const OptionCode("PPSW", "Shasta Pearl White Multi-Coat");
  static const OptionCode PPTI = const OptionCode("PPTI", "Titanium Metallic");
  static const OptionCode PRM31 = const OptionCode("PRM31", "Premium Interior");
  static const OptionCode PS00 = const OptionCode("PS00", "No Parcel Shelf");
  static const OptionCode PS01 = const OptionCode("PS01", "Parcel Shelf");
  static const OptionCode PX00 =
      const OptionCode("PX00", "No Performance Plus Package");
  static const OptionCode PX01 = const OptionCode("PX01", "Performance Plus");
  static const OptionCode PX6D =
      const OptionCode("PX6D", "Zero to 60 in 2.5 sec");
  static const OptionCode P85D = const OptionCode("P85D", "P85D");
  static const OptionCode QNET = const OptionCode("QNET", "Tan NextGen");
  static const OptionCode QPMP = const OptionCode("QPMP", "Black seats");
  static const OptionCode QTBW =
      const OptionCode("QTBW", "White Premium Seats");
  static const OptionCode QTFP =
      const OptionCode("QTFP", "Black Premium Seats");
  static const OptionCode QTPC =
      const OptionCode("QTPC", "Cream Premium Seats");
  static const OptionCode QTPP =
      const OptionCode("QTPP", "Black Premium Seats");
  static const OptionCode QTPT = const OptionCode("QTPT", "Tan Premium Seats");
  static const OptionCode QTTB =
      const OptionCode("QTTB", "Multi-Pattern Black Seats");
  static const OptionCode QVBM =
      const OptionCode("QVBM", "Multi-Pattern Black Seats");
  static const OptionCode QVPC = const OptionCode("QVPC", "Vegan Cream Seats");
  static const OptionCode QVPP = const OptionCode("QVPP", "Vegan Cream Seats");
  static const OptionCode QVSW = const OptionCode("QVSW", "White Tesla Seats");
  static const OptionCode RCX0 = const OptionCode("RCX0", "No Rear Console");
  static const OptionCode RF3G = const OptionCode("RF3G", "Model 3 Glass Roof");
  static const OptionCode RFBK = const OptionCode("RFBK", "Black Roof");
  static const OptionCode RFBC = const OptionCode("RFBC", "Body Color Roof");
  static const OptionCode RFFG = const OptionCode("RFFG", "Glass Roof");
  static const OptionCode RFP0 =
      const OptionCode("RFP0", "All Glass Panoramic Roof");
  static const OptionCode RFP2 = const OptionCode("RFP2", "Sunroof");
  static const OptionCode RFPX = const OptionCode("RFPX", "Model X Roof");
  static const OptionCode S02P = const OptionCode("S02P", "S02P");
  static const OptionCode S31B = const OptionCode("S31B", "S31B");
  static const OptionCode S32C = const OptionCode("S32C", "S32C");
  static const OptionCode S32P = const OptionCode("S32P", "S32P");
  static const OptionCode S32W = const OptionCode("S32W", "S32W");
  static const OptionCode SC00 = const OptionCode("SC00", "No Supercharging");
  static const OptionCode SC01 =
      const OptionCode("SC01", "Supercharging Enabled");
  static const OptionCode SC04 =
      const OptionCode("SC04", "Pay Per Use Supercharging");
  static const OptionCode SC05 = const OptionCode("SC05", "Free Supercharging");
  static const OptionCode SP00 =
      const OptionCode("SP00", "No Security Package");
  static const OptionCode SR01 = const OptionCode("SR01", "Standard 2nd row");
  static const OptionCode SR06 =
      const OptionCode("SR06", "Seven Seat Interior");
  static const OptionCode SR07 = const OptionCode("SR07", "Standard 2nd row");
  static const OptionCode ST00 =
      const OptionCode("ST00", "Non-leather Steering Wheel");
  static const OptionCode ST01 =
      const OptionCode("ST01", "Non-heated Leather Steering Wheel");
  static const OptionCode SU00 =
      const OptionCode("SU00", "Standard Suspension");
  static const OptionCode SU01 =
      const OptionCode("SU01", "Smart Air Suspension");
  static const OptionCode TIC4 = const OptionCode("TIC4", "All-Season Tires");
  static const OptionCode TM00 =
      const OptionCode("TM00", "General Production Trim");
  static const OptionCode TM02 =
      const OptionCode("TM02", "General Production Signature Trim");
  static const OptionCode TM0A =
      const OptionCode("TM0A", "ALPHA PRE-PRODUCTION NON-SALEABLE");
  static const OptionCode TM0B =
      const OptionCode("TM0B", "BETA PRE-PRODUCTION NON-SALEABLE");
  static const OptionCode TM0C =
      const OptionCode("TM0C", "PRE-PRODUCTION SALEABLE");
  static const OptionCode TP01 =
      const OptionCode("TP01", "Tech Package - No Autopilot");
  static const OptionCode TP02 =
      const OptionCode("TP02", "Tech Package with Autopilot");
  static const OptionCode TP03 =
      const OptionCode("TP03", "Tech Package with Enhanced Autopilot");
  static const OptionCode TR00 = const OptionCode("TR00", "No Third Row Seat");
  static const OptionCode TR01 = const OptionCode("TR01", "Third Row Seating");
  static const OptionCode TRA1 = const OptionCode("TRA1", "Third Row HVAC");
  static const OptionCode TW01 = const OptionCode("TW01", "Towing Package");
  static const OptionCode UM01 =
      const OptionCode("UM01", "Universal Mobile Charger - US Port (Single)");
  static const OptionCode UTAB =
      const OptionCode("UTAB", "Black Alcantara Headliner");
  static const OptionCode UTAW = const OptionCode("UTAW", "Light Headliner");
  static const OptionCode UTPB = const OptionCode("UTPB", "Dark Headliner");
  static const OptionCode UTSB = const OptionCode("UTSB", "Dark Headliner");
  static const OptionCode W39B = const OptionCode("W39B", "19\" Sport Wheels");
  static const OptionCode WT20 =
      const OptionCode("WT20", "20\" Silver Slipstream Wheels");
  static const OptionCode WTAS =
      const OptionCode("WTAS", "19\" Silver Slipstream Wheels");
  static const OptionCode WTDS =
      const OptionCode("WTDS", "19\" Grey Slipstream Wheels");
  static const OptionCode WTSG =
      const OptionCode("WTSG", "21\" Turbine Wheels");
  static const OptionCode WTSP =
      const OptionCode("WTSP", "21\" Turbine Wheels");
  static const OptionCode WTSS =
      const OptionCode("WTSS", "21\" Turbine Wheels");
  static const OptionCode WTTB =
      const OptionCode("WTTB", "19\" Cyclone Wheels");
  static const OptionCode WTW4 =
      const OptionCode("WTW4", "19\" Winter Tire Set");
  static const OptionCode WTW5 =
      const OptionCode("WTW5", "21\" Winter Tire Set");
  static const OptionCode WTX1 =
      const OptionCode("WTX1", "19\" Michelin Primacy Tire Upgrade");
  static const OptionCode WXW4 =
      const OptionCode("WXW4", "No 19\" Winter Tire Set");
  static const OptionCode WXW5 =
      const OptionCode("WXW5", "No 21\" Winter Tire Set");
  static const OptionCode X001 =
      const OptionCode("X001", "Override: Power Liftgate");
  static const OptionCode X003 = const OptionCode("X003", "Maps & Navigation");
  static const OptionCode X004 =
      const OptionCode("X004", "Override: No Navigation");
  static const OptionCode X007 =
      const OptionCode("X007", "Daytime running lights");
  static const OptionCode X010 = const OptionCode("X010", "Base Mirrors");
  static const OptionCode X011 = const OptionCode("X011", "Override: Homelink");
  static const OptionCode X012 =
      const OptionCode("X012", "Override: No Homelink");
  static const OptionCode X013 =
      const OptionCode("X013", "Override: Satellite Radio");
  static const OptionCode X014 =
      const OptionCode("X014", "Override: No Satellite Radio");
  static const OptionCode X019 =
      const OptionCode("X019", "Carbon Fiber Spoiler");
  static const OptionCode X020 =
      const OptionCode("X020", "No Performance Exterior");
  static const OptionCode X021 = const OptionCode("X021", "No Spoiler");
  static const OptionCode X024 =
      const OptionCode("X024", "Performance Package");
  static const OptionCode X025 =
      const OptionCode("X025", "No Performance Package");
  static const OptionCode X027 =
      const OptionCode("X027", "Lighted Door Handles");
  static const OptionCode X028 = const OptionCode("X028", "Battery Badge");
  static const OptionCode X029 =
      const OptionCode("X029", "Remove Battery Badge");
  static const OptionCode X030 =
      const OptionCode("X030", "Override: No Passive Entry Pkg");
  static const OptionCode X031 = const OptionCode("X031", "Keyless Entry");
  static const OptionCode X037 =
      const OptionCode("X037", "Powerfolding Mirrors");
  static const OptionCode X039 = const OptionCode("X039", "DAB Radio");
  static const OptionCode X040 = const OptionCode("X040", "No DAB Radio");
  static const OptionCode X043 = const OptionCode("X043", "No Phone Dock Kit");
  static const OptionCode X044 = const OptionCode("X044", "Phone Dock Kit");
  static const OptionCode YF00 = const OptionCode("YF00", "No Yacht Floor");
  static const OptionCode YF01 =
      const OptionCode("YF01", "Matching Yacht Floor");
  static const OptionCode YFCC = const OptionCode("YFCC", "YFCC");
  static const OptionCode YFFC =
      const OptionCode("YFFC", "Integrated Center Console");

  static const List<OptionCode> values = const <OptionCode>[
    MDLS,
    MDLX,
    MDL3,
    RENA,
    RENC,
    REEU,
    AD02,
    AD04,
    AD05,
    AD06,
    AD07,
    ADPX2,
    ADX8,
    AF00,
    AF02,
    AH00,
    APE1,
    APF0,
    APF1,
    APF2,
    APH0,
    APH2,
    APH3,
    APPA,
    APPB,
    AU00,
    AU01,
    BC0B,
    BC0R,
    BCMB,
    BP00,
    BP01,
    BR00,
    BR03,
    BR05,
    BS00,
    BS01,
    BT37,
    BT40,
    BT60,
    BT70,
    BT85,
    BTX4,
    BTX5,
    BTX6,
    BTX7,
    BTX8,
    CC04,
    CDM0,
    CH00,
    CH01,
    CH04,
    CH05,
    CH07,
    COL0,
    COL1,
    COL2,
    COL3,
    COUS,
    CW00,
    CW02,
    DA00,
    DA01,
    DA02,
    DCF0,
    DRLH,
    DRRH,
    DSH5,
    DSH7,
    DSHG,
    DU00,
    DU01,
    DV2W,
    DV4W,
    FG00,
    FG01,
    FG02,
    FMP6,
    FR01,
    FR03,
    FR04,
    HC00,
    HC01,
    HP00,
    HP01,
    IDBA,
    IDBO,
    IDCF,
    IDOM,
    IDOG,
    IDLW,
    IDPB,
    IN3PB,
    INBBW,
    INBFP,
    INBPP,
    INBTB,
    INFBP,
    INLPC,
    INLPP,
    INWPT,
    IVBPP,
    IVBSW,
    IVBTB,
    IVLPC,
    IX00,
    IX01,
    LLP1,
    LP01,
    LT00,
    LT01,
    LT1B,
    LT3W,
    LT4B,
    LT4C,
    LT4W,
    LT5C,
    LT5P,
    ME02,
    MI00,
    MI01,
    MI02,
    MT305,
    PA00,
    PBCW,
    PBSB,
    PBT8,
    PF00,
    PF01,
    PI00,
    PI01,
    PK00,
    PMAB,
    PMBL,
    PMMB,
    PMMR,
    PMNG,
    PMSG,
    PMSS,
    PMTG,
    PPMR,
    PPSB,
    PPSR,
    PPSW,
    PPTI,
    PRM31,
    PS00,
    PS01,
    PX00,
    PX01,
    PX6D,
    P85D,
    QNET,
    QPMP,
    QTBW,
    QTFP,
    QTPC,
    QTPP,
    QTPT,
    QTTB,
    QVBM,
    QVPC,
    QVPP,
    QVSW,
    RCX0,
    RF3G,
    RFBK,
    RFBC,
    RFFG,
    RFP0,
    RFP2,
    RFPX,
    S02P,
    S31B,
    S32C,
    S32P,
    S32W,
    SC00,
    SC01,
    SC04,
    SC05,
    SP00,
    SR01,
    SR06,
    SR07,
    ST00,
    ST01,
    SU00,
    SU01,
    TIC4,
    TM00,
    TM02,
    TM0A,
    TM0B,
    TM0C,
    TP01,
    TP02,
    TP03,
    TR00,
    TR01,
    TRA1,
    TW01,
    UM01,
    UTAB,
    UTAW,
    UTPB,
    UTSB,
    W39B,
    WT20,
    WTAS,
    WTDS,
    WTSG,
    WTSP,
    WTSS,
    WTTB,
    WTW4,
    WTW5,
    WTX1,
    WXW4,
    WXW5,
    X001,
    X003,
    X004,
    X007,
    X010,
    X011,
    X012,
    X013,
    X014,
    X019,
    X020,
    X021,
    X024,
    X025,
    X027,
    X028,
    X029,
    X030,
    X031,
    X037,
    X039,
    X040,
    X043,
    X044,
    YF00,
    YF01,
    YFCC,
    YFFC
  ];

  static OptionCode lookup(String code) {
    return values.firstWhere((c) => c.code == code, orElse: () => null);
  }
}
