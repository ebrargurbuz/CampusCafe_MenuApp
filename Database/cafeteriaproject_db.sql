-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1
-- Üretim Zamanı: 07 May 2026, 17:43:04
-- Sunucu sürümü: 10.4.32-MariaDB
-- PHP Sürümü: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `cafeteriaproject_db`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `category`
--

CREATE TABLE `category` (
  `CategoryID` int(11) NOT NULL,
  `CategoryName` varchar(50) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `category`
--

INSERT INTO `category` (`CategoryID`, `CategoryName`) VALUES
(1, 'Hot Beverages'),
(2, 'Cold Beverages'),
(3, 'Bakery'),
(4, 'Soft Drinks'),
(5, 'Desserts');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `customization`
--

CREATE TABLE `customization` (
  `CustomID` int(11) NOT NULL,
  `CustomType` varchar(30) NOT NULL,
  `Value` varchar(30) NOT NULL,
  `ExtraPrice` decimal(10,2) DEFAULT NULL CHECK (`ExtraPrice` >= 0)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `customization`
--

INSERT INTO `customization` (`CustomID`, `CustomType`, `Value`, `ExtraPrice`) VALUES
(1, 'Milk', 'Oat Milk', 15.00),
(2, 'Milk', 'Soy Milk', 12.00),
(3, 'Milk', 'Lactose-Free', 0.00),
(4, 'Syrup', 'Vanilla', 8.00),
(5, 'Syrup', 'Caramel', 8.00),
(6, 'Syrup', 'Hazelnut', 8.00),
(7, 'Size', 'Medium', 0.00),
(8, 'Size', 'Large', 15.00);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `order`
--

CREATE TABLE `order` (
  `OrderID` int(11) NOT NULL,
  `StudentID` int(11) DEFAULT NULL,
  `OrderDate` datetime DEFAULT NULL,
  `TotalPrice` decimal(10,2) DEFAULT NULL,
  `Status` varchar(25) DEFAULT NULL CHECK (`Status` in ('Pending','Preparing','Completed'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `order_detail`
--

CREATE TABLE `order_detail` (
  `DetailID` int(11) NOT NULL,
  `OrderID` int(11) DEFAULT NULL,
  `ProductID` int(11) DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL CHECK (`Quantity` > 0),
  `UnitPrice` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `order_detail_custom`
--

CREATE TABLE `order_detail_custom` (
  `DetailCustomID` int(11) NOT NULL,
  `DetailID` int(11) DEFAULT NULL,
  `CustomID` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `personnel`
--

CREATE TABLE `personnel` (
  `UserID` int(11) NOT NULL,
  `RegistrationNum` varchar(30) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `product`
--

CREATE TABLE `product` (
  `ProductID` int(11) NOT NULL,
  `CategoryID` int(11) DEFAULT NULL,
  `ProductName` varchar(100) NOT NULL,
  `Price` decimal(10,2) DEFAULT NULL,
  `IsActive` int(11) DEFAULT NULL CHECK (`IsActive` in (0,1))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `product`
--

INSERT INTO `product` (`ProductID`, `CategoryID`, `ProductName`, `Price`, `IsActive`) VALUES
(1, 1, 'Filter Coffee', 100.00, 1),
(2, 1, 'Americano', 90.00, 1),
(3, 1, 'Latte', 120.00, 1),
(4, 1, 'Tea', 30.00, 1),
(5, 1, 'Chai Tea Latte', 140.00, 1),
(6, 1, 'Caramel Latte', 90.00, 1),
(7, 1, 'Cappuccino', 110.00, 1),
(8, 1, 'Salep', 130.00, 1),
(9, 2, 'Ice Americano', 90.00, 1),
(10, 2, 'Ice Latte', 120.00, 1),
(11, 2, 'Homemade Lemonade', 80.00, 1),
(12, 2, 'Iced Caramel Latte', 140.00, 1),
(13, 2, 'Orange Juice', 80.00, 1),
(14, 3, 'Sandwich', 90.00, 1),
(15, 3, 'Cookie', 60.00, 1),
(16, 4, 'Coca Cola', 65.00, 1),
(17, 4, 'Fanta', 65.00, 1),
(18, 4, 'Ayran', 65.00, 1),
(19, 5, 'Cheesecake', 115.00, 1),
(20, 5, 'Tiramisu', 110.00, 1),
(21, 5, 'Cake', 90.00, 1),
(22, 5, 'Spoonful', 100.00, 1);

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `student`
--

CREATE TABLE `student` (
  `UserID` int(11) NOT NULL,
  `StudentNo` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `users`
--

CREATE TABLE `users` (
  `UserID` int(11) NOT NULL,
  `RoleType` varchar(50) DEFAULT NULL CHECK (`RoleType` in ('Student','Personnel','Admin')),
  `Email` varchar(50) NOT NULL,
  `Password` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Tablo döküm verisi `users`
--

INSERT INTO `users` (`UserID`, `RoleType`, `Email`, `Password`) VALUES
(1, 'Student', 'ebrar@ogrenci.karabuk.edu.tr', '$2y$10$m6Iv9BzzAjl/UFRAMSkOyOsMDUYC5whbM9vvtecUbTCPy2X5WpQIW'),
(2, 'Personnel', 'mustafa@karabuk.edu.tr', '$2y$10$i50ZyFWYZCSwDLfXJppGBuXnInZCHbRhy79CLEpSJ2u1oGJoUT4RW'),
(3, 'Student', 'mehmet@ogrenci.karabuk.edu.tr', '$2y$10$b9fxD8HuDoUm/0kyzMPgueprsw0KtxCew70wGoVVZErTHzR/NlUjC'),
(4, 'Student', 'ezo@ogrenci.karabuk.edu.tr', '$2y$10$BhufVD0PHz1ubLndW3WfIemS7GTiZharPcgcwbG/P0MMolUMaGb9W'),
(5, 'Personnel', 'ebrar@karabuk.edu.tr', '$2y$10$09gDCznSUsjF3ucMujyIlOiy/cjXyTRxz030jvHQSI9/GwVPJTgH6');

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `category`
--
ALTER TABLE `category`
  ADD PRIMARY KEY (`CategoryID`);

--
-- Tablo için indeksler `customization`
--
ALTER TABLE `customization`
  ADD PRIMARY KEY (`CustomID`);

--
-- Tablo için indeksler `order`
--
ALTER TABLE `order`
  ADD PRIMARY KEY (`OrderID`),
  ADD KEY `StudentID` (`StudentID`);

--
-- Tablo için indeksler `order_detail`
--
ALTER TABLE `order_detail`
  ADD PRIMARY KEY (`DetailID`),
  ADD KEY `OrderID` (`OrderID`),
  ADD KEY `ProductID` (`ProductID`);

--
-- Tablo için indeksler `order_detail_custom`
--
ALTER TABLE `order_detail_custom`
  ADD PRIMARY KEY (`DetailCustomID`),
  ADD KEY `DetailID` (`DetailID`),
  ADD KEY `CustomID` (`CustomID`);

--
-- Tablo için indeksler `personnel`
--
ALTER TABLE `personnel`
  ADD PRIMARY KEY (`UserID`),
  ADD UNIQUE KEY `RegistrationNum` (`RegistrationNum`);

--
-- Tablo için indeksler `product`
--
ALTER TABLE `product`
  ADD PRIMARY KEY (`ProductID`),
  ADD KEY `CategoryID` (`CategoryID`);

--
-- Tablo için indeksler `student`
--
ALTER TABLE `student`
  ADD PRIMARY KEY (`UserID`),
  ADD UNIQUE KEY `StudentNo` (`StudentNo`);

--
-- Tablo için indeksler `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`UserID`),
  ADD UNIQUE KEY `Email` (`Email`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `category`
--
ALTER TABLE `category`
  MODIFY `CategoryID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Tablo için AUTO_INCREMENT değeri `customization`
--
ALTER TABLE `customization`
  MODIFY `CustomID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- Tablo için AUTO_INCREMENT değeri `order`
--
ALTER TABLE `order`
  MODIFY `OrderID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `order_detail`
--
ALTER TABLE `order_detail`
  MODIFY `DetailID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `order_detail_custom`
--
ALTER TABLE `order_detail_custom`
  MODIFY `DetailCustomID` int(11) NOT NULL AUTO_INCREMENT;

--
-- Tablo için AUTO_INCREMENT değeri `product`
--
ALTER TABLE `product`
  MODIFY `ProductID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=23;

--
-- Tablo için AUTO_INCREMENT değeri `users`
--
ALTER TABLE `users`
  MODIFY `UserID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Dökümü yapılmış tablolar için kısıtlamalar
--

--
-- Tablo kısıtlamaları `order`
--
ALTER TABLE `order`
  ADD CONSTRAINT `order_ibfk_1` FOREIGN KEY (`StudentID`) REFERENCES `student` (`UserID`);

--
-- Tablo kısıtlamaları `order_detail`
--
ALTER TABLE `order_detail`
  ADD CONSTRAINT `order_detail_ibfk_1` FOREIGN KEY (`OrderID`) REFERENCES `order` (`OrderID`),
  ADD CONSTRAINT `order_detail_ibfk_2` FOREIGN KEY (`ProductID`) REFERENCES `product` (`ProductID`);

--
-- Tablo kısıtlamaları `order_detail_custom`
--
ALTER TABLE `order_detail_custom`
  ADD CONSTRAINT `order_detail_custom_ibfk_1` FOREIGN KEY (`DetailID`) REFERENCES `order_detail` (`DetailID`),
  ADD CONSTRAINT `order_detail_custom_ibfk_2` FOREIGN KEY (`CustomID`) REFERENCES `customization` (`CustomID`);

--
-- Tablo kısıtlamaları `personnel`
--
ALTER TABLE `personnel`
  ADD CONSTRAINT `personnel_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`);

--
-- Tablo kısıtlamaları `product`
--
ALTER TABLE `product`
  ADD CONSTRAINT `product_ibfk_1` FOREIGN KEY (`CategoryID`) REFERENCES `category` (`CategoryID`);

--
-- Tablo kısıtlamaları `student`
--
ALTER TABLE `student`
  ADD CONSTRAINT `student_ibfk_1` FOREIGN KEY (`UserID`) REFERENCES `users` (`UserID`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
