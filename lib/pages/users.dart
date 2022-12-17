import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:provider_uy_ishi_http/counter_view_model.dart';
import 'package:provider_uy_ishi_http/main.dart';
import 'package:provider_uy_ishi_http/model/model.dart';
import 'package:provider_uy_ishi_http/pages/user_name.dart';

class MyUsers extends StatelessWidget {
  MyUsers({super.key});

  List<User> users = [];

  bool loding = true;

  CounterViewModel? counterVM;

  void _onpress() {
    counterVM?.onPressUsers();
    counterVM?.onPressLoading();
  }

  @override
  Widget build(BuildContext context) {
    counterVM ??= context.read<CounterViewModel>();
    print("build -----");
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: Consumer<CounterViewModel>(
          builder: (context, value, child) {
            return Text("Users${value.users.length}");
          },
        ),
        centerTitle: true,
      ),
      body: Consumer<CounterViewModel>(
        builder: (context, value, child) {
          users = value.users;
          loding = value.setLoading;
          return users.isEmpty == true ? buildGetUser() : buildBody(context);
        },
      ),
    );
  }

  buildGetUser() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: Center(
            child: loding
                ? Lottie.asset("assets/lottie/lottie_empty.json")
                : const CircularProgressIndicator.adaptive(),
          ),
        ),
        ElevatedButton(
            onPressed: () {
              _onpress();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.purple,
              fixedSize: const Size(double.maxFinite, 44),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                Text(
                  "Download Users",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                ),
                SizedBox(width: 8),
                Icon(Icons.download),
              ],
            )),
      ],
    );
  }

  buildBody(BuildContext context) {
        return SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            children: List.generate(
              users.length,
              (index) => GestureDetector(
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => ChangeNotifierProvider(
                        create: (context) => CounterViewModel(),
                        child: MyUserName(
                            name: users[index].name ?? "",
                            userId: users[index].id ?? -1),
                      ),
                    ),
                  );
                  // Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => MyUserName(
                  //         name: users[index].name ?? "no named",
                  //         userId: index + 1),
                  //   ),
                  // );
                },
                child: Card(
                  elevation: 10,
                  shadowColor: Colors.grey,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Colors.grey,
                    ),
                    padding:
                        const EdgeInsets.only(left: 10, top: 16, bottom: 16),
                    height: 100,
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 25,
                          backgroundImage: AssetImage(
                            "assets/images/photo$index.jpg",
                          ),
                        ),
                        const SizedBox(width: 6),
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(height: 2),
                            Row(
                              children: [
                                const Text(
                                  "Name:",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  users[index].name ?? "no name",
                                  style: const TextStyle(
                                    color: Colors.yellow,
                                    fontSize: 16,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Email:",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Text(
                                  users[index].email ?? "no email",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 2),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      );
    
  }
}

enum State {
  start,
  loading,
  stop,
}
