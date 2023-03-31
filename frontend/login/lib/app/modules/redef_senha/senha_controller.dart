class SenhaController {
  Future<bool> senha(String user, String pass) async {
    // if (user == null || pass == null)
    //   throw Exception('User or Pass is invalid');
    return user == 'admin' && pass == '123';
  }
}
