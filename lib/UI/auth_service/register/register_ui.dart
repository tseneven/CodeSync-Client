import 'package:code_sync/UI/auth_service/register/bloc/register_bloc.dart';
import 'package:code_sync/UI/main_service/main_screen_ui.dart';
import 'package:code_sync/data/dto/user.dto.dart';
import 'package:code_sync/utils/hex_to_Color.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';
import 'package:code_sync/UI/auth_service/auth/auth_ui.dart';
import 'package:logger/logger.dart';

class RegisterPageWraper extends StatelessWidget {
  const RegisterPageWraper({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RegisterBloc(),
      child: const RegisterPage(),
    );
  }
}

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  // Боже обереги тех, кто лезет в свой код спустя несколько месяцев

  @override
  // ignore: library_private_types_in_public_api
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage>
    with TickerProviderStateMixin {
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
          child: BlocListener<RegisterBloc, RegisterState>(
            listener: (context, state) {
              if (state is RegisterError) {
                ScaffoldMessenger.of(context)
                    .showSnackBar(SnackBar(content: Text(state.exception)));
              } else if (state is RegisterSuccess) {
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
                _AddAvatarWidget(),
                _UnderAvatarWidget(),
                _TextfildWidget(
                  controller: _usernameController,
                  hintText: 'username',
                  icon: Icons.alternate_email,
                  isPassword: false,
                ),
                if (_showWidget)
                  _TextfildWidget(
                    controller: _emailController,
                    hintText: 'email',
                    icon: Icons.email,
                    isPassword: false,
                  ),
                if (_showWidget)
                  _TextfildWidget(
                    controller: _passwordController,
                    hintText: 'password',
                    icon: Icons.lock,
                    isPassword: true,
                  ),
                BlocBuilder<RegisterBloc, RegisterState>(
                  builder: (context, state) {
                    return _ButtonWidget(
                      isLoading: state is RegisterLoading,
                      register: state is RegisterLoading
                          ? null
                          : () {
                              final bloc = context.read<RegisterBloc>();
                              User user = User(
                                _usernameController.text,
                                _emailController.text,
                                _passwordController.text,
                              );
                              bloc.add(EmitRegister(user));
                            },
                    );
                  },
                ),
                _LoginWidget(),
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
            'Add your avatar and pick a username for quick start',
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

// Виджет для перехода на страницу логина
class _LoginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const AuthPageWrapper()),
      ),
      child: const Text(
        'Got an account? Sign in!',
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
  final VoidCallback? register;
  final bool isLoading;

  _ButtonWidget({required this.register, this.isLoading = false});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: register,
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

// Виджет с текстом над филдом
class _UnderAvatarWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: const Padding(
        padding: EdgeInsets.only(right: 245, top: 7),
        child: Text(
          'Display name',
          style: TextStyle(
            fontFamily: 'SFPro',
            fontWeight: FontWeight.bold,
            fontSize: 14,
          ),
        ),
      ),
    );
  }
}

// виджет с плашкой аватарки
class _AddAvatarWidget extends StatelessWidget {
  Color hexToColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: Container(
        padding: const EdgeInsets.all(1), // толщина рамки
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [hexToColor('#f5e2f8'), hexToColor('#edeffe')],
          ),
          borderRadius: BorderRadius.circular(18),
        ),
        child: Container(
          height: 80,
          decoration: BoxDecoration(
            color: Colors.white,
            gradient: LinearGradient(
              colors: [hexToColor('#f5e2f8'), hexToColor('#edeffe')],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(18.0),
            border: Border.all(color: Colors.white, width: 1.0),
          ),
          child: Row(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 10),
                child: CircleAvatar(
                  radius: 28,
                  backgroundImage: AssetImage('assets/memoji.webp'),
                  backgroundColor: Colors.white,
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Your avatar',
                      style: TextStyle(
                        fontFamily: 'SFPro',
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                    Text(
                      'PNG or JPG up to 10MB\n(200x200px max)',
                      style: TextStyle(
                        fontFamily: 'SFPro',
                        fontWeight: FontWeight.normal,
                        fontSize: 10,
                        color: Colors.grey,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: GestureDetector(
                  onTap: () {},
                  child: Container(
                    width: 90,
                    height: 35,
                    decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.circular(9.0),
                    ),
                    child: const Row(
                      children: [
                        SizedBox(width: 13),
                        Icon(
                          Icons.camera_enhance_rounded,
                          color: Colors.white,
                          size: 14,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            'Upload',
                            style: TextStyle(
                              fontFamily: 'SFPro',
                              fontWeight: FontWeight.normal,
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
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
