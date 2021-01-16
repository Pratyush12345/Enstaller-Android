import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/constant/app_string.dart';
import 'package:enstaller/core/constant/size_config.dart';
import 'package:enstaller/core/model/save_order_line.dart';
import 'package:flutter/material.dart';
import 'package:select_form_field/select_form_field.dart';

typedef OnDelete();

class OrderItem extends StatefulWidget {
  final SaveOrderLine saveOrderLine;
  final OnDelete onDelete;
  final List<Map<String, dynamic>> itemList;
  final List<Map<String, dynamic>> contractList;
  final state = _OrderItemState();
  bool isValid() => state.validate();

  OrderItem({Key key, this.saveOrderLine, this.onDelete, this.itemList, this.contractList}) : super(key: key);

  @override
  _OrderItemState createState() => state;
}

class _OrderItemState extends State<OrderItem> {


  final form = GlobalKey<FormState>();




  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: SizeConfig.sidepadding/2,
      child: Card(
        margin: SizeConfig.verticalBigPadding,
        elevation: 2,
        child: Form(
          key: form,
          child: Column(
            children: [
              Padding(
                padding: SizeConfig.sidepadding,
                child: SelectFormField(
                  type: SelectFormFieldType.dropdown,
                  initialValue: AppStrings.SELECT,
                  labelText: 'Items',
                  items: widget.itemList,
                  onSaved: (val) => widget.saveOrderLine.intItemId = int.parse(val),
                  onChanged: (val) => widget.saveOrderLine.intItemId = int.parse(val),
                  validator: (val) {
                    if (val == AppStrings.SELECT) return 'Please choose an option.';
                    return null;
                  },
                ),
              ),
              SizeConfig.verticalSpaceMedium(),
              Padding(
                padding: SizeConfig.sidepadding,
                child: SelectFormField(
                  type: SelectFormFieldType.dropdown,
                  initialValue: AppStrings.SELECT,
                  labelText: 'Contracts',
                  onChanged: (val)=> widget.saveOrderLine.intContractId = int.parse(val),
                  items: widget.contractList,
                  onSaved: (val)=> widget.saveOrderLine.intContractId = int.parse(val),
                  validator: (val) {
                    if (val == AppStrings.SELECT) return 'Please choose an option.';
                    return null;
                  },
                ),
              ),
              SizeConfig.verticalSpaceMedium(),
              Padding(
                padding: SizeConfig.sidepadding,
                child: Row(
                  children: [
                    Expanded(
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            labelText: AppStrings.QUANTITY,
                            hintText: AppStrings.QUANTITY,

                          ),
                          validator: (value) {
                            if (value.trim().isEmpty) {
                              return 'Required';
                            } else
                              return null;
                          },
                          onChanged: (val) => widget.saveOrderLine.decQty = int.parse(val.trim()),
                          onSaved: (val) => widget.saveOrderLine.decQty = int.parse(val.trim()),
                        )),
                    SizeConfig.horizontalSpaceMedium(),
                    IconButton(
                        icon: Icon(
                          Icons.delete,
                          color: AppColors.red,
                        ),
                        onPressed: widget.onDelete),
                  ],
                ),
              ),
              SizeConfig.verticalSpaceMedium(),
            ],
          ),
        ),
      ),
    );
  }
  bool validate() {
    var valid = form.currentState.validate();
    if (valid) form.currentState.save();
    return valid;
  }
}
