# Route-Search
A Flutter application that lets you test custom searches using the A* algorithm. Create stations, adjust the weights of the heuristics and see how the route is explored and traced!

## Description
This project is the result of two different assignments in my 3rd year of college: Mobile Development (SI700) and Introduction to Artificial Intelligence (SI702). In this application, you can create and edit train stations, setting their name, coordinates, line number and connections to other stations. The main feature is to search for the best route that matches your preferences, which are defined by weights for:
- shortest distance (euclidean distance);
- line changes;
- shorter travel time.

The stations are drawn as a graph. Colored lines mean the connected nodes (stations) belong to the same line. The line that represents the connection can also be thicker (fast connection) or thinner (normal connection). Fast connections take less time to travel on.

# Screenshots
![gh1](https://github.com/SantanaCosta/Route-Search/assets/106698124/1e5f66a4-7733-4d83-ad27-9aba10c29b33)

![gh2](https://github.com/SantanaCosta/Route-Search/assets/106698124/d455daa3-67aa-4ce3-b041-79aa08742f50)
