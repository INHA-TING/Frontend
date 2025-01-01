import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TaxiTingCreateList extends StatefulWidget {
  const TaxiTingCreateList({super.key});

  @override
  State<TaxiTingCreateList> createState() => _TaxiTingMatchState();
}

class _TaxiTingMatchState extends State<TaxiTingCreateList> {
  final TextEditingController _departureController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _timeController = TextEditingController();

  int _selectedPeople = 1; // 초기값 설정

  @override
  void initState() {
    super.initState();
    _dateController.text =
        DateFormat('MM-dd').format(DateTime.now()); // 오늘 날짜 기본값
    _timeController.text = "HH:MM"; // 초기 시간 형식
  }

  Future<void> _selectTime(BuildContext context) async {
    TimeOfDay initialTime = TimeOfDay.now();
    Duration initialDuration = Duration(
      hours: initialTime.hour,
      minutes: initialTime.minute,
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        int selectedHour = initialTime.hour;
        int selectedMinute = initialTime.minute;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16), // 화면 양옆 여백 추가
          child: Center(
            child: Container(
              padding: const EdgeInsets.all(16),
              height: 300,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                children: [
                  const Text(
                    '시간 선택',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Expanded(
                    child: CupertinoTimerPicker(
                      mode: CupertinoTimerPickerMode.hm, // 시, 분 선택
                      initialTimerDuration: initialDuration,
                      onTimerDurationChanged: (Duration newDuration) {
                        selectedHour = newDuration.inHours;
                        selectedMinute = newDuration.inMinutes % 60;
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        _timeController.text =
                            '${selectedHour.toString().padLeft(2, '0')}:${selectedMinute.toString().padLeft(2, '0')}';
                      });
                      Navigator.pop(context);
                    },
                    child: const Text('확인'),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: const Text(''),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Stack(
        children: [
          // 배경 이미지
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/Background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          // 콘텐츠
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 100, left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    '목록 생성하기',
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    '어쩌구 저쩌구 약간 간략한 설명',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 40),
                  // 조건 박스
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 20),
                    decoration: BoxDecoration(
                      color: Colors.grey[400],
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.1),
                          blurRadius: 10,
                          offset: const Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 8),
                        const Text(
                          '출발지',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: _departureController,
                            decoration: const InputDecoration(
                              hintText: '출발지를 입력하세요',
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 16),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          '목적지',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 50,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: TextField(
                            controller: _destinationController,
                            decoration: const InputDecoration(
                              hintText: '목적지를 입력하세요',
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.symmetric(horizontal: 16),
                            ),
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          '인원 수',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 50,
                          padding: const EdgeInsets.symmetric(horizontal: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: DropdownButton<int>(
                            value: _selectedPeople,
                            isExpanded: true,
                            underline: const SizedBox(),
                            items: List.generate(
                              3,
                              (index) => DropdownMenuItem(
                                value: index + 1,
                                child: Text('${index + 1}명'),
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                _selectedPeople = value!;
                              });
                            },
                          ),
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          '날짜 및 시간',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: [
                            // 날짜 입력
                            Expanded(
                              flex: 2,
                              child: Container(
                                height: 50,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: TextField(
                                  controller: _dateController,
                                  decoration: const InputDecoration(
                                    hintText: '날짜 (MM-DD)',
                                    border: InputBorder.none,
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 16),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(width: 8),
                            // 시간 입력
                            Expanded(
                              flex: 1,
                              child: GestureDetector(
                                onTap: () => _selectTime(context),
                                child: Container(
                                  height: 50,
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  alignment: Alignment.centerLeft,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16),
                                  child: Text(
                                    _timeController.text == "HH:MM"
                                        ? '시간 선택'
                                        : _timeController.text,
                                    style: const TextStyle(
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          '할 말',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        const SizedBox(height: 8),
                        Container(
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const TextField(
                            maxLines: null,
                            expands: true,
                            decoration: InputDecoration(
                              hintText: '추가로 할 말을 입력해 주세요!',
                              border: InputBorder.none,
                              contentPadding:
                                  EdgeInsets.only(top: 8, left: 16, right: 16),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 255, 103, 103),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: TextButton(
                      onPressed: () {
                        final departure = _departureController.text.trim();
                        final destination = _destinationController.text.trim();
                        final date = _dateController.text.trim();
                        final time = _timeController.text;
                        if (departure.isNotEmpty &&
                            destination.isNotEmpty &&
                            date.isNotEmpty &&
                            time.isNotEmpty) {
                          Navigator.pop(context,
                              '$departure → $destination       ($_selectedPeople명)     $time   $date');
                        }
                      },
                      child: const Text(
                        '생성하기',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
