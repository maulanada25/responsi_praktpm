import 'package:flutter/material.dart';
import 'package:responsi_praktpm/api.dart';
import 'model_matchdet.dart';

class MatchDetails extends StatefulWidget {
  final name;
  const MatchDetails({ Key? key, required this.name}) : super(key: key);

  @override
  State<MatchDetails> createState() => _MatchDetailsState();
}

class _MatchDetailsState extends State<MatchDetails> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(child: Scaffold(
      appBar: AppBar(
        title: Text("Match ID : " + widget.name),
      ),
      body: _buildDetailedMatchBody(widget.name),
    ));
  }
}

Widget _buildDetailedMatchBody(String name){
  return Container(
    child: FutureBuilder(
      future: ApiDataSource.instance.loadMatchDetails(name),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.hasError){
          return _buildErrorSection();
        }if(snapshot.hasData){
          DetailMatchesModel matchDetails = DetailMatchesModel.fromJson(snapshot.data);
          return _buildSuccessSection(context, matchDetails);
        }
        return _buildLoadingSection();
    },),
  );
}

Widget _buildSuccessSection(BuildContext context, DetailMatchesModel match){
  return SingleChildScrollView(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Row(
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
        Text("Stadium : "+ match.stageName!),
        Text("Location : "+ match.location!),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: 300,
            decoration: BoxDecoration(
              border: Border.all()
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Statistics", style: TextStyle(fontSize: 30), ),
                Text("Ball Possession"),
                Row(
                  children: [
                    
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    ),
  );
}

Widget _buildDetailedItem(){
  return Container(

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