import 'package:flutter/material.dart';
import 'dart:async';

class UserAuthenticationPage extends StatefulWidget {
  const UserAuthenticationPage({super.key});

  @override
  State<UserAuthenticationPage> createState() => _UserAuthenticationPageState();
}

class _UserAuthenticationPageState extends State<UserAuthenticationPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _verificationCodeController =
      TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  bool _showVerificationCodeField = false;
  bool _isVerificationSuccessful = false;
  bool _isEmailValid = false;
  bool _isAllFieldsValid = false;
  Timer? _timer;
  int _remainingSeconds = 300;
  String? _passwordErrorMessage;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(_validateFields);
    _verificationCodeController.addListener(_validateFields);
    _passwordController.addListener(_validateFields);
    _confirmPasswordController.addListener(_validateFields);
  }

  void _validateFields() {
    setState(() {
      _isEmailValid = _emailController.text.isNotEmpty;
      _isAllFieldsValid = _emailController.text.isNotEmpty &&
          _verificationCodeController.text.isNotEmpty &&
          _passwordController.text.isNotEmpty &&
          _confirmPasswordController.text.isNotEmpty;

      _passwordErrorMessage =
          (_passwordController.text != _confirmPasswordController.text &&
                  _passwordController.text.isNotEmpty &&
                  _confirmPasswordController.text.isNotEmpty)
              ? "비밀번호가 일치하지 않습니다."
              : null;
    });
  }

  void _startTimer() {
    _cancelTimer();
    setState(() {
      _remainingSeconds = 300;
      _showVerificationCodeField = true;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      setState(() {
        if (_remainingSeconds > 0) {
          _remainingSeconds--;
        } else {
          _cancelTimer();
          _showVerificationCodeField = false;
        }
      });
    });
  }

  void _cancelTimer() {
    _timer?.cancel();
    _timer = null;
  }

  void _checkVerificationCode() {
    if (_verificationCodeController.text == '1234') {
      setState(() {
        _isVerificationSuccessful = true;
        _showVerificationCodeField = false;
      });
      _cancelTimer();
    }
  }

  String _formatTime(int seconds) {
    final minutes = (seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (seconds % 60).toString().padLeft(2, '0');
    return "$minutes:$secs";
  }

  @override
  void dispose() {
    _emailController.dispose();
    _verificationCodeController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _cancelTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          children: [
            // Header Section
            Container(
              width: double.infinity,
              height: 250,
              color: const Color(0xFFD0E3FF).withOpacity(0.8),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          icon: const Icon(Icons.arrow_back),
                          onPressed: () => Navigator.pop(context),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Image.asset('assets/InhaTingLogoMain.png', height: 60),
                      const SizedBox(height: 10),
                      const Text('회원가입',
                          style: TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold)),
                      const SizedBox(height: 5),
                      const Text('이메일을 인증해 주세요',
                          style:
                              TextStyle(fontSize: 16, color: Colors.black54)),
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Scrollbar(
                thumbVisibility: true,
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildEmailField(),
                        const SizedBox(height: 8),
                        _buildVerificationField(),
                        if (_isVerificationSuccessful)
                          const Row(
                            children: [
                              Icon(Icons.check_circle,
                                  color: Colors.green, size: 20),
                              SizedBox(width: 8),
                              Text(
                                '인증 완료',
                                style: TextStyle(
                                    color: Colors.green,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        const SizedBox(height: 20),
                        _buildPasswordField('비밀번호', _passwordController),
                        const SizedBox(height: 20),
                        _buildPasswordField(
                            '비밀번호 확인', _confirmPasswordController),
                        if (_passwordErrorMessage != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              _passwordErrorMessage!,
                              style: const TextStyle(
                                  color: Colors.red, fontSize: 14),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _isAllFieldsValid ? Colors.blue : Colors.grey,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: _isAllFieldsValid && _isVerificationSuccessful
                      ? () {
                          Navigator.pushReplacementNamed(context, '/signup');
                        }
                      : null,
                  child: const Text('다음',
                      style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmailField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('학교 이메일',
            style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87)),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey),
                ),
                child: TextField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: '학교 이메일을 입력하세요',
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: _isEmailValid ? Colors.white : Colors.grey,
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                  side: const BorderSide(color: Colors.blue),
                ),
              ),
              onPressed: _isEmailValid ? _startTimer : null,
              child: Text(
                '인증하기',
                style: TextStyle(
                  fontSize: 14,
                  color: _isEmailValid ? Colors.black : Colors.black26,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildVerificationField() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
      height: _showVerificationCodeField && !_isVerificationSuccessful ? 50 : 0,
      child: Visibility(
        visible: _showVerificationCodeField && !_isVerificationSuccessful,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey),
          ),
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _verificationCodeController,
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: '인증번호를 입력하세요',
                  ),
                  onChanged: (_) => _checkVerificationCode(),
                ),
              ),
              Text(
                _formatTime(_remainingSeconds),
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPasswordField(String hint, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(hint,
            style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black87)),
        const SizedBox(height: 8),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: Colors.grey),
          ),
          child: TextField(
            controller: controller,
            obscureText: true,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hint,
            ),
          ),
        ),
      ],
    );
  }
}
