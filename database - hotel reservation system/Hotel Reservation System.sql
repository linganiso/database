DROP SCHEMA IF EXISTS `reservation`; 
CREATE SCHEMA `reservation`; 
USE `reservation`;

CREATE TABLE `position` (
  `userType_id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `userType` varchar(255) NOT NULL DEFAULT 'guest'
);

CREATE TABLE `owner` (
  `owner_id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `userType_id` int(11) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `id_No` varchar(35) NOT NULL UNIQUE,
  `phone_no` int(11) NOT NULL,
  `email` varchar(255) NOT NULL UNIQUE,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
   FOREIGN KEY (`userType_id`) REFERENCES `position` (`userType_id`)
);

CREATE TABLE `hotel` (
  `hotel_id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `userType_id` int(11) NOT NULL,
  `owner_id` int(11) NOT NULL,
  `hotel_name` varchar(191) NOT NULL,
  `location` varchar(191) NOT NULL,
  `logo` varchar(35) NOT NULL,
  `phoneNo` varchar(35) NOT NULL,
  `email` varchar(255) NOT NULL UNIQUE,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
   FOREIGN KEY (`userType_id`) REFERENCES `position` (`userType_id`),
   FOREIGN KEY (`owner_id`) REFERENCES `owner` (`owner_id`)
);

CREATE TABLE `admin` (
  `admin_id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `userType_id` int(11) NOT NULL,
  `hotel_id` int(11) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `gender` varchar(255) NOT NULL,
  `dob` date NOT NULL,
  `id_no` varchar(255) NOT NULL UNIQUE,
  `email` varchar(255) NOT NULL UNIQUE,
  `phone_no` int(11) NOT NULL,
  `location` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'active',
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
   FOREIGN KEY (`userType_id`) REFERENCES `position` (`userType_id`),
   FOREIGN KEY (`hotel_id`) REFERENCES `hotel` (`hotel_id`)
);

CREATE TABLE `stuff` (
  `stuff_id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `userType_id` int(11) NOT NULL,
  `admin_id` int(11) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `gender` varchar(255) NOT NULL,
  `dob` date NOT NULL,
  `id_no` varchar(255) NOT NULL UNIQUE,
  `email` varchar(255) NOT NULL UNIQUE,
  `phone_no` int(11) NOT NULL,
  `location` varchar(255) NOT NULL,
  `status` varchar(255) NOT NULL DEFAULT 'active',
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
   FOREIGN KEY (`userType_id`) REFERENCES `position` (`userType_id`),
   FOREIGN KEY (`admin_id`) REFERENCES `admin` (`admin_id`)
);

CREATE TABLE `room` (
  `room_id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `admin_id` int(11) NOT NULL,    
  `room_name` varchar(191) NOT NULL,
  `room_no` varchar(191) NOT NULL,
  `adults` int(11) NOT NULL,
  `children` int(11) NOT NULL,
  `room_price` double NOT NULL,
  `room_quantity` int(11) NOT NULL,
  `room_status` varchar(191) NOT NULL DEFAULT 'active',
  `image1` varchar(35) NOT NULL,
  `image2` varchar(35) NOT NULL,
  `image3` varchar(35) NOT NULL,
  `image4` varchar(35) NOT NULL,
  `image5` varchar(35) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
   FOREIGN KEY (`admin_id`) REFERENCES `admin` (`admin_id`)
);

CREATE TABLE `features` (
  `features_id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `admin_id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `features_name` varchar(191) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
   FOREIGN KEY (`admin_id`) REFERENCES `admin` (`admin_id`),
   FOREIGN KEY (`room_id`) REFERENCES `room` (`room_id`)    
);

CREATE TABLE `facilities` (
  `facility_id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `admin_id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,    
  `facility_name` varchar(191) NOT NULL,
  `facility_desc` varchar(191) NOT NULL,
  `facility_image` varchar(191) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
   FOREIGN KEY (`admin_id`) REFERENCES `admin` (`admin_id`),
   FOREIGN KEY (`room_id`) REFERENCES `room` (`room_id`)        
);

CREATE TABLE `booking` (
  `booking_id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `hotel_id` int(11) NOT NULL,
  `room_id` int(11) NOT NULL,
  `arrival_date` date NOT NULL,
  `departure_date` date NOT NULL,
  `numOfAdults` varchar(35) NOT NULL,
  `numOfChildren` varchar(35) NOT NULL,
  `booked_date` timestamp NOT NULL DEFAULT current_timestamp(),
   FOREIGN KEY (`hotel_id`) REFERENCES `hotel` (`hotel_id`),
   FOREIGN KEY (`room_id`) REFERENCES `room` (`room_id`)        
);

CREATE TABLE `guest` (
  `guest_id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `userType_id` int(11) NOT NULL,
  `booking_id` int(11) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `gender` varchar(255) NOT NULL,
  `dob` date NOT NULL,
  `id_no` varchar(255) NOT NULL UNIQUE,
  `email` varchar(255) NOT NULL UNIQUE,
  `phone_no` int(11) NOT NULL,
  `location` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  FOREIGN KEY (`userType_id`) REFERENCES `position` (`userType_id`),
  FOREIGN KEY (`booking_id`) REFERENCES `booking` (`booking_id`)
);
