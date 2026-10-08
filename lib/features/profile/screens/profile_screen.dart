import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';

// Import widget UI dari folder core
import '../../../core/widgets/app_input.dart';
import '../../../core/widgets/app_button.dart';

// Import database dan repository
import '../../../data/repositories/user_repository.dart';
import '../../../data/local/app_database.dart';

// Import halaman login untuk rute logout dan change password
import '../../login/screens/login_screen.dart';
import 'change_password_screen.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  
  bool _isEditing = false;
  bool _isLoading = false;
  File? _profileImage;
  UserModel? _currentUser;
  
  final int _currentUserId = 1; 

  @override
  void initState() {
    super.initState();
    Future.microtask(() => _loadUserData());
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    setState(() => _isLoading = true);
    try {
      final userRepository = ref.read(userRepositoryProvider);
      var user = await userRepository.getUserById(_currentUserId);

      if (user != null) {
        _currentUser = user;
        _usernameController.text = user.username;
        _phoneController.text = user.phoneNumber ?? '';
        
        if (user.profileImagePath != null && user.profileImagePath!.isNotEmpty) {
          final imageFile = File(user.profileImagePath!);
          if (await imageFile.exists()) {
            _profileImage = imageFile;
          }
        }
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal memuat profil: $e')),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _saveProfile() async {
    if (_currentUser == null) return;
    
    // Validasi sederhana: pastikan username dan nomor HP tidak kosong
    if (_usernameController.text.trim().isEmpty || _phoneController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Username dan nomor handphone tidak boleh kosong')),
      );
      return;
    }
    
    setState(() => _isLoading = true);
    try {
      final userRepository = ref.read(userRepositoryProvider);
      
      final updatedUser = UserModel(
        id: _currentUser!.id,
        username: _usernameController.text.trim(), // Mengambil nilai terbaru dari input
        fullName: _currentUser!.fullName, 
        passwordHash: _currentUser!.passwordHash,
        createdAt: _currentUser!.createdAt,
        phoneNumber: _phoneController.text.trim(),
        profileImagePath: _profileImage?.path,
      );

      await userRepository.upsertUser(updatedUser);
      
      setState(() {
        _isEditing = false;
        _currentUser = updatedUser;
      });
      
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profil berhasil diperbarui')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal menyimpan profil: $e')),
        );
      }
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Future<void> _pickImage() async {
    if (!_isEditing) return;

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: const Icon(Icons.camera_alt, color: Colors.blue),
                title: const Text('Ambil dari Kamera'),
                onTap: () async {
                  Navigator.of(context).pop();
                  final ImagePicker picker = ImagePicker();
                  final XFile? image = await picker.pickImage(
                    source: ImageSource.camera,
                    imageQuality: 80,
                  );
                  if (image != null) {
                    setState(() {
                      _profileImage = File(image.path);
                    });
                  }
                },
              ),
              ListTile(
                leading: const Icon(Icons.photo_library, color: Colors.blue),
                title: const Text('Pilih dari Galeri'),
                onTap: () async {
                  Navigator.of(context).pop();
                  final ImagePicker picker = ImagePicker();
                  final XFile? image = await picker.pickImage(
                    source: ImageSource.gallery,
                  );
                  if (image != null) {
                    setState(() {
                      _profileImage = File(image.path);
                    });
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showLogoutDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Konfirmasi Logout'),
          content: const Text('Apakah Anda yakin ingin keluar dari aplikasi?'),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Batal'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pushAndRemoveUntil(
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (Route<dynamic> route) => false,
                );
              },
              child: const Text('Keluar', style: TextStyle(color: Colors.red)),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.close : Icons.edit),
            tooltip: _isEditing ? 'Batal' : 'Edit Profil',
            onPressed: () {
              setState(() {
                if (_isEditing) {
                  _isEditing = false;
                  if (_currentUser != null) {
                    _usernameController.text = _currentUser!.username;
                    _phoneController.text = _currentUser!.phoneNumber ?? '';
                  }
                } else {
                  _isEditing = true;
                }
              });
            },
          )
        ],
      ),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator())
        : ListView(
            padding: const EdgeInsets.all(24.0),
            children: [
              _buildProfilePicture(),
              const SizedBox(height: 12),
              Center(
                child: Text(
                  _currentUser?.fullName ?? 'Pengguna',
                  style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 28),
              
              // Username dapat diedit saat mode _isEditing aktif
              IgnorePointer(
                ignoring: !_isEditing,
                child: Container(
                  decoration: BoxDecoration(
                    color: _isEditing ? Colors.blue.withOpacity(0.03) : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: AppInput(
                    label: 'Username',
                    controller: _usernameController,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              
              // Nomor HP yang dapat diedit saat mode _isEditing aktif
              IgnorePointer(
                ignoring: !_isEditing,
                child: Container(
                  decoration: BoxDecoration(
                    color: _isEditing ? Colors.blue.withOpacity(0.03) : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: AppInput(
                    label: 'Nomor Handphone',
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                  ),
                ),
              ),
              const SizedBox(height: 32),
              
              if (_isEditing)
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: AppButton(
                    label: 'Simpan Perubahan',
                    onPressed: _saveProfile,
                  ),
                )
              else ...[
                const Text(
                  'Pengaturan Keamanan',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Card(
                  elevation: 1,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                  child: ListTile(
                    leading: const Icon(Icons.lock_outline, color: Colors.blue),
                    title: const Text('Ubah Password'),
                    trailing: const Icon(Icons.chevron_right),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChangePasswordScreen(),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(height: 36),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: AppButton(
                    label: 'Logout',
                    onPressed: _showLogoutDialog,
                  ),
                ),
              ],
            ],
          ),
    );
  }

  Widget _buildProfilePicture() {
    return Center(
      child: Stack(
        children: [
          GestureDetector(
            onTap: _pickImage,
            child: CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blueGrey[100],
              backgroundImage: _profileImage != null ? FileImage(_profileImage!) : null,
              child: _profileImage == null
                  ? const Icon(Icons.person, size: 50, color: Colors.grey)
                  : null,
            ),
          ),
          if (_isEditing)
            Positioned(
              bottom: 0,
              right: 0,
              child: GestureDetector(
                onTap: _pickImage,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: const BoxDecoration(
                    color: Colors.blue,
                    shape: BoxShape.circle,
                  ),
                  child: const Icon(
                    Icons.camera_alt,
                    color: Colors.white,
                    size: 20,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}