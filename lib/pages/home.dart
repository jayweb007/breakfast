import 'package:breakfast/models/category_model.dart';
import 'package:breakfast/models/diet_model.dart';
import 'package:breakfast/models/popular_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<CategoryModel> categories = [];
  List<DietModel> diets = [];
  List<PopularDietsModel> popularDiets = [];

  void _getInitialInfo() {
    categories = CategoryModel.getCategories();
    diets = DietModel.getDiets();
    popularDiets = PopularDietsModel.getPopularDiets();
  }

  //
  @override
  Widget build(BuildContext context) {
    _getInitialInfo();

    return Scaffold(
      appBar: appBar(),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          _searchField(),
          const SizedBox(
            height: 40.0,
          ),
          _categorySection(),
          const SizedBox(
            height: 40.0,
          ),
          _dietSection(),
          const SizedBox(
            height: 40.0,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Text(
                  "Popular",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(
                height: 15.0,
              ),
              ListView.separated(
                itemCount: popularDiets.length,
                shrinkWrap: true,
                padding: const EdgeInsets.only(left: 20.0, right: 20.0),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 25.0,
                ),
                itemBuilder: (context, index) {
                  return Container(
                    height: 100.0,
                    decoration: BoxDecoration(
                        color: popularDiets[index].boxIsSelected
                            ? Colors.white
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(16.0),
                        boxShadow: popularDiets[index].boxIsSelected
                            ? [
                                BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    offset: const Offset(0, 10.0),
                                    blurRadius: 40.0,
                                    spreadRadius: 0.0)
                              ]
                            : []),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SvgPicture.asset(
                          popularDiets[index].iconPath,
                          width: 65.0,
                          height: 65.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              popularDiets[index].name,
                              style: const TextStyle(
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black,
                                  fontSize: 16.0),
                            ),
                            Text(
                              '${popularDiets[index].level} | ${popularDiets[index].duration} | ${popularDiets[index].calorie}',
                              style: const TextStyle(
                                  fontWeight: FontWeight.w400,
                                  color: Color(0xFF7B6F72),
                                  fontSize: 13.0),
                            ),
                          ],
                        ),
                        GestureDetector(
                          onTap: () {},
                          child: SvgPicture.asset(
                            "assets/icons/button.svg",
                            width: 30.0,
                            height: 30.0,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              )
            ],
          ),
          const SizedBox(
            height: 40.0,
          ),
        ],
      ),
    );
  }

  Column _dietSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text(
            "Recommendation \n for Diet",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 240,
          child: ListView.separated(
            itemCount: diets.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            separatorBuilder: (context, index) => const SizedBox(
              width: 25.0,
            ),
            itemBuilder: (context, index) {
              return Container(
                width: 210,
                decoration: BoxDecoration(
                    color: diets[index].boxColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(20.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    SvgPicture.asset(diets[index].iconPath),
                    Column(
                      children: [
                        Text(
                          diets[index].name,
                          style: const TextStyle(
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                              fontSize: 16.0),
                        ),
                        Text(
                          '${diets[index].level} | ${diets[index].duration} | ${diets[index].calorie}',
                          style: const TextStyle(
                              fontWeight: FontWeight.w400,
                              color: Color(0xFF7B6F72),
                              fontSize: 13.0),
                        ),
                      ],
                    ),
                    Container(
                      height: 45.0,
                      width: 130.0,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(50.0),
                          gradient: LinearGradient(colors: [
                            diets[index].viewIsSelected
                                ? const Color(0xff9dceff)
                                : Colors.transparent,
                            diets[index].viewIsSelected
                                ? const Color(0xff92a3fd)
                                : Colors.transparent
                          ])),
                      child: Center(
                        child: Text(
                          "View",
                          style: TextStyle(
                              color: diets[index].viewIsSelected
                                  ? Colors.white
                                  : const Color(0xffc58bf2),
                              fontSize: 14.0,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Column _categorySection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text(
            "Category",
            style: TextStyle(
              color: Colors.black,
              fontSize: 18.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          height: 120,
          child: ListView.separated(
            itemCount: categories.length,
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.only(left: 20.0, right: 20.0),
            separatorBuilder: (context, index) => const SizedBox(
              width: 25.0,
            ),
            itemBuilder: (context, index) {
              return Container(
                width: 100,
                decoration: BoxDecoration(
                    color: categories[index].boxColor.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(16.0)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      width: 50.0,
                      height: 50.0,
                      decoration: const BoxDecoration(
                          color: Colors.white, shape: BoxShape.circle),
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SvgPicture.asset(categories[index].iconPath),
                      ),
                    ),
                    Text(
                      categories[index].name,
                      style: const TextStyle(
                          fontWeight: FontWeight.w400,
                          color: Colors.black,
                          fontSize: 14.0),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Container _searchField() {
    return Container(
      margin: const EdgeInsets.only(
        left: 20.0,
        top: 40.0,
        right: 20.0,
      ),
      decoration: BoxDecoration(boxShadow: [
        BoxShadow(
            color: const Color(0xff1D1617).withOpacity(0.11),
            spreadRadius: 0.0,
            blurRadius: 40)
      ]),
      child: TextField(
        decoration: InputDecoration(
            filled: true,
            fillColor: Colors.white,
            hintText: "Search Pancake",
            hintStyle: TextStyle(color: Colors.grey.shade300),
            contentPadding: const EdgeInsets.all(15.0),
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SvgPicture.asset("assets/icons/Search.svg"),
            ),
            suffixIcon: SizedBox(
              width: 70,
              child: IntrinsicHeight(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    VerticalDivider(
                      color: Colors.grey[400],
                      indent: 10.0,
                      endIndent: 10.0,
                      thickness: 0.5,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset("assets/icons/Filter.svg"),
                    ),
                  ],
                ),
              ),
            ),
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.0),
                borderSide: BorderSide.none)),
      ),
    );
  }

  AppBar appBar() {
    return AppBar(
      backgroundColor: Colors.white,
      title: const Text(
        "BreakFast",
        style: TextStyle(
            color: Colors.black, fontSize: 18.0, fontWeight: FontWeight.bold),
      ),
      centerTitle: true,
      elevation: 0,
      leading: GestureDetector(
        onTap: () {},
        child: Container(
          alignment: Alignment.center,
          margin: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              color: const Color(0xfff7f8f8),
              borderRadius: BorderRadius.circular(10.0)),
          child: SvgPicture.asset(
            'assets/icons/arrow-left.svg',
            height: 20.0,
            width: 20.0,
          ),
        ),
      ),
      actions: [
        GestureDetector(
          onTap: () {},
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(10.0),
            width: 37,
            decoration: BoxDecoration(
                color: const Color(0xfff7f8f8),
                borderRadius: BorderRadius.circular(10.0)),
            child: SvgPicture.asset(
              'assets/icons/dots.svg',
              height: 5.0,
              width: 5.0,
            ),
          ),
        ),
      ],
    );
  }
}
