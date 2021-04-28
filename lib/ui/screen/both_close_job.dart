import 'package:enstaller/core/constant/app_colors.dart';
import 'package:enstaller/core/model/elec_closejob_model.dart';
import 'package:enstaller/ui/screen/elec_close_job.dart';
import 'package:enstaller/ui/screen/gas_close_job.dart';
import 'package:flutter/material.dart';
class BothCloseJob extends StatefulWidget {
  final List<CheckTable> list;
  BothCloseJob({@required this.list});
  
  @override
  _BothCloseJobState createState() => _BothCloseJobState();
}

class _BothCloseJobState extends State<BothCloseJob> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
          child: Scaffold(
       appBar: AppBar(title: Text("Close Jobs"),),
       body: Column(
            children: [
              Container(
                color: AppColors.green,
                width: MediaQuery.of(context).size.width,
                height: 50.0,
                child: TabBar(
                    labelPadding: EdgeInsets.zero,
                    labelColor: Colors.white,
                    unselectedLabelColor: Colors.white,
                    indicator: BoxDecoration(
                      color: Color(0xff3c6577),
                      borderRadius: BorderRadius.circular(
                        10.0,
                      ),
                    ),
                    tabs: [
                      Tab(
                        child: Text(
                          'Electricity Close Job',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      Tab(
                        child: Text(
                          'Gas Close Job',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 16.0,
                          ),
                        ),
                      ),
                      
                    ]),
              ),
              Expanded(
                flex: 2,
                child: TabBarView(children: [
                  ElecCloseJob(
                    list: widget.list,
                    fromTab: true,
                  ),
                  GasCloseJob(list: widget.list,
                   fromTab: true,
                  ),
                ]),
              ),
            ],
          ),
      ),
    );
  }
}