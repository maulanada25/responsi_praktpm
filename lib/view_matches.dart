import 'package:flutter/material.dart';
import 'package:responsi_praktpm/api.dart';
import 'package:responsi_praktpm/model_matches.dart';

import 'view_match_details.dart';
// import 'package:responsi_praktpm/view_match_details.dart';

class HomePage extends StatefulWidget {
  const HomePage({ Key? key }) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  // BoxDecoration flags = BoxDecoration(
  // );

  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text("Piala Dunia 2022"),
      ),
      body: Container(
        child: _buildMatchesBody(context),
      ),
    ));
  }
}

Widget _buildMatchesBody(BuildContext context){
  return Container(
    child: FutureBuilder(
      future: ApiDataSource.instance.loadMatches(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot){
        if(snapshot.hasError){
          print(snapshot.error);
          return _buildErrorSection();
        }if(snapshot.hasData){
          // MatchesModel matches = MatchesModel.fromJson(snapshot.data);
          return _buildSuccessSection(context, snapshot.data);
        }
        return _buildLoadingSection();
      }
    ),
  );
}

_buildSuccessSection(BuildContext context, List<dynamic> data){
  return Container(
    child: ListView.builder(
      itemCount: data.length,
      itemBuilder: (BuildContext context, index) {
        MatchesModel matches = MatchesModel.fromJson(data[index]);
        return _buildMatchesitem(context, matches);
    },),
  );
}

Widget _buildMatchesitem(BuildContext context, MatchesModel match){
  // print("https://flagcdn.com/256x192/"+ match.homeTeam!.country!.substring(0,2).toLowerCase());
  // return Text("asfasf");
  return InkWell(
    onTap: () {
      Navigator.push(context, MaterialPageRoute(builder: (context) => MatchDetails(name: match.id,),));
    },child: Column(
      children: [
        Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Image.network("https://flagcdn.com/256x192/"+ match.homeTeam!.country!.substring(0,2).toLowerCase() +".png",width: 100, 
                    errorBuilder: (context, error, stackTrace) => Icon(Icons.error, size: 100,),
                  ),
                  Text(match.homeTeam!.name!)
                ],
              ),
              SizedBox(width: 50,),
              Text(match.homeTeam!.goals!.toString() + " - " + match.awayTeam!.goals!.toString()),
              SizedBox(width: 50,),
              Column(
                children: [
                  Image.network("https://flagcdn.com/256x192/"+ match.awayTeam!.country!.substring(0,2).toLowerCase() +".png",width: 100, 
                    errorBuilder: (context, error, stackTrace) => Icon(Icons.error, size: 100, ),
                  ),
                  Text(match.awayTeam!.name!)
                ],
              )
            ]
          ),
        ),
        Container(
          height: 20,
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.2)
          ),
        )
      ],
    ),
  );
}

Widget _buildErrorSection(){
  return Container(
    child: Text("Ada Error nih"),
  );
}

Widget _buildLoadingSection(){
  return CircularProgressIndicator();
}