class ApiConfig {
  static const String baseUrl = 'http://localhost:8080/api/v1';
  
  static Map<String, String> getAuthHeaders() {
    // In a real app, get token from secure storage
    return {
      'Content-Type': 'application/json',
    };
  }
}
