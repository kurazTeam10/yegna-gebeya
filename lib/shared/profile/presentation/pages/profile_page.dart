import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:yegna_gebeya/core/locator.dart';
import 'package:yegna_gebeya/core/router/routes.dart';
import 'package:yegna_gebeya/shared/domain/models/user.dart';
import 'package:yegna_gebeya/shared/domain/repositories/image_repository.dart';
import 'package:yegna_gebeya/shared/domain/repositories/user_repository.dart';
import 'package:yegna_gebeya/shared/profile/presentation/cubit/profile_info_update_cubit.dart';
import 'package:yegna_gebeya/shared/profile/presentation/widgets/contact_info_card.dart';

class ProfilePage extends StatefulWidget {
  final User currentUser;
  const ProfilePage({super.key, required this.currentUser});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _profileImageFile;
  int _selectedIndex = 1;
  late String editedName;
  late String editedPhone;

  @override
  void initState() {
    super.initState();
    editedName = widget.currentUser.fullName;
    editedPhone = widget.currentUser.phoneNo;
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.sizeOf(context).height;
    final width = MediaQuery.sizeOf(context).width;
    return BlocProvider(
      create: (context) => ProfileInfoUpdateCubit(
        profileRepository: getIt<UserRepository>(),
        currentUser: widget.currentUser,
        imageRepository: getIt<ImageRepository>(),
      ),
      child: BlocBuilder<ProfileInfoUpdateCubit, ProfileInfoUpdateState>(
        builder: (context, state) {
          return Scaffold(
            backgroundColor: Colors.grey.shade50,
            appBar: AppBar(
              elevation: 0,
              leading: IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.arrow_back,
                  color: Theme.of(context).colorScheme.secondary,
                ),
              ),
            ),
            body: Column(
              children: [
                SizedBox(height: height * 0.02),
                Stack(
                  alignment: Alignment.bottomRight,
                  children: [
                    CircleAvatar(
                      radius: width * 0.2,
                      backgroundColor: Colors.grey[200],
                      backgroundImage: _profileImageFile != null
                          ? FileImage(_profileImageFile!) as ImageProvider
                          : state.user.imgUrl!.isNotEmpty
                          ? NetworkImage(state.user.imgUrl!)
                          : null,
                      child: _profileImageFile != null
                          ? null
                          : state.user.imgUrl!.isNotEmpty
                          ? null
                          : const Icon(
                              Icons.person,
                              size: 60,
                              color: Colors.black,
                            ),
                    ),
                    Positioned(
                      bottom: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () async {
                          final picker = ImagePicker();
                          final pickedFile = await picker.pickImage(
                            source: ImageSource.gallery,
                          );
                          if (pickedFile != null) {
                            setState(() {
                              _profileImageFile = File(pickedFile.path);
                            });
                          }
                        },
                        child: Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Theme.of(context).colorScheme.shadow,
                                blurRadius: 4,
                              ),
                            ],
                          ),
                          child: const Icon(
                            Icons.edit,
                            size: 20,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: height * 0.02),
                Text(
                  state.user.fullName,
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
                Text(
                  state.user.email,
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "contact information",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                        color: Theme.of(context).colorScheme.secondary,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.01),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.only(top: 8),
                    children: [
                      ContactInfoCard(
                        icon: Icons.person,
                        title: "Name",
                        value: editedName,
                        onValueChanged: (val) {
                          setState(() {
                            editedName = val;
                          });
                        },
                      ),
                      ContactInfoCard(
                        icon: Icons.phone,
                        title: "Phone Number",
                        value: editedPhone,
                        onValueChanged: (val) {
                          setState(() {
                            editedPhone = val;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
            floatingActionButton:
                BlocBuilder<ProfileInfoUpdateCubit, ProfileInfoUpdateState>(
                  builder: (context, state) {
                    if (state is ProfileInfoUpdateLoading) {
                      return const CircularProgressIndicator();
                    } else if (state is ProfileInfoUpdateFailure) {
                      WidgetsBinding.instance.addPostFrameCallback((_) {
                        ScaffoldMessenger.of(
                          context,
                        ).showSnackBar(const SnackBar(content: Text("failed")));
                      });
                    }
                    return Padding(
                      padding: const EdgeInsets.only(bottom: 70, right: 8),
                      child: FloatingActionButton.extended(
                        onPressed: () {
                          final cubit = context.read<ProfileInfoUpdateCubit>();
                          final oldUser = cubit.currentUser;
                          final newUser = oldUser.copyWith(
                            fullName: editedName,
                            phoneNo: editedPhone,
                          );
                          cubit.updateProfile(
                            image: _profileImageFile,
                            oldUser: oldUser,
                            newUser: newUser,
                          );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Profile saved!')),
                          );
                        },
                        icon: const Icon(Icons.save),
                        label: const Text('Save'),
                      ),
                    );
                  },
                ),
            floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
            bottomNavigationBar: state.user.role == UserRole.buyer
                ? BottomNavigationBar(
                    type: BottomNavigationBarType.fixed,
                    currentIndex: _selectedIndex,
                    onTap: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                      if (index == 3) {
                        // TODO: Implement navigation for Sellers
                      } else if (index == 2) {
                        // TODO: Implement navigation for Orders
                      } else if (index == 1) {
                        context.go(Routes.profile, extra: state.user);
                      } else if (index == 0) {
                        context.go(Routes.buyerHome, extra: state.user);
                      }
                    },
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.person),
                        label: 'Profile',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.store),
                        label: 'Sellers',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.list_alt),
                        label: 'Orders',
                      ),
                    ],
                  )
                : BottomNavigationBar(
                    currentIndex: _selectedIndex,
                    onTap: (index) {
                      setState(() {
                        _selectedIndex = index;
                      });
                      if (index == 2) {
                        context.go(Routes.orders, extra: state.user);
                      } else if (index == 1) {
                        // Profile tab, already here
                      } else if (index == 0) {
                        context.go(Routes.products, extra: state.user);
                      }
                    },
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.shopping_bag),
                        label: 'Products',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.person),
                        label: 'Profile',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.list_alt),
                        label: 'Orders',
                      ),
                    ],
                  ),
          );
        },
      ),
    );
  }
}
