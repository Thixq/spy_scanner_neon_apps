final class HostView {
  const HostView({
    required this.address,
    required this.deviceName,
    required this.mac,
    required this.vendor,
  });
  final String address;
  final String deviceName;
  final String mac;
  final String vendor;

  HostView copyWith({
    String? address,
    String? deviceName,
    String? mac,
    String? vendor,
  }) {
    return HostView(
      address: address ?? this.address,
      deviceName: deviceName ?? this.deviceName,
      mac: mac ?? this.mac,
      vendor: vendor ?? this.vendor,
    );
  }
}
