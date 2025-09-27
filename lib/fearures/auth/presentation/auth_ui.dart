import 'package:code_sync/fearures/register/register_ui.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> with TickerProviderStateMixin {
  bool _showWidget = false;

  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  Color hexToColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

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

  // Основной виджет
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      backgroundColor: hexToColor("#ebebe8"),
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
              _ButtonWidget(),
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
    return const Image(image: AssetImage('assets/bg_fon.jpg'));
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
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
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
