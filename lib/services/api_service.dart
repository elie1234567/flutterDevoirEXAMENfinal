import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/crud.dart';

class ApiService {
  // URL de base pour les opérations CRUD et l'authentification
  final String baseUrl = 'http://localhost:8000/api';

  // CRUD Operations
  Future<List<Crud>> getCruds() async {
    final response = await http.get(Uri.parse('$baseUrl/v1/crud'));
    if (response.statusCode == 200) {
      List jsonResponse = json.decode(response.body);
      return jsonResponse.map((data) => Crud.fromJson(data)).toList();
    } else {
      throw Exception('Failed to load cruds');
    }
  }

  Future<Crud> getCrud(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/v1/crud/$id'));
    if (response.statusCode == 200) {
      return Crud.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load crud');
    }
  }

  Future<void> createCrud(Crud crud) async {
    final response = await http.post(
      Uri.parse('$baseUrl/v1/crud'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(crud.toJson()),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to create crud');
    }
  }

  Future<void> updateCrud(int id, Crud crud) async {
    final response = await http.put(
      Uri.parse('$baseUrl/v1/crud/$id'),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(crud.toJson()),
    );
    if (response.statusCode != 200) {
      throw Exception('Failed to update crud');
    }
  }

  Future<void> deleteCrud(int id) async {
    final response = await http.delete(Uri.parse('$baseUrl/v1/crud/$id'));
    if (response.statusCode != 200) {
      throw Exception('Failed to delete crud');
    }
  }

  // Auth Operations
  Future<void> register(String name, String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register'), // Correct URL for registration
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'name': name,
        'email': email,
        'password': password,
      }),
    );
    if (response.statusCode != 201) {
      throw Exception('Failed to register');
    }
  }

  Future<void> login(String email, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login'), // Correct URL for login
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonEncode(<String, String>{
        'email': email,
        'password': password,
      }),
    );
    
    if (response.statusCode == 200) {
      
      var responseData = json.decode(response.body);
      
    } else if (response.statusCode == 401) {
      throw Exception('Unauthorized: Invalid email or password');
    } else {
      throw Exception('Failed to login: ${response.reasonPhrase}');
    }
  }
   Future<void> sendResetLinkEmail(String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/password/email'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'email': email}),
    );
    if (response.statusCode != 200) {
      throw Exception('Échec de l\'envoi du lien de réinitialisation');
    }
  }

  Future<void> resetPassword(String token, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/password/reset'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'token': token, 'password': password}),
    );
    if (response.statusCode != 200) {
      throw Exception('Échec de la réinitialisation du mot de passe');
    }
  }
}
