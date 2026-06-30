// import 'package:flutter/material.dart';

// import 'package:provider/provider.dart';
// import '../../app/theme/app_text_styles.dart';
// import '../../core/constants/assets_paths.dart';

// class FacilityManagementDrawer extends StatefulWidget {
//   final BuildContext mainContext;

//   const FacilityManagementDrawer({super.key, required this.mainContext});

//   @override
//   State<FacilityManagementDrawer> createState() =>
//       _FacilityManagementDrawerState();
// }

// class _FacilityManagementDrawerState extends State<FacilityManagementDrawer> {
//   bool _isFinanceExpanded = false;
//   bool _isMyTripsExpanded = false;
//   bool _crewExpanded = false;

//   bool _crewPurserExpanded = false;

//   final List<Map<String, dynamic>> _ownerDrawerItems = <Map<String, dynamic>>[
//     <String, dynamic>{
//       'image': AssetsPathConstants.dashBoardIconPath,
//       'text': 'Dashboard',
//       'index': '0',
//       'selectedImage': AssetsPathConstants.dashBoardSelectedIconPath,
//     },
//     <String, dynamic>{
//       'image': AssetsPathConstants.mayYachtDrawerImagePath,
//       'text': 'My Yacht',
//       'index': '1',
//       'selectedImage': AssetsPathConstants.myYachtSelectedImagePath,
//     },
//     <String, dynamic>{
//       'image': AssetsPathConstants.jobUnSelectedPath,
//       'text': 'Vacancies',
//       'index': '4',
//       'selectedImage': AssetsPathConstants.jobSelectedPath,
//     },
//     // <String, dynamic>{
//     //   'image': 'assets/images/graph.png',
//     //   'text': 'Analytics',
//     //   'index': '6',
//     //   'selectedImage': AssetsPathConstants.dashboardImagePath,
//     // },
//     //
//     // <String, dynamic>{
//     //   'image': 'assets/images/calender.png',
//     //   'text': 'Calendar',
//     //   'index': '7',
//     //   'selectedImage': AssetsPathConstants.dashboardImagePath,
//     // },
//     // <String, dynamic>{
//     //   'image': 'assets/images/settings.png',
//     //   'text': 'Settings',
//     //   'index': '8',
//     //   'selectedImage': AssetsPathConstants.dashboardImagePath,
//     // },
//     <String, dynamic>{
//       'image': AssetsPathConstants.logoutImgPath,
//       'text': 'Logout',
//       'index': '6',
//       'selectedImage': AssetsPathConstants.logoutImgPath,
//     },
//   ];
//   final List<Map<String, dynamic>> _crewDrawerItems = <Map<String, dynamic>>[
//     <String, dynamic>{
//       'image': AssetsPathConstants.dashBoardIconPath,
//       'text': 'Dashboard',
//       'index': '0',
//       'selectedImage': AssetsPathConstants.dashboardImagePath,
//     },
//     <String, dynamic>{
//       'image': AssetsPathConstants.profileUnselectedImgPath,
//       'text': 'My Profile',
//       'index': '1',
//       'selectedImage': AssetsPathConstants.profileSelectedImgPath,
//     },
//     <String, dynamic>{
//       'image': AssetsPathConstants.jobsUnselectedImgPath,
//       'text': 'Find Vacancies',
//       'index': '2',
//       'selectedImage': AssetsPathConstants.jobsSelectedImgPath,
//     },
//     <String, dynamic>{
//       'image': AssetsPathConstants.offersUnselectedImgPath,
//       'text': 'Active Offer',
//       'index': '3',
//       'selectedImage': AssetsPathConstants.offersSelectedImgPath,
//     },
//     <String, dynamic>{
//       'image': AssetsPathConstants.logoutImgPath,
//       'text': 'Logout',
//       'index': '4',
//       'selectedImage': AssetsPathConstants.logoutImgPath,
//     },
//   ];

//   int jobSelectedIndex = -1;

//   @override
//   Widget build(BuildContext context) {
//     final GlobalProvider provider = Provider.of<GlobalProvider>(context);
//     int selectedIndex = provider.drawerCurrentIndex;
//     int selectedCrewPurserIndex = provider.drawerPurserCurrentIndex;
//     return Drawer(
//       backgroundColor: AppColors.backgroundPrimary,
//       child: Column(
//         children: <Widget>[
//           SizedBox(height: 30.h),
//           _buildHeader(),
//           RoleData.selectedRoleName == 'Owner'
//               ? Flexible(
//                 child: ListView(
//                   padding: const EdgeInsets.only(top: 20),
//                   children: <Widget>[
//                     for (int i = 0; i < 2; i++)
//                       _buildOwnerDrawerItem(
//                         _ownerDrawerItems[i],
//                         provider,
//                         i,
//                         selectedIndex,
//                       ),
//                     _buildExpandableMenu(
//                       provider: provider,
//                       selectedIndex: selectedIndex,
//                       heading: 'My Trips',
//                       index: 2,
//                       selectedImagePath:
//                           AssetsPathConstants.mytripSelectedIconImagePath,
//                       unselectedImagePath:
//                           AssetsPathConstants.mytripIconImagePath,
//                       itemList: provider.myTripsItems,
//                       isExpanded: _isMyTripsExpanded,
//                       onItemSelected: (int index) {
//                         provider.changeDrawerIndex(index);
//                       },
//                       onExpansionChanged: (bool expanded) {
//                         _isMyTripsExpanded = expanded;
//                         _isFinanceExpanded = false;
//                         _crewExpanded = false;
//                         if (expanded) {
//                           provider.changeDrawerIndex(2);
//                           provider.changeSubIndex('My Trips', 0);
//                           provider.updateOwnerPage(2);
//                           provider.changeIndex(2);
//                         }
//                       },
//                     ),
//                     _buildExpandableMenu(
//                       provider: provider,
//                       selectedIndex: selectedIndex,
//                       heading: 'Finance',
//                       index: 3,
//                       selectedImagePath:
//                           AssetsPathConstants.financeSelectedIconImagePath,
//                       unselectedImagePath:
//                           AssetsPathConstants.financeIconImagePath,
//                       itemList: provider.financeItems,
//                       isExpanded: _isFinanceExpanded,
//                       onItemSelected: (int index) {
//                         provider.changeDrawerIndex(index);
//                       },
//                       onExpansionChanged: (bool expanded) {
//                         _isFinanceExpanded = expanded;
//                         _isMyTripsExpanded = false;
//                         _crewExpanded = false;
//                         if (expanded) {
//                           provider.changeDrawerIndex(3);
//                           provider.changeSubIndex('Finance', 0);
//                           provider.updateOwnerPage(3);
//                           provider.changeIndex(3);
//                         }
//                       },
//                     ),
//                     _buildOwnerDrawerItem(
//                       _ownerDrawerItems[2],
//                       provider,
//                       4,
//                       selectedIndex,
//                     ),
//                     // _buildExpandableMenu(
//                     //   provider: provider,
//                     //   selectedIndex: selectedIndex,
//                     //   heading: 'Jobs',
//                     //   index: 4,
//                     //   selectedImagePath: AssetsPathConstants.jobUnSelectedPath,
//                     //   unselectedImagePath: AssetsPathConstants.jobSelectedPath,
//                     //   itemList: provider.myJobsItems,
//                     //   isExpanded: _isMyJobsExpanded,
//                     //   onItemSelected: (int index) {
//                     //     provider.changeDrawerIndex(index);
//                     //   },
//                     //   onExpansionChanged: (bool expanded) {
//                     //     _isMyJobsExpanded = expanded;
//                     //     _isFinanceExpanded = false;
//                     //     _isMyTripsExpanded = false;
//                     //     _crewExpanded = false;
//                     //     if (expanded) {
//                     //       provider.changeDrawerIndex(4);
//                     //     }
//                     //   },
//                     // ),
//                     _buildExpandableMenu(
//                       provider: provider,
//                       selectedIndex: selectedIndex,
//                       heading: 'Crew Planning',
//                       index: 5,
//                       selectedImagePath:
//                           AssetsPathConstants.crewSelectedImagePath,
//                       unselectedImagePath:
//                           AssetsPathConstants.crewUnselectedImagePath,
//                       itemList: provider.crewItems,
//                       isExpanded: _crewExpanded,
//                       onItemSelected: (int index) {
//                         provider.changeDrawerIndex(index);
//                       },
//                       onExpansionChanged: (bool expanded) {
//                         _crewExpanded = expanded;
//                         _isFinanceExpanded = false;
//                         _isMyTripsExpanded = false;
//                         if (expanded) {
//                           provider.changeDrawerIndex(5);
//                           provider.changeSubIndex('Crew Planning', 0);
//                           provider.updateOwnerPage(5);
//                           provider.changeIndex(5);
//                         }
//                       },
//                     ),
//                     for (int i = 3; i < _ownerDrawerItems.length; i++)
//                       _buildOwnerDrawerItem(
//                         _ownerDrawerItems[i],
//                         provider,
//                         i + 3,
//                         selectedIndex,
//                       ),
//                   ],
//                 ),
//               )
//               : RoleData.selectedRoleName == 'Crew'
//               ? Flexible(
//                 child: ListView.builder(
//                   padding: const EdgeInsets.only(top: 20),
//                   itemCount: _crewDrawerItems.length,
//                   itemBuilder:
//                       (BuildContext context, int index) => _buildCrewDrawerItem(
//                         _crewDrawerItems[index],
//                         provider,
//                         index,
//                         selectedIndex,
//                       ),
//                 ),
//               )
//               : Flexible(
//                 child: ListView(
//                   padding: const EdgeInsets.only(top: 20),
//                   children: <Widget>[
//                     _buildExpandableMenu(
//                       provider: provider,
//                       selectedIndex: selectedCrewPurserIndex,
//                       heading: 'Crew Planning',
//                       index: provider.drawerPurserCurrentIndex,
//                       selectedImagePath:
//                           AssetsPathConstants.crewSelectedImagePath,
//                       unselectedImagePath:
//                           AssetsPathConstants.crewUnselectedImagePath,
//                       itemList: provider.crewItems,
//                       isExpanded: _crewPurserExpanded,
//                       onItemSelected: (int index) {
//                         provider.changePurserDrawerIndex(index);
//                       },
//                       onExpansionChanged: (bool expanded) {
//                         _crewPurserExpanded = expanded;

//                         if (expanded) {
//                           provider.changePurserDrawerIndex(0);
//                           provider.changeSubIndex('Crew Planning', 0);
//                           provider.updateCrewPurserPage(5);
//                         }
//                       },
//                     ),
//                     for (int i = 3; i < _ownerDrawerItems.length; i++)
//                       _buildOwnerDrawerItem(
//                         _ownerDrawerItems[i],
//                         provider,
//                         i + 3,
//                         selectedIndex,
//                       ),
//                   ],
//                 ),
//               ),
//         ],
//       ),
//     );
//   }

//   void showModal(BuildContext context) {
//     customShowModalBottomSheet(
//       context: context,
//       inputWidget: Container(
//         padding: const EdgeInsets.all(16),
//         child: Consumer<GlobalProvider>(
//           builder: (BuildContext context, GlobalProvider dashBoardProvider, _) {
//             return Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: <Widget>[
//                 Text('Select an Item', style: sectionTitleInDetails),
//                 const SizedBox(height: 20),
//                 Wrap(
//                   runSpacing: 8,
//                   spacing: 8,
//                   children: List<Widget>.generate(
//                     UserController().allYachtDataModel.length,
//                     (int index) {
//                       final String? item =
//                           UserController().allYachtDataModel[index].vesselName;
//                       final bool isSelected =
//                           dashBoardProvider.selectedYachtIndex == index;
//                       return GestureDetector(
//                         onTap: () {
//                           dashBoardProvider.swicthSelectedYacht(
//                             index,
//                             widget.mainContext,
//                           );
//                           print(UserController().yachtId);
//                           Navigator.pop(context);
//                         },
//                         child: Container(
//                           alignment: Alignment.center,
//                           padding: const EdgeInsets.all(10),
//                           height: 48,
//                           decoration: BoxDecoration(
//                             color: AppColors.backgroundPrimary,
//                             border: Border.all(
//                               width: isSelected ? 2 : 1,
//                               color:
//                                   isSelected
//                                       ? AppColors.marinerBlue800
//                                       : Colors.grey.shade300,
//                             ),
//                             borderRadius: BorderRadius.circular(12),
//                           ),
//                           child: Text(
//                             item!,
//                             style: bodyText.copyWith(
//                               color:
//                                   isSelected
//                                       ? AppColors.marinerBlue800
//                                       : AppColors.commonFontColorPrimary,
//                               fontWeight:
//                                   isSelected
//                                       ? FontWeight.w600
//                                       : FontWeight.w500,
//                             ),
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 ),
//               ],
//             );
//           },
//         ),
//       ),
//     );
//   }

//   // header with profile image and
//   Widget _buildHeader() {
//     return Card(
//       color: AppColors.marinerBlue800,
//       margin: const EdgeInsets.all(12.0),
//       elevation: 4.0,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.0)),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           mainAxisSize: MainAxisSize.min,
//           children: <Widget>[
//             Row(
//               children: <Widget>[
//                 const CircleAvatar(
//                   radius: 30,
//                   backgroundImage: AssetImage(
//                     AssetsPathConstants.defaultProfilePicPath,
//                   ),
//                 ),
//                 const SizedBox(width: 12),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: <Widget>[
//                       Text(
//                         UserController().userName,
//                         style: titleH4.copyWith(
//                           color: AppColors.backgroundPrimary,
//                           fontSize: 18,
//                         ),
//                       ),
//                       Text(
//                         RoleData.selectedRoleName == 'Crew Purser'
//                             ? UserSettings().position
//                             : UserSettings().role,
//                         style: formLabelsSecondaryHeadings.copyWith(
//                           color: AppColors.backgroundPrimary,
//                           fontSize: 16,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//             if (RoleData.selectedRoleName == 'Owner' ||
//                 RoleData.selectedRoleName == 'Crew Purser')
//               Padding(
//                 padding: const EdgeInsets.only(top: 12.0),
//                 child: Consumer<GlobalProvider>(
//                   builder: (
//                     BuildContext context,
//                     GlobalProvider vesselProvider,
//                     Widget? child,
//                   ) {
//                     final bool hasYachts =
//                         UserController().allYachtDataModel.isNotEmpty;
//                     final String? label =
//                         hasYachts
//                             ? UserController()
//                                 .allYachtDataModel[vesselProvider
//                                     .selectedYachtIndex]
//                                 .vesselName
//                             : 'No Yacht';

//                     return InkWell(
//                       onTap: hasYachts ? () => showModal(context) : null,
//                       borderRadius: BorderRadius.circular(8.0),
//                       child: Container(
//                         padding: const EdgeInsets.symmetric(
//                           horizontal: 12.0,
//                           vertical: 8.0,
//                         ),
//                         decoration: BoxDecoration(
//                           color: AppColors.backgroundPrimary,
//                           borderRadius: BorderRadius.circular(8.0),
//                           border: Border.all(
//                             color: AppColors.backgroundPrimary,
//                           ),
//                         ),
//                         child: Row(
//                           mainAxisSize: MainAxisSize.min,
//                           children: <Widget>[
//                             SizedBox(
//                               height: 30,
//                               child: Image.asset(
//                                 AssetsPathConstants.myYachtSelectedImagePath,
//                                 color: AppColors.marinerBlue900,
//                               ),
//                             ),
//                             const SizedBox(width: 8),
//                             Text(
//                               label!,
//                               style: TextStyle(
//                                 color: hasYachts ? Colors.black : Colors.black,
//                                 fontWeight: FontWeight.w500,
//                               ),
//                             ),
//                             if (hasYachts)
//                               const Padding(
//                                 padding: EdgeInsets.only(left: 8.0),
//                                 child: Icon(
//                                   Icons.arrow_drop_down,
//                                   color: AppColors.marinerBlue800,
//                                 ),
//                               ),
//                           ],
//                         ),
//                       ),
//                     );
//                   },
//                 ),
//               ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildOwnerDrawerItem(
//     Map<String, dynamic> item,
//     GlobalProvider provider,
//     int index,
//     int selectedIndex,
//   ) {
//     final bool isSelected = selectedIndex == index;

//     return SizedBox(
//       width: 343,
//       height: 56,
//       child: Padding(
//         padding: const EdgeInsets.only(left: 16.0, right: 8),
//         child: ListTile(
//           leading: Image.asset(
//             isSelected ? item['selectedImage'] : item['image'],
//             width: 20,
//             color: isSelected ? AppColors.marinerBlue800 : Colors.black,
//           ),
//           title: Text(
//             item['text'],
//             style:
//                 isSelected
//                     ? formLabelsSecondaryHeadings.copyWith(
//                       color: AppColors.marinerBlue800,
//                       fontWeight: FontWeight.w700,
//                     )
//                     : formLabelsSecondaryHeadings.copyWith(color: Colors.black),
//           ),
//           tileColor: isSelected ? AppColors.marinerBlue100 : Colors.transparent,
//           shape:
//               isSelected
//                   ? const RoundedRectangleBorder(
//                     side: BorderSide(color: Colors.transparent, width: 3),
//                     borderRadius: BorderRadius.all(Radius.circular(20)),
//                   )
//                   : null,
//           onTap: () {
//             if (index == 6) {
//               customShowModalBottomSheet(
//                 context: context,
//                 inputWidget: CommonBottomSheet(
//                   negativeTxt: 'No',
//                   postiveTxt: 'Log Out',
//                   postiveBtnClr: AppColors.marinerBlue800,
//                   positiveOnPress: () async {
//                     PreferenceUtils.removeDataFromShared('userID');
//                     PreferenceUtils.removeDataFromShared('password');
//                     PreferenceUtils.removeDataFromShared(UserSettings().userID);
//                     UserController().dispose();
//                     UserSettings.userSettings.fromJson({});
//                     RestartWidget.restartApp(context);
//                   },
//                   negativePress: () {
//                     Navigator.of(context).pop(true);
//                   },
//                   title: 'Are you sure you want to log out?',
//                 ),
//               );
//             } else {
//               if (index == 4) {
//                 Navigator.of(context).pop();
//                 Navigator.of(widget.mainContext).push(
//                   CustomRoute<MaterialPageRoute<Widget>>(
//                     builder: (BuildContext context) => const MyJobScreen(),
//                   ),
//                 );
//               } else if (index < 5) {
//                 provider.changeDrawerIndex(index);
//                 provider.changeIndex(index);
//                 Navigator.of(context).pop();
//               }
//               provider.updateOwnerPage(index);
//               setState(() {
//                 _isFinanceExpanded = false;
//                 _isMyTripsExpanded = false;
//               });
//             }
//           },
//         ),
//       ),
//     );
//   }

//   Widget _buildExpandableMenu({
//     required GlobalProvider provider,
//     required int selectedIndex,
//     required int index,
//     required String selectedImagePath,
//     required String unselectedImagePath,
//     required String heading,
//     required bool isExpanded,
//     required List<Map<String, dynamic>> itemList,
//     Function(int)? onItemSelected,
//     required Function(bool) onExpansionChanged,
//   }) {
//     final bool isSelected = selectedIndex == index;

//     return Padding(
//       padding: const EdgeInsets.only(left: 16.0, right: 8),
//       child: Container(
//         width: 343,
//         decoration: BoxDecoration(
//           color: isSelected ? AppColors.marinerBlue100 : Colors.transparent,
//           borderRadius: BorderRadius.circular(20),
//         ),
//         child: Theme(
//           data: Theme.of(context).copyWith(
//             dividerColor: Colors.transparent, // Remove divider line
//           ),
//           child: ExpansionTile(
//             leading: Image.asset(
//               isSelected ? selectedImagePath : unselectedImagePath,
//               width: 20,
//               color: isSelected ? AppColors.marinerBlue800 : Colors.black,
//             ),
//             title: Text(
//               heading,
//               style:
//                   isSelected
//                       ? formLabelsSecondaryHeadings.copyWith(
//                         color: AppColors.marinerBlue800,
//                         fontWeight: FontWeight.w700,
//                       )
//                       : formLabelsSecondaryHeadings.copyWith(
//                         color: Colors.black,
//                       ),
//             ),
//             tilePadding: const EdgeInsets.only(left: 16, right: 8),
//             backgroundColor: Colors.transparent, // No background selection
//             collapsedBackgroundColor: Colors.transparent,
//             initiallyExpanded: isExpanded,
//             onExpansionChanged: (bool expanded) {
//               setState(() {
//                 onExpansionChanged(expanded);
//               });
//             },

//             childrenPadding: const EdgeInsets.only(left: 45),
//             shape:
//                 isSelected
//                     ? const RoundedRectangleBorder(
//                       side: BorderSide(color: Colors.transparent, width: 3),
//                       borderRadius: BorderRadius.all(Radius.circular(20)),
//                     )
//                     : null,
//             children: List<Widget>.generate(itemList.length, (int index) {
//               bool isSubItemSelected = false;
//               if (heading == 'Finance') {
//                 isSubItemSelected = provider.financeIndex == index;
//               } else if (heading == 'My Trips') {
//                 isSubItemSelected = provider.tripSubIndex == index;
//               } else if (heading == 'Crew Planning') {
//                 isSubItemSelected = provider.crewPurserSubIndex == index;
//               } else {
//                 isSubItemSelected = provider.crewSubIndex == index;
//               }

//               return ListTile(
//                 title: Row(
//                   children: <Widget>[
//                     Icon(
//                       Icons.circle_rounded,
//                       color:
//                           isSubItemSelected
//                               ? AppColors.marinerBlue800
//                               : AppColors.lightgrey,
//                       size: 10,
//                     ),
//                     Padding(
//                       padding: const EdgeInsets.only(left: 8.0),
//                       child: Text(
//                         itemList[index]['text'],
//                         style:
//                             isSubItemSelected
//                                 ? formLabelsSecondaryHeadings.copyWith(
//                                   color: AppColors.marinerBlue800,
//                                   fontWeight: FontWeight.w700,
//                                 )
//                                 : formLabelsSecondaryHeadings,
//                       ),
//                     ),
//                   ],
//                 ),
//                 onTap: () {
//                   Navigator.pop(context);
//                   if (index == 0) {
//                     if (RoleData.selectedRoleName == 'Crew Purser') {
//                       provider.changeSubIndex('Crew Planning', 0);
//                       provider.updateCrewPurserPage(5);
//                     } else {
//                       provider.changeSubIndex(heading, index);
//                       provider.updateOwnerPage(selectedIndex);
//                       provider.changeIndex(selectedIndex);
//                     }
//                   } else {
//                     Navigator.of(context).push(
//                       CustomRoute<MaterialPageRoute<Widget>>(
//                         builder:
//                             (BuildContext context) => itemList[index]['index'],
//                       ),
//                     );
//                   }
//                 },
//               );
//             }),
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _buildCrewDrawerItem(
//     Map<String, dynamic> item,
//     GlobalProvider provider,
//     int index,
//     int selectedIndex,
//   ) {
//     final bool isSelected = selectedIndex == index;

//     return SizedBox(
//       width: 343,
//       height: 56,
//       child: Padding(
//         padding: const EdgeInsets.only(left: 16.0, right: 8),
//         child: ListTile(
//           leading: Image.asset(
//             isSelected ? item['selectedImage'] : item['image'],
//             width: 24,
//             height: 24,
//             color: isSelected ? AppColors.marinerBlue800 : Colors.black,
//           ),
//           title: Text(
//             item['text'],
//             style:
//                 isSelected
//                     ? formLabelsSecondaryHeadings.copyWith(
//                       color: AppColors.marinerBlue800,
//                       fontWeight: FontWeight.w700,
//                     )
//                     : formLabelsSecondaryHeadings.copyWith(color: Colors.black),
//           ),
//           tileColor: isSelected ? AppColors.marinerBlue100 : Colors.transparent,
//           shape:
//               isSelected
//                   ? const RoundedRectangleBorder(
//                     side: BorderSide(color: Colors.transparent, width: 3),
//                     borderRadius: BorderRadius.all(Radius.circular(20)),
//                   )
//                   : null,
//           onTap: () {
//             if (index == 4) {
//               customShowModalBottomSheet(
//                 context: context,
//                 inputWidget: CommonBottomSheet(
//                   negativeTxt: 'No',
//                   postiveTxt: 'Log Out',
//                   postiveBtnClr: AppColors.marinerBlue800,
//                   positiveOnPress: () async {
//                     PreferenceUtils.removeDataFromShared('userID');
//                     PreferenceUtils.removeDataFromShared('password');
//                     PreferenceUtils.removeDataFromShared(UserSettings().userID);
//                     UserController().dispose();
//                     UserSettings.userSettings.fromJson({});
//                     RestartWidget.restartApp(context);
//                   },
//                   negativePress: () {
//                     Navigator.of(context).pop(true);
//                   },
//                   title: 'Are you sure you want to log out?',
//                 ),
//               );
//             } else {
//               provider.changeDrawerIndex(index);
//               provider.changeIndex(index);
//               provider.updateCrewPage(index);
//               Navigator.of(context).pop();
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
