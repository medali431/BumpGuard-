import 'package:flutter/material.dart';
import '../home/home_map_page.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool isLogin = true;

  final emailController = TextEditingController();
  final passController = TextEditingController();
  final nameController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,

        // ✅ Gradient moderne
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              Color(0xFF0059FF),
              Color(0xFF00C2FF),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),

        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Icon(Icons.directions_car_rounded,
                    size: 90, color: Colors.white),

                SizedBox(height: 15),
                Text(
                  "Vehicle App",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                SizedBox(height: 40),

                // ✅ Carte blanche contenant le formulaire
                Container(
                  width: 350,
                  padding: EdgeInsets.all(25),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(25),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black12,
                        blurRadius: 12,
                        offset: Offset(0, 4),
                      )
                    ],
                  ),

                  child: Column(
                    children: [
                      Text(
                        isLogin ? "Connexion" : "Créer un compte",
                        style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87),
                      ),

                      SizedBox(height: 25),

                      // ✅ Champ Nom (Signup seulement)
                      if (!isLogin)
                        Column(
                          children: [
                            _buildTextField(
                              controller: nameController,
                              label: "Nom complet",
                              icon: Icons.person,
                            ),
                            SizedBox(height: 15),
                          ],
                        ),

                      _buildTextField(
                        controller: emailController,
                        label: "Email",
                        icon: Icons.email,
                      ),

                      SizedBox(height: 15),

                      _buildTextField(
                        controller: passController,
                        label: "Mot de passe",
                        icon: Icons.lock,
                        isPassword: true,
                      ),

                      SizedBox(height: 25),

                      // ✅ Bouton stylé
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: isLoading ? null : handleAuth,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color(0xFF0059FF),
                            elevation: 4,
                            padding: EdgeInsets.symmetric(vertical: 15),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(14),
                            ),
                          ),
                          child: isLoading
                              ? CircularProgressIndicator(color: Colors.white)
                              : Text(
                                  isLogin ? "Se connecter" : "S’inscrire",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 18),
                                ),
                        ),
                      ),

                      SizedBox(height: 20),

                      GestureDetector(
                        onTap: () {
                          setState(() => isLogin = !isLogin);
                        },
                        child: Text(
                          isLogin
                              ? "Créer un compte"
                              : "Déjà un compte ? Connexion",
                          style: TextStyle(
                              color: Color(0xFF0059FF),
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ✅ Widget champ stylé
  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Color(0xFF0059FF)),
        filled: true,
        fillColor: Colors.grey[100],
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(14),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

void handleAuth() {
  if (emailController.text.isEmpty || passController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Veuillez remplir tous les champs.")),
    );
    return;
  }

  if (!isLogin && nameController.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Veuillez entrer votre nom.")),
    );
    return;
  }

  setState(() => isLoading = true);

  Future.delayed(Duration(seconds: 2), () {
    setState(() => isLoading = false);

    // ✅ Message de confirmation
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isLogin
              ? "Connexion réussie !"
              : "Compte créé avec succès !",
        ),
      ),
    );

    // ✅ Aller vers HomeMapPage après login/signup
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => HomeMapPage()),
    );
  });
}
}