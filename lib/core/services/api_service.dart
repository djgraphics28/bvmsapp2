import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class ApiService {
  static final Dio _dio = Dio(BaseOptions(baseUrl: 'https://bvms.online/api'));
  static final FlutterSecureStorage _secureStorage = FlutterSecureStorage();

  // Save token to secure storage
  static Future<void> _saveToken(String token) async {
    await _secureStorage.write(key: 'auth_token', value: token);
  }

  // Get token from secure storage
  static Future<String?> _getToken() async {
    return await _secureStorage.read(key: 'auth_token');
  }

  // Remove token from secure storage
  static Future<void> _removeToken() async {
    await _secureStorage.delete(key: 'auth_token');
  }

  // Method to log in and save token
  static Future<bool> login(String email, String password) async {
    try {
      final response = await _dio.post(
        '/login',
        data: {
          'email': email,
          'password': password,
        },
      );

      if (response.statusCode == 200) {
        final token = response.data['token'];
        await _saveToken(token);
        print('Login successful, token saved.');
        return true;
      }

      print('Login failed: ${response.data}');
      return false;
    } on DioException catch (e) {
      print('Error during login: ${e.message}');
      return false;
    } catch (e) {
      print('Unexpected error during login: $e');
      return false;
    }
  }

  // Method to log out
  static Future<void> logout() async {
    try {
      final token = await _getToken();
      if (token != null) {
        await _dio.post(
          '/logout',
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
            },
          ),
        );
        print('Logged out successfully.');
      }
    } catch (e) {
      print('Error during logout: $e');
    } finally {
      await _removeToken(); // Clear token regardless of API response
    }
  }

  // Method to fetch profile
  static Future<Map<String, dynamic>?> getProfile() async {
    try {
      final token = await _getToken();
      if (token == null) throw Exception('No token found. Please log in.');

      final response = await _dio.get(
        '/profile',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.data != null) {
        return Map<String, dynamic>.from(response.data);
      } else {
        print('No profile data found.');
        return null;
      }
    } catch (e) {
      print('Error fetching profile: $e');
      return null;
    }
  }

  // Method to fetch vehicles
  static Future<List<Map<String, dynamic>>?> getVehicles() async {
    try {
      final token = await _getToken();
      if (token == null) throw Exception('No token found. Please log in.');

      final response = await _dio.get(
        '/vehicles',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.data != null) {
        List<dynamic> vehicles = response.data;
        return vehicles
            .map((vehicle) => Map<String, dynamic>.from(vehicle))
            .toList();
      } else {
        print('No vehicles found.');
        return [];
      }
    } catch (e) {
      print('Error fetching vehicles: $e');
      return null;
    }
  }

  // Method to create an incident report
  static Future<bool> createIncidentReport({
    required Map<String, dynamic> incidentData,
  }) async {
    try {
      final token = await _getToken();
      if (token == null) throw Exception('No token found. Please log in.');

      final response = await _dio.post(
        '/incidents',
        data: incidentData,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.statusCode == 201) {
        print('Incident report created successfully: ${response.data}');
        return true; // Success
      } else {
        print(
            'Failed to create incident report: ${response.statusCode}, ${response.data}');
        return false; // Failure
      }
    } catch (e) {
      print('Error creating incident report: $e');
      return false;
    }
  }

  // Method to fetch incidents
  static Future<List<Map<String, dynamic>>?> getIncidents({
    required int page,
    required int perPage,
  }) async {
    try {
      final token = await _getToken();
      if (token == null) throw Exception('No token found. Please log in.');

      final response = await _dio.get(
        '/incidents',
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
        ),
      );

      if (response.data != null && response.data['data'] != null) {
        List<dynamic> incidents = response.data['data'];
        return incidents
            .map((incident) => Map<String, dynamic>.from(incident))
            .toList();
      } else {
        print('No incidents found.');
        return [];
      }
    } catch (e) {
      print('Error fetching incidents: $e');
      return null;
    }
  }

  //getCatgories
  static Future<List<Map<String, dynamic>>?> getCategories() async {
    try {
      final token = await _getToken();
      if (token == null) throw Exception('No token found. Please log in.');

      final response = await _dio.get(
        '/incident-categories',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          },
        ),
      );

      if (response.data != null) {
        List<dynamic> categories = response.data;
        return categories
            .map((category) => Map<String, dynamic>.from(category))
            .toList();
      } else {
        print('No categories found.');
        return [];
      }
    } catch (e) {
      print('Error fetching categories: $e');
      return null;
    }
  }
}
