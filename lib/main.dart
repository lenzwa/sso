import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage>
    with SingleTickerProviderStateMixin {
  final PageController pageController = PageController();
  late AnimationController _animationController;
  late Animation<double> _scaleAnimation;
  bool _isDrawerOpen = false;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    // Инициализируем _animationController здесь
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _scaleAnimation =
        Tween<double>(begin: 1.0, end: 0.8).animate(_animationController);
  }

  @override
  void dispose() {
    // Проверка на mounted перед вызовом dispose()
    if (mounted) {
      _animationController.dispose();
    }
    super.dispose();
  }

  void toggleDrawer() {
    setState(() {
      _isDrawerOpen = !_isDrawerOpen;
      if (_isDrawerOpen) {
        _animationController.forward();
      } else {
        _animationController.reverse();
      }
    });
  }

  void onButtonPressed(int index) {
    setState(() {
      selectedIndex = index;
      pageController.jumpToPage(index);
    });
  }

  Widget _buildMenuItem({
    required IconData icon,
    required String title,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(
        icon,
        color: Colors.white,
        size: 24,
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 16,
        ),
      ),
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 24),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Drawer меню, которое будет за основной страницей
          SafeArea(
              child: Drawer(
            width: MediaQuery.of(context).size.width * 1,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
            backgroundColor:
                const Color.fromARGB(255, 52, 78, 100), // Dark blue-gray color
            child: Padding(
                padding: EdgeInsets.symmetric(vertical: 100),
                child: Column(
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 50, bottom: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          // Circular Avatar
                          Container(
                            margin: EdgeInsets.only(right: 200),
                            width: 100,
                            height: 100,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(50),
                              child: Image.asset(
                                'lib/assets/aruzhan.jpg',
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                          const SizedBox(height: 12),
                          // Name Text
                          const Text(
                            'Рахат Диана',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Menu Items
                    Expanded(
                      child: ListView(
                        padding: EdgeInsets.zero,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                border: Border(
                                    left: BorderSide(
                                        color: const Color.fromARGB(
                                            255, 227, 252, 0),
                                        width: 3))),
                            child: _buildMenuItem(
                              icon: LucideIcons.pencil,
                              title: 'Успеваемость',
                              onTap: () {
                                // Add your navigation logic here
                              },
                            ),
                          ),
                          _buildMenuItem(
                            icon: Icons.document_scanner_outlined,
                            title: 'ИУП',
                            onTap: () {
                              // Add your navigation logic here
                            },
                          ),
                          _buildMenuItem(
                            icon: LucideIcons.personStanding,
                            title: 'УМКД',
                            onTap: () {
                              // Add your navigation logic here
                            },
                          ),
                          _buildMenuItem(
                            icon: LucideIcons.userCheck,
                            title: 'Настройки',
                            onTap: () {
                              // Add your navigation logic here
                            },
                          ),
                          _buildMenuItem(
                            icon: Icons.logout,
                            title: 'Выход',
                            onTap: () {
                              // Add your navigation logic here
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                )),
          )),

          // Основная страница с анимацией уменьшения и сдвига
          AnimatedBuilder(
              animation: _animationController,
              builder: (context, child) {
                return Transform(
                  transform: Matrix4.identity()
                    ..scale(_scaleAnimation.value)
                    ..translate(_isDrawerOpen
                        ? 250.0 * _animationController.value
                        : 0.0),
                  alignment: Alignment.centerLeft,
                  child: child,
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  // Добавляем тень
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.6), // Цвет тени
                      spreadRadius: 5, // Насколько тень растягивается
                      blurRadius: 15, // Насколько тень размытой выглядит
                      offset: Offset(5, 5), // Смещение тени
                    ),
                  ],
                ),
                child: Scaffold(
                  drawerScrimColor: Color.fromARGB(255, 46, 76, 156),
                  appBar: AppBar(
                    backgroundColor: const Color.fromARGB(255, 46, 76, 156),
                    centerTitle: true,
                    title: const Text(
                      'Расписание',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.w400),
                    ),
                    leading: IconButton(
                      icon:
                          const Icon(Icons.menu, size: 30, color: Colors.white),
                      onPressed: toggleDrawer,
                    ),
                    actions: [
                      IconButton(
                        onPressed: () {},
                        icon: Image.asset('lib/assets/cloud.png'),
                      ),
                    ],
                  ),
                  body: PageView(
                    controller: pageController,
                    onPageChanged: (index) {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    children: const [
                      SchedulePage(),
                      ExamsPage(),
                    ],
                  ),
                  bottomNavigationBar: BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    items: const <BottomNavigationBarItem>[
                      BottomNavigationBarItem(
                        icon: Icon(Icons.edit_document),
                        label: 'Журнал',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.calendar_month_sharp),
                        label: 'Расписание',
                      ),
                      BottomNavigationBarItem(
                        icon: Image(
                          image: AssetImage('lib/assets/grade.png'),
                          width: 20,
                        ),
                        label: 'Оценки',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.notifications),
                        label: 'Уведомления',
                      ),
                    ],
                    currentIndex: selectedIndex,
                    selectedItemColor: const Color.fromARGB(255, 46, 76, 156),
                    onTap: onButtonPressed,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _raspisanie(),
        _days(),
        _times(),
      ],
    );
  }

  Row _raspisanie() {
    return Row(
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            alignment: Alignment.center,
            height: 40,
            width: 180,
            decoration: const BoxDecoration(
                border: Border(
                    bottom: BorderSide(
                        color: Color.fromARGB(255, 46, 76, 156), width: 2))),
            child: Text(
              'Расписание',
              style: TextStyle(
                  fontSize: 20, color: const Color.fromARGB(255, 46, 76, 156)),
            ),
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.only(bottom: 10),
          child: Container(
            alignment: Alignment.center,
            height: 40,
            width: 170,
            child: const Text(
              'Экзамены',
              style: TextStyle(
                fontSize: 20,
              ),
            ),
          ),
        )
      ],
    );
  }

  Expanded _times() {
    return Expanded(
      // Обернуть ListView в Expanded
      child: ListView(
        children: [
          SizedBox(
            height: 55,
            child: const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                '7:50-8:40',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Divider(
              thickness: 0.5,
            ),
          ),
          SizedBox(
            height: 55,
            child: const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                '8:55-9:45',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Divider(
              thickness: 0.5,
            ),
          ),
          SizedBox(
            height: 55,
            child: const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                '10:00-10:50',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Divider(
              thickness: 0.5,
            ),
          ),
          Container(
            height: 55,
            child: const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                '11:05-11:55',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Divider(
              thickness: 0.5,
            ),
          ),
          Container(
            decoration: BoxDecoration(color: Color.fromARGB(85, 255, 235, 59)),
            height: 60,
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Text(
                '12:10-13:00',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),

          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Divider(
              thickness: 0.5,
            ),
          ),
          SizedBox(
            height: 55,
            child: const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                '13:15-14:05',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Divider(
              thickness: 0.5,
            ),
          ),
          SizedBox(
            height: 55,
            child: const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                '14:20-15:10',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Divider(
              thickness: 0.5,
            ),
          ),
          SizedBox(
            height: 55,
            child: const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                '15:25-16:15',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Divider(
              thickness: 0.5,
            ),
          ),
          SizedBox(
            height: 55,
            child: const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                '16:30-17:20',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Divider(
              thickness: 0.5,
            ),
          ),
          SizedBox(
            height: 55,
            child: const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                '17:30-18:20',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Divider(
              thickness: 0.5,
            ),
          ),
          SizedBox(
            height: 55,
            child: const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                '18:30-19:20',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Divider(
              thickness: 0.5,
            ),
          ),
          SizedBox(
            height: 55,
            child: const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                '19:30-20:20',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Divider(
              thickness: 0.5,
            ),
          ),
          SizedBox(
            height: 55,
            child: const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                '20:30-21:20',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Divider(
              thickness: 0.5,
            ),
          ),
          SizedBox(
            height: 55,
            child: const Padding(
              padding: EdgeInsets.only(left: 15),
              child: Text(
                '21:30-22:20',
                style: TextStyle(fontSize: 12),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 15),
            child: Divider(
              thickness: 0.5,
            ),
          ),

          // Добавьте дополнительные элементы здесь
        ],
      ),
    );
  }

  SizedBox _days() {
    return SizedBox(
      height: 60,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        child: Row(
          children: [
            const Column(
              children: [
                Text('MON'),
                Padding(
                  padding: EdgeInsets.only(top: 9),
                  child: Text('4'),
                )
              ],
            ),
            const Spacer(),
            Column(
              children: [
                const Text('TUE'),
                Padding(
                  padding: const EdgeInsets.only(top: 5),
                  child: Container(
                    alignment: Alignment.center,
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: const Color.fromARGB(255, 66, 24, 221)),
                    child: const Text(
                      '5',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                )
              ],
            ),
            const Spacer(),
            const Column(
              children: [
                Text('WED'),
                Padding(
                  padding: EdgeInsets.only(top: 9),
                  child: Text('6'),
                )
              ],
            ),
            const Spacer(),
            const Column(
              children: [
                Text('THU'),
                Padding(
                  padding: EdgeInsets.only(top: 9),
                  child: Text('7'),
                )
              ],
            ),
            const Spacer(),
            const Column(
              children: [
                Text('FRI'),
                Padding(
                  padding: EdgeInsets.only(top: 9),
                  child: Text('8'),
                )
              ],
            ),
            const Spacer(),
            const Column(
              children: [
                Text('SAT'),
                Padding(
                  padding: EdgeInsets.only(top: 9),
                  child: Text('9'),
                )
              ],
            ),
            const Spacer(),
            const Column(
              children: [
                Text('SUN', style: TextStyle(color: Colors.red)),
                Padding(
                  padding: EdgeInsets.only(top: 9),
                  child: Text(
                    '10',
                    style: TextStyle(color: Colors.red),
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}

class ExamsPage extends StatelessWidget {
  const ExamsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(children: [
      Row(
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              alignment: Alignment.center,
              height: 40,
              width: 180,
              child: Text(
                'Расписание',
                style: TextStyle(
                    fontSize: 20,
                    color: const Color.fromARGB(255, 46, 76, 156)),
              ),
            ),
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.only(bottom: 10),
            child: Container(
              alignment: Alignment.center,
              height: 40,
              width: 170,
              decoration: const BoxDecoration(
                  border: Border(
                      bottom: BorderSide(
                          color: Color.fromARGB(255, 46, 76, 156), width: 2))),
              child: const Text(
                'Экзамены',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
          )
        ],
      ),
      Expanded(
          child: ListView(
        children: [
          _newCard(
              'Технический Английский ',
              secondname: 'Интермедиат 1',
              '8:00-10:00',
              'ГУК 723',
              'Бейсехан Ш.Г',
              '',
              '17',
              Color.fromARGB(85, 255, 235, 59)),
          _newCard(
              'Казахский язык. Академический ',
              secondname: 'уровень (B1)',
              '8:00-10:00',
              'ГУК 706',
              'Омурзакова А.К',
              '',
              '19',
              Color.fromARGB(84, 118, 35, 250)),
          _newCard(
              'Математика I ',
              secondname: '',
              '11:00-13:00',
              'ГУК 927',
              'Мукышева Ж.А',
              'Батесова Ф.К.,',
              proc2: ' Жиенкүлқызы.Д',
              '20',
              Color.fromARGB(83, 233, 153, 186)),
          _newCard(
              'Физика I ',
              secondname: '',
              '8:00-10:00',
              'ГУК 927',
              'Гриценко Л.В.',
              'Адибаева Ш.Т.,',
              proc2: 'Демебекова К.К',
              '23',
              Color.fromARGB(83, 233, 153, 186)),
          _newCard(
              'История Казахстана ',
              secondname: '',
              '8:00-10:00',
              'ГУК 927',
              'Нуржанова А.М',
              'Есенкельдина Д.И.,',
              proc2: 'Шингисова Р.К.',
              '25',
              Color.fromARGB(83, 241, 231, 80)),
          _newCard(
              'Введение специальности ',
              secondname: '',
              '14:00-16:00',
              'ГУК 535',
              'Юбузова Х.И.',
              'Абдихапарова Г.А.,',
              proc2: 'Таубаева А.Е',
              '26',
              Color.fromARGB(83, 221, 157, 37)),
        ],
      ))
    ]);
  }

  Padding _newCard(String name, String time, String cabinet, String exm,
      String proc, String date, Color color,
      {String secondname = '', String proc2 = ''}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 5, vertical: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
        height: 190,
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade600, spreadRadius: 0.2, blurRadius: 2)
            ]),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
                text: TextSpan(
                    style: TextStyle(color: Colors.black, fontSize: 16),
                    children: [
                  TextSpan(text: name + '\n'),
                  TextSpan(text: secondname)
                ])),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 8),
                      child: Container(
                        padding: EdgeInsets.all(5),
                        child: Text(
                          time,
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 16),
                        ),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: color),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(
                        'Кабинет: ' + cabinet,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: Text(
                        'Экзаменаторы: ' + exm,
                        style: TextStyle(fontSize: 16),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 5),
                      child: RichText(
                          text: TextSpan(
                              style:
                                  TextStyle(color: Colors.black, fontSize: 13),
                              children: [
                            TextSpan(text: 'Прокторы: ' + proc + '\n'),
                            TextSpan(text: proc2)
                          ])),
                    )
                  ],
                ),
                Spacer(),
                Container(
                  height: 100,
                  child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                          style: TextStyle(
                              color: Colors.red,
                              fontSize: 19,
                              fontWeight: FontWeight.bold),
                          children: [
                            TextSpan(text: date + '\n'),
                            TextSpan(text: 'Dec')
                          ])),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
