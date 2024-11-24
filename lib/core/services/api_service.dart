// lib/core/services/api_service.dart
import 'package:dio/dio.dart';

class ApiService {
  static final Dio _dio = Dio(BaseOptions(baseUrl: 'https://bvms.online/api'));

  // Method to login
  static Future<dynamic> login(String email, String password) async {
    try {
      final response = await _dio.post('/login', data: {
        'email': email,
        'password': password,
      });

      print(response.data);
      return response.data;
    } catch (e) {
      print('Login error: $e');
      return null;
    }
  }

  // Method to get incidents
  static Future<List<Map<String, dynamic>>?> getIncidents({
    required int page,
    required int perPage,
    required String? token,
  }) async {
    try {
      final response = await _dio.get('/incidents',
          queryParameters: {
            'page': page,
            'per_page': perPage,
          },
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
          ));
      
      if (response.data != null && response.data['data'] != null) {
        List<dynamic> incidents = response.data['data'];
        return incidents.map((incident) => Map<String, dynamic>.from(incident)).toList();
      } else {
        print("No incidents found or data is null");
        return [];
      }
    } catch (e) {
      print('Error fetching incidents: $e');
      return null;
    }
  }

  // Method to get the profile
  static Future<Map<String, dynamic>?> getProfile(String token) async {
    try {
      final response = await _dio.get('/profile', options: Options(
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ));

      // Check if data is not null
      if (response.data != null) {
        return Map<String, dynamic>.from(response.data);
      } else {
        print("No profile data found or data is null");
        return null;
      }
    } catch (e) {
      print('Error fetching profile: $e');
      return null;
    }
  }
}
