# Route-Search
A Flutter application that lets you test custom searches using the A* algorithm. Create stations, adjust the weights of the heuristics and see how the route is explored and traced!

## Description
This project is the result of two different assignments in my 3rd year of college: Mobile Development (SI700) and Introduction to Artificial Intelligence (SI702). In this application, you can create and edit train stations, setting their name, coordinates, line number and connections to other stations. The main feature is to search for the best route that matches your preferences, which are defined by weights for:
- shortest distance (euclidean distance);
- line changes;
- shorter travel time.

The stations are drawn as a graph. Colored lines mean the connected nodes (stations) belong to the same line. The line that represents the connection can also be thicker (fast connection) or thinner (normal connection). Fast connections take less time to travel on.

## Features
- The application uses the REST architectural style to perform operations on the Firebase Realtime Database, where the stations data are stored.
- It also uses bloc to monitor the database and manage the state of the application.
- This project uses Firebase Auth for login functionality. Only logged users can manage the stations, adding, editing or deleting them as they wish.
- The app allows you to test custom searches using the A* algorithm. You can adjust the weights of the heuristics and see how the route is explored and traced on the screen.
- This project has a user-friendly interface that lets you create and edit train stations, setting their name, coordinates, line number and connections to other stations. The stations are drawn as a graph.

# Screenshots
![gh1](https://github.com/SantanaCosta/Route-Search/assets/106698124/1e5f66a4-7733-4d83-ad27-9aba10c29b33)

![gh2](https://github.com/SantanaCosta/Route-Search/assets/106698124/d455daa3-67aa-4ce3-b041-79aa08742f50)
