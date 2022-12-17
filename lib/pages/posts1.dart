

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_uy_ishi_http/counter_view_model.dart';
import 'package:provider_uy_ishi_http/model/model.dart';

class MyPosts1 extends StatelessWidget {
  int id;
  String userIdtitle;
  String userIdbody;
  MyPosts1({
    super.key,
    required this.id,
    required this.userIdtitle,
    required this.userIdbody,
  });

  List<Comment> coment = [];

  CounterViewModel? cVM;

  bool comentIcon = true;

  @override
  Widget build(BuildContext context) {
    cVM ??= context.read<CounterViewModel>();
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          backgroundColor: Colors.purple,
          title: const Text(
            "Posts: 1",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
          centerTitle: true,
        ),
        body: Consumer<CounterViewModel>(
          builder: (context, value, child) {
            cVM?.onPressComment(id);
            cVM?.onPressLoading();
            comentIcon = value.setLoading;
            coment = value.coment;
            return Column(
              children: [
                Container(
                  color: Colors.grey.shade300,
                  margin: const EdgeInsets.all(12),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _columnBody(),
                      Row(
                        children: [
                          Text("  comments: ${coment.length}"),
                          Text(""),
                          Icon(
                            comentIcon
                                ? Icons.more_horiz
                                : Icons.arrow_downward,
                          ),
                        ],
                      ),
                      const SizedBox(height: 10),
                    ],
                  ),
                ),
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        comentIcon
                            ? Container()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: List.generate(
                                  coment.length,
                                  (index) => _rowComments(index),
                                ),
                              ),
                      ],
                    ),
                  ),
                ),
              ],
            );
          },
        ));
  }

  _rowComments(int index) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(width: 12),
            CircleAvatar(
              radius: 25,
              backgroundImage: AssetImage(
                "assets/images/photo${index}.jpg",
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        " name:",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Expanded(
                        child: Text(
                          "  ${coment[index].name}",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        " email:",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Expanded(
                        child: Text(
                          "  ${coment[index].email}",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        " body:",
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Expanded(
                        child: Text(
                          "  ${coment[index].body}",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                          // maxLines: 1,
                          // overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        index == 4
            ? const SizedBox()
            : const Divider(
                thickness: 1,
                color: Colors.grey,
              ),
      ],
    );
  }

  _columnBody() {
    return Column(
      children: [
        const SizedBox(height: 8),
        Row(
          children: [
            const Text(
              " title:",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Expanded(
              child: Text(
                "  ${userIdtitle}",
                style: TextStyle(
                  color: Colors.grey.shade600,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              " body:",
              style: TextStyle(
                color: Colors.black,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            Expanded(
              child: Text(
                "  ${userIdbody}",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
                // maxLines: 1,
                // overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const Divider(
          thickness: 1,
          color: Colors.black,
        ),
      ],
    );
  }
}
