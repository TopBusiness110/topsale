import 'dart:io';

import 'package:easy_localization/easy_localization.dart' as easy;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:sizer/sizer.dart';
import 'package:topsale/core/models/shipment_model.dart';
import 'package:topsale/core/widgets/custom_button.dart';
import 'package:topsale/features/home/cubit/itinerary_cubit/itinerary_cubit.dart';
import 'package:topsale/features/itinerary_details/cubit/itinerary_details_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/utils/app_colors.dart';
import '../../../core/widgets/custom_arrow_back.dart';
import '../../../core/widgets/custom_textfield.dart';

class ItineraryDetailsScreen extends StatefulWidget {
  const ItineraryDetailsScreen({super.key});

  @override
  State<ItineraryDetailsScreen> createState() => _ItineraryDetailsScreenState();
}

class _ItineraryDetailsScreenState extends State<ItineraryDetailsScreen> {
  LocationData? currentLocation;
  @override
  void initState() {
    getCurrentLocation();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItineraryCubit, ItineraryState>(
      builder: (context, state) {
        ItineraryCubit cubit = context.read<ItineraryCubit>();
        return Scaffold(
          backgroundColor: AppColors.primary,
          body: cubit.getOrderDetailsModel == null ||
                  cubit.getPartnerLatLongModel == null
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Column(children: [
                  SizedBox(
                    height: 5.h,
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          "itinerary_details",
                          style: Theme.of(context).textTheme.displayLarge,
                        ).tr(),
                      ),
                      const Spacer(),
                      const CustomArrowBack()
                    ],
                  ),
                  Expanded(
                    child: Container(
                      margin: EdgeInsets.all(12),
                      decoration: BoxDecoration(
                          color: AppColors.blue2,
                          borderRadius: BorderRadius.circular(19)),
                      child: ListView.separated(
                          itemBuilder: (context, index) {
                            //when we clicked on client
                            return InkWell(
                              onTap: () {},
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          "${cubit.getOrderDetailsModel!.result![index].name ?? ''}",
                                          // "${widget.shipmentModel.clientName}",
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium,
                                        ),
                                        Text(
                                          //cubit.matches.isEmpty?
                                          "${cubit.getOrderDetailsModel!.result![index].productUomQty}",
                                          // "${ widget.shipmentModel.address}",
                                          textDirection: TextDirection.ltr,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodySmall,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (context, index) {
                            return Divider(
                              indent: 10,
                              endIndent: 10,
                              color: AppColors.white.withOpacity(0.7),
                              thickness: 1,
                            );
                          },
                          itemCount:
                              cubit.getOrderDetailsModel!.result!.length),
                    ),
                  ),
                  // SizedBox(height: 5,),
                  Container(
                      height: 200,
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          borderRadius: BorderRadius.circular(15)),
                      child: GoogleMap(
                        initialCameraPosition: CameraPosition(
                            target: LatLng(
                                cubit.getPartnerLatLongModel!.result![0]
                                        .partnerLatitude ??
                                    0.0,
                                cubit.getPartnerLatLongModel!.result![0]
                                        .partnerLongitude ??
                                    0.0),
                            zoom: 14.5),
                        markers: {
                          Marker(
                            markerId: MarkerId("client location"),
                            position: LatLng(
                                cubit.getPartnerLatLongModel!.result![0]
                                        .partnerLatitude ??
                                    0.0,
                                cubit.getPartnerLatLongModel!.result![0]
                                        .partnerLongitude ??
                                    0.0),
                          )
                        },
                      )
                      //Image.asset("assets/images/map.png"),
                      ),
                  SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(
                          fontSize: 14,
                          width: 30.w,
                          height: 4.5.h,
                          backgroundColor: AppColors.lightBlue,
                          textColor: AppColors.white,
                          text: "start_trip".tr(),
                          onPressed: () {
                            context
                                .read<ItineraryDetailsCubit>()
                                .startDateTime = DateTime.now();
                            if (currentLocation != null) {
                              context
                                      .read<ItineraryDetailsCubit>()
                                      .startLatLng =
                                  LatLng(currentLocation!.latitude!,
                                      currentLocation!.longitude!);
                            }
                            // openGoogleMapsRoute(widget.shipmentModel.clientLat!, widget.shipmentModel.clientLng!,currentLocation!.latitude!,currentLocation!.longitude!);
                            Navigator.pushNamed(
                                context, Routes.googleMapRoutingRoute,
                                arguments: LatLng(
                                    cubit.getPartnerLatLongModel!.result![0]
                                            .partnerLatitude ??
                                        0.0,
                                    cubit.getPartnerLatLongModel!.result![0]
                                            .partnerLongitude ??
                                        0.0));
                          }),
                      CustomButton(
                          fontSize: 14,
                          width: 30.w,
                          height: 4.5.h,
                          backgroundColor: AppColors.yellow,
                          textColor: AppColors.white,
                          text: "end_trip".tr(),
                          onPressed: () {
                            context.read<ItineraryDetailsCubit>().endDateTime =
                                DateTime.now();
                            if (currentLocation != null) {
                              context.read<ItineraryDetailsCubit>().endLatLng =
                                  LatLng(currentLocation!.latitude!,
                                      currentLocation!.longitude!);
                            }
                            showInformationDialog(context);
                          }),
                      CustomButton(
                          fontSize: 14,
                          width: 30.w,
                          height: 4.5.h,
                          backgroundColor: AppColors.red,
                          textColor: AppColors.white,
                          text: "cancel".tr(),
                          onPressed: () {
                            context
                                .read<ItineraryDetailsCubit>()
                                .cancelDateTime = DateTime.now();
                            if (currentLocation != null) {
                              context
                                      .read<ItineraryDetailsCubit>()
                                      .cancelLatLng =
                                  LatLng(currentLocation!.latitude!,
                                      currentLocation!.longitude!);
                            }
                            // cubit.photo = null;
                            showCancelPopUp(context);
                          })
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),
                ]),
        );
      },
    );
  }

  getCurrentLocation() {
    Location location = Location();
    location.getLocation().then((value) {
      currentLocation = value;
    });
  }

  void openGoogleMapsRoute(double originLat, double originLng,
      double destinationLat, double destinationLng) async {
    final url =
        'https://www.google.com/maps/dir/?api=1&origin=$originLat,$originLng&destination=$destinationLat,$destinationLng';

    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch Google Maps.';
    }
  }

  void showCancelPopUp(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return BlocBuilder<ItineraryDetailsCubit, ItineraryDetailsState>(
          builder: (context, state) {
            ItineraryDetailsCubit cubit = context.read<ItineraryDetailsCubit>();
            return Dialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              backgroundColor: AppColors.blue2,
              child: ListView(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 2.h,
                  ),
                  Center(
                      child: Text(
                    "cancel_trip".tr(),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.displayLarge,
                  ).tr()),
                  SizedBox(
                    height: 2.h,
                  ),
                  CustomTextField(
                      controller: cubit.reasonController,
                      title: "write_reason".tr(),
                      textInputType: TextInputType.text,
                      backgroundColor: AppColors.primary,
                      textColor: AppColors.white),
                  SizedBox(
                    height: 2.h,
                  ),
                  TextButton(
                    onPressed: () {
                      // Handle photo button press
                      // Take a photo or perform related actions

                      cubit.takePhoto();
                    },
                    child: Text(
                      'take_photo'.tr(),
                      style: TextStyle(color: Colors.amberAccent),
                    ),
                  ),
                  cubit.photo != null
                      ? Container(
                          width: 20.w,
                          child: Image.file(File(cubit.photo!.path)))
                      : SizedBox(),
                  Container(
                    margin:
                        EdgeInsets.symmetric(horizontal: 27.w, vertical: 10),
                    padding: const EdgeInsets.symmetric(vertical: 20),
                    child: CustomButton(
                        backgroundColor: AppColors.yellow,
                        height: 30,
                        width: 30,
                        textColor: AppColors.white,
                        text: "ok".tr(),
                        onPressed: () {
                          Navigator.pop(context);

                          //add the new contact to the contacts list
                        }),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  void showInformationDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return BlocBuilder<ItineraryDetailsCubit, ItineraryDetailsState>(
          builder: (context, state) {
            ItineraryDetailsCubit cubit = context.read<ItineraryDetailsCubit>();
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              backgroundColor: AppColors.white,
              actionsAlignment: MainAxisAlignment.spaceBetween,
              title: Center(
                child: Text(
                  "end_trip_info".tr(),
                  style: Theme.of(context).textTheme.displayLarge!.copyWith(
                        color: AppColors.lightBlue,
                      ),
                ),
              ),
              content: Text(
                "  تاريخ انهاء الرحلة ${cubit.endDateTime.toString().substring(0, 16)}  ",
                style: Theme.of(context)
                    .textTheme
                    .displayMedium!
                    .copyWith(color: AppColors.lightBlue, fontSize: 14),
              ),
              actions: [
                // ElevatedButton(
                //   onPressed: () {
                //     Navigator.pop(context);
                //
                //   },
                //   style: ElevatedButton.styleFrom(
                //     minimumSize: Size(28.w, 5.h),
                //     maximumSize: Size(30.w, 5.h),
                //     backgroundColor: AppColors.red,
                //   ),
                //   child: Text(
                //     "yes_delete".tr(),
                //     style: Theme.of(context).textTheme.bodySmall,
                //   ),
                // ),
                ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.lightBlue,
                    minimumSize: Size(28.w, 5.h),
                    maximumSize: Size(30.w, 5.h),
                  ),
                  child: Text(
                    "ok".tr(),
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }
}
