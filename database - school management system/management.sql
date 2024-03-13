DROP SCHEMA IF EXISTS `management`; 
CREATE SCHEMA `management`; 
USE `management`;

CREATE TABLE `position` (
  `userType_id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `userType` varchar(255) NOT NULL
);

CREATE TABLE `owner` (
  `owner_id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `userType_id` int(11) NOT NULL,
  `school_name` varchar(255) NOT NULL,
  `location` varchar(255) NOT NULL,
  `school_type` varchar(35) NOT NULL,
  `school_email` varchar(255) NOT NULL UNIQUE,
  `phone_no` int(11) NOT NULL,
  `password` varchar(255) NOT NULL,
   FOREIGN KEY (`userType_id`) REFERENCES `position` (`userType_id`)
);

CREATE TABLE `admin` (
  `admin_id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `userType_id` int(11) NOT NULL,
  `owner_id` int(11) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `gender` varchar(255) NOT NULL,
  `dob` date NOT NULL,
  `id_no` varchar(255) NOT NULL UNIQUE,
  `email` varchar(255) NOT NULL UNIQUE,
  `phone_no` int(11) NOT NULL,
  `location` varchar(255) NOT NULL,
  `position` varchar(255) NOT NULL,
  `grade` int(11) NOT NULL,
  `password` varchar(255) NOT NULL,
   FOREIGN KEY (`userType_id`) REFERENCES `position` (`userType_id`),
   FOREIGN KEY (`owner_id`) REFERENCES `owner` (`owner_id`)
);

CREATE TABLE `subject` (
  `subject_id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `admin_id` int(11) NOT NULL,
  `subject_name` varchar(255) NOT NULL,
   FOREIGN KEY (`admin_id`) REFERENCES `admin` (`admin_id`)
);

CREATE TABLE `teacher` (
  `teacher_id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
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
  `position` varchar(255) NOT NULL,
  `grade` int(11) NOT NULL,
  `subject_id` int(11) NOT NULL,
  `password` varchar(255) NOT NULL,
   FOREIGN KEY (`userType_id`) REFERENCES `position` (`userType_id`),
   FOREIGN KEY (`admin_id`) REFERENCES `admin` (`admin_id`),
   FOREIGN KEY (`subject_id`) REFERENCES `subject` (`subject_id`)
);

CREATE TABLE `student` (
  `student_id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `admin_id` int(11) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `gender` varchar(255) NOT NULL,
  `id_no` varchar(255) NOT NULL UNIQUE,
  `grade` int(11) NOT NULL,
  `location` varchar(255) NOT NULL,
   FOREIGN KEY (`admin_id`) REFERENCES `admin` (`admin_id`)
);

CREATE TABLE `assessment` (
  `assessment_id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `subject_id` int(11) NOT NULL,
  `teacher_id` int(11) NOT NULL,
  `assessment_name` varchar(255) NOT NULL,
  `assessment_date` date NOT NULL,
   FOREIGN KEY (`subject_id`) REFERENCES `subject` (`subject_id`),
   FOREIGN KEY (`teacher_id`) REFERENCES `teacher` (`teacher_id`)
);

CREATE TABLE `mark` (
  `mark_id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `assessment_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `add_marks` varchar(35) NOT NULL,
  `comment` varchar(255) NOT NULL,
   FOREIGN KEY (`assessment_id`) REFERENCES `assessment` (`assessment_id`),
   FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`)
);

CREATE TABLE `parent` (
  `parent_id` int(11) NOT NULL PRIMARY KEY AUTO_INCREMENT,
  `userType_id` int(11) NOT NULL,
  `student_id` int(11) NOT NULL,
  `first_name` varchar(255) NOT NULL,
  `last_name` varchar(255) NOT NULL,
  `dob` date NOT NULL,
  `id_no` varchar(255) NOT NULL UNIQUE,
  `email` varchar(255) NOT NULL UNIQUE,
  `phone_no` int(11) NOT NULL,
  `location` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
   FOREIGN KEY (`userType_id`) REFERENCES `position` (`userType_id`),
   FOREIGN KEY (`student_id`) REFERENCES `student` (`student_id`)
);


