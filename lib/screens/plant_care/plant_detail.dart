import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_test_2/constants/bottom_bar_index_constant.dart';
import 'package:flutter_login_test_2/constants/color_constant.dart';
import 'package:flutter_login_test_2/constants/text_style.dart';
import 'package:flutter_login_test_2/models/plant_detail_model.dart';
import 'package:flutter_login_test_2/screens/loading/loading_server_plant_detail_edit.dart';
import 'package:flutter_login_test_2/widgets/bottom_navigation_bar/bottom_navigation_bar.dart';

class PlantDetailScreen extends StatefulWidget {
  PlantDetailModel plantDetailModel;
  PlantDetailScreen({Key key, @required this.plantDetailModel})
      : super(key: key);
  @override
  _PlantDetailScreenState createState() => _PlantDetailScreenState();
}

class _PlantDetailScreenState extends State<PlantDetailScreen>
    with TickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollController = new ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppBarColor,
        title: Text(widget.plantDetailModel.commonName),
      ),
      body: bodyLayout(),
      backgroundColor: Colors.white,
      bottomNavigationBar: buildBottomNavigationBar(
          context: context, index: kBottomBarIndexPlant),
    );
  }

  bodyLayout() {
    return NestedScrollView(
      controller: this._scrollController,
      headerSliverBuilder: (context, innerBoxIsScrolled) {
        return [
          // INFO
          SliverToBoxAdapter(
            // IMAGE + NAMES
            child: Stack(clipBehavior: Clip.none, children: [
              // IMAGE
              Container(
                width: MediaQuery.of(context).size.width,
                height: 300,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.fill,
                    image: NetworkImage(widget.plantDetailModel.imageUrl),
                  ),
                ),
              ),
              // EDIT BUTTON
              Positioned(
                top: 10.0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      InkWell(
                        child: Container(
                          margin: EdgeInsets.all(10),
                          padding: EdgeInsets.all(5),
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            borderRadius: BorderRadius.circular(100),
                          ),
                          child: Icon(
                            Icons.edit,
                            color: Colors.white,
                          ),
                        ),
                        onTap: () {
                          // call api check edited or not
                          // if hasn't edit before, navigate to
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  LoadingServerPlantDetailEditScreen(
                                      id: widget.plantDetailModel.id),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
              // NAMES
              Positioned(
                top: 265.0,
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Card(
                        elevation: 4.0,
                        color: Colors.white,
                        margin: EdgeInsets.only(left: 20, right: 20),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15)),
                        child: Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Column(
                            children: [
                              Text(
                                widget.plantDetailModel.commonName,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 22.0,
                                ),
                              ),
                              SizedBox(height: 10.0),
                              Text(
                                widget.plantDetailModel.scientificName,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ]),
          ),
          // NAVIGATE TAB
          SliverAppBar(
            backgroundColor: Colors.white,
            automaticallyImplyLeading: false,
            expandedHeight: 100,
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(10),
              child: TabBar(
                controller: _tabController,
                labelColor: kBottomBarColor,
                isScrollable: false,
                tabs: [
                  Container(
                    margin: const EdgeInsets.all(5.0),
                    child: Tab(
                      text: 'Xem nhanh',
                    ),
                  ),
                  Tab(
                    text: 'Chi ti???t',
                  ),
                ],
              ),
            ),
          ),
        ];
      },
      body: Container(
        child: TabBarView(
          controller: _tabController,
          children: [
            // INFO QUICK VIEW
            Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 10.0,
                  right: 10.0,
                  top: 40.0,
                ),
                child: SingleChildScrollView(
                  physics: NeverScrollableScrollPhysics(),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // left
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '??? ????? kh??',
                            style: kPlantInfoLabel,
                          ),
                          SizedBox(
                            height: 22,
                          ),
                          Text(
                            '???? Th??n thi???n th?? nu??i',
                            style: kPlantInfoLabel,
                          ),
                          SizedBox(
                            height: 22,
                          ),
                          Text(
                            '??? ??nh s??ng',
                            style: kPlantInfoLabel,
                          ),
                          SizedBox(
                            height: 22,
                          ),
                          Text(
                            '???? T?????i n?????c',
                            style: kPlantInfoLabel,
                          ),
                          SizedBox(
                            height: 22,
                          ),
                          Text(
                            '??????? Nhi???t ?????',
                            style: kPlantInfoLabel,
                          ),
                        ],
                      ),
                      // right
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              generateDifficultyStars(
                                  widget.plantDetailModel.difficulty),
                              style: kPlantInfo,
                            ),
                            SizedBox(
                              height: 22,
                            ),
                            Text(
                              widget.plantDetailModel.petFriendly
                                  ? 'c??'
                                  : 'kh??ng',
                              style: kPlantInfo,
                            ),
                            SizedBox(
                              height: 22,
                            ),
                            Text(
                              sunlightInfo(widget.plantDetailModel.sunLight),
                              style: kPlantInfo,
                            ),
                            SizedBox(
                              height: 22,
                            ),
                            Text(
                              waterInfo(widget.plantDetailModel.waterLevel),
                              style: kPlantInfo,
                            ),
                            SizedBox(
                              height: 22,
                            ),
                            Text(
                              temperatureInfo(
                                  widget.plantDetailModel.temperatureRange),
                              style: kPlantInfo,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            // INFO DETAIL
            Container(
              //margin: EdgeInsets.only(left: 5.0, right: 5.0),
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.only(
                  left: 10.0,
                  right: 10.0,
                  top: 40.0,
                ),
                child: Padding(
                  padding: EdgeInsets.only(
                    left: 10.0,
                    right: 10.0,
                    top: 10.0,
                  ),
                  child: SingleChildScrollView(
                    physics: NeverScrollableScrollPhysics(),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // COMMON NAME
                        plantDetailTextRegion(
                            title: 'T??n th?????ng g???i',
                            content: widget.plantDetailModel.commonName),
                        // SCIENTIFIC NAME
                        plantDetailTextRegion(
                            title: 'T??n khoa h???c',
                            content: widget.plantDetailModel.scientificName),
                        //INFORMATION
                        plantDetailTextRegion(
                          title: 'Th??ng tin',
                          content: widget.plantDetailModel.information,
                        ),
                        //B??N PH??N
                        plantDetailTextRegion(
                          title: 'B??n ph??n',
                          content: widget.plantDetailModel.feedInformation,
                        ), // COMMON NAME
                        plantDetailTextRegion(
                          title: 'V???n ????? th?????ng g???p',
                          content: widget.plantDetailModel.feedInformation,
                        ),
                        //TH?? NU??I
                        plantDetailTextRegion(
                            title: 'Th??n thi???n th?? nu??i',
                            content: widget.plantDetailModel.petFriendly
                                ? 'c??'
                                : 'kh??ng'),
                        //??NH S??NG
                        plantDetailTextRegion(
                          title: '??nh s??ng',
                          content:
                              sunlightInfo(widget.plantDetailModel.sunLight),
                        ),
                        //??NH S??NG
                        plantDetailTextRegion(
                          title: 'T?????i n?????c',
                          content:
                              waterInfo(widget.plantDetailModel.waterLevel),
                        ),
                        //NHI???T ?????
                        plantDetailTextRegion(
                          title: 'Nhi???t ?????',
                          content: temperatureInfo(
                              widget.plantDetailModel.temperatureRange),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  //PLANT DETAIL COMPONENTS
  plantDetailTextRegion({String title, String content}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        //TITLE COMMON NAME
        Text(
          title,
          style: kPlantDetailLabel,
        ),
        Divider(),
        //COMMON NAME
        Text(
          content,
        ),
        SizedBox(
          height: 30.0,
        ),
      ],
    );
  }

  //DIFFICULTY STARS GENERATE
  generateDifficultyStars(int difficulty) {
    String stars = '';
    for (int i = 0; i < difficulty; i++) {
      stars += '???';
    }
    int emptyStars = 5 - difficulty;
    for (int i = 0; i < emptyStars; i++) {
      stars += '???';
    }
    return stars;
  }

  //SUN LIGHT INFO
  sunlightInfo(int sunLight) {
    switch (sunLight) {
      case 1:
        return '??t s??ng';
      case 2:
        return '??t s??ng-kh??ng tr???c ti???p';
      case 3:
        return 'kh??ng tr???c ti???p';
      case 4:
        return 'kh??ng tr???c ti???p-ngo??i tr???i';
      case 5:
        return 'ngo??i tr???i';
    }
  }

  //WATERING INFO
  waterInfo(int waterLevel) {
    switch (waterLevel) {
      case 1:
        return 'th???nh tho???ng';
      case 2:
        return 'th???nh tho???ng-th?????ng xuy??n';
      case 3:
        return 'th?????ng xuy??n';
      case 4:
        return 'th?????ng xuy??n-li??n t???c';
      case 5:
        return 'li??n t???c';
    }
  }

  //TEMPERATURE INFO
  temperatureInfo(List<dynamic> temperatureRange) {
    int from = temperatureRange[0];
    int to = temperatureRange[1];
    return '$from - $to??C';
  }
}
