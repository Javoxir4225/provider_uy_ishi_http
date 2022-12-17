import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:provider_uy_ishi_http/counter_view_model.dart';
import 'package:provider_uy_ishi_http/model/model.dart';

class MyPhotos extends StatelessWidget {
  String name;
  int albumId;
  MyPhotos({super.key, required this.albumId, required this.name});

  List<Photos> photos = [];

  CounterViewModel? conVM;

  @override
  Widget build(BuildContext context) {
    conVM ??= context.read<CounterViewModel>();
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          elevation: 8,
          shadowColor: Colors.red,
          backgroundColor: Colors.purple,
          title: Consumer<CounterViewModel>(
            builder: (context, value, child) {
              conVM?.onPressPhotos(albumId);
              photos = value.photos;
              return photos.isNotEmpty == false
                  ? const Text(
                      "No Photos",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                      ),
                    )
                  : Column(
                      children: [
                        Text(name,style: const TextStyle(fontSize: 16,),),
                        const SizedBox(height: 2),
                        Text(
                          "Photos: ${photos.length}",
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    );
            },
          ),
          centerTitle: true,
        ),
        body: Consumer<CounterViewModel>(
          builder: (context, value, child) {
            conVM?.onPressPhotos(albumId);
            photos = value.photos;
            return photos.isNotEmpty == false
                ? _circlProgres()
                : GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 16 / 20,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    padding: const EdgeInsets.only(
                        right: 16, left: 16, top: 16, bottom: 16),
                    children: List.generate(
                      photos.length,
                      (index) => Container(
                        color: Colors.white,
                        child: Column(
                          children: [
                            Image.network(
                              (photos[index].thumbnailUrl ?? ""),
                              height: 164,
                              fit: BoxFit.cover,
                            ),
                            const Divider(
                              thickness: 1,
                              color: Colors.red,
                              height: 4,
                            ),
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
                                    "  ${photos[index].title}",
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
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  " id:  ",
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text("${photos[index].id}"),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
          },
        ));
  }

  _circlProgres() {
    return const Center(
      child: CircularProgressIndicator(
        color: Colors.red,
      ),
    );
  }
}
