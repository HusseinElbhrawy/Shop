import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:new_shop_appl/shared/cubit/states.dart';

class FavoriteScreenBloc extends Cubit<ShopStates> {
  FavoriteScreenBloc() : super(FavoriteScreenState());

  static FavoriteScreenBloc object(context) => BlocProvider.of(context);
}
