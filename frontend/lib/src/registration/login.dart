import 'package:logger/logger.dart';
import 'package:flutter_neumorphic_plus/flutter_neumorphic.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _WelcomePageState createState() => _WelcomePageState();
}

// Основной виджет
class _WelcomePageState extends State<WelcomePage> {
  var logger = Logger();
  final TextEditingController _usernameController = TextEditingController();
  Color hexToColor(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
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
        body: SingleChildScrollView(
          padding:
              EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
          child: Column(children: [
            const Image(image: AssetImage('assets/bg_fon.png')),
            const SizedBox(height: 30),
            const Text('Welcome, youre starting\n  your first journey here!',
                style: TextStyle(
                    fontFamily: 'SFPro',
                    fontWeight: FontWeight.bold,
                    fontSize: 24)),
            const Text(
              'Add your avatar and pick a username for quick start',
              style: TextStyle(
                  fontSize: 13,
                  color: Colors.grey,
                  fontFamily: 'SFPro',
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 30),
            _AddAvatarWidget(),
            _UnderAvatarWidget(),
            _TextfildWidget(controller: _usernameController),
            _ButtonWidget(),
            _LoginWidget(),
          ]),
        ));
  }
}

// Виджет для перехода на страницу логина
class _LoginWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: const Text(
        'Got an account? Sign in!',
        style: TextStyle(
          color: Colors.blue,
          decoration: TextDecoration.underline,
          fontWeight: FontWeight.bold,
          fontFamily: 'SFPro'
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
                child: Text('Create an account',
                  style: TextStyle(
                    fontFamily: 'SFPro',
                    fontWeight: FontWeight.normal,
                    fontSize: 12,
                    color: Colors.grey
                  )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// Виджет с полей username
class _TextfildWidget extends StatelessWidget {
  final TextEditingController controller;

  const _TextfildWidget({required this.controller});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(13.0),
      child: Neumorphic(
          style: NeumorphicStyle(
            depth:
                -4, // отрицательное — вдавленность, положительное — выпуклость
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
                decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'username',
                    contentPadding: EdgeInsets.only(bottom: 4),
                    prefixIcon: Icon(
                      Icons.alternate_email,
                      size: 15,
                      color: Colors.black87,
                    ),
                    prefixIconConstraints: BoxConstraints(
                      minWidth: 30,
                      minHeight: 20,
                    ),
                    hintStyle: TextStyle(
                        fontFamily: 'SFPro',
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                        color: Colors.grey)),
              ),
            ),
          )),
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
        child: Text('Display name',
            style: TextStyle(
                fontFamily: 'SFPro',
                fontWeight: FontWeight.bold,
                fontSize: 14)),
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
              border: Border.all(color: Colors.white, width: 1.0)),
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
                    Text('Your avatar',
                        style: TextStyle(
                            fontFamily: 'SFPro',
                            fontWeight: FontWeight.bold,
                            fontSize: 12)),
                    Text('PNG or JPG up to 10MB\n(200x200px max)',
                        style: TextStyle(
                            fontFamily: 'SFPro',
                            fontWeight: FontWeight.normal,
                            fontSize: 10,
                            color: Colors.grey)),
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
                          child: Text('Upload',
                              style: TextStyle(
                                  fontFamily: 'SFPro',
                                  fontWeight: FontWeight.normal,
                                  fontSize: 12,
                                  color: Colors.white)),
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
