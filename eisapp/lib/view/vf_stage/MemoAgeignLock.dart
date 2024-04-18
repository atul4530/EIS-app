import 'package:flutter/material.dart';
import 'package:http/http.dart';

import '../../model/GetVfStageDetaulsModel.dart';
import 'details_call.dart';

class MemoAgeignLock extends StatefulWidget {
  Result result;
   MemoAgeignLock({super.key,required this.result});

  @override
  State<MemoAgeignLock> createState() => _MemoAgeignLockState();
}

class _MemoAgeignLockState extends State<MemoAgeignLock> {
  bool dataLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    memo_ageign_lock(context);
  }

  memo_ageign_lock(BuildContext context) async {
    setState(() {
      dataLoading=true;
    });
    Response response = await details_call("api/a/sql/get_vf_approve_memo_ageing_details/csc/${widget.result.vfId}/");
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
