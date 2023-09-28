import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../models/Category.dart';
import '../../models/SubLevel.dart';
import '../../models/SubSubLevel.dart';
import '../../providers/signup/signup_provider.dart';
import '../../services/categoriesService.dart';
import '../../widgets/category/cardCategory.dart';
import '../../widgets/scaffolds/authScaffold.dart';

class DefineCategoryScreen extends StatefulWidget {
  const DefineCategoryScreen({super.key});

  @override
  State<DefineCategoryScreen> createState() => _DefineCategoryScreenState();
}

class _DefineCategoryScreenState extends State<DefineCategoryScreen> {
  late String selectedPrincipalCategory = "";
  late String selectedSubLevelCategory = "";
  final CategoriesService _categoriesService = CategoriesService();
  late List<Category> categories = [];
  bool isLoading = true;

  void getAllCategories() async {
    final responseCategories = await _categoriesService.getCategories();

    if (responseCategories.isNotEmpty) {
      setState(() {
        categories = responseCategories as List<Category>;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    getAllCategories();
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final signUpProvider = Provider.of<SignUpProvider>(context);
    return QuickyAuthScaffold(
      currentScreenType: 'define-category',
      contentScreen: Container(
        margin: EdgeInsets.only(
          top: 40,
        ),
        width: double.infinity,
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 80),
              child: Image(
                height: 180,
                width: 180,
                image: AssetImage('assets/icons/brand/quiky.png'),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 25),
              child: Text(
                'Escoge una categoría para tu comercio',
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: isLoading
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : signUpProvider.principalCategorySelected.isEmpty
                      ? showGridCategories(signUpProvider)
                      : signUpProvider.subLevelSelected.isEmpty
                          ? showGridSubCategories(signUpProvider)
                          : showGridSubSubCategories(signUpProvider),
            )
          ],
        ),
      ),
    );
  }

  Widget showGridCategories(SignUpProvider provider) {
    return GridView.builder(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, mainAxisExtent: 125, crossAxisSpacing: 10),
        itemCount: categories.length,
        itemBuilder: ((context, index) {
          Category category = categories[index];
          return CategoryItem(
            selected: category.name == selectedPrincipalCategory,
            onTap: () {
              provider.selectPrincipalCategory(category.name);
            },
            image: category.banner,
            text: category.name,
          );
        }));
  }

  Widget showGridSubCategories(SignUpProvider provider) {
    Category category = categories.firstWhere(
        (element) => element.name == provider.principalCategorySelected);

    return GridView.builder(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, mainAxisExtent: 125, crossAxisSpacing: 10),
        itemCount: category.sublevels.length,
        itemBuilder: ((context, index) {
          SubLevel subLevel = category.sublevels[index];
          return CategoryItem(
            selected: subLevel.name == selectedSubLevelCategory,
            onTap: () {
              provider.selectedSubLevelCategory(subLevel.name);
            },
            image: subLevel.banner,
            text: subLevel.name,
          );
        }));
  }

  Widget showGridSubSubCategories(SignUpProvider provider) {
    Category category = categories.firstWhere(
        (element) => element.name == provider.principalCategorySelected);

    List<SubLevel> subLevels = category.sublevels;

    List<SubSubLevel> subSublevels = subLevels
        .firstWhere((element) => element.name == provider.subLevelSelected)
        .subSublevels;

    return GridView.builder(
        padding: EdgeInsets.only(top: 20, left: 20, right: 20),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisExtent: 125,
            crossAxisSpacing: 10,
            mainAxisSpacing: 20),
        itemCount: subSublevels.length,
        itemBuilder: ((context, index) {
          SubSubLevel subLevel = subSublevels[index];
          return CategoryItem(
            selected: subLevel.name == provider.subSubLevelSelected,
            onTap: () {
              provider.selectedSubSubLevelCategory(subLevel.name);
              Navigator.pushNamed(context, '/select/photo');
            },
            image: subLevel.banner,
            text: subLevel.name,
          );
        }));
  }
}
