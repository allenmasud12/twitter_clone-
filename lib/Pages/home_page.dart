import 'package:flutter/material.dart';
import 'package:twitter_app/data/datasource/tweet_datasource.dart';
import 'package:twitter_app/data/model/tweet_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController _nameTextEditingController = TextEditingController();
  TextEditingController _tweetTextEditingController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Twitter Clone APP", style: TextStyle(color: Colors.white),), 
        backgroundColor: Colors.blue ,
        centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(onPressed: (){
                    showModalBottomSheet(
                      context: context, 
                      builder: (context) => Container(
                        height: 400,
                        child: Column(
                          children: [
                                Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                          controller: _nameTextEditingController,
                                          decoration: InputDecoration(
                                          labelText: 'Name',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12.0),
                                          ),
                                          contentPadding: EdgeInsets.all(16.0),
                                          hintText: 'Type here',
                                          suffixIcon: Icon(Icons.text_fields),
                                        ),
                                      ),
                                ),
                             Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TextField(
                                          controller: _tweetTextEditingController,
                                          decoration: InputDecoration(
                                          labelText: 'Tweets',
                                          border: OutlineInputBorder(
                                            borderRadius: BorderRadius.circular(12.0),
                                          ),
                                          contentPadding: EdgeInsets.all(16.0),
                                          hintText: 'Type here',
                                          suffixIcon: Icon(Icons.text_fields),
                                        ),
                                      ),
                                ),
                            ElevatedButton(onPressed: () async {
                              String name = _nameTextEditingController.text;
                              String tweet = _tweetTextEditingController.text;
                               await TweetDatasource.postTweet(TweetModel(auther: name, body: tweet));
                              Navigator.pop(context);
                              print("post button working");
                            }, child: Text("Post") )
                        ]),
                      )
                    );
                    }, child: Text("Add Tweet")),
                  ),
                   Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(onPressed: (){
                    print("Refresh Button Working");
                    setState((){});
                    }, child: Text("Refresh")),
                  ),
                ],
              ),
            ),
            Expanded(
              flex: 10,
              child: FutureBuilder(
                future: TweetDatasource.getAllTweets(),
                builder: (BuildContext context, AsyncSnapshot snapshot){
                  if(snapshot.hasError){
                    return Center(child: Text("Error! ${snapshot.error}"));
                  }
                  if(snapshot.hasData){
                    List<TweetModel> tweets = snapshot.data;
                    return ListView.builder(
                      itemCount: tweets.length,
                      itemBuilder: (BuildContext context, index ) => ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSXUv6ZrOiS4QQaWCBlsw2zbj64_mcv8Bk-ZCLwDSWLznS_Iu2bxfnet_eaChBoikcPoCc&usqp=CAU"),
                        ),
                        title: Text("${tweets[index].auther}"),
                        subtitle: Text("${tweets[index].body}"),
                      )
                     );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ),
          ],
        ),
      // body: ListView.builder(
      //   itemCount: 20,
      //   itemBuilder: (BuildContext context, index) => const ListTile(
      //     leading: CircleAvatar(
      //       backgroundImage: NetworkImage("https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSXUv6ZrOiS4QQaWCBlsw2zbj64_mcv8Bk-ZCLwDSWLznS_Iu2bxfnet_eaChBoikcPoCc&usqp=CAU"),
      //       ),
      //     title: Column(
      //       crossAxisAlignment: CrossAxisAlignment.start,
      //       children: [
      //         Text("null user",style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),),
      //         Text("2023-12-29T16:32:30.434Z", style: TextStyle(fontSize: 14),)
      //       ],
      //     ),
      //     subtitle: Text("simply dummy text of the printing and typesetting industry."),
      //   ) 
      //   ) ,
      //   floatingActionButton: FloatingActionButton(
      //   backgroundColor: Colors.yellow,
      //   child: const Icon(Icons.home),
      //   onPressed:  () {
      //    TweetDatasource.getAllTweets();
      //   },
      // ),
    );
  }
}