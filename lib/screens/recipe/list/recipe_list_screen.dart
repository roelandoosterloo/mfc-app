import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mfc_app/blocs/recipe/list_recipe/list_recipe_bloc.dart';
import 'package:mfc_app/models/recipe/Recipe.dart';
import 'package:mfc_app/widgets/loading.dart';

class RecipeListScreen extends StatefulWidget {
  const RecipeListScreen({Key? key}) : super(key: key);

  @override
  _RecipeListScreenState createState() => _RecipeListScreenState();
}

class _RecipeListScreenState extends State<RecipeListScreen> {
  void initState() {
    super.initState();
    BlocProvider.of<ListRecipeBloc>(context).add(RecipesRequested());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Recipes",
        ),
      ),
      body: BlocBuilder<ListRecipeBloc, ListRecipeState>(
        builder: (context, state) {
          if (state is ListRecipeInitial) {
            return Loading();
          }
          if (state is RecipesAvailable) {
            return Container(
              child: ListView.builder(
                itemCount: state.recipes.length,
                scrollDirection: Axis.vertical,
                itemBuilder: (context, index) {
                  Recipe recipe = state.recipes[index];
                  return Card(
                    child: Column(
                      children: [
                        SizedBox(
                          width: double.infinity,
                          height: 150,
                          child: Hero(
                            tag: index,
                            child: Image.network(
                              recipe.imageUrl,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        ListTile(
                          title: Text(
                            recipe.name,
                            style: TextStyle(fontSize: 24),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            );
          }
          return Text("Loading???");
        },
      ),
    );
  }
}
