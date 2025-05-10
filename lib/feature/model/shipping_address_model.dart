import 'dart:convert';
import 'package:ecommerce_app/core/helpers/cashe_helper/shared_prefernce.dart';

class ShippingAddress {
  final String details;
  final String phone;
  final String city;

  ShippingAddress({
    required this.details,
    required this.phone,
    required this.city,
  });

  Map<String, dynamic> toJson() => {
    'details': details,
    'phone': phone,
    'city': city,
  };

  factory ShippingAddress.fromJson(Map<String, dynamic> json) {
    return ShippingAddress(
      details: json['details'] ?? '',
      phone: json['phone'] ?? '',
      city: json['city'] ?? '',
    );
  }
}

class ShippingAddressManager {
  static const String _storageKey = 'shipping_addresses';

  static Future<List<ShippingAddress>> getAddresses() async {
    final String? addressesJson = await CashHelper.getData(key: _storageKey);
    if (addressesJson == null) return [];
    
    final List<dynamic> decoded = json.decode(addressesJson);
    return decoded.map((item) => ShippingAddress.fromJson(item)).toList();
  }

  static Future<void> addAddress(ShippingAddress address) async {
    final addresses = await getAddresses();
    addresses.add(address);
    await _saveAddresses(addresses);
  }

  static Future<void> updateAddress(int index, ShippingAddress address) async {
    final addresses = await getAddresses();
    if (index >= 0 && index < addresses.length) {
      addresses[index] = address;
      await _saveAddresses(addresses);
    }
  }

  static Future<void> deleteAddress(int index) async {
    final addresses = await getAddresses();
    if (index >= 0 && index < addresses.length) {
      addresses.removeAt(index);
      await _saveAddresses(addresses);
    }
  }

  static Future<void> _saveAddresses(List<ShippingAddress> addresses) async {
    final String encoded = json.encode(addresses.map((a) => a.toJson()).toList());
    await CashHelper.setData(key: _storageKey, value: encoded);
  }
} 