# UNHCR Vacancy Flutter

This is a Flutter mobile application developed for the UNHCR contractor position screen assessment. The application consists of two screens:

- **Vacancy List Screen**: Displays a list of job vacancies fetched from an API.
- **Vacancy Details Screen**: Shows detailed information about a selected job vacancy.

## Features

- **Vacancy List Screen**:
  - Fetches data from [UNHCR Job API](https://www.unhcrjo.org/jobs/api).
  - Displays each vacancy's title, company, description, date posted, and a thumbnail image.
  - Allows navigation to the Vacancy Details Screen when a vacancy is selected.

- **Vacancy Details Screen**:
  - Displays detailed information about the selected vacancy, including job ID, title, company, location, description, long description, salary, date posted, and a thumbnail image.

## Video Demo

You can view a demo of the application in action via the video link below:
[Video Demo](https://youtu.be/6e2pmuPBWhU)


## API Content
For testing purposes, you can use the sample JSON data below, which mirrors the structure of the API response:
[
  {
    "job_id": "6",
    "title": "HR Manager",
    "company": "People First Inc.",
    "location": "Boston, MA",
    "description": "Oversee HR operations and manage employee relations.",
    "long_description": "As an HR Manager at People First Inc., you will oversee all HR operations...",
    "salary": "$75,000 - $95,000",
    "date_posted": "2024-09-11",
    "image_url": "https://www.unhcrjo.org/img/jobs/hr_manager.jfif"
  },
  ...
]

*Note: This data is for local testing only. The actual application fetches data from the API endpoint.*

## Error Handling
The application handles API errors gracefully by displaying appropriate messages to the user. A retry button allows users to attempt fetching the data again.



