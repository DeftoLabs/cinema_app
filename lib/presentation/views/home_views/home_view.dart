import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:cinema/presentation/providers/providers.dart';
import 'package:cinema/presentation/widgets/movies/movie_horizontal_listview.dart';
import 'package:cinema/presentation/widgets/movies/movies_slideshow.dart';
import 'package:cinema/presentation/widgets/shared/custom_appbar.dart';








class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {

  @override
  void initState() {
    super.initState();

    ref.read(nowPLayingMoviesProvider.notifier).loadNextPage();
    ref.read(popularMoviesProvider.notifier).loadNextPage();
    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
    ref.read(upComingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {

    final initialLoading = ref.watch(initialLoadingProvider);
    //if(initialLoading) return const FullScreenLoader();

    final nowPlayingMovies = ref.watch(nowPLayingMoviesProvider);
    final moviesSlideshow = ref.watch(moviesSlideshowProvider);
    final popularMovies= ref.watch(popularMoviesProvider);
    final upComing= ref.watch(upComingMoviesProvider);
    final topRatedMovies= ref.watch(topRatedMoviesProvider);

   


    return Visibility(
      visible: !initialLoading,
      child: CustomScrollView(
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
              movies:upComing,
              title: 'Proximamente',
              loadNextPage: (){
                ref.read(upComingMoviesProvider.notifier).loadNextPage();
              },
              ),
        
              MovieHorizontalListview (
              movies:popularMovies,
              title: 'Populares',
              loadNextPage: (){
                ref.read(popularMoviesProvider.notifier).loadNextPage();
              },
              ),
        
              MovieHorizontalListview (
              movies:topRatedMovies,
              title: 'Mejor Calificadas',
              loadNextPage: (){
                ref.read(topRatedMoviesProvider.notifier).loadNextPage();
              },
              ),
             const SizedBox(height: 20,)  
          ],
        
        );
              },
              childCount: 1,
              ))
        ]
      
        
        
      
      ),
    );
  }
}
