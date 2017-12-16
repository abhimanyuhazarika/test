library(Imap)

#Test for deg2rad conversion
test_that("Test deg2rad(15)",{
  expect_equal(deg2rad(15), 0.2617994)
})

#Test for function distance
test_that("Test distance(-0.1335856,0.9256887)",{
  #get the distance from distance() function in userDistance.R for longitude=-0.1335856, latitude=0.9256887
  dist<-distance(-0.1335856,0.9256887)
  #get the geodesic distance between Intercom's Dublin office and longitude=-0.1335856, latitude=0.9256887
  #using Vincenty inverse formula for ellipsoids
  gmapDist <- gdist(lon.1 = -6.257664, 
                     lat.1 = 53.339428, 
                     lon.2 = -7.653889, 
                     lat.2 = 53.038056, 
                     units = "km")
  #used tolerance of 1e-2 between the two calculations
  expect_equal(dist, gmapDist,tolerance=1e-2)
})


