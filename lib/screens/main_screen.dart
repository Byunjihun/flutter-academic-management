import 'package:flutter/material.dart';
import 'package:academic_management/screens/chat_screen.dart';
import 'package:academic_management/screens/bulletin.dart';
import 'package:academic_management/screens/graduation.dart';
import 'package:academic_management/screens/mypage.dart';
import 'package:academic_management/screens/home.dart';
import 'package:academic_management/utilities/dot_curved_bottom_nav.dart';

class MainScreens extends StatefulWidget {
  @override
  _MainScreensState createState() => _MainScreensState();
}

class _MainScreensState extends State<MainScreens> {
  int _currentPage = 0; // 현재 선택된 탭의 인덱스를 추적합니다.
  ScrollController _scrollController = ScrollController();

  // 각 탭에 해당하는 위젯을 리스트로 관리합니다.
  final List<Widget> _widgetOptions = <Widget>[
    HomeScreen(),
    GraduationScreen(),
    BulletinBoardScreen(),
    MyPageScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _currentPage = index; // 사용자가 탭을 선택하면 인덱스를 업데이트합니다.
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Row(
              children: <Widget>[
                Icon(
                  Icons.local_library,
                  color: Colors.deepPurple,
                ),
                SizedBox(width: 3),
                Text(
                  'COMMAN',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.0,
                    color: Colors.deepPurple,
                  ),
                ),
              ],
            ),
            IconButton(
              icon: Icon(Icons.notifications, color: Colors.black),
              onPressed: () {
                // 알람 아이콘 클릭 이벤트 처리
                print('Notification icon tapped!');
              },
            ),
          ],
        ),
      ),
      body: Center(
        // 선택된 탭에 해당하는 위젯을 표시합니다.
        child: _widgetOptions.elementAt(_currentPage),
      ),
      bottomNavigationBar: DotCurvedBottomNav(
        scrollController: _scrollController,
        hideOnScroll: true,
        indicatorColor: Colors.black,
        backgroundColor: Colors.blueGrey.withOpacity(0.5),
        animationDuration: const Duration(milliseconds: 300),
        animationCurve: Curves.ease,
        selectedIndex: _currentPage,
        indicatorSize: 5,
        borderRadius: 25,
        height: 70,
        onTap: (index) {
          setState(() => _currentPage = index);
        },
        items: [
          Icon(
            Icons.home,
            color: _currentPage == 0 ? Colors.black : Colors.white,
          ),
          Icon(
            Icons.thumb_up,
            color: _currentPage == 1 ? Colors.black : Colors.white,
          ),
          Icon(
            Icons.forum,
            color: _currentPage == 2 ? Colors.black : Colors.white,
          ),
          Icon(
            Icons.person,
            color: _currentPage == 3 ? Colors.black : Colors.white,
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print('Chat button pressed!');
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => ChatScreen()),
          );
        },
        child: Icon(Icons.sms),
        backgroundColor: Colors.deepPurple,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat, // 버튼 위치
    );
  }
}
