import 'package:flutter/material.dart';
import 'model/vacancy.dart';

class VacancyDetails extends StatelessWidget {
  final Vacancy vacancy;

  VacancyDetails({required this.vacancy});

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xff0072bc)),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          vacancy.title,
          style: TextStyle(
            color: Color(0xff0072bc),
            fontSize: screenHeight * 0.022,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: screenHeight * 0.02, bottom: screenHeight * 0.01, top: screenHeight * 0.01),
            child: Image.asset('assets/Unlogosmall.png'),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(screenHeight * 0.02),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: screenWidth * 0.7,
                  height: screenHeight * 0.22,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15), // Rounded corners
                    image: DecorationImage(
                      image: NetworkImage(vacancy.imageURL),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Job ID: ${vacancy.jobId}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Title: ${vacancy.title}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Company: ${vacancy.company}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Location: ${vacancy.location}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Salary: ${vacancy.salary}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 8),
            Text(
              'Date Posted: ${vacancy.datePosted}',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: screenHeight * 0.02),
            Text(
              'Description:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              vacancy.description,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 16),
            Text(
              'Long Description:',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Text(
              vacancy.longDescription,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
