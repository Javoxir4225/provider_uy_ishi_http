import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_uy_ishi_http/counter_view_model.dart';
import 'package:provider_uy_ishi_http/model/model.dart';
import 'package:provider_uy_ishi_http/pages/photos.dart';
import 'package:provider_uy_ishi_http/pages/posts1.dart';

class MyUserName extends StatelessWidget {
  String name;
  int userId;
  MyUserName({super.key, required this.name, required this.userId});

  List<Todo> todo = [];

  List<Album> album = [];

  List<Posts> post = [];

  bool iconSet = true;

  CounterViewModel? countVM;

  @override
  Widget build(BuildContext context) {
    countVM ??= context.read<CounterViewModel>();
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: Text(
            name,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20,
            ),
          ),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [
              Tab(
                child: Text("Todo"),
              ),
              Tab(
                child: Text("Alboms"),
              ),
              Tab(
                child: Text("Post"),
              ),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _Container1(),
            _Container2(),
            _Container3(),
          ],
        ),
      ),
    );
  }

  Widget _circprogres() {
    return const Center(
      child: CircularProgressIndicator(color: Colors.white),
    );
  }

  _Container1() {
    return Container(
        color: Colors.black,
        child: Consumer<CounterViewModel>(
          builder: (context, value, child) {
            countVM?.onPressTodo(userId);
            todo = value.todo;
            return todo.isNotEmpty == false
                ? _circprogres()
                : SingleChildScrollView(
                    child: Column(
                      children: List.generate(
                        todo.length,
                        (index) => Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            elevation: 10,
                            shadowColor: Colors.grey,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white,
                              ),
                              padding: const EdgeInsets.only(
                                  left: 12, top: 8, bottom: 6, right: 10),
                              height: 120,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "userId: $userId",
                                    style: const TextStyle(
                                      color: Colors.green,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    "id: ${todo[index].id}",
                                    style: const TextStyle(
                                        color: Colors.green,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Divider(
                                    thickness: 1,
                                    color: Colors.grey,
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          const Text(
                                            "title: ",
                                            style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          SizedBox(
                                            width: 240,
                                            child: Text(
                                              todo[index].title ?? "no title",
                                              style: TextStyle(
                                                color: Colors.grey.shade700,
                                                fontSize: 14,
                                              ),
                                              maxLines: 1,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                          ),
                                        ],
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          // Network.patchData(Network.apiTodo,
                                          //     {"completed": true}, index + 1);
                                        },
                                        icon: Icon(
                                          todo[index].completed ?? false
                                              ? Icons.check_box
                                              : Icons.check_box_outline_blank,
                                        ),
                                        color: Colors.blue,
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
          },
        ));
  }

  _Container2() {
    return Consumer<CounterViewModel>(
      builder: (context, value, child) {
        countVM?.onPressAlbum(userId);
        album = value.albums;
        return Container(
          color: Colors.green,
          child: album.isNotEmpty == false
              ? _circprogres()
              : SingleChildScrollView(
                  child: Column(
                    children: List.generate(
                      album.length,
                      (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              CupertinoPageRoute(
                                builder: (context) => ChangeNotifierProvider(
                                  create: (context) => CounterViewModel(),
                                  child: MyPhotos(
                                      albumId: album[index].id ?? -1, name: name),
                                ),
                              ),
                            );
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
                                color: Colors.white,
                              ),
                              padding: const EdgeInsets.only(
                                  left: 20, top: 12, bottom: 16, right: 10),
                              height: 100,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "userId: $userId",
                                    style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Text(
                                    "id: ${album[index].id}",
                                    style: const TextStyle(
                                        color: Colors.red,
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Divider(
                                    thickness: 1,
                                    color: Colors.grey,
                                  ),
                                  Row(
                                    children: [
                                      const Text(
                                        "Name:  ",
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 14,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 240,
                                        child: Text(
                                          album[index].title ?? "no title",
                                          style: TextStyle(
                                            color: Colors.grey.shade900,
                                            fontSize: 14,
                                          ),
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
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
                ),
        );
      },
    );
  }

  _Container3() {
    return Consumer<CounterViewModel>(
      builder: (context, value, child) {
        countVM?.onPressPosts(userId);
        post = value.posts;
      return Container(
        color: Colors.amber,
        child: post.isNotEmpty == false
            ? _circprogres()
            : SingleChildScrollView(
                child: Column(
                  children: List.generate(
                    post.length,
                    (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () {
                          // Navigator.of(context).push(
                          //   MaterialPageRoute(
                          //     builder: (context) =>
                          //         ChangeNotifierProvider(
                          //           create: (context) => CounterViewModel(),
                          //           child: MyPosts1(userIdtitle: post[index].title??"", id: index,userIdbody: post[index].body??"")),
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
                              color: Colors.white,
                            ),
                            padding: const EdgeInsets.only(
                                left: 20, top: 6, bottom: 4, right: 10),
                            height: 120,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "userId: $userId",
                                  style: const TextStyle(
                                      color: Colors.green,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  "id: ${post[index].id}",
                                  style: const TextStyle(
                                      color: Colors.green,
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold),
                                ),
                                const Divider(
                                  thickness: 1,
                                  color: Colors.grey,
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "title:  ",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 240,
                                      child: Text(
                                        post[index].title ?? "no title",
                                        style: TextStyle(
                                          color: Colors.grey.shade900,
                                          fontSize: 14,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
                                  ],
                                ),
                                const Divider(
                                  thickness: 1,
                                  color: Colors.grey,
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "body:  ",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(
                                      width: 240,
                                      child: Text(
                                        post[index].body ?? "no title",
                                        style: TextStyle(
                                          color: Colors.grey.shade900,
                                          fontSize: 14,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ),
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
              ),
      );
      }
    );
  }
}
