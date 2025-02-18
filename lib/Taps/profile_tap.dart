import 'package:flutter/material.dart';
import 'package:movies/Model/profile_response.dart';
import 'package:movies/Model/watchlist_response.dart';
import 'package:movies/Model/watchlist_response.dart' as watchlistModel;
import 'package:movies/Provider/history_provider.dart';
import 'package:movies/Taps/profile_update_screen.dart';
import 'package:movies/movie_card.dart';
import 'package:movies/profile_manager.dart';
import 'package:provider/provider.dart';
import 'dart:io';
import 'package:flutter/services.dart';


class ProfileScreen extends StatefulWidget {
  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  bool isWatchListSelected = true;


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
  }


  @override
  void initState() {
    super.initState();
    profileManager.getWatchList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Column(
        children: [
          _buildProfileHeader(),
          Expanded(child: _buildMovieList()),
        ],
      ),
    );
  }

  Widget _buildProfileHeader() {
    return Container(
      padding: EdgeInsets.all(16.0),
      color: Color(0XFF212121),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                children: [
                  FutureBuilder<profileResponse?>(
                    future: profileManager.getProfile(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                            child: Text("Error loading profile",
                                style: TextStyle(color: Colors.white)));
                      }
                      if (snapshot.hasData && snapshot.data?.data != null) {
                        int avatarId = snapshot.data!.data!.avaterId ?? 1;
                        return CircleAvatar(
                          radius: 50,
                          backgroundColor: Colors.blue,
                          backgroundImage: AssetImage(
                              "assets/images/gamer${avatarId + 1}.png"),
                        );
                      }
                      return Center(
                          child: Text("No data available",
                              style: TextStyle(color: Colors.white)));
                    },
                  ),
                  SizedBox(height: 8),
                  FutureBuilder<profileResponse?>(
                    future: profileManager.getProfile(),
                    builder: (context, snapshot) {
                      if (snapshot.hasError) {
                        return Center(
                            child: Text("Error loading profile",
                                style: TextStyle(color: Colors.white)));
                      }
                      if (snapshot.hasData && snapshot.data?.data != null) {
                        String username = snapshot.data!.data!.name ?? "Guest";
                        return Text("$username",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.w700));
                      }
                      return Center(
                          child: Text("No data available",
                              style: TextStyle(color: Colors.white)));
                    },
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  FutureBuilder<watchListResponse>(
                    future: profileManager.getWatchList(), // Call your function here
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Text("...");
                      } else if (snapshot.hasError){
                        return Text("Error");
                      }else if (snapshot.hasData) {
                        List<watchlistModel.Data>? watchlist = snapshot.data?.data;
                        print("${watchlist?.length}");
                        return Text("${watchlist?.length}" ,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 36,
                              fontWeight: FontWeight.w700),);
                      } else {
                        return Text("0");
                      }
                    },
                  ),
                  SizedBox(height: 8),
                  Text("Wish List",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.w700)),
                ],
              ),
              SizedBox(width: 10),
              Consumer<HistoryManager>(
                builder: (context, historyManager, child) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "${historyManager.history.length}", // Use history length
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 36,
                            fontWeight: FontWeight.w700),
                      ),
                      SizedBox(height: 8),
                      Text("History",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.w700)),
                    ],
                  );
                },
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0XFFF6BD00),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // Border radius
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24), // Text padding
                  ),
                  onPressed: () async {
                    // Navigator.pushNamed(context,UpdateProfileScreen.routName );
                    bool? updated = await Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => UpdateProfileScreen()),
                    );

                    if (updated == true) {
                      setState(() {
                        print(
                            "Refreshing profile after update..."); // Debugging
                      });
                    }
                  },
                  child: Text("Edit Profile",
                      style: TextStyle(color: Colors.black, fontSize: 20)),
                ),
              ),
              SizedBox(width: 10),
              Expanded(
                flex: 1,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0XFFE82626),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15), // Border radius
                    ),
                    padding: EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24), // Text padding
                  ),
                  onPressed: () {
                    if (Platform.isAndroid) {
                      SystemNavigator.pop(); // For Android
                    }
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Exit",
                          style: TextStyle(color: Colors.white, fontSize: 20)),
                      SizedBox(
                        width: 10,
                      ),
                      Icon(Icons.exit_to_app, color: Colors.white),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildToggleButton("Watch List", true, Icons.folder),
              _buildToggleButton("History", false, Icons.history),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton(String label, bool isSelected, IconData icon) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isWatchListSelected = isSelected;
          // fetchMovies();
        });
      },
      child: Column(
        children: [
          Icon(icon,
              color: isWatchListSelected == isSelected
                  ? Color(0XFFF6BD00)
                  : Colors.white),
          Text(label,
              style: TextStyle(
                  color: isWatchListSelected == isSelected
                      ? Color(0XFFF6BD00)
                      : Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w700)),
          Container(
            height: 3,
            width: 80,
            color: isWatchListSelected == isSelected
                ? Color(0XFFF6BD00)
                : Colors.transparent,
          )
        ],
      ),
    );
  }

  Widget _buildMovieList() {
    return isWatchListSelected ? _buildWatchListView() : _buildHistoryView();
  }

  Widget _buildHistoryView() {
    return Consumer<HistoryManager>(
      builder: (context, historyManager, child) {
        return GridView.builder(
          padding: EdgeInsets.all(8.0),
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            childAspectRatio: 0.7,
            crossAxisSpacing: 8.0,
            mainAxisSpacing: 8.0,
          ),
          itemCount: historyManager.history.length,
          itemBuilder: (context, index) {
            final movie = historyManager.history[index];

            return MovieCard(
              title: movie.title,
              imagePath: movie.imagePath,
              rating: movie.rating,
              movieId: movie.id,
            );
          },
        );
      },
    );
  }

  Widget _buildWatchListView() {
    return FutureBuilder<watchListResponse>(
      future: profileManager.getWatchList(),
      builder: (context, snapshot) {
        print("Snapshot: ${snapshot.toString()}");
        // print("FutureBuilder Triggered: ${snapshot.connectionState}");
        // print("Has Data: ${snapshot.hasData}");
        // print("Error: ${snapshot.error}");

        // if (snapshot.connectionState == ConnectionState.waiting) {
        //   return const Center(child: CircularProgressIndicator());
        // } else if (snapshot.hasError) {
        //   return Center(child: Text("Error: ${snapshot.error}", style: TextStyle(color: Colors.white)));
        // }

        final watchlist = snapshot.data?.data;
        print("Snapshot Data: $watchlist");

        if (watchlist == null) {
          return Center(child: Image.asset("assets/images/empty.png"));
        }

        return GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 2 / 3,
          ),
          itemCount: watchlist!.length,
          itemBuilder: (context, index) {
            return MovieCard(
              title: watchlist[index].name!,
              imagePath: watchlist[index].imageURL!,
              rating: watchlist[index].rating!,
              movieId: watchlist[index].movieId!,
            );
          },
        );
      },

      // ),
    );
  }
}
