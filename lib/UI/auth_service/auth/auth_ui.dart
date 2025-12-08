import 'package:code_sync/UI/auth_service/auth/bloc/auth_bloc.dart';
import 'package:code_sync/UI/auth_service/register/register_ui.dart';
import 'package:code_sync/UI/main_service/main_screen_ui.dart';
import 'package:code_sync/data/dto/user.dto.dart';
import 'package:code_sync/utils/hex_to_Color.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:logger/logger.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthPageWrapper extends StatelessWidget {
  const AuthPageWrapper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthBloc(),
      child: const AuthPage(),
    );
  }
}

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> with TickerProviderStateMixin {
  bool _showWidget = false;

  final Logger logger = Logger();

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
          child: BlocListener<AuthBloc, AuthState>(
            listener: (context, state) {
              if (state is AuthError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.exception)));
              } else if (state is AuthSuccess) {
                Navigator.pushReplacement(
                  context,
                  PageRouteBuilder(
                    pageBuilder: (context, animation, secondaryAnimation) =>
                        const MainPage(),
                    transitionsBuilder:
                        (context, animation, secondaryAnimation, child) {
                      var opacityAnimation =
                          Tween(begin: 0.0, end: 1.0).animate(animation);
                      return FadeTransition(
                          opacity: opacityAnimation, child: child);
                    },
                  ),
                );
              }
            },
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
                BlocBuilder<AuthBloc, AuthState>(
                  builder: (context, state) {
                    return _ButtonWidget(
                      isLoading: state is AuthLoading,
                      login: state is AuthLoading
                          ? null
                          : () {
                              final bloc = context.read<AuthBloc>();
                              User user = User(
                                _usernameController.text,
                                _emailController.text,
                                _passwordController.text,
                              );
                              bloc.add(EmitAuth(user));
                            },
                    );
                  },
                ),
                _RegisterWidget(),
              ],
            ),
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
        MaterialPageRoute(builder: (context) => const RegisterPageWraper()),
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
  final VoidCallback? login;
  final bool isLoading;

  _ButtonWidget({required this.login, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: login,
      child: Padding(
        padding: const EdgeInsets.all(13.0),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: isLoading ? Colors.grey : Colors.black,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Center(
            child: isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      color: Colors.white,
                      strokeWidth: 2,
                    ),
                  )
                : const Text(
                    'Create an account',
                    style: TextStyle(
                      fontFamily: 'SFPro',
                      fontWeight: FontWeight.bold,
                      fontSize: 12,
                      color: Colors.grey,
                    ),
                  ),
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
