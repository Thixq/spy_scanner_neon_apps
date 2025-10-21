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

  static const Map<String,dynamic> _tr_TR = {
  "generic": {
    "app_name": "Spy Scanner",
    "cancel": "İptal",
    "ok": "Tamam",
    "yes": "Evet",
    "no": "Hayır",
    "loading": "Yükleniyor",
    "next": "İleri",
    "previous": "Geri",
    "done": "Bitti",
    "comming_soon": "Yakında"
  },
  "paywall": {
    "title": "Spy Scanner Premium'u Deneyin!!",
    "offer": {
      "offer_one": "Sınırsız Tarama",
      "offer_two": "WiFi Adres Geçmişi Yedekleme",
      "offer_three": "Bluetooth Tarama",
      "offer_four": "Kızılötesi Tespit",
      "offer_five": "mDNS Tarama"
    },
    "price_options": {
      "option_one": {
        "title": "7 Günlük Ücretsiz Deneme",
        "payment_method": "Aylık Abone",
        "price": "Aylık {price}"
      },
      "option_two": {
        "title": "Ömür Boyu Sınırsız Erişim!",
        "payment_method": "Tek Seferlik Ödeme",
        "price": "Tek Sefer {price}"
      }
    }
  },
  "privacy_policy": {
    "title": "Gizlilik Potikası",
    "text": " Spy Scanner gizliliğinize ve güvenliğinize önem verir. Uygulama, yalnızca Wi-Fi, Bluetooth ve kızılötesi (IR) sensör taramaları kullanarak olası gizli kameraları tespit eder. Tüm taramalar ve analizler varsayılan olarak cihazınızda yerel olarak gerçekleştirilir; hiçbir fotoğraf, ses kaydı veya ham sensör verisi sizin açık izniniz olmadan cihaz dışına aktarılmaz. Firebase üzerinde yalnızca otomatik olarak oluşturulan anonim UUID’ler aracılığıyla anonim kullanım kayıtları tutulur — bu kayıtlar, tanımlayıcı bilgi içermeyen tarama verilerini (zaman damgası, tarama türü, cihaz modeli ve anonimleştirilmiş sonuçlar) içerir ve sadece tanılama ile isteğe bağlı bulut senkronizasyonu için kullanılır. İsim, e-posta, telefon numarası gibi kişisel bilgiler, yalnızca sizin isteğinizle (örneğin destek talebi gönderirken) toplanır. İsteğe bağlı anonim analiz verileri (katılım onaylı) algılama doğruluğunu artırmak için kullanılır. Yerel tarama geçmişi şifrelenir ve siz farklı bir tercih yapmadıkça 30 gün süreyle saklanır. Dilediğiniz zaman onayınızı geri çekebilir, bulut senkronizasyonunu devre dışı bırakabilir veya Firebase üzerindeki anonim kayıtlarınızın silinmesini talep edebilirsiniz. Kişisel veriler hiçbir şekilde satılmaz. Politika güncellemeleri uygulama içinde yayınlanır ve yayınlandığı anda yürürlüğe girer.İletişim: kaanddos@gmail.com"
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
        "tab_one": "SSS",
        "tab_two": "Geri Bildirim"
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
        "title": "İpucu",
        "description": "Her zaman odanızda gizli kameralar olup olmadığını kontrol edin. Duman dedektörlerini, çalar saatleri, aynaları ve prizleri inceleyin. Gizliliğinizi koruyun — şüpheli bir cihaz bulursanız otel personeline hemen bildirin. Güvende ve farkında kalın."
      }
    },
    "lan_scan": {
      "title": "LAN Tarayıcı",
      "scan_host_text": "Host Tarayıcı",
      "scan_mdns_text": "mDNS Tarayıcı",
      "scan_cancel_text": "Durdur",
      "scanned_yet_text": "Henüz Tarama Sonuçu Yok",
      "host_info_result": {
        "ip_address": "IP Adresi: ",
        "device_name": "Cihaz Adı: ",
        "mac_address": "Mac Adresi: "
      },
      "mdns_info_result": {
        "service_name": "Servis Adı: ",
        "ip_addresses": null,
        "service_type": "Servis Tipi: "
      }
    },
    "bluetooth_scan": {
      "title": "Bluetooth Tarayıcı",
      "scan_text": "Taramayı Başlat",
      "scan_cancel_text": "Durdur",
      "scanned_yet_text": "Henüz Tarama Sonuçu Yok",
      "bluetooth_info_result": {
        "name": "Ad: ",
        "address": "Adres: ",
        "rssi": "RSSI: {rssi} dBm "
      }
    }
  },
  "components": {
    "status_info_card": {
      "ip_address": "IP Adresi",
      "bluetooth": "Bluetooth",
      "ble_status": "Aktif",
      "not_connection": "Bağlantı Yok"
    }
  },
  "dialogs": {
    "feedback_dialog": {
      "title": "Geri Bildirim",
      "description": "Geri bildirimizini bekliyoruz.",
      "cancel_text": "Iptal",
      "send_text": "Geri Bildirim Yap"
    }
  }
};
static const Map<String,dynamic> _en_US = {
  "generic": {
    "app_name": "Spy Scanner",
    "cancel": "Cancel",
    "ok": "OK",
    "yes": "Yes",
    "no": "No",
    "loading": "Loading",
    "next": "Next",
    "previous": "Previous",
    "done": "Done",
    "comming_soon": "Comming Soon"
  },
  "privacy_policy": {
    "title": "Privacy Policy",
    "text": " Spy Scanner respects your privacy and security. The app detects potential hidden cameras using Wi-Fi, Bluetooth, and infrared (IR) sensor scans only. Scans and analysis occur locally on your device by default; no photos, audio recordings, or raw sensor streams are transmitted off-device without your explicit consent. We store anonymous usage records in Firebase keyed only by automatically generated UUIDs — these records contain non-identifying scan metadata (timestamp, scan type, device model, and anonymized results) used for diagnostics and optional cloud sync. We do not collect names, emails, phone numbers, or other personally identifiable information unless you voluntarily provide them (for example, when contacting support). Optional anonymized analytics (opt-in) help improve detection accuracy. Local scan history is encrypted and retained for 30 days unless you choose to save or delete it sooner. You may withdraw consent, disable cloud sync, or request deletion of your Firebase anonymous records via the app settings. We never sell personal data. Policy updates will be posted in-app and take effect upon publication. Contact: kaanddos@gmail.com."
  },
  "paywall": {
    "title": "Try Spy Scanner Premium",
    "offer": {
      "offer_one": "Unlimited Scans",
      "offer_two": "WiFİ Addresses History Backup",
      "offer_three": "Bluetooth Scanning",
      "offer_four": "Infrared Decetion",
      "offer_five": "mDNS Scanning"
    },
    "price_options": {
      "option_one": {
        "title": "7 Days Free Trial",
        "payment_method": "Monthly Subscription",
        "price": "{price} for month"
      },
      "option_two": {
        "title": "Unlimited Access Lifetime!",
        "payment_method": "One-Time Payment",
        "price": "One-Time {price}  "
      }
    }
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
        "tab_one": "FQA",
        "tab_two": "Feedback"
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
        "title": "Tip",
        "description": "Always check your room for hidden cameras. Inspect smoke detectors, alarm clocks, mirrors, and power outlets. Protect your privacy — report any suspicious devices to hotel staff immediately. Stay safe and aware."
      }
    },
    "lan_scan": {
      "title": "LAN Scanner",
      "scan_host_text": "Host Scan",
      "scan_mdns_text": "mDNS Scan",
      "scan_cancel_text": "Cancel",
      "scanned_yet_text": "No Scan Result Yet",
      "host_info_result": {
        "ip_address": "IP Address: ",
        "device_name": "Device Name: ",
        "mac_address": "Mac Address: "
      },
      "mdns_info_result": {
        "service_name": "Service Name: ",
        "ip_addresses": null,
        "service_type": "Service Type: "
      }
    },
    "bluetooth_scan": {
      "title": "Bluetooth Scanner",
      "scan_text": "Scan",
      "scan_cancel_text": "Cancel",
      "scanned_yet_text": "No Scan Result Yet",
      "bluetooth_info_result": {
        "name": "Name: ",
        "address": "Address: ",
        "rssi": "RSSI: {rssi} dBm "
      }
    }
  },
  "components": {
    "status_info_card": {
      "ip_address": "IP Address",
      "bluetooth": "Bluetooth",
      "ble_status": "Available",
      "not_connection": "Not connected"
    }
  },
  "dialogs": {
    "feedback_dialog": {
      "title": "Feedback",
      "description": "We are waiting for your feedback.",
      "cancel_text": "Cancel",
      "send_text": "Send Feedback"
    }
  }
};
static const Map<String, Map<String,dynamic>> mapLocales = {"tr_TR": _tr_TR, "en_US": _en_US};
}
