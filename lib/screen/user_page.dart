import 'package:flutter/material.dart';
import 'package:login_auth_model/provider/auth/auth_provider.dart';
import 'package:login_auth_model/provider/local_database_provider/local_bd_provider.dart';
import 'package:provider/provider.dart';
import '../provider/auth/google_sign_provider.dart';
import 'auth/login_screen.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<UserPage> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {


  @override
  void initState() {
    super.initState();
    _initialize();
  }


  _initialize() async {
    await context.read<LocalDbProvider>().getToken();
    if(!mounted) return;

    String? loginToken = context.read<LocalDbProvider>().userToken;
    if(!mounted) return;
    if (loginToken != null && loginToken.isNotEmpty) {
      await context.read<ApiAuthProvider>().getUser(loginToken);
      throw('successful');
    } else {
      throw("❌ Token is NULL or Empty");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile page'),
        actions: [
          Consumer<ApiAuthProvider>(
            builder: (context, authProvider, child) => ElevatedButton(
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all(Colors.grey),
              ),
              onPressed: () {
                context.read<GoogleSignProvider>().googleSingOut();
                context.read<LocalDbProvider>().deleteToken();

                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => LoginScreen()),
                );
                ScaffoldMessenger.of(
                  context,
                ).showSnackBar(SnackBar(content: Text('LogOut Success')));

                // else if(emailUser != null){
                //   context.read<LocalDbProvider>().deleteToken();
                //   Navigator.pushReplacement(
                //     context,
                //     MaterialPageRoute(
                //       builder: (context) => LoginScreen(),
                //     ),
                //   );
                // }else{
                //   ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Please Login First')));
                // }
              },
              child: Icon(Icons.logout),
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Consumer<ApiAuthProvider>(
          builder: (context, authProvider, child) {
            final userResponse = authProvider.userResponse?.data;
            return authProvider.isRegistrationLoading
                ? Center(child: CircularProgressIndicator())
                : Center(
                  child: Column(

                      children: [
                        SizedBox(height: 20),

                        userResponse?.profileImage != null
                            ? Image.network(
                                userResponse!.profileImage!,
                                height: 100,
                                width: 100,
                              )
                            : Icon(Icons.person_rounded, size: 100),

                        SizedBox(height: 20),

                        Text(
                          userResponse?.name ?? 'No email',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          userResponse?.email ?? 'No email',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 20),
                        Text(
                          userResponse?.createdAt ?? 'No email',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                        SizedBox(height: 20),

                        ElevatedButton(
                          onPressed: () async {
                            // print(authProvider.userResponse?.data?.toString());
                            // print(authProvider.userResponse?.message);
                            // print(authProvider.userResponse?.status);
                            // print(userResponse?.name);
                            // print(userResponse?.email);
                            // print(userResponse?.emailVerify);
                            // // context.read<GoogleSignProvider>().googleSingOut();
                            // // Navigator.pushReplacement(
                            // //   context,
                            // //   MaterialPageRoute(
                            // //     builder: (context) => LoginScreen(),
                            // //   ),
                            // // );
                            // // String loginToken = await sharePreferenceService.getLoginToken().toString();
                            //
                            // String? loginToken = context
                            //     .read<LocalDbProvider>()
                            //     .userToken;
                            //
                            // print(loginToken);
                          },
                          child: Text('Google LogOut'),
                        ),
                      ],
                    ),
                );
          },
        ),
      ),
    );
  }
}
