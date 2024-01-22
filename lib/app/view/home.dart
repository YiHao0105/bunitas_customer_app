/*
  Authors : initappz (Rahul Jograna)
  Website : https://initappz.com/
  App Name : Ultimate Salon Full App Flutter V2
  This App Template Source code is licensed as per the
  terms found in the Website https://initappz.com/license
  Copyright and Good Faith Purchasers © 2023-present initappz.
*/
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:salon_user/app/controller/home_controller.dart';
import 'package:salon_user/app/controller/service_cart_controller.dart';
import 'package:salon_user/app/env.dart';
import 'package:salon_user/app/helper/router.dart';
import 'package:salon_user/app/util/theme.dart';
import 'package:salon_user/app/view/sidemenu.dart';
import 'package:skeletons/skeletons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final CarouselController _controller = CarouselController();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  var top = 0.0;
  int _current = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => GetBuilder<HomeController>(
        builder: (value) {
          return SafeArea(
            child: Scaffold(
              key: _scaffoldKey,
              // drawerEnableOpenDragGesture: false,
              // drawer: const SideMenuScreen(),
              body: value.apiCalled == false
                  ? SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: Column(
                        children: [
                          SizedBox(
                            height: 240,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: SkeletonLine(
                                    style: SkeletonLineStyle(height: 220, width: double.infinity, borderRadius: BorderRadius.circular(0)),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: SkeletonParagraph(
                              style: SkeletonParagraphStyle(
                                  lines: 1,
                                  spacing: 6,
                                  lineStyle: SkeletonLineStyle(
                                    randomLength: true,
                                    height: 20,
                                    borderRadius: BorderRadius.circular(8),
                                    minLength: MediaQuery.of(context).size.width,
                                  )),
                            ),
                          ),
                          SingleChildScrollView(
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                  7,
                                  (index) => const Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        child: SkeletonAvatar(
                                          style: SkeletonAvatarStyle(shape: BoxShape.circle, width: 60, height: 60),
                                        ),
                                      )),
                            ),
                          ),
                          const SizedBox(height: 20),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: const NeverScrollableScrollPhysics(),
                            child: Row(
                              children: List.generate(
                                  7,
                                  (index) => Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: SkeletonLine(
                                          style: SkeletonLineStyle(height: 170, width: 250, borderRadius: BorderRadius.circular(10)),
                                        ),
                                      )),
                            ),
                          ),
                          const SizedBox(height: 20),
                          SingleChildScrollView(
                            physics: const NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.horizontal,
                            child: Row(
                              children: List.generate(
                                  7,
                                  (index) => const Padding(
                                        padding: EdgeInsets.symmetric(horizontal: 10),
                                        child: SkeletonAvatar(
                                          style: SkeletonAvatarStyle(shape: BoxShape.circle, width: 60, height: 60),
                                        ),
                                      )),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 10),
                            child: SkeletonParagraph(
                              style: SkeletonParagraphStyle(
                                  lines: 1,
                                  spacing: 6,
                                  lineStyle: SkeletonLineStyle(
                                    randomLength: true,
                                    height: 20,
                                    borderRadius: BorderRadius.circular(8),
                                    minLength: MediaQuery.of(context).size.width,
                                  )),
                            ),
                          ),
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            physics: const NeverScrollableScrollPhysics(),
                            child: Row(
                              children: List.generate(
                                  7,
                                  (index) => Padding(
                                        padding: const EdgeInsets.symmetric(horizontal: 10),
                                        child: SkeletonLine(
                                          style: SkeletonLineStyle(height: 170, width: 250, borderRadius: BorderRadius.circular(10)),
                                        ),
                                      )),
                            ),
                          ),
                        ],
                      ),
                    )
                  : CustomScrollView(
                      physics: const ClampingScrollPhysics(),
                      slivers: <Widget>[
                        SliverAppBar(
                          backgroundColor: ThemeProvider.transparent,
                          pinned: true,
                          snap: false,
                          floating: true,
                          elevation: 0,
                          toolbarHeight: 70,
                          expandedHeight: 180.0,

                          // leading: IconButton(
                          //   icon: const Icon(
                          //     Icons.menu,
                          //     color: ThemeProvider.whiteColor,
                          //   ),
                          //   onPressed: () => _scaffoldKey.currentState?.openDrawer(),
                          // ),
                          flexibleSpace: LayoutBuilder(
                            builder: (ctx, cons) {
                              top = cons.biggest.height;
                              return FlexibleSpaceBar(
                                centerTitle: true,
                                title: AnimatedOpacity(
                                  opacity: top <= 80 ? 1.0 : 0.0,
                                  duration: const Duration(microseconds: 200),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(horizontal: 60),
                                    child: InkWell(
                                      onTap: () {
                                        value.onSearch();
                                      },
                                      child: Container(
                                        decoration: const BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.all(Radius.circular(5)),
                                        ),
                                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              'He',
                                              style: const TextStyle(color: ThemeProvider.greyColor, fontSize: 16),
                                            ),
                                            const Icon(
                                              Icons.search_outlined,
                                              color: ThemeProvider.greyColor,
                                              size: 16,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                background: Stack(
                                  children: [
                                    Container(
                                      height: 180,
                                      width: double.infinity,
                                      decoration: const BoxDecoration(
                                        image: DecorationImage(image: AssetImage('assets/images/home_bg_pink.png'), fit: BoxFit.fill),
                                      ),
                                      child: Center(
                                        child: Container(
                                          margin: EdgeInsets.only(left: 10, top: 10),
                                          child: Column(
                                            mainAxisAlignment: MainAxisAlignment.start,
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Column(
                                                    mainAxisAlignment: MainAxisAlignment.start,
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(height: 20),
                                                      InkWell(
                                                        onTap: () {
                                                          Get.toNamed(AppRouter.getFindLocationRoutes());
                                                        },
                                                        child: RichText(
                                                          text: TextSpan(
                                                            children: [
                                                              TextSpan(
                                                                  text: 'Hi'.tr + ", ",
                                                                  style: const TextStyle(
                                                                    color: Colors.black,
                                                                    fontFamily: 'normal',
                                                                    fontSize: 22,
                                                                  )),
                                                              TextSpan(
                                                                  text: '',
                                                                  style: const TextStyle(
                                                                    color: Colors.black,
                                                                    fontFamily: 'bold',
                                                                    fontSize: 22,
                                                                  )),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                      Text(
                                                        'Time To Pamper Yourself'.tr,
                                                        style: const TextStyle(color: Colors.black, fontFamily: 'normal', fontSize: 14),
                                                      ),
                                                    ],
                                                  ),
                                                  Image.asset('assets/images/icon_message.png', width: 90, height: 90, fit: BoxFit.fitHeight),
                                                ],
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                'Find and book best services'.tr,
                                                style: const TextStyle(color: Colors.black, fontFamily: 'medium', fontSize: 17),
                                              ),
                                              const SizedBox(height: 10),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                        bottom: 1.0,
                                        width: MediaQuery.of(context).size.width,
                                        child: InkWell(
                                          onTap: () {
                                            value.onSearch();
                                          },
                                          child: Container(
                                            decoration: const BoxDecoration(
                                              shape: BoxShape.rectangle,
                                              color: Colors.white,
                                              borderRadius: BorderRadius.all(Radius.circular(20)),
                                            ),
                                            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                            margin: EdgeInsets.only(left: 30, right: 30),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.start,
                                              crossAxisAlignment: CrossAxisAlignment.center,
                                              children: [
                                                const Icon(
                                                  Icons.search_sharp,
                                                  color: Colors.black,
                                                  size: 16,
                                                ),
                                                SizedBox(width: 10),
                                                Text(
                                                  'Search salon, spa and barber'.tr,
                                                  style: const TextStyle(color: ThemeProvider.greyColor, fontSize: 16),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ))
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                        SliverList(
                          delegate: SliverChildListDelegate(
                            [
                              SingleChildScrollView(
                                padding: const EdgeInsets.symmetric(horizontal: 5),
                                child: value.haveData == true
                                    ? Column(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(top: 10, left: 10),
                                            child: Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Text(
                                                  'Browse Treatment Type'.tr,
                                                  style: const TextStyle(fontSize: 18, fontFamily: 'bold'),
                                                ),
                                                // TextButton(
                                                //   style: TextButton.styleFrom(
                                                //     textStyle: const TextStyle(fontSize: 14, color: ThemeProvider.blackColor),
                                                //   ),
                                                //   onPressed: () {
                                                //     value.onAllCategories();
                                                //   },
                                                //   child: Text(
                                                //     'View all'.tr,
                                                //     style: const TextStyle(color: ThemeProvider.lightPink, fontSize: 12),
                                                //   ),
                                                // ),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            height: value.categoriesList.length < 4
                                                ? constraints.maxHeight * .18
                                                : value.categoriesList.length < 8
                                                    ? constraints.maxHeight * .28
                                                    : constraints.maxHeight * .38,
                                            child: GridView.count(
                                                crossAxisCount: _getGridCountLength(value.categoriesList.length),
                                                childAspectRatio: 0.90,
                                                children: List.generate(value.categoriesList.length, (index) {
                                                  return InkWell(
                                                    onTap: () {
                                                      value.onCategoriesList(value.categoriesList[index].id as int, value.categoriesList[index].name.toString());
                                                    },
                                                    child: Container(
                                                      color: ThemeProvider.lightPink.withOpacity(0.1),
                                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                                      child: Column(
                                                        children: [
                                                          Container(
                                                            padding: EdgeInsets.only(top: 5),
                                                            decoration: new BoxDecoration(borderRadius: BorderRadius.circular(10), color: Colors.white.withOpacity(0.5)),
                                                            height: 90,
                                                            width: 120,
                                                            child: Column(
                                                              children: [
                                                                ClipOval(
                                                                  child: Container(
                                                                    height: 50,
                                                                    width: 50,
                                                                    padding: EdgeInsets.all(10),
                                                                    decoration: BoxDecoration(
                                                                        gradient: LinearGradient(
                                                                      begin: Alignment.topCenter,
                                                                      end: Alignment.bottomLeft,
                                                                      colors: [
                                                                        ThemeProvider.lightPink,
                                                                        Colors.white,
                                                                      ],
                                                                    )),
                                                                    child: ClipOval(
                                                                        child: FadeInImage(
                                                                      image: NetworkImage('${Environments.apiBaseURL}storage/images/${value.categoriesList[index].cover.toString()}'),
                                                                      placeholder: const AssetImage("assets/images/placeholder.jpeg"),
                                                                      imageErrorBuilder: (context, error, stackTrace) {
                                                                        return Image.asset('assets/images/notfound.png', fit: BoxFit.cover);
                                                                      },
                                                                      fit: BoxFit.cover,
                                                                    )),
                                                                  ),
                                                                ),
                                                                Padding(
                                                                  padding: const EdgeInsets.only(top: 10),
                                                                  child: Text(
                                                                    value.categoriesList[index].name!.length > 15 ? '${value.categoriesList[index].name!.substring(0, 15)}...' : value.categoriesList[index].name.toString(),
                                                                    style: const TextStyle(fontSize: 10, color: Colors.black, fontFamily: 'normal'),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),

                                                          // Column(
                                                          //   children: [
                                                          //     Padding(
                                                          //       padding: const EdgeInsets.only(top: 10),
                                                          //       child: Text(
                                                          //         value.categoriesList[index].name!.length > 15 ? '${value.categoriesList[index].name!.substring(0, 15)}...' : value.categoriesList[index].name.toString(),
                                                          //         style: const TextStyle(fontSize: 10, color: Colors.black, fontFamily: 'normal'),
                                                          //       ),
                                                          //     ),
                                                          //   ],
                                                          // ),
                                                        ],
                                                      ),
                                                    ),
                                                  );
                                                })),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(top: 15),
                                            child: CarouselSlider(
                                              options: CarouselOptions(
                                                  height: 190,
                                                  viewportFraction: 0.80,
                                                  initialPage: 0,
                                                  enableInfiniteScroll: true,
                                                  reverse: false,
                                                  autoPlay: true,
                                                  autoPlayInterval: const Duration(seconds: 3),
                                                  autoPlayAnimationDuration: const Duration(milliseconds: 800),
                                                  autoPlayCurve: Curves.fastOutSlowIn,
                                                  enlargeCenterPage: false,
                                                  scrollDirection: Axis.horizontal,
                                                  onPageChanged: (index, reason) {
                                                    setState(() {
                                                      _current = index;
                                                    });
                                                  }),
                                              carouselController: _controller,
                                              items: List.generate(
                                                value.bannerList.length,
                                                (index) => GestureDetector(
                                                  onTap: () {
                                                    value.onBanner(value.bannerList[index].value.toString(), value.bannerList[index].type.toString());
                                                  },
                                                  child: Padding(
                                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                                                    child: SizedBox(
                                                      width: double.infinity,
                                                      child: Column(
                                                        children: [
                                                          Stack(
                                                            clipBehavior: Clip.none,
                                                            alignment: Alignment.bottomCenter,
                                                            children: [
                                                              SizedBox(
                                                                height: 170,
                                                                width: double.infinity,
                                                                child: ClipRRect(
                                                                  borderRadius: BorderRadius.circular(10),
                                                                  child: FadeInImage(
                                                                    image: NetworkImage('${Environments.apiBaseURL}storage/images/${value.bannerList[index].cover.toString()}'),
                                                                    placeholder: const AssetImage("assets/images/placeholder.jpeg"),
                                                                    imageErrorBuilder: (context, error, stackTrace) {
                                                                      return Image.asset('assets/images/notfound.png', fit: BoxFit.cover);
                                                                    },
                                                                    fit: BoxFit.cover,
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                height: 50,
                                                                width: double.infinity,
                                                                padding: const EdgeInsets.symmetric(horizontal: 15),
                                                                decoration: BoxDecoration(
                                                                  borderRadius: const BorderRadius.only(
                                                                    bottomLeft: Radius.circular(10),
                                                                    bottomRight: Radius.circular(10),
                                                                  ),
                                                                  color: ThemeProvider.blackColor.withOpacity(0.5),
                                                                ),
                                                                child: Column(
                                                                  mainAxisAlignment: MainAxisAlignment.center,
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Text(
                                                                      value.bannerList[index].title.toString(),
                                                                      overflow: TextOverflow.ellipsis,
                                                                      style: const TextStyle(color: ThemeProvider.whiteColor),
                                                                    ),
                                                                  ],
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
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: value.bannerList.map(
                                              (image) {
                                                int index = value.bannerList.indexOf(image);
                                                return Container(
                                                  width: 18.0,
                                                  height: 8.0,
                                                  margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
                                                  decoration: BoxDecoration(borderRadius: _current == index ? BorderRadius.all(Radius.circular(8.0)) : null, shape: _current == index ? BoxShape.rectangle : BoxShape.circle, color: _current == index ? ThemeProvider.darkPink : Color.fromRGBO(0, 0, 0, 0.4)),
                                                );
                                              },
                                            ).toList(), // this was the part the I had to add
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Browse by Mobile Beautician'.tr,
                                                style: const TextStyle(fontSize: 14, fontFamily: 'bold'),
                                              ),
                                              TextButton(
                                                style: TextButton.styleFrom(
                                                  textStyle: const TextStyle(fontSize: 14, color: ThemeProvider.blackColor),
                                                ),
                                                onPressed: () {
                                                  value.onAllSpecialist();
                                                },
                                                child: Text(
                                                  'View all'.tr,
                                                  style: const TextStyle(color: ThemeProvider.appColor, fontSize: 12),
                                                ),
                                              ),
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(bottom: 20),
                                            child: SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Padding(
                                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                                child: Row(
                                                  children: [
                                                    for (var item in value.individualList)
                                                      Container(
                                                        margin: const EdgeInsets.only(right: 10),
                                                        decoration: BoxDecoration(
                                                          border: Border.all(color: Colors.grey),
                                                          borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                        ),
                                                        child: InkWell(
                                                          onTap: () {
                                                            value.onServices(item.uid as int);
                                                          },
                                                          child: Column(
                                                            children: [
                                                              SizedBox(
                                                                height: 150,
                                                                width: 250,
                                                                child: ClipRRect(
                                                                  borderRadius: const BorderRadius.all(Radius.circular(30)),
                                                                  child: Padding(
                                                                    padding: const EdgeInsets.all(8.0),
                                                                    child: FadeInImage(
                                                                      image: NetworkImage('${Environments.apiBaseURL}storage/images/${item.userInfo?.cover.toString()}'),
                                                                      placeholder: const AssetImage("assets/images/placeholder.jpeg"),
                                                                      imageErrorBuilder: (context, error, stackTrace) {
                                                                        return Image.asset('assets/images/notfound.png', fit: BoxFit.cover);
                                                                      },
                                                                      fit: BoxFit.cover,
                                                                    ),
                                                                  ),
                                                                ),
                                                              ),
                                                              SizedBox(
                                                                width: 250,
                                                                child: Stack(
                                                                  children: [
                                                                    Padding(
                                                                      padding: const EdgeInsets.symmetric(horizontal: 10),
                                                                      child: Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          Padding(
                                                                            padding: const EdgeInsets.symmetric(vertical: 10),
                                                                            child: Row(
                                                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                              children: [
                                                                                Expanded(
                                                                                  child: Text(
                                                                                    "Browse  By saloons",
                                                                                    overflow: TextOverflow.ellipsis,
                                                                                    style: const TextStyle(fontSize: 15),
                                                                                  ),
                                                                                ),
                                                                                Row(
                                                                                  children: [
                                                                                    const Icon(
                                                                                      Icons.star,
                                                                                      color: Colors.orange,
                                                                                      size: 17,
                                                                                    ),
                                                                                    const SizedBox(width: 5),
                                                                                    Text(
                                                                                      "4.4",
                                                                                      style: const TextStyle(fontSize: 15),
                                                                                    )
                                                                                  ],
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          Padding(
                                                                            padding: const EdgeInsets.only(bottom: 15),
                                                                            child: Text(
                                                                              "1111 2nd Avenue, New york",
                                                                              overflow: TextOverflow.ellipsis,
                                                                              style: const TextStyle(fontSize: 12, color: ThemeProvider.greyColor),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                    Positioned(
                                                                      right: 0,
                                                                      bottom: 0,
                                                                      child: Container(
                                                                        height: 30,
                                                                        width: 60,
                                                                        decoration: const BoxDecoration(color: ThemeProvider.appColor, borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomRight: Radius.circular(10))),
                                                                        child: Row(
                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                          children: [
                                                                            Text(
                                                                              'Book'.tr,
                                                                              style: const TextStyle(fontSize: 10, color: Colors.white),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          ),
                                          // SingleChildScrollView(
                                          //   scrollDirection: Axis.horizontal,
                                          //   child: Row(
                                          //     children: [
                                          //       for (var item in value.individualList)
                                          //         Padding(
                                          //           padding: const EdgeInsets.symmetric(horizontal: 10),
                                          //           child: Column(
                                          //             children: [
                                          //               InkWell(
                                          //                 onTap: () {
                                          //                   print("helloId======>${item.uid}");
                                          //                   value.onSpecialist(
                                          //                     item.uid as int,
                                          //                   );
                                          //                 },
                                          //                 child: Container(
                                          //                   decoration: BoxDecoration(
                                          //                     borderRadius: BorderRadius.circular(100.0),
                                          //                     border: Border.all(
                                          //                       width: 2,
                                          //                       color: ThemeProvider.appColor,
                                          //                     ),
                                          //                   ),
                                          //                   child: Padding(
                                          //                     padding: const EdgeInsets.all(3.0),
                                          //                     child: ClipRRect(
                                          //                       borderRadius: BorderRadius.circular(100),
                                          //                       child: SizedBox.fromSize(
                                          //                         size: const Size.fromRadius(25),
                                          //                         child: FadeInImage(
                                          //                           image: NetworkImage('${Environments.apiBaseURL}storage/images/${item.userInfo?.cover.toString()}'),
                                          //                           placeholder: const AssetImage("assets/images/placeholder.jpeg"),
                                          //                           imageErrorBuilder: (context, error, stackTrace) {
                                          //                             return Image.asset('assets/images/notfound.png', fit: BoxFit.cover);
                                          //                           },
                                          //                           fit: BoxFit.cover,
                                          //                         ),
                                          //                       ),
                                          //                     ),
                                          //                   ),
                                          //                 ),
                                          //               ),
                                          //               const SizedBox(height: 5),
                                          //               Text(
                                          //                 "Test",
                                          //                 style: const TextStyle(fontFamily: 'semibold'),
                                          //               ),
                                          //               Text(
                                          //                 "demo",
                                          //                 style: const TextStyle(fontSize: 10),
                                          //               ),
                                          //             ],
                                          //           ),
                                          //         )
                                          //     ],
                                          //   ),
                                          // ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Browse By Salon'.tr,
                                                style: const TextStyle(fontSize: 14, fontFamily: 'bold'),
                                              ),
                                              TextButton(
                                                  style: TextButton.styleFrom(
                                                    textStyle: const TextStyle(fontSize: 14, color: ThemeProvider.blackColor),
                                                  ),
                                                  onPressed: () {
                                                    value.onAllOffers();
                                                  },
                                                  child: Text(
                                                    'View all'.tr,
                                                    style: const TextStyle(color: ThemeProvider.darkPink, fontSize: 12, decoration: TextDecoration.underline),
                                                  ))
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Container(
                                            color: ThemeProvider.lightPink.withOpacity(0.1),
                                            child: ListView.builder(
                                              itemCount: 2,
                                              shrinkWrap: true,
                                              physics: NeverScrollableScrollPhysics(),
                                              itemBuilder: (context, index) {
                                                return Container(
                                                  margin: const EdgeInsets.only(right: 10, bottom: 5),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(color: Colors.white),
                                                    color: Colors.white,
                                                    borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      value.onServices(value.salonList[index].uid as int);
                                                    },
                                                    child: Row(
                                                      children: [
                                                        Padding(
                                                          padding: const EdgeInsets.all(8.0),
                                                          child: SizedBox(
                                                            height: 100,
                                                            width: 100,
                                                            child: ClipRRect(
                                                              borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                              child: FadeInImage(
                                                                image: NetworkImage('${Environments.apiBaseURL}storage/images/${value.salonList[index].cover.toString()}'),
                                                                placeholder: const AssetImage("assets/images/placeholder.jpeg"),
                                                                imageErrorBuilder: (context, error, stackTrace) {
                                                                  return Image.asset('assets/images/notfound.png', fit: BoxFit.cover);
                                                                },
                                                                fit: BoxFit.cover,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 250,
                                                          child: Stack(
                                                            children: [
                                                              Padding(
                                                                padding: const EdgeInsets.symmetric(horizontal: 10),
                                                                child: Column(
                                                                  crossAxisAlignment: CrossAxisAlignment.start,
                                                                  children: [
                                                                    Row(
                                                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                                      children: [
                                                                        Expanded(
                                                                          child: Text(
                                                                            value.salonList[index].name.toString(),
                                                                            overflow: TextOverflow.ellipsis,
                                                                            style: const TextStyle(
                                                                              fontSize: 15,
                                                                              fontFamily: 'medium',
                                                                            ),
                                                                          ),
                                                                        ),
                                                                      ],
                                                                    ),
                                                                    Text(
                                                                      value.salonList[index].address!.length > 15 ? '${value.salonList[index].address!.substring(0, value.salonList[index].address!.length)}...' : value.salonList[index].address.toString(),
                                                                      overflow: TextOverflow.ellipsis,
                                                                      style: const TextStyle(fontSize: 12, color: ThemeProvider.greyColor),
                                                                    ),
                                                                    Text(
                                                                      "Hair/Face",
                                                                      overflow: TextOverflow.ellipsis,
                                                                      style: const TextStyle(fontSize: 12, color: ThemeProvider.greyColor),
                                                                    ),
                                                                    SizedBox(height: 10),
                                                                    Row(
                                                                      children: [
                                                                        const Icon(
                                                                          Icons.star_border_rounded,
                                                                          color: Colors.orange,
                                                                          size: 17,
                                                                        ),
                                                                        const SizedBox(width: 5),
                                                                        Text(
                                                                          value.salonList[index].rating.toString(),
                                                                          style: const TextStyle(fontSize: 13),
                                                                        )
                                                                      ],
                                                                    ),
                                                                  ],
                                                                ),
                                                              ),
                                                              Positioned(
                                                                right: 0,
                                                                top: 0,
                                                                child: Icon(Icons.favorite_border),
                                                              ),
                                                              Positioned(
                                                                right: 0,
                                                                bottom: 0,
                                                                child: Container(
                                                                    width: 30.0,
                                                                    height: 30.0,
                                                                    decoration: BoxDecoration(
                                                                      color: ThemeProvider.lightPink,
                                                                      borderRadius: BorderRadius.all(Radius.circular(50.0)),
                                                                      border: Border.all(
                                                                        color: ThemeProvider.darkPink,
                                                                        width: 1.0,
                                                                      ),
                                                                    ),
                                                                    child: Icon(
                                                                      Icons.add,
                                                                      color: ThemeProvider.darkPink,
                                                                    )),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                'Top Products'.tr,
                                                style: const TextStyle(fontSize: 14, fontFamily: 'bold'),
                                              ),
                                              TextButton(
                                                  style: TextButton.styleFrom(
                                                    textStyle: const TextStyle(fontSize: 14, color: ThemeProvider.blackColor),
                                                  ),
                                                  onPressed: () {
                                                    value.onTopProducts();
                                                  },
                                                  child: Text(
                                                    'View all'.tr,
                                                    style: const TextStyle(color: ThemeProvider.appColor, fontSize: 12),
                                                  ))
                                            ],
                                          ),
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Container(
                                              padding: const EdgeInsets.only(left: 16),
                                              margin: const EdgeInsets.symmetric(vertical: 8),
                                              child: Row(
                                                children: List.generate(
                                                  value.productsList.length,
                                                  (i) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        value.onProduct(
                                                          value.productsList[i].id as int,
                                                        );
                                                      },
                                                      child: Container(
                                                        clipBehavior: Clip.antiAlias,
                                                        margin: const EdgeInsets.only(right: 10, bottom: 16),
                                                        width: 150,
                                                        decoration: BoxDecoration(
                                                          color: ThemeProvider.whiteColor,
                                                          borderRadius: const BorderRadius.all(
                                                            Radius.circular(8),
                                                          ),
                                                          boxShadow: [
                                                            BoxShadow(color: ThemeProvider.blackColor.withOpacity(0.2), offset: const Offset(0, 1), blurRadius: 3),
                                                          ],
                                                        ),
                                                        child: Column(
                                                          children: [
                                                            SizedBox(
                                                              height: 120,
                                                              width: double.infinity,
                                                              child: Stack(
                                                                clipBehavior: Clip.none,
                                                                children: [
                                                                  FadeInImage(
                                                                    image: NetworkImage('${Environments.apiBaseURL}storage/images/${value.productsList[i].cover.toString()}'),
                                                                    placeholder: const AssetImage("assets/images/placeholder.jpeg"),
                                                                    imageErrorBuilder: (context, error, stackTrace) {
                                                                      return Image.asset('assets/images/notfound.png', width: double.infinity, height: 120, fit: BoxFit.cover);
                                                                    },
                                                                    width: double.infinity,
                                                                    height: 120,
                                                                    fit: BoxFit.cover,
                                                                  ),
                                                                  Positioned(
                                                                    top: 8,
                                                                    left: 0,
                                                                    child: Container(
                                                                      padding: const EdgeInsets.symmetric(horizontal: 4),
                                                                      color: ThemeProvider.secondaryAppColor.withOpacity(.2),
                                                                      child: Text(
                                                                        '${value.productsList[i].discount} %',
                                                                        style: const TextStyle(color: ThemeProvider.secondaryAppColor, fontFamily: 'medium', fontSize: 12),
                                                                      ),
                                                                    ),
                                                                  ),
                                                                ],
                                                              ),
                                                            ),
                                                            Container(
                                                              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                                                              child: Column(
                                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                                children: [
                                                                  Text(
                                                                    value.productsList[i].name.toString(),
                                                                    overflow: TextOverflow.ellipsis,
                                                                    textAlign: TextAlign.center,
                                                                    style: const TextStyle(color: ThemeProvider.blackColor, fontFamily: 'medium', fontSize: 14),
                                                                  ),
                                                                  const SizedBox(height: 6),
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    children: [
                                                                      Icon(Icons.star, color: value.productsList[i].rating! >= 1 ? ThemeProvider.orangeColor : ThemeProvider.greyColor, size: 12),
                                                                      Icon(Icons.star, color: value.productsList[i].rating! >= 2 ? ThemeProvider.orangeColor : ThemeProvider.greyColor, size: 12),
                                                                      Icon(Icons.star, color: value.productsList[i].rating! >= 3 ? ThemeProvider.orangeColor : ThemeProvider.greyColor, size: 12),
                                                                      Icon(Icons.star, color: value.productsList[i].rating! >= 4 ? ThemeProvider.orangeColor : ThemeProvider.greyColor, size: 12),
                                                                      Icon(Icons.star, color: value.productsList[i].rating! >= 5 ? ThemeProvider.orangeColor : ThemeProvider.greyColor, size: 12),
                                                                      const SizedBox(width: 6),
                                                                      Text(
                                                                        value.productsList[i].totalRating.toString(),
                                                                        style: const TextStyle(color: ThemeProvider.blackColor, fontFamily: 'medium', fontSize: 12),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(height: 6),
                                                                  Row(
                                                                    mainAxisAlignment: MainAxisAlignment.center,
                                                                    crossAxisAlignment: CrossAxisAlignment.center,
                                                                    children: [
                                                                      Text(
                                                                        value.currencySide == 'left' ? '${value.currencySymbol}${value.productsList[i].originalPrice}' : '${value.productsList[i].originalPrice}${value.currencySymbol}',
                                                                        style: const TextStyle(decoration: TextDecoration.lineThrough, color: ThemeProvider.greyColor, fontSize: 12),
                                                                      ),
                                                                      Text(
                                                                        value.currencySide == 'left' ? '${value.currencySymbol}${value.productsList[i].sellPrice}' : '${value.productsList[i].sellPrice}${value.currencySymbol}',
                                                                        style: const TextStyle(color: ThemeProvider.appColor, fontFamily: 'bold', fontSize: 12),
                                                                      ),
                                                                    ],
                                                                  ),
                                                                  const SizedBox(height: 6),
                                                                  value.productsList[i].quantity == 0
                                                                      ? SizedBox(
                                                                          width: 100,
                                                                          height: 26,
                                                                          child: ElevatedButton(
                                                                            onPressed: () {
                                                                              value.addToCart(i);
                                                                            },
                                                                            style: ElevatedButton.styleFrom(
                                                                                backgroundColor: ThemeProvider.appColor,
                                                                                shadowColor: ThemeProvider.blackColor,
                                                                                foregroundColor: ThemeProvider.whiteColor,
                                                                                elevation: 3,
                                                                                shape: (RoundedRectangleBorder(
                                                                                  borderRadius: BorderRadius.circular(6),
                                                                                )),
                                                                                padding: const EdgeInsets.all(0)),
                                                                            child: Text(
                                                                              'ADD'.tr,
                                                                              style: const TextStyle(letterSpacing: 1, fontSize: 12, color: ThemeProvider.whiteColor, fontFamily: 'bold'),
                                                                            ),
                                                                          ),
                                                                        )
                                                                      : Row(
                                                                          mainAxisAlignment: MainAxisAlignment.center,
                                                                          children: [
                                                                            Row(
                                                                              children: [
                                                                                SizedBox(
                                                                                  width: 24,
                                                                                  height: 24,
                                                                                  child: ElevatedButton(
                                                                                      onPressed: () {
                                                                                        value.updateProductQuantityRemove(i);
                                                                                      },
                                                                                      style: ElevatedButton.styleFrom(
                                                                                          backgroundColor: ThemeProvider.redColor,
                                                                                          shadowColor: ThemeProvider.blackColor,
                                                                                          foregroundColor: ThemeProvider.whiteColor,
                                                                                          elevation: 3,
                                                                                          shape: (RoundedRectangleBorder(
                                                                                            borderRadius: BorderRadius.circular(50),
                                                                                          )),
                                                                                          padding: const EdgeInsets.all(0)),
                                                                                      child: const Icon(Icons.remove)),
                                                                                ),
                                                                                Container(
                                                                                  padding: const EdgeInsets.symmetric(horizontal: 10),
                                                                                  child: Text(
                                                                                    value.productsList[i].quantity.toString(),
                                                                                    style: const TextStyle(fontSize: 14, fontFamily: 'medium', color: ThemeProvider.blackColor),
                                                                                  ),
                                                                                ),
                                                                                SizedBox(
                                                                                  width: 24,
                                                                                  height: 24,
                                                                                  child: ElevatedButton(
                                                                                      onPressed: () {
                                                                                        value.updateProductQuantity(i);
                                                                                      },
                                                                                      style: ElevatedButton.styleFrom(
                                                                                          backgroundColor: ThemeProvider.greenColor,
                                                                                          shadowColor: ThemeProvider.blackColor,
                                                                                          foregroundColor: ThemeProvider.whiteColor,
                                                                                          elevation: 3,
                                                                                          shape: (RoundedRectangleBorder(
                                                                                            borderRadius: BorderRadius.circular(50),
                                                                                          )),
                                                                                          padding: const EdgeInsets.all(0)),
                                                                                      child: const Icon(Icons.add)),
                                                                                )
                                                                              ],
                                                                            ),
                                                                          ],
                                                                        ),
                                                                ],
                                                              ),
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Column(
                                        crossAxisAlignment: CrossAxisAlignment.center,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          const SizedBox(height: 20),
                                          SizedBox(
                                            height: 80,
                                            width: 80,
                                            child: Image.asset(
                                              "assets/images/no-data.png",
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                          const SizedBox(
                                            height: 30,
                                          ),
                                          Center(
                                            child: Text(
                                              'No Data Found Near You!'.tr,
                                              style: const TextStyle(fontFamily: 'bold'),
                                            ),
                                          ),
                                        ],
                                      ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
              bottomNavigationBar: Get.find<ServiceCartController>().totalItemsInCart > 0
                  ? SizedBox(
                      height: 70,
                      child: InkWell(
                        onTap: () {
                          value.onCheckout();
                        },
                        child: Container(
                          margin: const EdgeInsets.all(10),
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          decoration: BoxDecoration(
                            color: ThemeProvider.appColor,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                value.currencySide == 'left' ? '${Get.find<ServiceCartController>().totalItemsInCart} ${'Items'.tr} ${value.currencySymbol}${Get.find<ServiceCartController>().totalPrice}' : ' ${Get.find<ServiceCartController>().totalItemsInCart} ${'Items'.tr} ${Get.find<ServiceCartController>().totalPrice}${value.currencySymbol}',
                                style: const TextStyle(color: ThemeProvider.whiteColor),
                              ),
                              Text(
                                'Book Services'.tr,
                                style: const TextStyle(color: ThemeProvider.whiteColor),
                              ),
                            ],
                          ),
                        ),
                      ),
                    )
                  : const SizedBox(),
            ),
          );
        },
      ),
    );
  }

  int _getGridCountLength(int returnLength) {
    if (returnLength < 4)
      return 1;
    else if (returnLength < 8)
      return 2;
    else if (returnLength < 12)
      return 3;
    else
      return 4;
  }

  Widget _searchWidget(HomeController value) {
    return InkWell(
      onTap: () {
        value.onSearch();
      },
      child: Container(
        width: MediaQuery.of(context).size.width,
        margin: EdgeInsets.only(left: 20, right: 30),
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Icon(
              Icons.search_outlined,
              color: ThemeProvider.greyColor,
              size: 16,
            ),
            Text(
              'Search salon, spa and barber'.tr,
              style: const TextStyle(color: ThemeProvider.greyColor, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
