import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinema/presentation/widgets/widgets.dart';
import 'package:cinema/presentation/providers/providers.dart';


class HomeScreen extends StatelessWidget {

  static const name = 'home-screen';

  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigator(),
      );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {

  @override
  void initState() {
    super.initState();

    ref.read(nowPLayingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {

    final nowPlayingMovies = ref.watch(nowPLayingMoviesProvider);
    final moviesSlideshow = ref.watch(moviesSlideshowProvider);

    return CustomScrollView(
      slivers: [

        const SliverAppBar(
          floating: true,
          flexibleSpace: FlexibleSpaceBar(
            title:  CustomAppBar(),
          ),
        ),

        SliverList(
          delegate:SliverChildBuilderDelegate(
            (context, index){
              return 

                    Column(
        children: [
          MovieSlidesshow(movies:moviesSlideshow),
          MovieHorizontalListview (
            movies:nowPlayingMovies,
            title: 'En Cines',
            subTitle: 'Lunes 20',
            loadNextPage: (){
              ref.read(nowPLayingMoviesProvider.notifier).loadNextPage();
            },
            ),
      
            MovieHorizontalListview (
            movies:nowPlayingMovies,
            title: 'Proximamente',
            loadNextPage: (){
              ref.read(nowPLayingMoviesProvider.notifier).loadNextPage();
            },
            ),
      
            MovieHorizontalListview (
            movies:nowPlayingMovies,
            title: 'Populares',
            loadNextPage: (){
              ref.read(nowPLayingMoviesProvider.notifier).loadNextPage();
            },
            ),
      
            MovieHorizontalListview (
            movies:nowPlayingMovies,
            title: 'Mejor Calificadas',
            loadNextPage: (){
              ref.read(nowPLayingMoviesProvider.notifier).loadNextPage();
            },
            ),
           const SizedBox(height: 20,)  
        ],
      
      );
            },
            childCount: 1,
            ))
      ]

      
      

    );
  }
}
