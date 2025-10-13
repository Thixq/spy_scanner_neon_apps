// DO NOT EDIT. This is code generated via package:easy_localization/generate.dart

// ignore_for_file: prefer_single_quotes, avoid_renaming_method_parameters, constant_identifier_names

import 'dart:ui';

import 'package:easy_localization/easy_localization.dart' show AssetLoader;

class CodegenLoader extends AssetLoader{
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>?> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }

  static const Map<String,dynamic> _tr = {
  "generic": {
    "app_name": "Spy Scanner",
    "cancel": "İptal",
    "ok": "Tamam",
    "yes": "Evet",
    "no": "Hayır",
    "loading": "Yükleniyor",
    "next": "İleri",
    "previous": "Geri",
    "done": "Bitti"
  },
  "views": {
    "onboard": {
      "page_one": {
        "title": "LAN Tarayıcı",
        "description": "Ağınıza bağlı cihazları tespit edebilir. Beklediğinizden daha fazla cihaz bağlıysa, şüphelenebilirsiniz."
      },
      "page_two": {
        "title": "Bluetooth Tarayıcı",
        "description": "BLE sinyali yayan tüm cihazları ve size olan uzaklıklarını takip edebilirsiniz. Size çok yakın bir sinyal alıyor ancak bu sinyal size ait değilse, şüphelenebilirsiniz."
      },
      "page_three": {
        "title": "Kızılötesi Tarayıcı",
        "description": "Farklı kamera filtrelerini kullanarak prizlerde ve duş başlıklarında gizlenmiş kızılötesi sensörleri ve benzerlerini tespit edebilirsiniz."
      }
    },
    "home": {
      "tabs": {
        "tab_one": "Ayarlar",
        "tab_two": "Gizlilik Potikası"
      },
      "scanners": {
        "scanner_one": {
          "title": "LAN Tarayıcı",
          "description": "LAN üzerindeki tüm cihazları tara ve hangi servislerin açık olduğunu kontrol et.",
          "button_text": "LAN Tarayıcı"
        },
        "scanner_two": {
          "title": "Bluetooth Tarayıcı",
          "description": null,
          "button_text": null
        },
        "scanner_three": {
          "title": "Kızılötesi Tarayıcı",
          "description": null,
          "button_text": null
        }
      },
      "info_card": {
        "title": "İpuçları",
        "description": "Her zaman odanızda gizli kameralar olup olmadığını kontrol edin. Duman dedektörlerini, çalar saatleri, aynaları ve prizleri inceleyin. Gizliliğinizi koruyun — şüpheli bir cihaz bulursanız otel personeline hemen bildirin. Güvende ve farkında kalın."
      }
    }
  },
  "components": {
    "lan_info_card": {
      "ip_address": "IP Adresi",
      "connection": "Bağlantı",
      "not_connection": "Bağlantı Yok",
      "wifi": "Wi-Fi: "
    }
  }
};
static const Map<String,dynamic> _en = {
  "generic": {
    "app_name": "Spy Scanner",
    "cancel": "Cancel",
    "ok": "OK",
    "yes": "Yes",
    "no": "No",
    "loading": "Loading",
    "next": "Next",
    "previous": "Previous",
    "done": "Done"
  },
  "views": {
    "onboard": {
      "page_one": {
        "title": "LAN Scanner",
        "description": "It can detect the devices connected to your network. If there are more devices connected than you expect, you may suspect something."
      },
      "page_two": {
        "title": "Bluetooth Scanner",
        "description": "You can track all devices emitting BLE signals and their distance from you. If you receive a signal that is very close to you but does not belong to you, you may suspect something."
      },
      "page_three": {
        "title": "Infrared Scanner",
        "description": "You can detect infrared sensors and their derivatives hidden in sockets and shower heads using different camera filters."
      }
    },
    "home": {
      "tabs": {
        "tab_one": "Settings",
        "tab_two": "Privacy Policy"
      },
      "scanners": {
        "scanner_one": {
          "title": "LAN Scanner",
          "description": "Scan all devices on the LAN and check which services are open.",
          "button_text": "LAN Scan"
        },
        "scanner_two": {
          "title": "Bluetooth Scanner",
          "description": null,
          "button_text": null
        },
        "scanner_three": {
          "title": "Infrared Scanner",
          "description": null,
          "button_text": null
        }
      },
      "info_card": {
        "title": "Tips",
        "description": "Always check your room for hidden cameras. Inspect smoke detectors, alarm clocks, mirrors, and power outlets. Protect your privacy — report any suspicious devices to hotel staff immediately. Stay safe and aware."
      }
    }
  },
  "components": {
    "lan_info_card": {
      "ip_address": "IP Address",
      "connection": "Connection",
      "not_connection": "Not connected",
      "wifi": "Wi-Fi: "
    }
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"tr": _tr, "en": _en};
}
