import 'dart:io';

import 'package:backend_services_repository/backend_service_repositoy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:next_gen_ai_healthcare/blocs/auth_bloc/auth_bloc.dart';
import 'package:next_gen_ai_healthcare/blocs/create_item_bloc/create_item_bloc.dart';

class AddItem extends StatefulWidget {
  const AddItem({super.key});

  @override
  State<AddItem> createState() => _AddItemState();
}

class _AddItemState extends State<AddItem> {
  final _formKey = GlobalKey<FormState>();
  final _itemNameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _sellerController = TextEditingController();
  List<String>? images;
  @override
  void dispose() {
    _itemNameController.dispose();
    _descriptionController.dispose();
    _sellerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Item'),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      TextFormField(
                        controller: _itemNameController,
                        decoration:
                            const InputDecoration(labelText: 'Item Name'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Item Name';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 10,
                      ),

                      TextFormField(
                        controller: _descriptionController,
                        decoration:
                            const InputDecoration(labelText: 'Description'),
                        maxLines: 3,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter Description';
                          }
                          return null;
                        },
                      ),
                      // const SizedBox(height: 10,),
                      // TextFormField(
                      //   controller: _sellerController,
                      //   decoration: const InputDecoration(labelText: 'Seller'),
                      //   validator: (value) {
                      //     if (value == null || value.isEmpty) {
                      //       return 'Please enter Seller Name';
                      //     }
                      //     return null;
                      //   },
                      // ),
                      const SizedBox(height: 16),
                      TextButton(
                        onPressed: () {
                          context
                              .read<CreateItemBloc>()
                              .add(CreateItemLoadImagesEvent());
                        },
                        child: const Text('Pick Images'),
                      ),
                      const SizedBox(height: 16),
                      const Text('Selected Images:'),
                      BlocBuilder<CreateItemBloc, CreateItemState>(
                        builder: (context, state) {
                          if (state is CreateItemLoadImages) {
                            images = state.images;
                            return SizedBox(
                              height: 100,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: images!.length,
                                itemBuilder: (context, index) {
                                  return Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Image.file(
                                      File(images![index]),
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                    ),
                                  );
                                },
                              ),
                            );
                          } else {
                            return const SizedBox();
                          }
                        },
                      ),
                      const SizedBox(height: 16),
                      ElevatedButton(
                        onPressed: () {
                          final authState = context.read<AuthBloc>().state
                              as AuthLoadingSuccess;
                          if (_formKey.currentState!.validate()) {
                            context.read<CreateItemBloc>().add(
                                CreateItemRequiredEvent(
                                  userId: authState.user.userId,
                                    item: Item(
                                        itemId: "",
                                        itemName: _itemNameController.text,
                                        description:
                                            _descriptionController.text,
                                        images: images!,
                                        location: {},
                                        seller: authState.user.userName,
                                        sold: 0,
                                        rating: 0),
                                    imagePaths: images!));
                          }
                        },
                        child: const Text('Submit'),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          BlocBuilder<CreateItemBloc ,CreateItemState>(
            builder: (context, state) {
              if(state is CreateItemLoadingState){
                return Container(
                color: const Color.fromARGB(108, 0, 0, 0),
                child: const Center(child: CircularProgressIndicator(),),
              );
              } else if(state is CreateItemSuccessState){
                return  AlertDialog(content: Text(state.success.value),);
              }else if(state is CreateItemErrorState){
                return  SizedBox(child: Text(state.errorMessage),);
              }else{
                return const SizedBox();
              }
            },
          )
        ],
      ),
    );
  }
}
