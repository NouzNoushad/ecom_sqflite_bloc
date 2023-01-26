import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../colors.dart';
import '../../cubit/ecom_cubit.dart';

class HomeList extends StatelessWidget {
  const HomeList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EcomCubit, EcomState>(
      builder: (context, state) {
        EcomCubit cubit = EcomCubit.getContext(context);
        return ListView.builder(
          shrinkWrap: true,
          itemCount: cubit.brandLists.length,
          itemBuilder: (context, index) {
            final brand = cubit.brandLists[index];
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
                      _textButton(cubit, brand),
                    ]),
              ),
            );
          },
        );
      },
    );
  }

  _textButton(EcomCubit cubit, Map<String, dynamic> brand) {
    return TextButton(
      onPressed: () {
        cubit.ecomAddToCart(name: brand['name'], price: brand['price']);
      },
      style: TextButton.styleFrom(backgroundColor: CustomColors.greenColor),
      child: Text(
        'Add to Cart',
        style: TextStyle(color: CustomColors.whiteColor),
      ),
    );
  }
}
