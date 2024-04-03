// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:topsale/features/home/cubit/itinerary_cubit/itinerary_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../config/routes/app_routes.dart';
import '../../../core/models/shipment_model.dart';
import '../../../core/utils/app_assets.dart';
import '../../../core/utils/app_colors.dart';
//خط السير
class ItineraryTab extends StatefulWidget {
  const ItineraryTab({super.key});

  @override
  State<ItineraryTab> createState() => _ItineraryTabState();
}

class _ItineraryTabState extends State<ItineraryTab> {
  // LocationData? currentLocation ;
  // @override
  // void initState() {
  //   getCurrentLocation();
  //   super.initState();
  // }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ItineraryCubit, ItineraryState>(
  builder: (context, state) {
    ItineraryCubit cubit = context.read<ItineraryCubit>();
    return SafeArea(
      child: Scaffold(
        backgroundColor: AppColors.primary,
        body: Column(
          children: [
            SizedBox(height: 5),
            Row(
            //  mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(width: 10,),
                Container(
                decoration: const BoxDecoration(
                  shape:BoxShape.circle,

                ),

                child:Image.asset(AssetsManager.profile),),
                const SizedBox(width: 5,),
                Flexible(child: Text("اهلا, مصطفي خليل",style: Theme.of(context).textTheme.bodyMedium,)),],),
            Flexible(
                child: ListView.builder(
                  shrinkWrap: true,
              physics: const BouncingScrollPhysics(),
              itemCount: shipments.length,
              itemBuilder: (context, index) {
              return InkWell(
                onTap: () {
                  print("_______________________________________________________");
                  print(shipments[index].products?[0].code);
                  Navigator.pushNamed(context, Routes.itineraryDetailsRoute,arguments: shipments[index]);
                },
                child: Container(
                  alignment: Alignment.centerRight,
                  margin: EdgeInsets.all(12),
                  padding: EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.blue2,
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("${shipments[index].clientName}",style: Theme.of(context).textTheme.bodyMedium,),
                      SizedBox(height: 10,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("${shipments[index].address}",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            color: AppColors.yellow
                          ),),
                          Text("${shipments[index].dateTime.toString().substring(0,11)}",style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                              color: AppColors.yellow
                          ),),
                        ],
                      ),
                      const SizedBox(height: 10,),
                       Row(
                        children: [

                       InkWell(
                         onTap:(){
                           launch("tel://${shipments[index].clientPhoneNumber}");
                         },
                         child: const CircleAvatar(
                           radius: 15,
                           backgroundColor: AppColors.yellow,
                           child: Icon(Icons.call,color: AppColors.white,size: 20,),
                         ),
                       ),
                          const SizedBox(width: 20,),
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(context, Routes.googleMapRoute,arguments: LatLng(shipments[index].clientLat!,
                                  shipments[index].clientLng!));
                            },
                            child: const CircleAvatar(
                              radius: 15,
                              backgroundColor: AppColors.lightBlue,
                              child: Icon(Icons.location_on_outlined,color: AppColors.white,size: 20,),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10,),

                    ],
                  ),


                ),
              );
            },))
          ],
        ),
      ),
    );
  },
);
  }

  getCurrentLocation()async{
    Location location =await Location();
    location.getLocation().then((value) {
      // currentLocation=value;
    });

  }
}
