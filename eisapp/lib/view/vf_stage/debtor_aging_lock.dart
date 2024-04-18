import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../model/GetVfStageDetaulsModel.dart';
import 'details_call.dart';

class DebtorAgingLock extends StatefulWidget {
  Result result;
  DebtorAgingLock({super.key,required this.result});

  @override
  State<DebtorAgingLock> createState() => _DebtorAgingLockState();
}

class _DebtorAgingLockState extends State<DebtorAgingLock> {
  bool dataLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    debtor_aging_lock_call(context);
  }

  debtor_aging_lock_call(BuildContext context) async {
    setState(() {
      dataLoading=true;
    });
    Response response = await details_call("api/a/sql/get_vf_approve_debtor_ageing_details/csc/${widget.result.vfStageId}/");
    if(response.statusCode==200){
      print("response : ${response.body}");
    }
    else
    {
      setState(() {
        dataLoading=false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column();
  }
}
