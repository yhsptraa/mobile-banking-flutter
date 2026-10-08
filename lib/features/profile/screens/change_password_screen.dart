import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/app_input.dart';
import '../../../core/widgets/app_button.dart';
import '../../../data/repositories/user_repository.dart';
import '../../../data/local/app_database.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  bool _isLoading = false;
  final int _currentUserId = 1; // ID default database bawaan

  @override
  void dispose() {
    _oldPasswordController.dispose();
    _newPasswordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _updatePassword() async {
    final oldPassword = _oldPasswordController.text;
    final newPassword = _newPasswordController.text;
    final confirmPassword = _confirmPasswordController.text;

    // 1. Validasi Input Kosong
    if (oldPassword.isEmpty || newPassword.isEmpty || confirmPassword.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Semua kolom harus diisi')),
      );
      return;
    }

    // 2. Validasi Konfirmasi Password Baru
    if (newPassword != confirmPassword) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Password baru dan konfirmasi tidak cocok')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final userRepository = ref.read(userRepositoryProvider);
      final user = await userRepository.getUserById(_currentUserId);

      if (user == null) {
        throw Exception('User tidak ditemukan');
      }

      // 3. Validasi Password Lama (Sesuai dengan database)
      if (user.passwordHash != oldPassword) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password lama salah')),
        );
        setState(() => _isLoading = false);
        return;
      }

      // 4. Update Password Baru ke Database
      final updatedUser = UserModel(
        id: user.id,
        username: user.username,
        fullName: user.fullName,
        passwordHash: newPassword, // Update password dengan yang baru
        createdAt: user.createdAt,
        phoneNumber: user.phoneNumber,
        profileImagePath: user.profileImagePath,
      );

      await userRepository.upsertUser(updatedUser);

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password berhasil diubah')),
        );
        Navigator.pop(context); // Kembali ke halaman profil
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal mengubah password: $e')),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ubah Password'),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView(
              padding: const EdgeInsets.all(24.0),
              children: [
                const Text(
                  'Buat password baru yang aman untuk akun Anda.',
                  style: TextStyle(color: Colors.grey, fontSize: 14),
                ),
                const SizedBox(height: 24),
                
                AppInput(
                  label: 'Password Lama',
                  controller: _oldPasswordController,
                  isPassword: true,
                ),
                const SizedBox(height: 16),
                
                AppInput(
                  label: 'Password Baru',
                  controller: _newPasswordController,
                  isPassword: true,
                ),
                const SizedBox(height: 16),
                
                AppInput(
                  label: 'Konfirmasi Password Baru',
                  controller: _confirmPasswordController,
                  isPassword: true,
                ),
                const SizedBox(height: 48),
                
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: AppButton(
                    label: 'Simpan Password',
                    onPressed: _updatePassword,
                  ),
                ),
              ],
            ),
    );
  }
}