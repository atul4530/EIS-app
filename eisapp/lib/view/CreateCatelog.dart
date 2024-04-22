// ignore_for_file: deprecated_member_use, use_build_context_synchronously, avoid_print

import 'dart:convert';
import 'dart:math';

import 'package:eisapp/helper/pref_data.dart';
import 'package:eisapp/model/GetBarCodeContactColumnRequired.dart';
import 'package:eisapp/model/GetBarcodeCatelogListNameModel.dart';
import 'package:eisapp/view/ProductDetailsScreen.dart';
import 'package:eisapp/view/design_consts/DecorationMixin.dart';
import 'package:eisapp/view/loader/loader.dart';
import 'package:flutter/cupertino.dart';


import 'package:flutter/material.dart';

import 'package:flutter_sizer/flutter_sizer.dart';
import 'package:intl/intl.dart';

import '../model/GetBarCodeCatelogListModel.dart';
import '../model/LoginResponeModel.dart';
import '../network/ApiService.dart';
import 'CatelogListScreen.dart';

class CreateCatelog extends StatefulWidget {
  const CreateCatelog({super.key});

  @override
  State<CreateCatelog> createState() => _CreateCatelogState();
}

class _CreateCatelogState extends State<CreateCatelog>
    with BackgroundDecoration {
  bool light = false;
  bool selectedContact = true;

  List<GetBarCodeCatalogNameList> selectedColumnData = [];
  List<GetCatalogReqColumn> selectedColumnDataContract = [];
  List<GetBarCodeCatalogNameList> selectedData = [];
  List<GetCatalogReqColumn> selectedDataContract = [];
  bool dataLoading = true;
  GetBarCodeCatalogListModel? getBarCodeCatalogListModel;

  String selected_catelog = "Select Catelog";
  String selected_catelog_id = "Select Catelog";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getBarcodeCatelogListData();
  }

  getBarcodeCatelogListData() async {
    setState(() {
      dataLoading = true;
    });
    LoginResponseModel loginResponseModel = LoginResponseModel.fromJson(
        jsonDecode(
            (await PreferenceHelper().getStringValuesSF("data")).toString()));
    var response = await ApiService.getData(
        "rfid/TA/result/getBarCodeCatalogList/-1/${loginResponseModel.data!.first.cscId}/-1/-1/- 1/1/'-1'/'-1'/'-1'/-1/-1/-1/-1/-1/-1/-1/-1");
    GetBarCodeCatalogListModel data =
        GetBarCodeCatalogListModel.fromJson(jsonDecode(response.body));
    if (data.result ?? false) {
      setState(() {
        getBarCodeCatalogListModel = data;
        dataLoading = false;
      });
    } else {
      setState(() {
        dataLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          decoration: bgDecoration(),
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child: Column(
              children: [
                SizedBox(
                  //color: Colors.black,
                  height: MediaQuery.of(context).size.height / 9,
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(userMobile(context) ? 8.0 : 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(
                                  Icons.arrow_back,
                                  color: Colors.white,
                                )),
                            GestureDetector(
                              onTap: () async {
                                await getSelectCatelogData();
                                openOptions(context);
                              },
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 5),
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(35)),
                                child: Row(
                                  children: [
                                    Text(
                                      selected_catelog,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: userMobile(context)
                                              ? 13.sp
                                              : 16.sp),
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    Icon(
                                      Icons.arrow_drop_down,
                                      color: Colors.black,
                                      size: 15.sp,
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(userMobile(context) ? 8.0 : 16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              "Create Catelog",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                  fontSize:
                                      userMobile(context) ? 16.sp : 20.sp),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.search,
                                  color: Colors.transparent,
                                  size: userMobile(context) ? 22.sp : 27.sp,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const CatelogListScreen()));
                                    },
                                    child: Icon(
                                      Icons.list,
                                      color: Colors.white,
                                      size: userMobile(context) ? 22.sp : 27.sp,
                                    ))
                              ],
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
                Container(
                  decoration: decorationCommon(),
                  height: MediaQuery.of(context).size.height -
                      MediaQuery.of(context).size.height / 5.8,
                  width: MediaQuery.of(context).size.width,
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            GestureDetector(
                              onTap: () {
                                // setState(() {
                                //   selectedContact=!selectedContact;
                                // });
                              },
                              child: Row(
                                children: [
                                  Container(
                                    width: 22,
                                    height: 22,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(22),
                                        border: Border.all(
                                            width: 1,
                                            color: const Color(0xff32B7C6))),
                                    child: Container(
                                      height: 14,
                                      width: 14,
                                      margin: const EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(14),
                                          color: selectedContact
                                              ? const Color(0xff32B7C6)
                                              : Colors.transparent,
                                          border: Border.all(
                                              color: selectedContact
                                                  ? const Color(0xff32B7C6)
                                                  : Colors.transparent)),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    "CONTRACT",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.w600,
                                        fontSize: userMobile(context)
                                            ? 15.sp
                                            : 20.sp),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                Text(
                                  "In Stock",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                      fontSize:
                                          userMobile(context) ? 15.sp : 20.sp),
                                ),
                                Switch(
                                  // This bool value toggles the switch.
                                  value: light,

                                  onChanged: (bool value) {
                                    // This is called when the user toggles the switch.
                                    setState(() {
                                      light = value;
                                    });
                                  },
                                )
                              ],
                            )
                          ],
                        ),
                        dataLoading
                            ? const Center(
                                child: CircularProgressIndicator(),
                              )
                            : Expanded(
                                child: GridView.builder(
                                  // physics: NeverScrollableScrollPhysics(),
                                  gridDelegate:
                                      SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          mainAxisSpacing:
                                              userMobile(context) ? 2 : 10,
                                          childAspectRatio:
                                              userMobile(context) ? .84 : 1,
                                          crossAxisSpacing:
                                              userMobile(context) ? 2 : 10),
                                  padding: const EdgeInsets.all(0),
                                  // padding around the grid
                                  itemCount: getBarCodeCatalogListModel!
                                      .getBarCodeCatalogList!.length,
                                  // total number of items
                                  itemBuilder: (context, index) {
                                    var details = getBarCodeCatalogListModel!
                                        .getBarCodeCatalogList![index];
                                    return gridItem(context, details);
                                  },
                                ),
                              )
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget gridItem(
      BuildContext context, GetBarCodeCatalogList getBarCodeCatalogList) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductDetailsScreen(
                    cont_id: getBarCodeCatalogList.contId.toString(),
                    data:getBarCodeCatalogList)));
      },
      child: Card(
        elevation: 6,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        child: Container(
          width: MediaQuery.of(context).size.width / 2.2,
          decoration: BoxDecoration(
              color: Colors.white, borderRadius: BorderRadius.circular(12)),
          child: Stack(
            alignment: Alignment.topRight,
            children: [
              Column(
                children: [
                  Column(
                    children: [
                      Container(
                          width: MediaQuery.of(context).size.width / 2.1,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(12),
                                topRight: Radius.circular(12)),
                          ),
                          alignment: Alignment.center,
                          child: ClipRRect(
                              borderRadius: const BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12)),
                              child: Image.network(
                                getBarCodeCatalogList.img!,
                                height: MediaQuery.of(context).size.width / 5.5,
                                width: MediaQuery.of(context).size.width / 6.5,
                                fit: BoxFit.cover,
                              ))),
                      Container(
                        width: MediaQuery.of(context).size.width / 2.1,
                        alignment: Alignment.center,
                        padding: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            color:Color(0xFFD1C6FE)),
                        child: Text(
                          getBarCodeCatalogList.contTypeNo!,
                          style: TextStyle(fontWeight: FontWeight.w600,
                              fontSize: userMobile(context) ? 13.sp : 20.sp),
                        ),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 4, right: 4, bottom: 8, top: 3),
                    child: Column(
                      children: [
                        detailedWidget("${getBarCodeCatalogList.contId!}"),
                        detailedWidget(
                            getBarCodeCatalogList.jewelleryTypeName!),
                        detailedWidget(getBarCodeCatalogList.collection1!),
                        detailedWidget(
                            getBarCodeCatalogList.businessCategoryName!),
                        detailedWidget(getBarCodeCatalogList.stoneDesc!.length >
                                19
                            ? getBarCodeCatalogList.stoneDesc!.substring(0, 20)
                            : getBarCodeCatalogList.stoneDesc!),
                        detailedWidget(getBarCodeCatalogList.metalDesc!.length >
                                19
                            ? getBarCodeCatalogList.metalDesc!.substring(0, 20)
                            : getBarCodeCatalogList.metalDesc!),
                        // detailedWidget(getBarCodeCatalogList.metalDesc!),
                      ],
                    ),
                  ),
                ],
              ),
              GestureDetector(
                onTap: () async {
                  if (selected_catelog == "Select Catelog") {
                    await getBarcodeCatelogNameListModel();
                    openDigitalCatelog(context, getBarCodeCatalogList);
                  } else {
                    submitData(context, getBarCodeCatalogList);
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(
                    Icons.add_shopping_cart_outlined,
                    color: const Color(0xff6a208f),
                    size: userMobile(context) ? 24.sp : 27.sp,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  submitData(
      BuildContext context, GetBarCodeCatalogList getBarCodeCatalogList) async {
    showLoaderDialog(context);
    LoginResponseModel loginResponseModel = LoginResponseModel.fromJson(
        jsonDecode(
            (await PreferenceHelper().getStringValuesSF("data")).toString()));
    var response = await ApiService.getData(
        'rfid/TA/kciSaveBarCodeScan/{"catalogId":"$selected_catelog_id","catalogName":"$selected_catelog","cscId":"${loginResponseModel.data!.first.cscId}","catalogFor":"CONTRACT","reqColumns":"","contractNo":"${getBarCodeCatalogList.contTypeNo!.replaceAll("/", "-")}","contractId":"${getBarCodeCatalogList.contId}","userId":"${loginResponseModel.data!.first.empId}","remarks":""}');
    print("Response :  ${response.body}");
    Navigator.pop(context);
    if (response.body.contains("SUCCESS")) {
      var snackBar = SnackBar(
        content: Text(
            "Added Successfully ${(jsonDecode(response.body))["BarCodeCatalogId"].first["digital_catalogue_name"]}"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      const snackBar = SnackBar(
        content: Text("Something Went Wrong!!"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  submitFormData(BuildContext context, String url) async {
    showLoaderDialog(context);
    //LoginResponseModel loginResponseModel = LoginResponseModel.fromJson(jsonDecode((await PreferenceHelper().getStringValuesSF("data")).toString()));
    var response = await ApiService.getData(url);
    print("Response :  ${response.body}");
    Navigator.pop(context);
    Navigator.pop(context);
    if (response.body.contains("SUCCESS")) {
      var snackBar = SnackBar(
        content: Text(
            "Added Successfully ${(jsonDecode(response.body))["BarCodeCatalogId"].first["digital_catalogue_name"]}"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else {
      const snackBar = SnackBar(
        content: Text("Something Went Wrong!!"),
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Widget detailedWidget(String name) {
    return Row(
      children: [
        const Icon(
          Icons.circle_outlined,
          color: Colors.black,
          size: 12,
        ),
        const SizedBox(
          width: 3,
        ),
        Text(
          name.length>25?name.substring(0,25):name,
          style: TextStyle(
              fontSize: userMobile(context) ? 11.sp : 18.sp,
              fontWeight: FontWeight.w600),
        )
      ],
    );
  }

  TextEditingController catelogNameController = TextEditingController();
  TextEditingController remarksController = TextEditingController();

  DateTime selectedDate = DateTime.now();
  String expiry = "";

  Future<void> _selectDate(BuildContext context) async {
    await showDatePicker(
            context: context,
            initialDate: selectedDate,
            firstDate: DateTime.now(),
            lastDate: DateTime(2030))
        .then((picked) {
      if (picked != null && picked != selectedDate) {
        setState(() {
          selectedDate=picked;
          final DateFormat formatter = DateFormat('dd-MMM-yyyy');
          final String formatted = formatter.format(selectedDate);
          expiry = formatted;

          print("DATA\n\n\n\n\n\n ${formatted}");
        });

        setState(() {

        });
      }
    });
  }

  openDigitalCatelog(
      BuildContext context, GetBarCodeCatalogList getBarCodeCatalogList) {
    selectedData.clear();
    showDialog<void>(
        context: context,
        builder: (context) => StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                contentPadding: EdgeInsets.zero,
                content: Container(
                  height: 70.h,
                  width: 98.w,
                  color: Colors.white,
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Digital Catelog",
                                style: TextStyle(
                                    color: const Color(0xff6a208f),
                                    fontSize: 22.sp,
                                    fontWeight: FontWeight.w400),
                              ),
                              GestureDetector(
                                onTap: () async {
                                  // ignore: prefer_is_empty
                                  if (catelogNameController.text.trim().length >
                                          0 &&
                                      remarksController.text.trim().length >
                                          0 &&
                                      selectedDataContract.length > 0 &&
                                      expiry != "") {
                                    LoginResponseModel loginResponseModel =
                                        LoginResponseModel.fromJson(jsonDecode(
                                            (await PreferenceHelper()
                                                    .getStringValuesSF("data"))
                                                .toString()));
                                    List columnData = [];
                                    for (int i = 0;
                                        i < selectedDataContract.length;
                                        i++) {
                                      columnData
                                          .add(selectedDataContract[i].value!);
                                    }
                                    String url =
                                        'rfid/TA/kciSaveBarCodeScan/{"catalogId":"-1","catalogName":"${catelogNameController.text.trim()}","cscId":"${loginResponseModel.data!.first.cscId}","catalogFor":"CONTRACT","reqColumns":"${columnData.toString().replaceAll("[", "").replaceAll("]", "")}","contractNo":"${getBarCodeCatalogList.contTypeNo!.replaceAll("/", "-")}","contractId":"${getBarCodeCatalogList.contId}","userId":"${await loginResponseModel.data!.first.empId}","remarks":"${remarksController.text.trim()}","expirydate":"$expiry"}';
                                    submitFormData(context, url);
                                  } else {
                                    var snackBar = const SnackBar(
                                        content: Text('"Enter Value!!'));
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(snackBar);
                                  }
                                },
                                child: Container(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.green,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Text(
                                    "SAVE",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 16.sp),
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: Text(
                                    "Catelog Name*",
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.5),
                                        fontSize: 13.sp),
                                    textAlign: TextAlign.start,
                                  )),
                              Container(
                                height: 30.sp,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black.withOpacity(0.5),
                                        width: 0.5),
                                    borderRadius: BorderRadius.circular(10)),
                                child: TextField(
                                  controller: catelogNameController,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none),
                                ),
                              )
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                child: Text(
                                  "Expiry Date",
                                  style: TextStyle(
                                      color: Colors.black.withOpacity(0.5),
                                      fontSize: 13.sp),
                                  textAlign: TextAlign.start,
                                )),
                            GestureDetector(
                              onTap: () {
                                _selectDate(context).then((value) {
                                  setState((){});
                                });
                              },
                              child: SizedBox(
                                height: 5.h,
                                child: Card(
                                  elevation: 1,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10)),
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 12, vertical: 3),
                                  color: Colors.white,
                                  child: Container(
                                    padding: const EdgeInsets.all(8),
                                    child: Container(
                                      height: 30.sp,
                                      width: 100.w,
                                      //color: selectedData.contains(data)?Colors.deepPurple.withOpacity(0.5):Colors.white,
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 8.0),
                                        child: Text(
                                          expiry == "" ? "DD-MM-YYYY" : expiry,
                                          style: TextStyle(
                                              fontSize: 13.5.sp,
                                              color: Colors.black
                                                  .withOpacity(0.5)),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                  margin: const EdgeInsets.symmetric(
                                      horizontal: 12),
                                  child: Text(
                                    "Remarks",
                                    style: TextStyle(
                                        color: Colors.black.withOpacity(0.5),
                                        fontSize: 13.sp),
                                    textAlign: TextAlign.start,
                                  )),
                              Container(
                                height: 30.sp,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 12),
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.black.withOpacity(0.5),
                                        width: 0.5),
                                    borderRadius: BorderRadius.circular(10)),
                                child: TextField(
                                  controller: remarksController,
                                  decoration: const InputDecoration(
                                      border: InputBorder.none),
                                ),
                              )
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Card(
                            elevation: 1,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                                side: BorderSide(
                                    width: 1,
                                    color: Colors.black.withOpacity(0.5))),
                            margin: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 3),
                            color: Colors.white,
                            child: Container(
                              padding: const EdgeInsets.all(8),
                              child: Container(
                                height: 30.sp,
                                width: 100.w,
                                //color: selectedData.contains(data)?Colors.deepPurple.withOpacity(0.5):Colors.white,
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 8.0),
                                  child: Text(
                                    "Select Column Required*",
                                    style: TextStyle(
                                        fontSize: 13.5.sp,
                                        color: Colors.black.withOpacity(0.5)),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 34.h,
                          child: ListView.builder(
                              itemCount: selectedContact
                                  ? selectedColumnDataContract.length
                                  : selectedColumnData.length,
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              itemBuilder: (context, index) {
                                var data = selectedContact
                                    ? GetBarCodeCatalogNameList()
                                    : selectedColumnData[index];
                                var dataC = selectedContact
                                    ? selectedColumnDataContract[index]
                                    : GetCatalogReqColumn();
                                return GestureDetector(
                                  onTap: () {
                                    if (selectedDataContract.contains(dataC)) {
                                      selectedDataContract.remove(dataC);
                                    } else {
                                      selectedDataContract.add(dataC);
                                    }

                                    print("------- $selectedDataContract");
                                    setState(() {});
                                  },
                                  child: SizedBox(
                                    height: 5.h,
                                    child: Card(
                                      elevation: 1,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 12, vertical: 3),
                                      color: selectedContact
                                          ? (selectedDataContract
                                                  .contains(dataC)
                                              ? Colors.deepPurple
                                                  .withOpacity(0.5)
                                              : Colors.white)
                                          : (selectedData.contains(data)
                                              ? Colors.deepPurple
                                                  .withOpacity(0.5)
                                              : Colors.white),
                                      child: Container(
                                        padding: const EdgeInsets.all(8),
                                        child: Container(
                                          height: 30.sp,
                                          width: 100.w,
                                          //color: selectedData.contains(data)?Colors.deepPurple.withOpacity(0.5):Colors.white,
                                          alignment: Alignment.centerLeft,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 8.0),
                                            child: Text(
                                              selectedContact
                                                  ? dataC.label!
                                                  : data.label!,
                                              style: TextStyle(
                                                  fontSize: 13.5.sp,
                                                  color: Colors.black
                                                      .withOpacity(0.5)),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      ],
                    ),
                  ),
                ),
              );
            })).then((value) {
      //   Navigator.pop(context);
    });
  }

  GetBarCodeCatelogNameListModel? getBarCodeCatelogNameList;

  openOptions(BuildContext context) {
    //selectedData.clear();
    showDialog<void>(
        context: context,
        builder: (context) => StatefulBuilder(builder: (context, setState) {
              return AlertDialog(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4)),
                contentPadding: EdgeInsets.zero,
                content: Container(
                  height: 50.h,
                  color: Colors.white,
                  child: Column(
                    children: [
                      SizedBox(
                        height: 5.h,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Icon(
                                  Icons.close,
                                  color: Colors.red,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              selected_catelog = "Select Catelog";
                              selected_catelog_id = "Select Catelog";
                              Navigator.pop(context);
                            });
                          },
                          child: SizedBox(
                            height: 5.h,
                            child: Card(
                              elevation: 1,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10)),
                              margin: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 3),
                              color: Colors.white,
                              child: Container(
                                padding: const EdgeInsets.all(8),
                                child: Container(
                                  height: 30.sp,
                                  width: 100.w,
                                  //color: selectedData.contains(data)?Colors.deepPurple.withOpacity(0.5):Colors.white,
                                  alignment: Alignment.centerLeft,
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 8.0),
                                    child: Text(
                                      "Select Catelog",
                                      style: TextStyle(
                                          fontSize: 13.5.sp,
                                          color: Colors.black.withOpacity(0.5)),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        height: 40.h,
                        width: 98.w,
                        color: Colors.white,
                        child: ListView.builder(
                            itemCount: getBarCodeCatelogNameList!
                                .getBarCodeCatalogNameList!.length,
                            padding:
                                const EdgeInsets.symmetric(horizontal: 8.0),
                            itemBuilder: (context, index) {
                              var dataC = getBarCodeCatelogNameList!
                                  .getBarCodeCatalogNameList![index];
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selected_catelog = dataC.label!;
                                    selected_catelog_id =
                                        dataC.value!.toString();
                                    Navigator.pop(context);
                                  });
                                },
                                child: SizedBox(
                                  height: 5.h,
                                  child: Card(
                                    elevation: 1,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 3),
                                    color: Colors.white,
                                    child: Container(
                                      padding: const EdgeInsets.all(8),
                                      child: Container(
                                        height: 30.sp,
                                        width: 100.w,
                                        alignment: Alignment.centerLeft,
                                        child: Padding(
                                          padding:
                                              const EdgeInsets.only(left: 8.0),
                                          child: Text(
                                            dataC.label!,
                                            style: TextStyle(
                                                fontSize: 13.5.sp,
                                                color: Colors.black
                                                    .withOpacity(0.5)),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }),
                      ),
                    ],
                  ),
                ),
              );
            })).then((value) {
      setState(() {});
    });
  }

  getSelectCatelogData() async {
    LoginResponseModel loginResponseModel = LoginResponseModel.fromJson(
        jsonDecode(
            (await PreferenceHelper().getStringValuesSF("data")).toString()));
    showLoaderDialog(context);
    var response = await ApiService.getData(
        "rfid/TA/result/getBarCodeCatalogNameList/-1/${loginResponseModel.data!.first.cscId!}/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1");
    getBarCodeCatelogNameList =
        GetBarCodeCatelogNameListModel.fromJson(jsonDecode(response.body));
    Navigator.pop(context);
  }

  getBarcodeCatelogNameListModel() async {
    LoginResponseModel loginResponseModel = LoginResponseModel.fromJson(
        jsonDecode(
            (await PreferenceHelper().getStringValuesSF("data")).toString()));
    showLoaderDialog(context);
    selectedColumnDataContract.clear();
    var response = await ApiService.getData(selectedContact
        ? "rfid/TA/result/getCatalogReqColumns/-1/${loginResponseModel.data!.first.cscId}/-1/-1/'CONTRACT'/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1"
        : "rfid/TA/result/getBarCodeCatalogNameList/-1/${loginResponseModel.data!.first.cscId!}/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1/-1");
    if (selectedContact) {
      GetBarCodeCatelogRequriedColumnListModel
          getBarCodeCatelogRequriedColumnListModel =
          GetBarCodeCatelogRequriedColumnListModel.fromJson(
              jsonDecode(response.body));
      if (getBarCodeCatelogRequriedColumnListModel.result ?? false) {
        Navigator.pop(context);
        setState(() {
          selectedColumnDataContract.addAll(
              getBarCodeCatelogRequriedColumnListModel.getCatalogReqColumns!);
        });
      } else {}
    } else {
      GetBarCodeCatelogNameListModel getBarCodeCatelogNameListModel =
          GetBarCodeCatelogNameListModel.fromJson(jsonDecode(response.body));
      if (getBarCodeCatelogNameListModel.result ?? false) {
        Navigator.pop(context);
        setState(() {
          selectedColumnData.addAll(
              getBarCodeCatelogNameListModel.getBarCodeCatalogNameList!);
        });
      } else {}
    }
  }
}

bool userMobile(BuildContext context) {
  var shortestSide = MediaQuery.of(context).size.shortestSide;
  final bool useMobileLayout = shortestSide < 600;
  return useMobileLayout;
}
