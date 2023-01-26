import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../colors.dart';
import '../../cubit/ecom_cubit.dart';

class CartList extends StatelessWidget {
  const CartList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EcomCubit, EcomState>(
      builder: (context, state) {
        EcomCubit cubit = EcomCubit.getContext(context);
        cubit.cartItemsTotal(
            cubit.ecomLists.map<int>((e) => e['price']).toList());
        return Column(
          children: [
            Expanded(
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: cubit.ecomLists.length,
                itemBuilder: (context, index) {
                  final brand = cubit.ecomLists[index];
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(15.0),
                      child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  brand['name'],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                  ),
                                ),
                                const SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  '\$${brand['price']}',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                    fontSize: 15,
                                    color: CustomColors.errorColor,
                                  ),
                                ),
                              ],
                            ),
                            _deleteButton(cubit, brand),
                          ]),
                    ),
                  );
                },
              ),
            ),
            Container(
              color: CustomColors.primaryColor,
              padding: const EdgeInsets.all(20),
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Total',
                      style: TextStyle(
                        fontSize: 18,
                        color: CustomColors.whiteColor,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '\$ ${cubit.sum}',
                      style: TextStyle(
                        color: CustomColors.whiteColor,
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                      ),
                    ),
                  ]),
            ),
          ],
        );
      },
    );
  }

  _deleteButton(EcomCubit cubit, Map<dynamic, dynamic> brand) {
    return IconButton(
        onPressed: () {
          cubit.deleteFromCart(id: brand['id']);
        },
        icon: Icon(
          Icons.close,
          color: CustomColors.errorColor,
        ));
  }
}
