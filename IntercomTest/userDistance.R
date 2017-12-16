install.packages("jsonlite")
library("jsonlite")

#set the working directory
setwd("U:/IntercomTest") 

# Retrieving the user data stored in JSON format
data<-stream_in(file("gistfile1.txt"))

# Function to convert degree values to radian
deg2rad <- function(deg) return(deg*pi/180)

# Converting the user's latitude and longitude from degree to radian
data$latitude <- deg2rad(as.numeric(data$latitude))
data$longitude <- deg2rad(as.numeric(data$longitude))

# Function to calculate the geo distance between User's latitude/longitude and Dublin office 
# using Spherical Law of Cosines
distance <- function(usrLong, usrLat) {
  officeLong=deg2rad(-6.257664) #Longitude of Intercom's Dublin office
  officeLat<-deg2rad(53.339428) #Latitude of Intercom's Dublin office
  R <- 6371 # Mean radius of Earth
  dist <- acos(sin(usrLat)*sin(officeLat) + cos(usrLat)*cos(officeLat) * cos(officeLong-usrLong)) * R
  return(dist) # Returning distance in kms
}

# Adding column distance containing distance of the user from Intercom's Dublin office
data$distance<-distance(data$longitude, data$latitude)

# Selecting only the user_id and name of the customers who live within 100 kms from Intercom's Dublin office
data<-data[data$distance <= 100, c("user_id","name")] 

# Putting the data in ascending order of user id
data <-data[order(data$user_id),]

#Export the data into a CSV file
write.csv(data,file='usersWithin100kms.csv')
