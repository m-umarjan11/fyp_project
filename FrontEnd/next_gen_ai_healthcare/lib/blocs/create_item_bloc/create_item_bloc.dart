import 'package:backend_services_repository/backend_service_repositoy.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'create_item_event.dart';
part 'create_item_state.dart';

class CreateItemBloc extends Bloc<CreateItemEvent, CreateItemState> {
  final StoreDataImp storeData;
  CreateItemBloc({required this.storeData}) : super(CreateItemInitial()) {
    on<CreateItemRequiredEvent>((event, emit)async {
      emit(CreateItemLoadingState());
      try{
        Result result = await storeData.createItemObjectInDatabase(event.userId);
        if(result.isFailure){
          emit(CreateItemErrorState(errorMessage: result.error));
          return;
        }
        Result azureResult = await storeData.uploadToAzureBlobStorage(event.imagePaths, result.value);
        
        emit(CreateItemSuccessState(success: azureResult, images: event.imagePaths));
      } catch (e){
        print(e);
          emit(const CreateItemErrorState(errorMessage: "We are very sorry. Some unexpected error occurred."));
      }
    });

    on<CreateItemLoadImagesEvent>((event, emit)async{
      List<String> imagePaths = await storeData.getImagesFromPhone();
      emit(CreateItemLoadImages(images: imagePaths));
    });
  }
}
