import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'model/vacancy.dart';
import 'vacancy_details.dart';  // Import the new details screen

class VacancyList extends StatefulWidget {
  VacancyList({super.key});

  @override
  State<VacancyList> createState() => _VacancyListState();
}

class _VacancyListState extends State<VacancyList> {
  List<Vacancy> vacancies = [];

  Future<List<Vacancy>> getData() async {
    try {
      var response = await http.get(Uri.https('unhcrjo.org', 'jobs/api'));

      // Check if the response is OK (status code 200)
      if (response.statusCode == 200) {
        var jsonData = jsonDecode(response.body);

        vacancies.clear(); // Clear previous data

        for (var eachVacancy in jsonData) {
          final vacancy = Vacancy(
            jobId: eachVacancy["job_id"],
            title: eachVacancy["title"],
            company: eachVacancy["company"],
            location: eachVacancy["location"],
            description: eachVacancy["description"],
            longDescription: eachVacancy["long_description"],
            salary: eachVacancy["salary"],
            datePosted: eachVacancy["date_posted"],
            imageURL: eachVacancy["image_url"],
          );
          vacancies.add(vacancy);
        }

        return vacancies;
      } else {
        // Handle non-200 responses
        throw Exception('Failed to load vacancies: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Failed to connect to the server. Please check your internet connection and try again.');
    }
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Vacancy List",
          style: TextStyle(
            color: Color(0xff0072bc),
            fontSize: screenHeight * 0.04,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding:  EdgeInsets.only(right: screenHeight*0.02, bottom: screenHeight*0.01,top: screenHeight*0.01),
            child: Image.asset('assets/Unlogosmall.png'),
          ),
        ],
      ),
      body: Padding(
        padding:  EdgeInsets.all(screenHeight*0.008),
        child: FutureBuilder<List<Vacancy>>(
          future: getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              Icons.wifi_off, // WiFi connection problem icon
                              size: 50,
                              color: Colors.red,
                            ),
                            SizedBox(height: 10),
                            Text(
                              'Error: ${snapshot.error}',
                              textAlign: TextAlign.center,
                              style: TextStyle(fontSize: 18, color: Colors.red),
                            ),
                            SizedBox(height: 10),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  getData();
                                });
                              },
                              child: Text('Retry'),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );

            } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
              return Center(
                child: Text('No vacancies available at the moment'),
              );
            } else {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  var vacancy = snapshot.data![index];
                  return Padding(
                    padding: const EdgeInsets.all(10),
                    child: Material(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(20),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => VacancyDetails(vacancy: vacancy),
                            ),
                          );
                        },
                        splashColor: Colors.blue.withOpacity(0.2),
                        highlightColor: Colors.blue.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(20),
                        child: Card(
                          elevation: 4.0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Container(
                                      width: screenHeight*0.13,
                                      height: screenHeight*0.1,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        image: DecorationImage(
                                          image: NetworkImage(vacancy.imageURL),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 16.0),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            vacancy.title,
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Text(
                                            vacancy.company,
                                            style: TextStyle(
                                              fontSize: 18.0,
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                          SizedBox(height: 4),
                                          Row(
                                            children: [
                                              Icon(Icons.location_on_outlined),
                                              SizedBox(width: 2,),
                                              Text(
                                                vacancy.location,
                                                style: TextStyle(
                                                  fontSize: 14.0,
                                                  color: Colors.grey[600],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 16.0),
                                Text(
                                  vacancy.description,
                                  style: TextStyle(
                                    fontSize: 16.0,
                                    color: Colors.grey[700],
                                  ),
                                  maxLines: 8,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                SizedBox(height: 16.0),
                                Align(
                                  alignment: Alignment.bottomRight,
                                  child: Text(
                                    "Posted on ${vacancy.datePosted}",
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      color: Colors.grey[600],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          },
        ),
      ),
    );
  }
}
