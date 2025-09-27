import 'package:code_sync/fearures/auth/data/registration_data.dart';
import 'package:code_sync/fearures/auth/domain/registration_Interface.dart';
import 'package:code_sync/fearures/auth/presentation/register/register_ui.dart';
import 'package:code_sync/fearures/main_screen/main_screen_ui.dart';
import 'package:code_sync/utils/hex_to_Color.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:logger/logger.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> with TickerProviderStateMixin {
  bool _showWidget = false;

  final Logger logger = Logger();

  final RegistrationData login = RegistrationData();

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();

    _usernameController.addListener(() {
      setState(() {
        _showWidget = _usernameController.text.isNotEmpty;
      });
    });
  }

  @override
  void dispose() {
    _usernameController.dispose();
    super.dispose();
  }

  void logined() async {
    String result = await login.login(_usernameController.text,
        _emailController.text, _passwordController.text);

    if (result != "Ок") {
      logger.e(result);
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(result)));
    } else {
      logger.e(result);
      Navigator.pushReplacement(
        context,
        PageRouteBuilder(
          pageBuilder: (context, animation, secondaryAnimation) =>
              const MainPage(),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            var opacityAnimation =
                Tween(begin: 0.0, end: 1.0).animate(animation);
            return FadeTransition(opacity: opacityAnimation, child: child);
          },
        ),
      );
    }
  }

  // Основной виджет
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: HexToColor.hexToColor("#ebebe8"),
      body: AnimatedSize(
        duration: const Duration(milliseconds: 500),
        curve: Curves.fastOutSlowIn,
        alignment: Alignment.topCenter,
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Column(
            children: [
              const ImageWidget(),
              _SwitchUpWidget(showWidget: _showWidget),
              const SizedBox(height: 30),
              _TextfildWidget(
                controller: _emailController,
                hintText: 'email',
                icon: Icons.email,
                isPassword: false,
              ),
              _TextfildWidget(
                controller: _passwordController,
                hintText: 'password',
                icon: Icons.lock,
                isPassword: true,
              ),
              _ButtonWidget(login: logined),
              _RegisterWidget(),
            ],
          ),
        ),
      ),
    );
  }
}

class ImageWidget extends StatelessWidget {
  const ImageWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Image(image: AssetImage('assets/bg_fon.png'));
  }
}

class _SwitchUpWidget extends StatelessWidget {
  const _SwitchUpWidget({required bool showWidget}) : _showWidget = showWidget;

  final bool _showWidget;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 600),
      transitionBuilder: (Widget child, Animation<double> animation) {
        return SizeTransition(
          sizeFactor: animation,
          axis: Axis.vertical,
          child: child,
        );
      },
      child: _showWidget
          ? const SizedBox.shrink()
          : Column(
              key: const ValueKey('welcome_text'),
              children: [
                const SizedBox(height: 30),
                Padding(
                  padding: const EdgeInsets.only(left: 22),
                  child: _TextWidget(),
                ),
              ],
            ),
    );
  }
}

class _TextWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Column(
        children: [
          Text(
            'Welcome, you’re starting\nyour first journey here!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: 'SFPro',
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
          SizedBox(height: 10),
          Text(
            'Log in to get more features!',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey,
              fontFamily: 'SFPro',
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}

// Виджет для перехода на страницу регистрации
class _RegisterWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const RegisterPage()),
      ),
      child: const Text(
        'Dont have an account? Register!',
        style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.bold,
          fontFamily: 'SFPro',
        ),
      ),
    );
  }
}

// Виджет с кнопкой
class _ButtonWidget extends StatelessWidget {

  VoidCallback login;

  _ButtonWidget ({required this.login});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: login,
      child: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: const Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.only(left: 5),
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontFamily: 'SFPro',
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Виджет с полем username
class _TextfildWidget extends StatelessWidget {
  final TextEditingController controller;
  final IconData icon;
  final String hintText;
  final bool isPassword;

  const _TextfildWidget({
    required this.controller,
    required this.hintText,
    required this.icon,
    required this.isPassword,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: Neumorphic(
        style: NeumorphicStyle(
          depth: -4,
          color: Colors.grey[300],
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(16)),
        ),
        child: Container(
          height: 50,
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(left: 12, right: 8),
            child: TextField(
              controller: controller,
              obscureText: isPassword,
              decoration: InputDecoration(
                border: InputBorder.none,
                hintText: hintText,
                contentPadding: const EdgeInsets.only(bottom: 0),
                prefixIcon: Icon(icon, size: 15, color: Colors.black87),
                prefixIconConstraints: const BoxConstraints(
                  minWidth: 30,
                  minHeight: 20,
                ),
                hintStyle: const TextStyle(
                  fontFamily: 'SFPro',
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
