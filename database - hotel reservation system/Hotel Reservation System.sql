Enter password: ******
Welcome to the MySQL monitor.  Commands end with ; or \g.
Your MySQL connection id is 13
Server version: 5.5.16 MySQL Community Server (GPL)

Copyright (c) 2000, 2011, Oracle and/or its affiliates. All rights reserved.

Oracle is a registered trademark of Oracle Corporation and/or its
affiliates. Other names may be trademarks of their respective
owners.

Type 'help;' or '\h' for help. Type '\c' to clear the current input statement.

mysql> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| test               |
+--------------------+
4 rows in set (0.00 sec)

mysql> CREATE SCHEMA `reservation`;
Query OK, 1 row affected (0.00 sec)

mysql> SHOW DATABASES;
+--------------------+
| Database           |
+--------------------+
| information_schema |
| mysql              |
| performance_schema |
| reservation        |
| test               |
+--------------------+
5 rows in set (0.00 sec)

mysql> USE `reservation`;
Database changed
mysql>
mysql> -- Table: User Positions/Roles
mysql> CREATE TABLE `position` (
    ->   `userType_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    ->   `userType` VARCHAR(255) NOT NULL
    -> );
Query OK, 0 rows affected (0.03 sec)

mysql>
mysql> -- Table: Owners
mysql> CREATE TABLE `owner` (
    ->   `owner_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    ->   `userType_id` INT NOT NULL,
    ->   `first_name` VARCHAR(255) NOT NULL,
    ->   `last_name` VARCHAR(255) NOT NULL,
    ->   `id_No` VARCHAR(35) NOT NULL UNIQUE,
    ->   `phone_no` VARCHAR(20) NOT NULL,
    ->   `email` VARCHAR(255) NOT NULL UNIQUE,
    ->   `password` VARCHAR(255) NOT NULL,
    ->   `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ->   FOREIGN KEY (`userType_id`) REFERENCES `position` (`userType_id`)
    -> );
Query OK, 0 rows affected (0.03 sec)

mysql>
mysql> -- Table: Hotels
mysql> CREATE TABLE `hotel` (
    ->   `hotel_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    ->   `userType_id` INT NOT NULL,
    ->   `owner_id` INT NOT NULL,
    ->   `hotel_name` VARCHAR(191) NOT NULL,
    ->   `location` VARCHAR(191) NOT NULL,
    ->   `logo` VARCHAR(191) NOT NULL,
    ->   `phone_no` VARCHAR(20) NOT NULL,
    ->   `email` VARCHAR(255) NOT NULL UNIQUE,
    ->   `password` VARCHAR(255) NOT NULL,
    ->   `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ->   FOREIGN KEY (`userType_id`) REFERENCES `position` (`userType_id`),
    ->   FOREIGN KEY (`owner_id`) REFERENCES `owner` (`owner_id`)
    -> );
Query OK, 0 rows affected (0.03 sec)

mysql>
mysql> -- Table: Admins
mysql> CREATE TABLE `admin` (
    ->   `admin_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    ->   `userType_id` INT NOT NULL,
    ->   `hotel_id` INT NOT NULL,
    ->   `first_name` VARCHAR(255) NOT NULL,
    ->   `last_name` VARCHAR(255) NOT NULL,
    ->   `gender` VARCHAR(10) NOT NULL,
    ->   `dob` DATE NOT NULL,
    ->   `id_no` VARCHAR(255) NOT NULL UNIQUE,
    ->   `email` VARCHAR(255) NOT NULL UNIQUE,
    ->   `phone_no` VARCHAR(20) NOT NULL,
    ->   `location` VARCHAR(255) NOT NULL,
    ->   `status` VARCHAR(50) NOT NULL DEFAULT 'active',
    ->   `password` VARCHAR(255) NOT NULL,
    ->   `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ->   FOREIGN KEY (`userType_id`) REFERENCES `position` (`userType_id`),
    ->   FOREIGN KEY (`hotel_id`) REFERENCES `hotel` (`hotel_id`)
    -> );
Query OK, 0 rows affected (0.02 sec)

mysql>
mysql> -- Table: Staff
mysql> CREATE TABLE `staff` (
    ->   `staff_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    ->   `userType_id` INT NOT NULL,
    ->   `admin_id` INT NOT NULL,
    ->   `first_name` VARCHAR(255) NOT NULL,
    ->   `last_name` VARCHAR(255) NOT NULL,
    ->   `gender` VARCHAR(10) NOT NULL,
    ->   `dob` DATE NOT NULL,
    ->   `id_no` VARCHAR(255) NOT NULL UNIQUE,
    ->   `email` VARCHAR(255) NOT NULL UNIQUE,
    ->   `phone_no` VARCHAR(20) NOT NULL,
    ->   `location` VARCHAR(255) NOT NULL,
    ->   `status` VARCHAR(50) NOT NULL DEFAULT 'active',
    ->   `password` VARCHAR(255) NOT NULL,
    ->   `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ->   FOREIGN KEY (`userType_id`) REFERENCES `position` (`userType_id`),
    ->   FOREIGN KEY (`admin_id`) REFERENCES `admin` (`admin_id`)
    -> );
Query OK, 0 rows affected (0.01 sec)

mysql>
mysql> -- Table: Rooms
mysql> CREATE TABLE `room` (
    ->   `room_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    ->   `admin_id` INT NOT NULL,
    ->   `room_name` VARCHAR(191) NOT NULL,
    ->   `room_no` VARCHAR(191) NOT NULL,
    ->   `adults` INT NOT NULL,
    ->   `children` INT NOT NULL,
    ->   `room_price` DECIMAL(10,2) NOT NULL,
    ->   `room_quantity` INT NOT NULL,
    ->   `room_status` VARCHAR(50) NOT NULL DEFAULT 'active',
    ->   `image1` VARCHAR(191) NOT NULL,
    ->   `image2` VARCHAR(191),
    ->   `image3` VARCHAR(191),
    ->   `image4` VARCHAR(191),
    ->   `image5` VARCHAR(191),
    ->   `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ->   FOREIGN KEY (`admin_id`) REFERENCES `admin` (`admin_id`)
    -> );
Query OK, 0 rows affected (0.03 sec)

mysql>
mysql> -- Table: Room Features
mysql> CREATE TABLE `features` (
    ->   `features_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    ->   `admin_id` INT NOT NULL,
    ->   `room_id` INT NOT NULL,
    ->   `features_name` VARCHAR(191) NOT NULL,
    ->   `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ->   FOREIGN KEY (`admin_id`) REFERENCES `admin` (`admin_id`),
    ->   FOREIGN KEY (`room_id`) REFERENCES `room` (`room_id`)
    -> );
Query OK, 0 rows affected (0.03 sec)

mysql>
mysql> -- Table: Room Facilities
mysql> CREATE TABLE `facilities` (
    ->   `facility_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    ->   `admin_id` INT NOT NULL,
    ->   `room_id` INT NOT NULL,
    ->   `facility_name` VARCHAR(191) NOT NULL,
    ->   `facility_desc` VARCHAR(191) NOT NULL,
    ->   `facility_image` VARCHAR(191) NOT NULL,
    ->   `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ->   FOREIGN KEY (`admin_id`) REFERENCES `admin` (`admin_id`),
    ->   FOREIGN KEY (`room_id`) REFERENCES `room` (`room_id`)
    -> );
Query OK, 0 rows affected (0.01 sec)

mysql>
mysql> -- Table: Bookings
mysql> CREATE TABLE `booking` (
    ->   `booking_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    ->   `hotel_id` INT NOT NULL,
    ->   `room_id` INT NOT NULL,
    ->   `arrival_date` DATE NOT NULL,
    ->   `departure_date` DATE NOT NULL,
    ->   `numOfAdults` INT NOT NULL,
    ->   `numOfChildren` INT NOT NULL,
    ->   `booked_date` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ->   FOREIGN KEY (`hotel_id`) REFERENCES `hotel` (`hotel_id`),
    ->   FOREIGN KEY (`room_id`) REFERENCES `room` (`room_id`)
    -> );
Query OK, 0 rows affected (0.03 sec)

mysql>
mysql> -- Table: Guests
mysql> CREATE TABLE `guest` (
    ->   `guest_id` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
    ->   `userType_id` INT NOT NULL,
    ->   `booking_id` INT NOT NULL,
    ->   `first_name` VARCHAR(255) NOT NULL,
    ->   `last_name` VARCHAR(255) NOT NULL,
    ->   `gender` VARCHAR(10) NOT NULL,
    ->   `dob` DATE NOT NULL,
    ->   `id_no` VARCHAR(255) NOT NULL UNIQUE,
    ->   `email` VARCHAR(255) NOT NULL UNIQUE,
    ->   `phone_no` VARCHAR(20) NOT NULL,
    ->   `location` VARCHAR(255) NOT NULL,
    ->   `password` VARCHAR(255) NOT NULL,
    ->   `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
    ->   FOREIGN KEY (`userType_id`) REFERENCES `position` (`userType_id`),
    ->   FOREIGN KEY (`booking_id`) REFERENCES `booking` (`booking_id`)
    -> );
Query OK, 0 rows affected (0.03 sec)

mysql>
mysql> SHOW TABLES;
+-----------------------+
| Tables_in_reservation |
+-----------------------+
| admin                 |
| booking               |
| facilities            |
| features              |
| guest                 |
| hotel                 |
| owner                 |
| position              |
| room                  |
| staff                 |
+-----------------------+
10 rows in set (0.01 sec)

mysql>
mysql> DESCRIBE `position`;
+-------------+--------------+------+-----+---------+----------------+
| Field       | Type         | Null | Key | Default | Extra          |
+-------------+--------------+------+-----+---------+----------------+
| userType_id | int(11)      | NO   | PRI | NULL    | auto_increment |
| userType    | varchar(255) | NO   |     | NULL    |                |
+-------------+--------------+------+-----+---------+----------------+
2 rows in set (0.04 sec)

mysql>
mysql> DESCRIBE `owner`;
+-------------+--------------+------+-----+-------------------+----------------+
| Field       | Type         | Null | Key | Default           | Extra          |
+-------------+--------------+------+-----+-------------------+----------------+
| owner_id    | int(11)      | NO   | PRI | NULL              | auto_increment |
| userType_id | int(11)      | NO   | MUL | NULL              |                |
| first_name  | varchar(255) | NO   |     | NULL              |                |
| last_name   | varchar(255) | NO   |     | NULL              |                |
| id_No       | varchar(35)  | NO   | UNI | NULL              |                |
| phone_no    | varchar(20)  | NO   |     | NULL              |                |
| email       | varchar(255) | NO   | UNI | NULL              |                |
| password    | varchar(255) | NO   |     | NULL              |                |
| created_at  | timestamp    | NO   |     | CURRENT_TIMESTAMP |                |
+-------------+--------------+------+-----+-------------------+----------------+
9 rows in set (0.03 sec)

mysql>
mysql> DESCRIBE `hotel`;
+-------------+--------------+------+-----+-------------------+----------------+
| Field       | Type         | Null | Key | Default           | Extra          |
+-------------+--------------+------+-----+-------------------+----------------+
| hotel_id    | int(11)      | NO   | PRI | NULL              | auto_increment |
| userType_id | int(11)      | NO   | MUL | NULL              |                |
| owner_id    | int(11)      | NO   | MUL | NULL              |                |
| hotel_name  | varchar(191) | NO   |     | NULL              |                |
| location    | varchar(191) | NO   |     | NULL              |                |
| logo        | varchar(191) | NO   |     | NULL              |                |
| phone_no    | varchar(20)  | NO   |     | NULL              |                |
| email       | varchar(255) | NO   | UNI | NULL              |                |
| password    | varchar(255) | NO   |     | NULL              |                |
| created_at  | timestamp    | NO   |     | CURRENT_TIMESTAMP |                |
+-------------+--------------+------+-----+-------------------+----------------+
10 rows in set (0.03 sec)

mysql>
mysql> DESCRIBE `admin`;
+-------------+--------------+------+-----+-------------------+----------------+
| Field       | Type         | Null | Key | Default           | Extra          |
+-------------+--------------+------+-----+-------------------+----------------+
| admin_id    | int(11)      | NO   | PRI | NULL              | auto_increment |
| userType_id | int(11)      | NO   | MUL | NULL              |                |
| hotel_id    | int(11)      | NO   | MUL | NULL              |                |
| first_name  | varchar(255) | NO   |     | NULL              |                |
| last_name   | varchar(255) | NO   |     | NULL              |                |
| gender      | varchar(10)  | NO   |     | NULL              |                |
| dob         | date         | NO   |     | NULL              |                |
| id_no       | varchar(255) | NO   | UNI | NULL              |                |
| email       | varchar(255) | NO   | UNI | NULL              |                |
| phone_no    | varchar(20)  | NO   |     | NULL              |                |
| location    | varchar(255) | NO   |     | NULL              |                |
| status      | varchar(50)  | NO   |     | active            |                |
| password    | varchar(255) | NO   |     | NULL              |                |
| created_at  | timestamp    | NO   |     | CURRENT_TIMESTAMP |                |
+-------------+--------------+------+-----+-------------------+----------------+
14 rows in set (0.03 sec)

mysql>
mysql> DESCRIBE `staff`;
+-------------+--------------+------+-----+-------------------+----------------+
| Field       | Type         | Null | Key | Default           | Extra          |
+-------------+--------------+------+-----+-------------------+----------------+
| staff_id    | int(11)      | NO   | PRI | NULL              | auto_increment |
| userType_id | int(11)      | NO   | MUL | NULL              |                |
| admin_id    | int(11)      | NO   | MUL | NULL              |                |
| first_name  | varchar(255) | NO   |     | NULL              |                |
| last_name   | varchar(255) | NO   |     | NULL              |                |
| gender      | varchar(10)  | NO   |     | NULL              |                |
| dob         | date         | NO   |     | NULL              |                |
| id_no       | varchar(255) | NO   | UNI | NULL              |                |
| email       | varchar(255) | NO   | UNI | NULL              |                |
| phone_no    | varchar(20)  | NO   |     | NULL              |                |
| location    | varchar(255) | NO   |     | NULL              |                |
| status      | varchar(50)  | NO   |     | active            |                |
| password    | varchar(255) | NO   |     | NULL              |                |
| created_at  | timestamp    | NO   |     | CURRENT_TIMESTAMP |                |
+-------------+--------------+------+-----+-------------------+----------------+
14 rows in set (0.03 sec)

mysql>
mysql> DESCRIBE `room`;
+---------------+---------------+------+-----+-------------------+----------------+
| Field         | Type          | Null | Key | Default           | Extra          |
+---------------+---------------+------+-----+-------------------+----------------+
| room_id       | int(11)       | NO   | PRI | NULL              | auto_increment |
| admin_id      | int(11)       | NO   | MUL | NULL              |                |
| room_name     | varchar(191)  | NO   |     | NULL              |                |
| room_no       | varchar(191)  | NO   |     | NULL              |                |
| adults        | int(11)       | NO   |     | NULL              |                |
| children      | int(11)       | NO   |     | NULL              |                |
| room_price    | decimal(10,2) | NO   |     | NULL              |                |
| room_quantity | int(11)       | NO   |     | NULL              |                |
| room_status   | varchar(50)   | NO   |     | active            |                |
| image1        | varchar(191)  | NO   |     | NULL              |                |
| image2        | varchar(191)  | YES  |     | NULL              |                |
| image3        | varchar(191)  | YES  |     | NULL              |                |
| image4        | varchar(191)  | YES  |     | NULL              |                |
| image5        | varchar(191)  | YES  |     | NULL              |                |
| created_at    | timestamp     | NO   |     | CURRENT_TIMESTAMP |                |
+---------------+---------------+------+-----+-------------------+----------------+
15 rows in set (0.01 sec)

mysql>
mysql> DESCRIBE `features`;
+---------------+--------------+------+-----+-------------------+----------------+
| Field         | Type         | Null | Key | Default           | Extra          |
+---------------+--------------+------+-----+-------------------+----------------+
| features_id   | int(11)      | NO   | PRI | NULL              | auto_increment |
| admin_id      | int(11)      | NO   | MUL | NULL              |                |
| room_id       | int(11)      | NO   | MUL | NULL              |                |
| features_name | varchar(191) | NO   |     | NULL              |                |
| created_at    | timestamp    | NO   |     | CURRENT_TIMESTAMP |                |
+---------------+--------------+------+-----+-------------------+----------------+
5 rows in set (0.01 sec)

mysql>
mysql> DESCRIBE `facilities`;
+----------------+--------------+------+-----+-------------------+----------------+
| Field          | Type         | Null | Key | Default           | Extra          |
+----------------+--------------+------+-----+-------------------+----------------+
| facility_id    | int(11)      | NO   | PRI | NULL              | auto_increment |
| admin_id       | int(11)      | NO   | MUL | NULL              |                |
| room_id        | int(11)      | NO   | MUL | NULL              |                |
| facility_name  | varchar(191) | NO   |     | NULL              |                |
| facility_desc  | varchar(191) | NO   |     | NULL              |                |
| facility_image | varchar(191) | NO   |     | NULL              |                |
| created_at     | timestamp    | NO   |     | CURRENT_TIMESTAMP |                |
+----------------+--------------+------+-----+-------------------+----------------+
7 rows in set (0.03 sec)

mysql>
mysql> DESCRIBE `booking`;
+----------------+-----------+------+-----+-------------------+----------------+
| Field          | Type      | Null | Key | Default           | Extra          |
+----------------+-----------+------+-----+-------------------+----------------+
| booking_id     | int(11)   | NO   | PRI | NULL              | auto_increment |
| hotel_id       | int(11)   | NO   | MUL | NULL              |                |
| room_id        | int(11)   | NO   | MUL | NULL              |                |
| arrival_date   | date      | NO   |     | NULL              |                |
| departure_date | date      | NO   |     | NULL              |                |
| numOfAdults    | int(11)   | NO   |     | NULL              |                |
| numOfChildren  | int(11)   | NO   |     | NULL              |                |
| booked_date    | timestamp | NO   |     | CURRENT_TIMESTAMP |                |
+----------------+-----------+------+-----+-------------------+----------------+
8 rows in set (0.02 sec)

mysql>
mysql> DESCRIBE `guest`;
+-------------+--------------+------+-----+-------------------+----------------+
| Field       | Type         | Null | Key | Default           | Extra          |
+-------------+--------------+------+-----+-------------------+----------------+
| guest_id    | int(11)      | NO   | PRI | NULL              | auto_increment |
| userType_id | int(11)      | NO   | MUL | NULL              |                |
| booking_id  | int(11)      | NO   | MUL | NULL              |                |
| first_name  | varchar(255) | NO   |     | NULL              |                |
| last_name   | varchar(255) | NO   |     | NULL              |                |
| gender      | varchar(10)  | NO   |     | NULL              |                |
| dob         | date         | NO   |     | NULL              |                |
| id_no       | varchar(255) | NO   | UNI | NULL              |                |
| email       | varchar(255) | NO   | UNI | NULL              |                |
| phone_no    | varchar(20)  | NO   |     | NULL              |                |
| location    | varchar(255) | NO   |     | NULL              |                |
| password    | varchar(255) | NO   |     | NULL              |                |
| created_at  | timestamp    | NO   |     | CURRENT_TIMESTAMP |                |
+-------------+--------------+------+-----+-------------------+----------------+
13 rows in set (0.03 sec)

mysql>
mysql> -- Insert user types
mysql> INSERT INTO `position` (`userType`) VALUES
    -> ('owner'),
    -> ('admin'),
    -> ('staff'),
    -> ('guest');
Query OK, 4 rows affected (0.03 sec)
Records: 4  Duplicates: 0  Warnings: 0

mysql>
mysql> -- Insert an owner
mysql> INSERT INTO `owner` (`userType_id`, `first_name`, `last_name`, `id_No`, `phone_no`, `email`, `password`)
    -> VALUES (1, 'Alice', 'Owens', 'ID001', '0712345678', 'alice@hotel.com', 'password123');
Query OK, 1 row affected (0.03 sec)

mysql>
mysql> -- Insert a hotel
mysql> INSERT INTO `hotel` (`userType_id`, `owner_id`, `hotel_name`, `location`, `logo`, `phone_no`, `email`, `password`)
    -> VALUES (1, 1, 'Sunset Resort', 'Coastal City', 'sunset_logo.png', '0711223344', 'contact@sunsetresort.com', 'hotelpass');
Query OK, 1 row affected (0.03 sec)

mysql>
mysql> -- Insert an admin
mysql> INSERT INTO `admin` (`userType_id`, `hotel_id`, `first_name`, `last_name`, `gender`, `dob`, `id_no`, `email`, `phone_no`, `location`, `password`)
    -> VALUES (2, 1, 'Bob', 'Adminson', 'Male', '1990-06-15', 'ID002', 'bob.admin@sunset.com', '0799887766', 'Coastal City', 'adminpass');
Query OK, 1 row affected (0.00 sec)

mysql>
mysql> -- Insert a staff member
mysql> INSERT INTO `staff` (`userType_id`, `admin_id`, `first_name`, `last_name`, `gender`, `dob`, `id_no`, `email`, `phone_no`, `location`, `password`)
    -> VALUES (3, 1, 'Charlie', 'Smith', 'Male', '1995-05-20', 'ID003', 'charlie.staff@sunset.com', '0788111222', 'Coastal City', 'staffpass');
Query OK, 1 row affected (0.02 sec)

mysql>
mysql> -- Insert a room
mysql> INSERT INTO `room` (`admin_id`, `room_name`, `room_no`, `adults`, `children`, `room_price`, `room_quantity`, `image1`)
    -> VALUES (1, 'Deluxe Ocean View', 'D101', 2, 2, 150.00, 5, 'room1.jpg');
Query OK, 1 row affected (0.03 sec)

mysql>
mysql> -- Insert room features
mysql> INSERT INTO `features` (`admin_id`, `room_id`, `features_name`)
    -> VALUES (1, 1, 'Balcony'), (1, 1, 'Sea View');
Query OK, 2 rows affected (0.02 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> -- Insert room facilities
mysql> INSERT INTO `facilities` (`admin_id`, `room_id`, `facility_name`, `facility_desc`, `facility_image`)
    -> VALUES
    -> (1, 1, 'Swimming Pool', 'Access to outdoor pool', 'pool.jpg'),
    -> (1, 1, 'WiFi', 'Free high-speed internet', 'wifi.jpg');
Query OK, 2 rows affected (0.02 sec)
Records: 2  Duplicates: 0  Warnings: 0

mysql>
mysql> -- Insert a booking
mysql> INSERT INTO `booking` (`hotel_id`, `room_id`, `arrival_date`, `departure_date`, `numOfAdults`, `numOfChildren`)
    -> VALUES (1, 1, '2025-05-01', '2025-05-05', 2, 1);
Query OK, 1 row affected (0.02 sec)

mysql>
mysql> -- Insert a guest
mysql> INSERT INTO `guest` (`userType_id`, `booking_id`, `first_name`, `last_name`, `gender`, `dob`, `id_no`, `email`, `phone_no`, `location`, `password`)
    -> VALUES (4, 1, 'Diana', 'Guestly', 'Female', '1992-04-10', 'ID004', 'diana.guest@example.com', '0722334455', 'Uptown', 'guestpass');
Query OK, 1 row affected (0.01 sec)

mysql>
mysql> -- View all guests and their bookings
mysql> SELECT
    ->     g.guest_id,
    ->     g.first_name AS guest_first_name,
    ->     g.last_name AS guest_last_name,
    ->     g.email,
    ->     g.phone_no,
    ->     b.booking_id,
    ->     b.arrival_date,
    ->     b.departure_date,
    ->     r.room_name,
    ->     r.room_no,
    ->     h.hotel_name,
    ->     h.location AS hotel_location
    -> FROM guest g
    -> JOIN booking b ON g.booking_id = b.booking_id
    -> JOIN room r ON b.room_id = r.room_id
    -> JOIN hotel h ON b.hotel_id = h.hotel_id
    -> ORDER BY g.guest_id;
+----------+------------------+-----------------+-------------------------+------------+------------+--------------+----------------+-------------------+---------+---------------+----------------+
| guest_id | guest_first_name | guest_last_name | email                   | phone_no   | booking_id | arrival_date | departure_date | room_name         | room_no | hotel_name    | hotel_location |
+----------+------------------+-----------------+-------------------------+------------+------------+--------------+----------------+-------------------+---------+---------------+----------------+
|        1 | Diana            | Guestly         | diana.guest@example.com | 0722334455 |          1 | 2025-05-01   | 2025-05-05     | Deluxe Ocean View | D101    | Sunset Resort | Coastal City   |
+----------+------------------+-----------------+-------------------------+------------+------------+--------------+----------------+-------------------+---------+---------------+----------------+
1 row in set (0.00 sec)

mysql>
mysql> -- List all rooms with features and facilities
mysql> SELECT
    ->     r.room_id,
    ->     r.room_name,
    ->     r.room_no,
    ->     r.room_price,
    ->     GROUP_CONCAT(DISTINCT f.features_name) AS room_features,
    ->     GROUP_CONCAT(DISTINCT fa.facility_name) AS room_facilities
    -> FROM room r
    -> LEFT JOIN features f ON r.room_id = f.room_id
    -> LEFT JOIN facilities fa ON r.room_id = fa.room_id
    -> GROUP BY r.room_id, r.room_name, r.room_no, r.room_price
    -> ORDER BY r.room_id;
+---------+-------------------+---------+------------+------------------+--------------------+
| room_id | room_name         | room_no | room_price | room_features    | room_facilities    |
+---------+-------------------+---------+------------+------------------+--------------------+
|       1 | Deluxe Ocean View | D101    |     150.00 | Balcony,Sea View | Swimming Pool,WiFi |
+---------+-------------------+---------+------------+------------------+--------------------+
1 row in set (0.00 sec)

mysql>
mysql> --  See all users by role
mysql> SELECT
    ->     o.owner_id AS user_id,
    ->     o.first_name,
    ->     o.last_name,
    ->     o.email,
    ->     o.phone_no,
    ->     p.userType AS role,
    ->     o.created_at
    -> FROM owner o
    -> JOIN position p ON o.userType_id = p.userType_id
    ->
    -> UNION ALL
    ->
    -> SELECT
    ->     a.admin_id AS user_id,
    ->     a.first_name,
    ->     a.last_name,
    ->     a.email,
    ->     a.phone_no,
    ->     p.userType AS role,
    ->     a.created_at
    -> FROM admin a
    -> JOIN position p ON a.userType_id = p.userType_id
    ->
    -> UNION ALL
    ->
    -> SELECT
    ->     s.staff_id AS user_id,
    ->     s.first_name,
    ->     s.last_name,
    ->     s.email,
    ->     s.phone_no,
    ->     p.userType AS role,
    ->     s.created_at
    -> FROM staff s
    -> JOIN position p ON s.userType_id = p.userType_id
    ->
    -> UNION ALL
    ->
    -> SELECT
    ->     g.guest_id AS user_id,
    ->     g.first_name,
    ->     g.last_name,
    ->     g.email,
    ->     g.phone_no,
    ->     p.userType AS role,
    ->     g.created_at
    -> FROM guest g
    -> JOIN position p ON g.userType_id = p.userType_id
    ->
    -> ORDER BY role, user_id;
+---------+------------+-----------+--------------------------+------------+-------+---------------------+
| user_id | first_name | last_name | email                    | phone_no   | role  | created_at          |
+---------+------------+-----------+--------------------------+------------+-------+---------------------+
|       1 | Bob        | Adminson  | bob.admin@sunset.com     | 0799887766 | admin | 2025-04-13 02:38:06 |
|       1 | Diana      | Guestly   | diana.guest@example.com  | 0722334455 | guest | 2025-04-13 02:39:48 |
|       1 | Alice      | Owens     | alice@hotel.com          | 0712345678 | owner | 2025-04-13 02:37:24 |
|       1 | Charlie    | Smith     | charlie.staff@sunset.com | 0788111222 | staff | 2025-04-13 02:38:26 |
+---------+------------+-----------+--------------------------+------------+-------+---------------------+
4 rows in set (0.00 sec)

mysql> -- Get hotel info with owner and admin
mysql> SELECT
    ->     h.hotel_id,
    ->     h.hotel_name,
    ->     h.location AS hotel_location,
    ->     h.phone_no AS hotel_phone,
    ->     h.email AS hotel_email,
    ->
    ->     o.owner_id,
    ->     o.first_name AS owner_first_name,
    ->     o.last_name AS owner_last_name,
    ->     o.email AS owner_email,
    ->     o.phone_no AS owner_phone,
    ->
    ->     a.admin_id,
    ->     a.first_name AS admin_first_name,
    ->     a.last_name AS admin_last_name,
    ->     a.email AS admin_email,
    ->     a.phone_no AS admin_phone
    ->
    -> FROM hotel h
    -> JOIN owner o ON h.owner_id = o.owner_id
    -> LEFT JOIN admin a ON h.hotel_id = a.hotel_id
    -> ORDER BY h.hotel_id;
+----------+---------------+----------------+-------------+--------------------------+----------+------------------+-----------------+-----------------+-------------+----------+------------------+-----------------+----------------------+-------------+
| hotel_id | hotel_name    | hotel_location | hotel_phone | hotel_email              | owner_id | owner_first_name | owner_last_name | owner_email     | owner_phone | admin_id | admin_first_name | admin_last_name | admin_email          | admin_phone |
+----------+---------------+----------------+-------------+--------------------------+----------+------------------+-----------------+-----------------+-------------+----------+------------------+-----------------+----------------------+-------------+
|        1 | Sunset Resort | Coastal City   | 0711223344  | contact@sunsetresort.com |        1 | Alice            | Owens           | alice@hotel.com | 0712345678  |        1 | Bob              | Adminson        | bob.admin@sunset.com | 0799887766  |
+----------+---------------+----------------+-------------+--------------------------+----------+------------------+-----------------+-----------------+-------------+----------+------------------+-----------------+----------------------+-------------+
1 row in set (0.00 sec)

mysql>
mysql> -- Available rooms by hotel
mysql> SELECT
    ->     h.hotel_id,
    ->     h.hotel_name,
    ->     h.location AS hotel_location,
    ->     r.room_id,
    ->     r.room_name,
    ->     r.room_no,
    ->     r.room_price,
    ->     r.adults,
    ->     r.children,
    ->     r.room_quantity,
    ->     r.room_status
    -> FROM hotel h
    -> JOIN admin a ON h.hotel_id = a.hotel_id
    -> JOIN room r ON a.admin_id = r.admin_id
    -> WHERE r.room_status = 'active'
    -> ORDER BY h.hotel_id, r.room_id;
+----------+---------------+----------------+---------+-------------------+---------+------------+--------+----------+---------------+-------------+
| hotel_id | hotel_name    | hotel_location | room_id | room_name         | room_no | room_price | adults | children | room_quantity | room_status |
+----------+---------------+----------------+---------+-------------------+---------+------------+--------+----------+---------------+-------------+
|        1 | Sunset Resort | Coastal City   |       1 | Deluxe Ocean View | D101    |     150.00 |      2 |        2 |             5 | active      |
+----------+---------------+----------------+---------+-------------------+---------+------------+--------+----------+---------------+-------------+
1 row in set (0.00 sec)

mysql>
mysql> -- Insert New Room
mysql> INSERT INTO `room` (
    ->   `admin_id`, `room_name`, `room_no`, `adults`, `children`, `room_price`, `room_quantity`, `image1`
    -> )
    -> VALUES (
    ->   1, 'Ocean Suite', 'D102', 2, 2, 250.00, 3, 'ocean_suite.jpg'
    -> );
Query OK, 1 row affected (0.02 sec)

mysql>
mysql> -- Filter Rooms by Price or Availability
mysql> SELECT `room_name`, `room_no`, `room_price`, `room_quantity`
    -> FROM `room`
    -> WHERE `room_price` < 200.00;
+-------------------+---------+------------+---------------+
| room_name         | room_no | room_price | room_quantity |
+-------------------+---------+------------+---------------+
| Deluxe Ocean View | D101    |     150.00 |             5 |
+-------------------+---------+------------+---------------+
1 row in set (0.00 sec)

mysql>
mysql> -- Edit Room Details
mysql> UPDATE `room`
    -> SET `room_price` = 275.00, `room_quantity` = 4
    -> WHERE `room_no` = 'D102';
Query OK, 1 row affected (0.03 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql>
mysql> -- Delete a Room
mysql> DELETE FROM `room`
    -> WHERE `room_no` = 'D102';
Query OK, 1 row affected (0.03 sec)

mysql>
mysql> -- Insert a New Booking
mysql> INSERT INTO `booking` (
    ->   `hotel_id`, `room_id`, `arrival_date`, `departure_date`,
    ->   `numOfAdults`, `numOfChildren`
    -> )
    -> VALUES (
    ->   1, 1, '2025-06-10', '2025-06-15', 2, 0
    -> );
Query OK, 1 row affected (0.03 sec)

mysql>
mysql> -- Update a Booking
mysql> UPDATE `booking`
    -> SET `departure_date` = '2025-06-17'
    -> WHERE `booking_id` = 1;
Query OK, 1 row affected (0.00 sec)
Rows matched: 1  Changed: 1  Warnings: 0

mysql>
mysql> -- View All Bookings for a Hotel
mysql> SELECT
    ->   b.booking_id, g.first_name AS guest_name, b.arrival_date, b.departure_date, r.room_name
    -> FROM `booking` b
    -> JOIN `guest` g ON b.booking_id = g.booking_id
    -> JOIN `room` r ON b.room_id = r.room_id
    -> WHERE b.hotel_id = 1;
+------------+------------+--------------+----------------+-------------------+
| booking_id | guest_name | arrival_date | departure_date | room_name         |
+------------+------------+--------------+----------------+-------------------+
|          1 | Diana      | 2025-05-01   | 2025-06-17     | Deluxe Ocean View |
+------------+------------+--------------+----------------+-------------------+
1 row in set (0.00 sec)

mysql>
mysql> -- View Guest Information
mysql> SELECT
    ->   g.first_name, g.last_name, g.email, g.phone_no, b.arrival_date, b.departure_date
    -> FROM `guest` g
    -> JOIN `booking` b ON g.booking_id = b.booking_id
    -> WHERE b.booking_id = 1;
+------------+-----------+-------------------------+------------+--------------+----------------+
| first_name | last_name | email                   | phone_no   | arrival_date | departure_date |
+------------+-----------+-------------------------+------------+--------------+----------------+
| Diana      | Guestly   | diana.guest@example.com | 0722334455 | 2025-05-01   | 2025-06-17     |
+------------+-----------+-------------------------+------------+--------------+----------------+
1 row in set (0.00 sec)

mysql>
mysql> -- Change Guest Information
mysql> UPDATE `guest`
    -> SET `phone_no` = '0777888999', `email` = 'emily.new@example.com'
    -> WHERE `id_no` = 'ID005';
Query OK, 0 rows affected (0.00 sec)
Rows matched: 0  Changed: 0  Warnings: 0

mysql>
