

# Journey

 - This is a sample project implementing Swift and Objective-C
   interoperability with necessary Unit testing.  
   
 - MVVW pattern is used so that the view models can be ideal tested separately.  
 
 - This project is about getting random coordinates from Rest API and display them on the list view and map view. I use car related information as sample data. 
 - There are two pages: Car list and Mapview.

# Car List Page (Swift)
There are three main processes on this page. 
1. Get 30 random points from **internal rest API**. (NodeJS hosted on zeit.co as Lambdas execution) .
2. Get 30 car detail from **local JSON file** (carlist.json).
3. Get 30 different addresses following coordinates from (1) by using **Google Map API**. 
After getting all the information, combine and display them on a list. 

![alt text](https://github.com/sronglongchhem/Journey/blob/master/Design/Screenshot/first_page.png?raw=true "Car List Page")


## Map View Page (Objective-C)
This page contains two processes.
1. Get map bound (South East and North West) from Map view.
2. Get 30 random points from rest API base on a map bound and display them on the map.
* Each time map view finish moving, it requests new 30 random points.


![alt text](https://github.com/sronglongchhem/Journey/blob/master/Design/Screenshot/second_page.png?raw=true "Map View Page")

<!--stackedit_data:
eyJoaXN0b3J5IjpbMTAxNjA3OTMwOV19
-->