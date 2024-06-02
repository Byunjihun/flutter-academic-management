import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const String server = "http://13.237.43.243:8000"; // 국민 서버
const String server2 = "http://15.164.30.188:8080"; // 지훈 서버

// 유저데이터 백엔드랑 통신해서 받아올 거니까 여기다 저장 후 다른 페이지에도 적용하게끔
class UserProfile {
  final String userName;
  final String department;
  final String year;
  final String studentId;
  final int graduationScore;
  final int maxScore;
  final List<String> skills;
  final Map<String, bool> subjects;

  UserProfile({
    required this.userName,
    required this.department,
    required this.year,
    required this.studentId,
    required this.graduationScore,
    required this.maxScore,
    required this.skills, // 스킬 넣는거임 ex) 파이썬 이런거
    required this.subjects, // 내가 수강한 과목 넣기!
  });

  // JSON 데이터를 UserProfile 객체로 변환하기 위한 factory constructor 추가
  factory UserProfile.fromJson(Map<String, dynamic> json) {
    return UserProfile(
      userName: json['userName'] ?? '',
      department: json['department'] ?? '',
      year: json['year'] ?? '',
      studentId: json['studentId'] ?? '',
      graduationScore: json['graduationScore'] ?? 0,
      maxScore: json['maxScore'] ?? 0,
      skills: List<String>.from(json['skills'] ?? []),
      subjects: Map<String, bool>.from(json['subjects'] ?? {}),
    );
  }
}

// 전역 UserProfile 인스턴스
UserProfile userProfile = UserProfile(
  userName: '김성민',
  department: '컴퓨터공학과',
  year: '3-1',
  studentId: '20180595',
  graduationScore: 30,
  maxScore: 1000,
  skills: ["파이썬"],
  subjects: {"자료구조": true, "알고리즘": true, "캡스톤디자인": true},
);

Future<void> sendLoginRequest() async {
  final url = Uri.parse('$server2/member/login');
  final headers = {"Content-Type": "application/json"};
  final body =
      jsonEncode({"memberStudentId": "20201234", "memberPassword": "1234"});

  final response = await http.post(url, headers: headers, body: body);

  if (response.statusCode == 200) {
    print('Login successful');
    print('Response body: ${response.body}');

    // 응답 본문을 JSON으로 파싱하여 userProfile 업데이트
    final jsonResponse = jsonDecode(response.body);
    userProfile = UserProfile.fromJson(jsonResponse);
    print('UserProfile updated: $userProfile');
  } else {
    print('Login failed: ${response.statusCode}');
    print('Response body: ${response.body}');
  }
}
