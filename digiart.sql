-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Generation Time: Jul 30, 2024 at 02:48 AM
-- Server version: 10.11.8-MariaDB-cll-lve
-- PHP Version: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `digiart`
--
CREATE DATABASE IF NOT EXISTS `digiart` DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE `digiart`;

-- --------------------------------------------------------

--
-- Table structure for table `art`
--

DROP TABLE IF EXISTS `art`;
CREATE TABLE `art` (
  `Artwork_ID` int(20) NOT NULL,
  `User_ID` int(13) NOT NULL,
  `Artstyle` set('Vectorart','Lineart','Minimalism','Conceptart','Anime') NOT NULL,
  `Date_posted` date DEFAULT current_timestamp(),
  `Price` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `art`
--

INSERT INTO `art` (`Artwork_ID`, `User_ID`, `Artstyle`, `Date_posted`, `Price`) VALUES
(202306001, 1500463, 'Vectorart', '2023-06-26', '150.00'),
(202306002, 1500463, 'Conceptart', '2023-06-26', '200.00'),
(202306004, 1500463, 'Anime', '2023-06-26', '150.00'),
(202306005, 1500463, 'Lineart', '2023-06-26', '300.00'),
(202306006, 1500463, 'Vectorart', '2023-06-26', '200.00'),
(202306009, 1500464, 'Lineart', '2023-06-26', '120.00'),
(202306010, 1500464, 'Lineart', '2023-06-26', '60.00'),
(202306012, 1500464, 'Minimalism', '2023-06-26', '150.00'),
(202306013, 1500464, 'Conceptart', '2023-06-26', '450.00'),
(202306017, 1500465, 'Anime', '2023-06-26', '500.00'),
(202306029, 1500463, 'Anime', '2024-05-29', '100.00'),
(202306042, 1500463, 'Vectorart', '2024-05-30', '290.00'),
(202306043, 1500464, 'Conceptart', '2024-05-30', '300.00'),
(202306044, 1500463, 'Conceptart', '2024-05-30', '280.00'),
(202306047, 1500465, 'Minimalism', '2024-05-30', '200.00'),
(202306048, 1500463, 'Vectorart', '2024-05-31', '210.00'),
(202306055, 1500463, 'Lineart', '2024-06-03', '310.00'),
(202306061, 240610965, 'Anime', '2024-06-10', '200.00');

-- --------------------------------------------------------

--
-- Table structure for table `commission`
--

DROP TABLE IF EXISTS `commission`;
CREATE TABLE `commission` (
  `Commission_ID` int(20) NOT NULL,
  `User_ID` int(13) NOT NULL,
  `Artstyle` set('Vectorart','Lineart','Minimalism','Conceptart','Anime') NOT NULL,
  `deadline` date NOT NULL,
  `message` varchar(150) NOT NULL,
  `status` varchar(50) NOT NULL,
  `paid` varchar(100) DEFAULT NULL,
  `date_commissioned` date NOT NULL DEFAULT current_timestamp(),
  `commi_price` decimal(10,2) DEFAULT NULL,
  `artist_id` int(13) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `commission`
--

INSERT INTO `commission` (`Commission_ID`, `User_ID`, `Artstyle`, `deadline`, `message`, `status`, `paid`, `date_commissioned`, `commi_price`, `artist_id`) VALUES
(3, 1, 'Vectorart', '2024-05-28', 'Kanang nindot', 'Pending', NULL, '2024-05-28', NULL, 1500464),
(4, 1, 'Anime', '2024-05-31', 'oy oy oy ', 'Completed', 'Paid', '2024-05-28', '200.50', 1500463),
(5, 1, 'Minimalism', '2024-06-08', 'himo kog pet portrait plzz', 'Rejected', NULL, '2024-05-29', NULL, 1500463),
(6, 1, 'Vectorart', '2024-06-06', 'testing', 'Cancelled', NULL, '2024-05-29', NULL, 1500463),
(7, 1, 'Minimalism', '2024-06-06', 'heeyyy', 'Completed', 'Paid', '2024-05-29', '250.00', 1500463),
(10, 240530351, 'Vectorart', '2024-05-31', 'helloo test', 'Rejected', NULL, '2024-05-30', NULL, 1500463),
(11, 240606072, 'Vectorart', '2024-06-24', 'hellooo', 'Completed', 'Paid', '2024-06-06', '200.00', 1500463),
(12, 240606072, 'Vectorart', '2024-06-24', 'hellooo hi testt', 'Completed', 'Paid', '2024-06-06', '50.00', 1500463),
(13, 240606072, 'Vectorart', '2024-06-14', 'testftsfsdf', 'Pending', NULL, '2024-06-06', NULL, 1500464),
(14, 240606072, 'Minimalism', '2024-06-14', 'hephep', 'Pending', NULL, '2024-06-06', NULL, 1500464),
(17, 240606072, 'Conceptart', '2024-06-11', 'wdwada', 'Completed', 'Paid', '2024-06-06', '150.00', 1500463),
(18, 240606072, 'Vectorart', '2024-06-11', 'wdwadadawdas', 'Completed', 'Paid', '2024-06-06', '300.00', 1500463),
(23, 240610402, 'Vectorart', '2024-06-18', 'hatdog jevie', 'Completed', 'Paid', '2024-06-10', '200.00', 1500464),
(24, 240610668, 'Vectorart', '2024-06-19', 'Make it nice', 'In Progress', 'Paid', '2024-06-10', '100.00', 1500463),
(25, 240610668, 'Lineart', '2024-06-20', 'Make it simple', 'Pending', NULL, '2024-06-10', NULL, 1500464),
(26, 240610668, 'Vectorart', '2024-06-20', 'Make it nice', 'Completed', 'Paid', '2024-06-10', '200.00', 240610965),
(27, 1, 'Vectorart', '2024-06-14', 'testttt', 'In Progress', 'Paid', '2024-06-11', '500.00', 1500463),
(28, 240610425, 'Conceptart', '2024-06-19', 'masdasss', 'Completed', 'Paid', '2024-06-11', NULL, 1500464),
(29, 240610425, 'Anime', '2024-06-19', 'Ghibli Inspired', 'Accepted', 'Paid', '2024-06-11', NULL, 1500464),
(30, 240610425, 'Conceptart', '2024-06-14', 'hhh', 'Accepted', 'Paid', '2024-06-11', NULL, 1500464),
(31, 240610425, 'Minimalism', '2024-06-27', 'lineline', 'Accepted', NULL, '2024-06-11', NULL, 1500464),
(32, 240610425, 'Minimalism', '2024-06-20', 'sffsdfdsfsdfd', 'Completed', 'Paid', '2024-06-11', NULL, 1500464),
(33, 240610425, 'Vectorart', '2024-06-20', '213123123wdsr', 'Completed', 'Paid', '2024-06-11', NULL, 1500464),
(34, 240610425, 'Minimalism', '2024-06-13', 'rwerwr', 'In Progress', 'Paid', '2024-06-11', '10.00', 1500466),
(35, 240610425, 'Conceptart', '2024-06-12', 'huuuuutttts', 'In Progress', 'Paid', '2024-06-11', '80.00', 1500466),
(36, 240610425, 'Lineart', '2024-06-20', 'test', 'In Progress', 'Paid', '2024-06-12', '10.00', 1500466),
(37, 240610425, 'Minimalism', '2024-06-13', 'HELLOO', 'Completed', 'Paid', '2024-06-12', '200.00', 1500466),
(39, 240610425, 'Minimalism', '2024-06-20', 'QQQQQQQQQQQQQQQQQ', 'Completed', 'Paid', '2024-06-12', '20.00', 1500466),
(40, 240610425, 'Minimalism', '2024-06-20', '1', 'Cancelled', NULL, '2024-06-12', NULL, 1500466),
(41, 240610425, 'Conceptart', '2024-06-20', '2', 'Accepted', 'Paid', '2024-06-12', '2.00', 1500466),
(42, 240610425, 'Anime', '2024-06-20', '3', 'In Progress', 'Paid', '2024-06-12', '3.00', 1500466),
(43, 240610425, 'Lineart', '2024-06-20', '4', 'Rejected', NULL, '2024-06-12', NULL, 1500466),
(44, 1, 'Lineart', '2024-06-21', 'tsrt', 'Accepted', 'Paid', '2024-06-12', '200.00', 1500463),
(45, 1, 'Minimalism', '2024-06-22', 'test', 'Pending', NULL, '2024-06-12', NULL, 1500463),
(46, 240610425, 'Conceptart', '2024-06-20', '8000000000000', 'Completed', 'Paid', '2024-06-12', '1.00', 1500466),
(47, 240610425, 'Anime', '2024-06-21', 'DSJKSDFD', 'Pending', NULL, '2024-06-12', NULL, 1500466),
(48, 240610425, 'Vectorart', '2024-06-13', 'testt', 'Pending', NULL, '2024-06-13', NULL, 240606124),
(49, 240610425, 'Minimalism', '2024-06-26', 'Hshdshshshhshshshwhwhw', 'Accepted', 'Paid', '2024-06-13', '200.00', 1500465),
(50, 240610425, 'Anime', '2024-06-25', 'TEEEEEEEEEEEEEEEEEEESSSSSSSTTTTT', 'Completed', 'Paid', '2024-06-13', '50.00', 1500465),
(51, 240610425, 'Lineart', '2024-06-18', 'LINEEE', 'Completed', 'Paid', '2024-06-13', '200.00', 1500465),
(52, 240610425, 'Conceptart', '2024-06-25', 'GDGDHDHSHS', 'Accepted', NULL, '2024-06-13', '10.00', 1500465);

-- --------------------------------------------------------

--
-- Table structure for table `ratings`
--

DROP TABLE IF EXISTS `ratings`;
CREATE TABLE `ratings` (
  `ratingid` int(11) NOT NULL,
  `userid` int(11) NOT NULL,
  `artistid` int(11) NOT NULL,
  `Commission_ID` int(11) NOT NULL,
  `rating` int(11) NOT NULL,
  `comment` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `ratings`
--

INSERT INTO `ratings` (`ratingid`, `userid`, `artistid`, `Commission_ID`, `rating`, `comment`) VALUES
(7, 1, 1500463, 7, 4, 'I like the art'),
(8, 1, 1500463, 4, 5, 'So cute!!!'),
(9, 240606072, 1500463, 11, 5, 'i love it'),
(12, 240606072, 1500463, 12, 5, 'amesing'),
(13, 240606072, 1500463, 17, 4, 'nice very wow'),
(14, 240606072, 1500463, 18, 2, 'mehh');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `User_ID` int(13) NOT NULL,
  `Usertype` set('admin','artist','client','') NOT NULL,
  `Username` varchar(20) NOT NULL,
  `Firstname` varchar(20) NOT NULL,
  `Lastname` varchar(20) NOT NULL,
  `Contact_number` varchar(13) NOT NULL,
  `Country` varchar(50) NOT NULL,
  `Gender` set('Female','Male','Other') NOT NULL,
  `Email` varchar(50) NOT NULL,
  `Password` varchar(100) NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'unregistered'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_general_ci;

--
-- Dumping data for table `users`
--

INSERT INTO `users` (`User_ID`, `Usertype`, `Username`, `Firstname`, `Lastname`, `Contact_number`, `Country`, `Gender`, `Email`, `Password`, `status`) VALUES
(1, 'client', 'juan', 'Juan', 'Cruz', '09053964708', 'Philippines', 'Male', 'client@gmail.com', '123', 'unregistered'),
(1500462, 'admin', 'admin', 'admin', 'admin', '09123456789', 'US', 'Other', 'admin@gmail.com', '123', 'unregistered'),
(1500463, 'artist', 'Jevs', 'Jevie', 'Saturre', '09053964708', 'Philippines', 'Female', 'saturre.jevie@gmail.com', 'Jevs', 'unregistered'),
(1500464, 'artist', 'lingcreates', 'Shala', 'Masip', '09608891427', 'Philippines', 'Female', 'masipshala@gmail.com', '123', 'unregistered'),
(1500465, 'artist', 'rozieee', 'Nizylle Rose', 'Codino', '09383971500', 'Philippines', 'Female', 'nizyllecodino@gmail.com', '123', 'unregistered'),
(1500466, 'artist', 'Mweh', 'Mary Grace', 'Encabo', '09152181245', 'Philippines', 'Female', 'marygrace.encabo@gmail.com', '123', 'unregistered'),
(1500467, 'artist', 'Kenkaizen0624', 'Grison Kent', 'Padillo', '09383071964', 'Philippines', 'Male', 'grisonkentpadillo.gkp@gmail.com', '123', 'unregistered'),
(202300007, 'client', 'Louecute', 'Jirhaelle', 'Gloria', '09770530435', 'Philippines', 'Female', 'loue.gloria@gmail.com', 'Moondustin143', 'unregistered'),
(202300008, 'client', 'Levigumera69', 'Francis Merian', 'Gumera', '09054917252', 'Philippines', 'Female', 'Franmergum@gmail.com', 'tongbens', 'unregistered'),
(202300009, 'client', 'Dabi69', 'Francis Dave', 'Gravino', '09165273421', 'Philippines', 'Male', 'gwaponess680@gmail.com', 'gwapoko123', 'unregistered'),
(202300010, 'client', 'Kaneki420', 'Brix', 'Tizon', '09616880175', 'Philippines', 'Male', 'tizonbrix@gmail.com', 'brixgwapoilambos', 'unregistered'),
(202300011, 'client', 'raprap', 'Rufe', 'Jalina', '09756867195', 'Philippines', 'Male', 'rufejalinaa22@gmail.com', 'raprap', 'unregistered'),
(202300012, 'client', 'Sheynnn', 'Arabela', 'Ampahan', '09636415816', 'Philippines', 'Female', 'arabelashaneampahan@gmail.com', 'akorani', 'unregistered'),
(202300014, 'client', 'yellowflash', 'Mark Adrian', 'Anadeo', '09560084550', 'Philippines', 'Male', 'markadrianmaghanoy@gmail.com', 'yellowflash', 'unregistered'),
(202300015, 'client', 'Gwyn', 'Gwyneth', 'Pongyan', '09055737248', 'Philippines', 'Female', 'gwynethpongyan9@gmail.com', 'Gwyn', 'unregistered'),
(202300016, 'client', 'jolo', 'Joseph Paulo', 'Galleros', '09463845676', 'Philippines', 'Male', 'jpgalleros@gmail.com', 'jolo', 'unregistered'),
(202300018, 'client', 'Carrice', 'Edcel Carrice Marie', 'Balili', '09709847706', 'Philippines', 'Female', 'edcelcarricemarie@gmail.com', 'KARYANGZEKE200324', 'unregistered'),
(202300019, 'client', 'Sheena', 'Siti Sheena', 'Mediana', '09930962518', 'Philippines', 'Female', 'sheenamediana18@gmail.com', 'sheena', 'unregistered'),
(202300020, 'client', 'shannonleelie', 'Shannon Lee', 'Tuyor', '09991658559', 'Philippines', 'Female', 's.tuyor@yahoo.com', 'lamishangbayhana', 'unregistered'),
(202300021, 'client', 'emannadela', 'Eman', 'Nadela', '09503538451', 'Philippines', 'Female', 'emannadela7@gmail.com', 'emannadela7', 'unregistered'),
(202300022, 'client', 'Its_jessabing', 'Jessa Mae', 'Abing', '09298677565', 'Philippines', 'Female', 'abingjessa41@gmail.com', 'bingg', 'unregistered'),
(202300023, 'client', 'Tannie', 'Iza', 'Tan', '09099641378', 'Philippines', 'Female', 'izatan@gmail.com', 'tatanshi', 'unregistered'),
(202300024, 'client', 'dendi0123', 'Diomari Jose', 'Vale', '09619081616', 'Philippines', 'Male', 'valediomari@gmail.com', 'd10m@r13', 'unregistered'),
(202300025, 'client', 'kswyn', 'Chizza', 'Angcap', '09213684778', 'Philippines', 'Female', 'angcapchizzayown@gmail.com', 'chizza', 'unregistered'),
(202300026, 'client', 'Rossy', 'Mary Rose', 'Vina', '09079129276', 'Philippines', 'Female', 'vinarossie@gmail.com', 'rose@123', 'unregistered'),
(202300027, 'client', 'james123', 'James', 'Mintang', '09157339058', 'Philippines', 'Male', 'james.mintang@gmail.com', 'james123', 'unregistered'),
(202300028, 'client', 'someh', 'Theo', 'Paculanang', '09167431234', 'Philippines', 'Male', 'pacs@gmail.com', '1234', 'unregistered'),
(202300029, 'client', 'jeff.123', 'Jefferson', 'Canamo', '09827738827', 'Philippines', 'Male', 'jefferson@outlook.com', 'jeff.123', 'unregistered'),
(202300030, 'client', 'Mweh', 'Mary Grace', 'Encabo', '09152181245', 'Philippines', 'Female', 'graceencabo@gmail.com', 'mweh1910', 'unregistered'),
(202300031, 'client', 'Monzty123', 'Aldrin', 'Abaton', '09190073037', 'Philippines', 'Male', 'aldrin.abaton14@gmail.com', 'something123', 'unregistered'),
(202300032, 'client', 'udustin2003', 'Dustin Roi', 'Reyes', '09461433789', 'Philippines', 'Male', 'dustinroireyes10@gmail.com', 'kianacute05', 'unregistered'),
(202300033, 'client', 'Joelyn@20', 'Joelyn', 'Mangilimotan', '09709618708', 'Philippines', 'Female', 'joelynmangilimotan1@gmail.com', 'Joelyn2003', 'unregistered'),
(202300034, 'client', 'Dave72', 'Dave', 'Dominguez', '09709574233', 'Philippines', 'Male', 'davedominguez@gmail.com', 'd302008', 'unregistered'),
(202300035, 'client', 'Lexx', 'VJ Alexxa', 'Unabia', '09616020434', 'Philippines', 'Female', 'vjalexaunabia@gmail.com', 'Ambot1111', 'unregistered'),
(202300036, 'client', 'Dwight09', 'Arjune', 'Matugas', '09223476654', 'Philippines', 'Male', 'arjune08matugas@gmail.com', 'latolato45', 'unregistered'),
(202300037, 'client', 'Arabst', 'Zyro Winch', 'Aguijon', '09174821113', 'Philippines', 'Male', 'zyro.aguijon061703@gmail.com', 'iamarabs123', 'unregistered'),
(202300038, 'client', 'jessa', 'Jessa', 'Abadilla', '09185840945', 'Philippines', 'Female', 'jeessaabadilla@gmail.com', 'jessaabadilla', 'unregistered'),
(202300039, 'client', 'KaiT', 'Kakai', 'Tagle', '091234567654', 'Philippines', 'Female', 'kaiT@gmail.com', 'PASSKO', 'unregistered'),
(202300040, 'client', 'unknownymous', 'Cris Darvi', 'Cartajenas', '09205470919', 'Philippines', 'Male', '63920547019cris@gmail.com', '143darvi', 'unregistered'),
(202300041, 'client', 'basicjvn', 'Jovyn', 'Tugano', '09304260382', 'Philippines', 'Male', 'jovynjokertugano@gmail.com', 'urmom1580', 'unregistered'),
(202300042, 'client', 'princez_xd', 'Princez Marie', 'Reyes', '09673157856', 'Philippines', 'Female', 'princezmariereyes17@gmail.com', 'immanloml', 'unregistered'),
(202300043, 'client', 'Equilt', 'Alec', 'Lizardo', '09064740013', 'Philippines', 'Male', 'alecfrankiellizardox@gmail.com', 'passpass324', 'unregistered'),
(202300044, 'client', '@Donut_29', 'Miggy', 'Moreno', '09664601968', 'Philippines', 'Male', 'miguelmoreno@gmail.com', '123456789moreno', 'unregistered'),
(202300045, 'client', 'azraelstyles', 'Angel', 'Zalsos', '09108753675', 'Philippines', 'Female', 'angelzalsos714@gmail.com', 'azraelstyles', 'unregistered'),
(202300046, 'client', 'JuneMark', 'June Mark', 'Velasquez', '09124306802', 'Philippines', 'Male', 'junemark52@gmail.com', 'JuneMark', 'unregistered'),
(202300047, 'client', 'Stevoe', 'Steve', 'Morales', '09652898028', 'Philippines', 'Male', 'stevemorales@gmail.com', 'esteb000', 'unregistered'),
(202300048, 'client', 'gwapo123', 'Kurt', 'Fick', '09968393404', 'Philippines', 'Male', 'kdune@gmail.com', 'mazdacar', 'unregistered'),
(202300049, 'client', 'berson', 'Berson', 'Largo', '09155533044', 'Philippines', 'Male', 'bersonlargo@yahoo.com', 'berson', 'unregistered'),
(202300050, 'client', 'random_user', 'Random', 'User', '09123456789', 'Philippines', 'Male', 'randomuser@gmail.com', 'random123', 'unregistered'),
(202300051, 'client', 'Jelo', 'Anjelo', 'Pascua', '09554776611', 'Philippines', 'Male', 'bobomo334@gmail.com', 'Ikawbahala', 'unregistered'),
(202300052, 'client', 'Brendilyn2002', 'Brendilyn', 'Alburo', '09511970646', 'Philippines', 'Female', 'alburobrendilyn@gmail.com', 'Alburo', 'unregistered'),
(202300053, 'client', 'JaDi264718', 'Janine', 'Dingding', '09638186844', 'Philippines', 'Female', 'Jadi264718', 'iloveyou', 'unregistered'),
(202300054, 'client', 'zadkyy', 'Andrei', 'Dango', '09165125539', 'Philippines', 'Male', 'andried07@gmail.com', '1234', 'unregistered'),
(202300055, 'client', 'Chiqui', 'Yhanchie', 'Dasigan', '0961901450', 'Philippines', 'Female', 'yhanchied@gmail.com', 'jydChie_0516', 'unregistered'),
(202300056, 'client', 'Zhyel', 'Angel', 'Padayhag', '09504147128', 'Philippines', 'Female', 'angel.padayhag@gmail.com', '22136754', 'unregistered'),
(202300057, 'client', 'Ella', 'Ella Therese', 'Lazaga', '09661825065', 'Philippines', 'Female', 'elliahlim001@gmail.com', 'PassWord012', 'unregistered'),
(202300058, 'client', 'pnd_buttercup', 'Princess Nicole', 'Dasigan', '09762812930', 'Philippines', 'Female', 'princessnicoledasigan@gmail.com', 'buttercup', 'unregistered'),
(202300059, 'client', 'Perlie07', 'Perlie', 'Jabillo', '09460243671', 'Philippines', 'Female', 'perliejabillo@gmail.com', 'gwapako123', 'unregistered'),
(202300063, 'client', 'Celline', 'Celline', 'Jabillo', '09347899870', 'Philippines', 'Female', 'cellinejabillo@gmail.com', 'cute123x', 'unregistered'),
(202300064, 'client', 'Glorious', 'Lecefe', 'Gloria', '09125614180', 'Philippines', 'Female', 'bernovelet@gmail.com', 'Moon143', 'unregistered'),
(202300065, 'client', 'Sabrinah', 'Sabrinah', 'Gloria', '09308291561', 'Philippines', 'Female', 'Sabrinah.gloria@gmail.com', 'Moon143', 'unregistered'),
(202300066, 'client', 'Pandamonium', 'Clifford', 'Limquimbo', '09055770217', 'Philippines', 'Male', 'vanilachipmonster@gmail.com', 'vanillapanda', 'unregistered'),
(202300067, 'client', 'arieshi', 'Patrice', 'Andriano', '09565280983', 'Philippines', 'Female', 'arieshikami@gmail.com', 'shutupxx', 'unregistered'),
(202300068, 'client', 'Ceejay', 'Christ Jean', 'Vasquez', '09093624673', 'Philippines', 'Female', 'vasquezchristjean@gmail.com', 'vasquez0102', 'unregistered'),
(202300069, 'client', 'eunoo', 'Heizel Rose', 'Gomisong', '09369267986', 'Philippines', 'Female', 'heizelrosen@gmail.com', 'hakdog', 'unregistered'),
(202300070, 'client', 'belleyza', 'Yza Belle', 'Ramo', '09507728630', 'Philippines', 'Female', 'hoephasing@gmail.com', 'lunalovegood0319', 'unregistered'),
(202300071, 'client', 'sunshine_28', 'Ira', 'Vios', '09466660724', 'Philippines', 'Female', 'iravios091@gmail.com', 'Grison_wayligo_777', 'unregistered'),
(202300072, 'client', 'Milesyyy', 'Miles Enrico', 'Sagario', '09453409815', 'Philippines', 'Male', 'milesenricosagario24@gmail.com', 'Milesyyy122400', 'unregistered'),
(202300073, 'client', 'Arlyn Pegalan', 'Arlyn', 'Pegalan', '09071680964', 'Philippines', 'Female', 'pegalanarlyn89@gmail.com', 'arlyn12345', 'unregistered'),
(202300074, 'client', 'Elijah123', 'Elijah', 'Palangan', '09123456788', 'Philippines', 'Male', 'elijah.palangan@gmail.com', 'Elijah321', 'unregistered'),
(202300075, 'client', 'Karl', 'Karl John', 'Bodiongan', '09109315260', 'Philippines', 'Male', 'Bodiongan111@gmail.com', '21178kj', 'unregistered'),
(202300076, 'client', 'bryrchl', 'Aubrey Rachel', 'Dagpin', '09617986861', 'Philippines', 'Female', 'aubreydagpin62@gmail.com', 'wrGdschldrn09', 'unregistered'),
(202300077, 'client', 'jilliveC.D.', 'Olive', 'Decena', '09639611677', 'Philippines', 'Female', 'olivejilldecena@gmail.com', 'jillive87', 'unregistered'),
(202300078, 'client', 'rydryd', 'Ryed Jolester', 'Jore', '09074062028', 'Philippines', 'Male', 'ryedjolestercj@gmail.com', 'gwapako123', 'unregistered'),
(202300079, 'client', 'lexiloreee123', 'Marilyn', 'Prontes', '09531601355', 'Philippines', 'Female', 'prontesmarilyn@gmail.com', 'Lexiloreee@987', 'unregistered'),
(202300080, 'client', 'yeng_jaramillo', 'Oriel', 'Jaramillo', '09815188367', 'Philippines', 'Male', 'orieljaramillo885@gmail.com', 'yeng_jaramillo', 'unregistered'),
(202300081, 'client', 'paul bulawin', 'Paul', 'Bulawin', '09203040121', 'Philippines', 'Male', 'paul1323@gmail.com', 'password123', 'unregistered'),
(202300082, 'client', 'its_erlie', 'Earlie', 'Manlegro', '09187113851', 'Philippines', 'Female', 'manlegroearlie@gmail.com', 'lie123', 'unregistered'),
(202300083, 'client', 'Carl059', 'Carl', 'Daguman', '09125272862', 'Philippines', 'Male', 'Carl059@gmail.com', 'carlito654321', 'unregistered'),
(202300084, 'client', 'Jeuse Bayawa', 'Jeuse', 'Bayawa', '09516547940', 'Philippines', 'Female', 'jeusebayawa56@gmail.com', 'jcsb2101015', 'unregistered'),
(202300085, 'client', 'sajah30', 'J-Jairah', 'Canoy', '09481397324', 'Philippines', 'Female', 'Sajahcan30@gmail.com', 'secretlangha', 'unregistered'),
(202300086, 'client', 'Kratos19', 'Marc', 'Alegado', '09987517751', 'Philippines', 'Male', 'marckronos@yahoo.com', 'you10prono', 'unregistered'),
(202300087, 'client', 'harasambo', 'Hara Mae', 'Sambo', '09270046922', 'Philippines', 'Female', 'harasambo11@yahoo.com', 'heramay123', 'unregistered'),
(202300088, 'client', 'Sayuri', 'Kate', 'Sohon', '09123456789', 'Philippines', 'Female', 'wonderkid@gmail.com', 'pakawsabakhaw', 'unregistered'),
(202300089, 'client', 'Sanpedro_Glee', 'Gleeza Brie', 'San Pedro', '09561401046', 'Philippines', 'Female', 'gleezabriesanpedro6@gmail.com', 'cjthegoat', 'unregistered'),
(202300090, 'client', 'cjthegoat', 'CJ Andrei', 'Pinero', '09385927492', 'Philippines', 'Male', 'cjandreip@gmail.com', 'cj12345678', 'unregistered'),
(202300091, 'client', 'Arnelie', 'Arnelie', 'Cagas', '09639634479', 'Philippines', 'Female', 'arneliecags@gmail.com', 'cagas2003', 'unregistered'),
(202300092, 'client', 'POLPOL', 'Paul Christian', 'Arcamo', '09156566218', 'Philippines', 'Male', 'paularcamo193@gmail.com', 'eknlbf', 'unregistered'),
(202300093, 'client', 'joyiii', 'Goldy Joi', 'Decena', '09207991218', 'Philippines', 'Female', 'joidcn@gmail.com', 'joyiii', 'unregistered'),
(202300094, 'client', 'Jhiss', 'Jhisel', 'Berjame', '09816204218', 'Philippines', 'Female', 'jhiselberjame@gmail.com', '123123123', 'unregistered'),
(202300095, 'client', 'by_vynz', 'Vynz', 'Tizon', '09709920310', 'Philippines', 'Male', 'jhiselberjame@gmail.com', 'vynz07', 'unregistered'),
(202300097, 'client', 'kupacakes', 'Cyrah', 'Opamen', '09700444173', 'Philippines', 'Female', 'kupacakes@gmail.com', 'Kupa2667', 'unregistered'),
(202300111, 'client', 'ade.elle', 'Adelle', 'Andales', '09207419381', 'Philippines', 'Female', 'adellepabriga@gmail.com', 'adelleeee', 'unregistered'),
(202300112, 'client', 'clentserohijos', 'Clent John', 'Serohijos', '09616880323', 'Philippines', 'Male', 'clentserohijossagario@gmail.com', 'clentserohijos', 'unregistered'),
(202300113, 'client', 'fordarichgurl', 'Alyssa Ashley', 'Mira', '09067332274', 'Philippines', 'Female', 'alyssaashleymira@gmail.com', 'fordarichgurl', 'unregistered'),
(202300114, 'client', 'inumaki_07', 'Carmel', 'Balbutin', '09187115313', 'Philippines', 'Female', 'balbutin.marycarmel@gmail.com', 'inumaki_07', 'unregistered'),
(202300115, 'client', 'username', 'Althea Jen', 'Mata', '09508904779', 'Philippines', 'Female', 'sunxflowerxiu@gmail.com', 'username', 'unregistered'),
(202300116, 'client', 'Christine', 'Christine', 'Bautista', '09635602599', 'Philippines', 'Female', 'hopebautista07@yahoo.com', 'Christine', 'unregistered'),
(202300117, 'client', 'names', 'Geylou', 'Samporna', '09381126514', 'Philippines', 'Male', 'geylou1000@gmail.com', 'names', 'unregistered'),
(202300118, 'client', 'christinabb', 'Christina', 'Bacus', '09305851098', 'Philippines', 'Female', 'christinaprirabacus@gmail.com', 'christinabb', 'unregistered'),
(202300119, 'client', 'iamjay', 'Jay', 'Andog', '09469053241', 'Philippines', 'Male', 'iamjayandog@gmail.com', 'iamjay', 'unregistered'),
(202300120, 'client', 'lovinyuuhh', 'Vinya Joy', 'Villanueva', '09673152318', 'Philippines', 'Female', 'vjoy.villanueva1302@gmail.com', 'lovinyuuhh', 'unregistered'),
(202300121, 'client', '@shoyocato', 'Romel', 'Begontes', '09106371881', 'Philippines', 'Male', 'appolobegontes@gmail.com', '190496916', 'unregistered'),
(202300122, 'client', 'maryethel18', 'Mary Ethel', 'Tolosa', '09065448443', 'Philippines', 'Female', 'maryetheltolosa@gmail.com', 'ethel1105', 'unregistered'),
(202300123, 'client', 'itsfranzeh', 'Franzelle Rose', 'Satorre', '09708693142', 'Philippines', 'Female', 'franzellerose.satorre@gmail.com', 'yahayninyo12345', 'unregistered'),
(202300124, 'client', 'sovereignty', 'Reign Kirvy', 'Gulang', '09496617766', 'Philippines', 'Male', 'reigngulang01@gmail.com', 'mahalkoangexomwamwa', 'unregistered'),
(202300125, 'client', 'SiriusLy', 'Kit Ian', 'Parojinog', '09185304431', 'Philippines', 'Male', 'kitianparojinog@gmail.com', 'kitqt22', 'unregistered'),
(202300136, 'client', 'Shane D', 'Sheney', 'Dionio', '09618058587', 'Philippines', 'Female', 'ostingsd@gmail.com', 'jejeje', 'unregistered'),
(202300137, 'client', 'carlstien', 'John Carlstien', 'Uy', '09105012057', 'Philippines', 'Male', 'johncarlstienuy@gmail.com', '123456', 'unregistered'),
(202300138, 'client', 'verygwapa', 'David Joseph', 'Epe', '09876543219', 'Philippines', 'Male', 'epedavid@gmail.com', 'verygwapa', 'unregistered'),
(202300139, 'client', 'be1234', 'Rhea', 'Beduya', '09666496869', 'Philippines', 'Female', 'beduyarhea23@gmail.com', 'freenbecky', 'unregistered'),
(202300140, 'client', 'Zhujin', 'Will Martin', 'Caballero', '09357745239', 'Philippines', 'Male', 'caballerowill66@gmail.com', 'Ambotsaimo12345', 'unregistered'),
(202300141, 'client', 'Mythl', 'Maythel', 'Reponte', '09122208561', 'Philippines', 'Male', 'maythelreponte13@gmail.com', 'Mythl', 'unregistered'),
(202300142, 'client', 'May Bel Lyn', 'Maybelyn', 'Sebial', '09104130035', 'Philippines', 'Female', 'maybelynsebial@gmail.com', 'meybs@23', 'unregistered'),
(202300143, 'client', 'geedee_20', 'GD Rose', 'Alcontin', '09991613656', 'Philippines', 'Female', 'gdrose.alcontin@gmail.com', 'gwapako063', 'unregistered'),
(202300144, 'client', 'lynoel_gwapa017', 'Lynoel Faith', 'Manapsal', '09169129501', 'Philippines', 'Female', 'ortizlynoelfaith@gmail.com', 'pinakaGWAPA123', 'unregistered'),
(202300145, 'client', 'Kris', 'Kristia', 'Lantaca', '09128932306', 'Philippines', 'Female', 'Krisacatnal@gmail.com', 'akoraka143', 'unregistered'),
(202300146, 'client', 'clarky', 'Clark', 'Pontoy', '09105504270', 'Philippines', 'Male', 'clarkpontoy14@gmail.com', 'secrt', 'unregistered'),
(202300147, 'client', 'jade_hayes', 'Jade', 'Hayes', '09457663669', 'Philippines', 'Female', 'jade.hayes@gmail.com', 'jade_hayes', 'unregistered'),
(202300148, 'client', 'kcymae', 'Khecy Mae', 'Palioto', '09773706025', 'Philippines', 'Female', 'khecy.palioto@gmail.com', 'kcymaepal', 'unregistered'),
(202300149, 'client', '@L.jie', 'Ehl Jay', 'Empal', '09453851225', 'Philippines', 'Male', 'ehl.jay@gmail.com', '1234q9x9O', 'unregistered'),
(202300150, 'client', 'jayhayha', 'Arvin Jay', 'Baril', '09052175447', 'Philippines', 'Male', 'arvinjaybaril@gmail.com', 'Reebook', 'unregistered'),
(202300151, 'client', 'MaryvicX11', 'Maryvic', 'Morala', '09089287537', 'Philippines', 'Female', 'moralamaryvic@gmail.com', 'MaryvicX11', 'unregistered'),
(202300152, 'client', 'Yully29', 'Yullysses', 'Almonte', '09034568834', 'Philippines', 'Male', 'yullyssesalmonte@gmail.com', 'Yully29@', 'unregistered'),
(202300153, 'client', 'Jesaac10', 'Jenny', 'Dela Cerna', '09953704916', 'Philippines', 'Female', 'jdelacerna966@gmail.com', 'limitlesssky', 'unregistered'),
(202300154, 'client', 'Tucks', 'Anthony Ryan', 'Dumpa', '09700399868', 'Philippines', 'Male', 'adumpa4@gmail.com', 'RosesAreRed', 'unregistered'),
(202300155, 'client', 'Francis Apilan', 'Francis', 'Apilan', '09122871365', 'Philippines', 'Male', 'francisapilan5@gmail.com', 'fran0410', 'unregistered'),
(202300156, 'client', 'Zps_avec', 'Anthony Virgel', 'Cagurin', '09670069916', 'Philippines', 'Male', 'zzoroo336@gmail.com', 'Fa_yui8980', 'unregistered'),
(202300157, 'client', 'klent', 'Ivan Klent', 'Aclo', '09514666726', 'Philippines', 'Male', 'klentivanaclo@gmail.com', 'klent8986', 'unregistered'),
(202300158, 'client', 'bragz', 'Bryan', 'Acoymo', '09484666122', 'Philippines', 'Male', 'acoymobryan@gmail.com', '244466888', 'unregistered'),
(202300159, 'client', '@cardi_bope', 'Blanche Orvinne', 'Erquita', '09774411346', 'Philippines', 'Female', 'beechan562@gmail.com', 'mapagmahal143', 'unregistered'),
(202300183, 'client', 'Sharhim JP', 'Sharhim J', 'Pabriga', '09453644934', 'Philippines', 'Female', 'kkozume10165@gmail.com', 'esjeh', 'unregistered'),
(202300185, 'client', 'veneathjade', 'Veneath Jade', 'Cabarron', '09991613817', 'Philippines', 'Female', 'jadecabarron84@gmail.com', 'veneathjade', 'unregistered'),
(202300186, 'client', 'Melenio Pasok', 'Melenio', 'Pasok', '09078796440', 'Philippines', 'Male', 'lensyopasok@gmail.com', '12345678', 'unregistered'),
(202300187, 'client', 'Cyril Dico', 'Cyril Jules', 'Dico', '09392721795', 'Philippines', 'Male', 'cyrildico08@gmail.com', '127248090011', 'unregistered'),
(202300188, 'client', 'psalm2002', 'Psalm', 'Jakosalem', '09294900112', 'Philippines', 'Male', 'psalm2002@gmail.com', 'psalm1234', 'unregistered'),
(202300189, 'client', 'Marvin17', 'Marvin', 'Gonzales', '09060087753', 'Philippines', 'Male', 'mgonzales22314@gmail.com', 'qwertyaskilo', 'unregistered'),
(202300190, 'client', 'jankhen', 'Jan Khen', 'Dayon', '09269400122', 'Philippines', 'Male', 'jankhendayon@gmail.com', 'jankhen', 'unregistered'),
(202300191, 'client', 'justine123 ', 'Justine Mark', 'Taga-an', '09055757460', 'Philippines', 'Male', 'tagaanjustinemark5@gmail.com', 'justine321', 'unregistered'),
(202300192, 'client', 'ashrrc', 'Ashanti', 'Saquin', '09632387863', 'Philippines', 'Male', 'asherc4903@gmail.com', 'ashantisaq06', 'unregistered'),
(202300211, 'client', 'Potenciano', 'Potenciano', 'Saturre', '09566737256', 'Philippines', 'Male', 'saturrejayar@gmail.com', 'jarya', 'unregistered'),
(202300212, 'client', 'Johnson', 'Johnson', 'Saturre', '09566737255', 'Philippines', 'Male', 'saturresonson@gmail.com', 'sonson', 'unregistered'),
(202300213, 'client', 'Jennifer', 'Jennifer', 'Saturre', '09566737254', 'Philippines', 'Female', 'jennifer@gmail.com', 'jenn', 'unregistered'),
(202300214, 'client', 'Jacklint', 'Jacklint', 'Saturre', '09566737253', 'Philippines', 'Male', 'jackasaturre@gmail.com', 'clint', 'unregistered'),
(202300215, 'client', 'Jackie', 'Jackie', 'Saturre', '09566737252', 'Philippines', 'Female', 'olartejackie@gmail.com', 'kieiee', 'unregistered'),
(202300216, 'client', 'Juvilyn', 'Juvilyn', 'Olarte', '09566737205', 'Philippines', 'Female', 'juvilttser@gmail.com', 'sdfsd', 'unregistered'),
(202300217, 'client', 'Janet', 'Janet', 'Olarte', '09566737249', 'Philippines', 'Female', 'netttt@gmail.com', 'fff', 'unregistered'),
(202300218, 'client', 'Ferdie', 'Ferdie', 'Olarte', '09566737248', 'Philippines', 'Male', 'ferdsolarte@gmail.com', 'fers', 'unregistered'),
(202300219, 'client', 'Jhandie', 'Jhandie', 'Olarte', '09566737247', 'Philippines', 'Male', 'jhandiieaye@gmail.com', 'jfnie', 'unregistered'),
(202300220, 'client', 'Rosie', 'Rosie', 'Durand', '09566737246', 'Philippines', 'Female', 'rosefloral@gmail.com', 'riiee', 'unregistered'),
(202300221, 'client', 'Rex', 'Rex', 'Olarte', '09566737245', 'Philippines', 'Male', 'Olartettrec@gmail.com', '0399ff', 'unregistered'),
(202300222, 'client', 'Fiona', 'Fiona', 'Olarte', '09683014917', 'Philippines', 'Female', 'fionzkei@gmail.com', 'paswoesd', 'unregistered'),
(202300223, 'client', 'Chloe', 'Chloe', 'Villabito', '09705448109', 'Philippines', 'Female', 'cloookk@gmail.com', '309hey', 'unregistered'),
(202300224, 'client', 'Christine Jane', 'Christine Jane', 'Bacus', '09683014917', 'Philippines', 'Female', 'chrisjansbacuse@gmail.com', 'password', 'unregistered'),
(202300225, 'client', 'Mila Jane', 'Mila Jane', 'Malaubang', '09977460863', 'Philippines', 'Female', 'milajance@gmail.com', '1233me', 'unregistered'),
(202300226, 'client', 'Merylle Erich', 'Merylle Erich', 'Quizon', '09972353265', 'Philippines', 'Female', 'ejfiiichh@gmail.com', '00ha', 'unregistered'),
(202300227, 'client', 'Raffy', 'Raffy', 'Carreon', '09052170229', 'Philippines', 'Male', 'raffycarreon23@gmail.com', '123456', 'unregistered'),
(202300228, 'client', 'Joel Jhey', 'Joel Jhey', 'Peras', '09265109318', 'Philippines', 'Male', 'jjhey.peras@gmail.com', 'Dodong@54', 'unregistered'),
(202300229, 'client', 'Patric', 'Patric', 'Star', '09874532345', 'Philippines', 'Female', 'patricstarrr@gmail.com', 'starrr', 'unregistered'),
(202300230, 'client', 'iztephaniee', 'Stephanie', 'Caballero', '09776690260', 'Philippines', 'Female', 'stephaniecaballero0428@gmail.com', '12e456789', 'unregistered'),
(202300231, 'client', 'Kerby Dabon', 'Kerby', 'Dabon', '09262939185', 'Philippines', 'Male', 'kerbydanon@gmail.com', '09262939185', 'unregistered'),
(202300255, 'client', 'normae', 'Normae', 'Maata', '09345678934', 'Philippines', 'Female', 'norm.maata@gmail.com', 'mae', 'unregistered'),
(202300256, 'client', 'JuanDelaCruz', 'Juan', 'Dela Cruz', '09566737245', 'Philippines', 'Male', 'juandelacruz@gmail.com', 'juandelacruz123', 'unregistered'),
(202300307, 'client', 'Almar', 'Almar', 'Pantillo', '09609016150', 'Philippines', 'Male', 'almarpantillo15@gmail.com', 'Almar', 'unregistered'),
(202300308, 'client', 'Jomar', 'Jomar', 'Epe', '09924778009', 'Philippines', 'Male', 'epejomar@gmail.com', '09924', 'unregistered'),
(202300309, 'client', 'ericagenotiva', 'Erica Jane', 'Genotiva', '09396692541', 'Philippines', 'Female', 'ericajanegenotiva21@gmail.com', '122103', 'unregistered'),
(202300310, 'client', 'jaynee', 'Jaynee Rose', 'Danlag', '09546925877', 'Philippines', 'Female', 'ericjanea.genotiva@mu.edu.ph', 'BLACKPINK', 'unregistered'),
(202300311, 'client', 'cosit', 'Cozette Ryhnne', 'Baluyos', '09291068712', 'Philippines', 'Female', 'cozetteryhnne.baluyos@gmail.com', 'kaeyaalberich', 'unregistered'),
(202300312, 'client', 'johnkaroy123', 'John Cary', 'Tarundoy', '09453925951', 'Philippines', 'Male', 'karoytarundoy@gmail.com', 'Password12345', 'unregistered'),
(202300313, 'client', 'Jingsss', 'Niljie May', 'Panganoron', '09052793290', 'Philippines', 'Female', 'niljiemayp@gmail.com', 'may252003', 'unregistered'),
(202300326, 'client', 'Sealtiel Angelo', 'Kim', 'Capuyan', '09971787044', 'Philippines', 'Male', 'angelocapuyan143@gmail.com', 'KANDEN', 'unregistered'),
(202300327, 'client', 'Shannon', 'Shannonleelie', 'Tuyor', '09991658559', 'Philippines', 'Female', 's.tuyor@yahoo.com', 'shannonleelie7765', 'unregistered'),
(202300347, 'client', 'Maria Theresa', 'Maria Theresa', 'Palioto', '09542844857', 'Philippines', 'Female', 'theresa@gmail.com', 'theresa', 'unregistered'),
(202300348, 'client', 'Alerandy', 'Alerandy', 'Palioto', '09387483482', 'Philippines', 'Male', 'randy@gmail.com', 'randy', 'unregistered'),
(202300349, 'client', 'Fidelia', 'Fidelia', 'Nava', '09756754565', 'Philippines', 'Female', 'fidelia@gmail.com', 'fnava2023', 'unregistered'),
(202300378, 'client', 'joy', 'Shaira Joy', 'Malinaw', '09907987978', 'Philippines', 'Female', 'malinaw_shairajoy23@gmail.com', 'joyjoy', 'unregistered'),
(202300379, 'client', 'nixon', 'Nixon', 'Montefalcon', '09847745364', 'Philippines', 'Male', 'montefalconnixon@gmail.com', 'nixon', 'unregistered'),
(202300380, 'client', 'stacey', 'Stacey', 'Gabriel', '09345678909', 'Philippines', 'Female', 'stacey@gmail.com', 'grabriel', 'unregistered'),
(202300381, 'client', 'stacey', 'Stacey', 'Gabriel', '09345678909', 'Philippines', 'Female', 'stacey@gmail.com', 'grabriel', 'unregistered'),
(202300382, 'client', 'ferrer', 'Samantha', 'Ferrer', '09345678907', 'Philippines', 'Female', 'samferrer@gmail.com', 'samantha', 'unregistered'),
(202300383, 'client', 'noriel', 'Noriel Kent', 'Pitogo', '09979586758', 'Philippines', 'Male', 'norielkent@gmail.com', 'kent', 'unregistered'),
(202300384, 'client', 'gemar', 'Gemar', 'Reyes', '09567895387', 'Philippines', 'Male', 'gemarreyes@gmail.com', 'reyes', 'unregistered'),
(202300385, 'client', 'wynne', 'Wynne', 'Dionsay', '09457356788', 'Philippines', 'Female', 'wynnevergara@gmail.com', 'dionsay', 'unregistered'),
(202300386, 'client', 'jimby', 'Jimby', 'Cuazon', '09909990998', 'Philippines', 'Male', 'cuazonjimby@gmail.com', 'cuazon', 'unregistered'),
(202300387, 'client', 'jimby', 'Jimby', 'Cuazon', '09909990998', 'Philippines', 'Male', 'cuazonjimby@gmail.com', 'cuazon', 'unregistered'),
(202300388, 'client', 'junjun', 'Jhon Jhon', 'Alfeche', '09543356789', 'Philippines', 'Male', 'Jhonalfeche@gmail.com', 'alfeche', 'unregistered'),
(202300389, 'client', 'aldwin', 'Aldwin', 'Genon', '09384323456', 'Philippines', 'Male', 'aldwingenon@gmail.com', 'genon', 'unregistered'),
(202300390, 'client', 'russel', 'Russel', 'Oredimo', '09876543235', 'Philippines', 'Male', 'russel@gmail.com', 'russel', 'unregistered'),
(202300391, 'client', 'churl', 'Melody Churl', 'Colonia', '09234567890', 'Philippines', 'Female', 'melody@gmail.com', 'churl', 'unregistered'),
(202300392, 'client', 'erika', 'Erika', 'Cabaron', '09578965434', 'Philippines', 'Female', 'erikacabaron@gmail.com', 'erika', 'unregistered'),
(202300393, 'client', 'renz', 'Renz', 'Abellana', '09456798765', 'Philippines', 'Male', 'abellanarenz@gmail.com', 'renz', 'unregistered'),
(202300394, 'client', 'montoya', 'Ofelia', 'Montoya', '09789879676', 'Philippines', 'Female', 'ofel@gmail.com', 'montoya', 'unregistered'),
(202300395, 'client', 'Ruth Mary', 'Andy', 'Goren', '09876543456', 'Philippines', 'Male', 'andygoreng@gmail.com', 'ruthruth', 'unregistered'),
(202300396, 'client', 'eve', 'Rose Eve', 'Toylo', '09483234567', 'Philippines', 'Female', 'Rosetoylo@gmail.com', 'eve', 'unregistered'),
(202300397, 'client', 'khen', 'Khen', 'Espra', '09567899875', 'Philippines', 'Male', 'khen@gmail.com', 'espra', 'unregistered'),
(202300398, 'client', 'marlon', 'Marlon', 'Gravina', '09345678909', 'Philippines', 'Male', 'gravina_M@gmail.com', 'marlon', 'unregistered'),
(202300399, 'client', 'mariebeth', 'Mariebeth', 'Sanchez', '09789876898', 'Philippines', 'Female', 'mariebethsanchez45@gmail.com', 'sanchez', 'unregistered'),
(202300400, 'client', 'erik', 'Erik', 'Suela', '09765432345', 'Philippines', 'Male', 'eriksuela@gmail.com', 'suela', 'unregistered'),
(202300401, 'client', 'ritzy', 'Ritzy', 'Galon', '09876543456', 'Philippines', 'Female', 'ritzygalon@gmail.com', 'galon', 'unregistered'),
(202300402, 'client', 'tilde', 'Tilde', 'Lumbab', '09567899876', 'Philippines', 'Female', 'lumbabtilde@gmail.com', 'lumbab', 'unregistered'),
(202300403, 'client', 'dode', 'Dode', 'Cabatingan', '09876543212', 'Philippines', 'Male', 'dodecabatingan@gmail.com', 'dode', 'unregistered'),
(202300404, 'client', 'diego', 'Diego', 'Rosales', '09654345678', 'Philippines', 'Male', 'Diego@gmail.com', 'rosales', 'unregistered'),
(202300405, 'client', 'maryjoy', 'Mary Joy', 'Pahayahay', '09347898765', 'Philippines', 'Female', 'Mjpahayahay@gmail.com', 'pahayahay', 'unregistered'),
(202300430, 'client', 'divine', 'Divine Grace', 'Capa', '09345678909', 'Philippines', 'Female', 'Capadivine@gmail.com', 'divine', 'unregistered'),
(202300433, 'client', 'solesty', 'Solesty', 'Macasarte', '09345678943', 'Philippines', 'Female', 'soulestii@gmail.com', 'macasarte', 'unregistered'),
(202300434, 'client', 'vergil', 'Vergil', 'Ilagan', '09348323567', 'Philippines', 'Male', 'vergil@yahoo.com', 'ilagan', 'unregistered'),
(202300471, 'client', 'Sydney Joyce', 'Sydney Joyce', 'Balucan', '09785625366', 'Philippines', 'Female', 'joyce@gmail.com', 'Gwapa', 'unregistered'),
(202300472, 'client', 'Jose', 'Jose', 'Delosa', '09050266530', 'Philippines', 'Male', 'josedelosa@gmail.com', 'Jose sa krus', 'unregistered'),
(202300473, 'client', 'Ramon', 'Ramon', 'Moreno', '09876543456', 'Philippines', 'Male', 'moreno@gmail.com', '4d362c64', 'unregistered'),
(202300474, 'client', 'Jesus', 'Jesus', 'Herrera', '09876544567', 'Philippines', 'Male', 'herrera@gmail.com', '93bc7b27', 'unregistered'),
(202300475, 'client', 'Joan', 'Joan', 'Perez', '09876543234', 'Philippines', 'Female', 'gchamplin@gmail.com', '72b39e47', 'unregistered'),
(202300476, 'client', 'Sebastian', 'Sebastian', 'Garrido', '09876543345', 'Philippines', 'Male', 'sebastian.garrido@gmail.com', '6b86fb20', 'unregistered'),
(202300477, 'client', 'Joane', 'Joane', 'Delosa', '09120999407', 'Philippines', 'Female', 'Joane.delos@gmail.c', 'Joane123', 'unregistered'),
(202300478, 'client', 'María Pilar', 'María Pilar', 'Mora', '09876543456', 'Philippines', 'Female', 'mora@gmail.com', '2b10b18d', 'unregistered'),
(202300479, 'client', 'Lucia', 'Lucia', 'Pastor', '09876543234', 'Philippines', 'Female', 'pastorlucia@gmail.com', 'e5d65ca7', 'unregistered'),
(202300480, 'client', 'María Rosa', 'María Rosa', 'Guerrero', '09090987654', 'Philippines', 'Female', 'guerrero@gmail.com', '148fed2f', 'unregistered'),
(202300484, 'client', 'TcMargarette', 'TcMargarette', 'Pantillo', '09665761797', 'Philippines', 'Female', 'tcpantillo@gmail.com', 'LALISAJEON', 'unregistered'),
(202300485, 'client', 'Grison', 'Grison', 'Padillo', '09475475598', 'Philippines', 'Male', 'grisonpadillo24@gmail.com', 'padillo', 'unregistered'),
(202300486, 'client', 'amshe', 'Sheam', 'Cris', '09934509875', 'Philippines', 'Female', 'sheamcris@gmail.com', 'cris', 'unregistered'),
(202300487, 'client', 'james', 'James', 'Mintang', '098765433456', 'Philippines', 'Male', 'jamesmintz@gmail.com', 'mintang', 'unregistered'),
(202300488, 'client', 'Mekay_01', 'Katrina Yhv', 'Dumaplin', '09261569363', 'Philippines', 'Female', 'mekaydumaplin@gmail.com', '123456789', 'unregistered'),
(202300489, 'client', 'Irene_Jessa', 'Irene Jessa', 'Paulin', '09261569363', 'Philippines', 'Female', 'irenejessa@gmail.com', 'irene123', 'unregistered'),
(202300490, 'client', 'Marietta_123', 'Marietta', 'Dumaplin', '09268991232', 'Philippines', 'Female', 'mariettadumaplin@gmail.com', 'Inday_123', 'unregistered'),
(202300491, 'client', 'Reneboy', 'Renante', 'Dumaplin', '09556018416', 'Philippines', 'Male', 'renantedumaplin@gmail.com', 'Reneboy123', 'unregistered'),
(202300504, 'client', 'marvin', 'Marvin', 'Gonzales', '09060087753', 'Philippines', 'Male', 'marvingonz221@gmail.com', '1234', 'unregistered'),
(202300511, 'client', 'epe', 'Cent Junedy Lou', 'Epe', '09096554397', 'Philippines', 'Female', 'centepe.20@gmail.com', 'center', 'unregistered'),
(202300515, 'client', 'Aesyang', 'Aecy', 'Macalisang', '09606290239', 'Philippines', 'Female', 'aecymacalisang2@gmail.com', 'macalisang28', 'unregistered'),
(202300516, 'client', 'Abingabing', 'Arvian', 'Calibo', '09705448109', 'Philippines', 'Male', 'arvian.calibo19@gmail.com', 'abingcalibo', 'unregistered'),
(202300517, 'client', 'jankhen', 'Jan Khen', 'Dayon', '09269400121', 'Philippines', 'Female', 'jankhendayon@gmail.com', 'jankhen', 'unregistered'),
(202300522, 'client', 'dendi0123', 'Diomari Jose', 'Vale', '09619081616', 'Philippines', 'Male', 'valediomari@gmail.com', 'd10m@r130', 'unregistered'),
(202300523, 'client', 'Marvin', 'Marvin', 'Gonzales', '09053964708', 'Philippines', 'Male', 'marvingonzales@gmail.com', '1234', 'unregistered'),
(202300524, 'client', 'boopers', 'Lance Harvey', 'Ongayo', '09558472059', 'Philippines', 'Male', 'bulokjeam@gmail.com', 'caizu12b', 'unregistered'),
(202300526, 'client', 'TEST', 'd', 'd', '34', 'df', 'Male', 'dfd', '202cb962ac59075b964b07152d234b70', 'unregistered'),
(202300527, 'client', 'davegrison', 'Dave', 'Padillo', '0921321321323', 'Thailand', 'Male', 'davidejoseph@gmail.com', '1610838743cc90e3e4fdda748282d9b8', 'unregistered'),
(240530351, 'client', 'heyder', 'hello', 'there', '09034567705', 'Philippines', 'Male', 'there@gmail.com', '123', 'registered'),
(240606072, 'client', 'khecy', 'Khecy', 'Palioto', '0929318971', 'UK', 'Female', 'khecy@gmail.com', '1234', 'registered'),
(240606119, 'artist', 'artes', 'sekret', 'tagnaa', '09054346123', 'Philippines', 'Female', 'hekhoks@gmail.com', '123', 'registered'),
(240606124, 'artist', 'Eps', 'David', 'Epe', '09054346707', 'Philippines', 'Male', 'davidjoseph@gmail.com', '123', 'registered'),
(240606254, 'artist', 'fsdfddf', 'd', 'd', '234', 'resdf', 'Male', 'wefd@gmail.com', '123', 'registered'),
(240606383, 'artist', 'hellowsssxx', 'juana', 'criz', '2896975', 'UK', 'Female', 'wtyfj@gmail.com', '123', 'registered'),
(240606695, 'artist', 'w', 'w', 'w', '2', 'd', 'Male', 'w@gmail.com', '123', 'registered'),
(240610160, 'client', 'eyy', 'dsf', 'dsf', '09053964708', 'Philippines', 'Male', 'hep@gmail.com', '123', 'registered'),
(240610402, 'client', 'jems', 'James', 'Cabatuan', '09043567808', 'Philippines', 'Male', 'jamescabatuan@gmail.com', '123', 'registered'),
(240610425, 'client', 'client', 'Nems', 'Testt', '09034567808', 'Philippines', 'Female', 'client2@gmail.com', 'client', 'registered'),
(240610668, 'client', 'name', 'Name', 'Lname', '0934245', 'Philippines', 'Male', 'name@gmail.com', '321', 'registered'),
(240610965, 'artist', 'artess', 'Nname', 'Lname', '12334', 'Philippines', 'Female', 'artist@gmail.com', '123', 'registered'),
(240611569, 'client', 'client', 'John', 'Doe', '0912345678', 'Philippines ', 'Female', 'clientt@gmail.com', '1234', 'registered'),
(240613247, 'client', 'jessie', 'Jessa', 'Abadilla', '09123456789', 'Philippines ', 'Female', 'j@gmail.com', '123', 'registered'),
(240613407, 'client', 'Tin', 'Hehd', 'Hdhd', '626', 'Hdh', 'Male', 'hdhd@gmail.com', '123', 'registered');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `art`
--
ALTER TABLE `art`
  ADD PRIMARY KEY (`Artwork_ID`),
  ADD KEY `idx_Artstyle` (`Artstyle`),
  ADD KEY `FK_User_ID` (`User_ID`);

--
-- Indexes for table `commission`
--
ALTER TABLE `commission`
  ADD PRIMARY KEY (`Commission_ID`),
  ADD KEY `user_id` (`User_ID`),
  ADD KEY `artist_id` (`artist_id`);

--
-- Indexes for table `ratings`
--
ALTER TABLE `ratings`
  ADD PRIMARY KEY (`ratingid`),
  ADD KEY `userid` (`userid`),
  ADD KEY `artistid` (`artistid`),
  ADD KEY `Commission_ID` (`Commission_ID`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`User_ID`),
  ADD KEY `idx_User_ID` (`User_ID`),
  ADD KEY `idx_username` (`Username`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `art`
--
ALTER TABLE `art`
  MODIFY `Artwork_ID` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=202306062;

--
-- AUTO_INCREMENT for table `commission`
--
ALTER TABLE `commission`
  MODIFY `Commission_ID` int(20) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=53;

--
-- AUTO_INCREMENT for table `ratings`
--
ALTER TABLE `ratings`
  MODIFY `ratingid` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `User_ID` int(13) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2147483648;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `art`
--
ALTER TABLE `art`
  ADD CONSTRAINT `FK_User_ID` FOREIGN KEY (`User_ID`) REFERENCES `users` (`User_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `art_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `users` (`User_ID`) ON DELETE CASCADE;

--
-- Constraints for table `commission`
--
ALTER TABLE `commission`
  ADD CONSTRAINT `commission_ibfk_1` FOREIGN KEY (`User_ID`) REFERENCES `users` (`User_ID`) ON DELETE CASCADE,
  ADD CONSTRAINT `commission_ibfk_2` FOREIGN KEY (`artist_id`) REFERENCES `users` (`User_ID`) ON DELETE CASCADE;

--
-- Constraints for table `ratings`
--
ALTER TABLE `ratings`
  ADD CONSTRAINT `ratings_ibfk_1` FOREIGN KEY (`userid`) REFERENCES `users` (`User_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ratings_ibfk_2` FOREIGN KEY (`artistid`) REFERENCES `users` (`User_ID`) ON DELETE CASCADE ON UPDATE CASCADE,
  ADD CONSTRAINT `ratings_ibfk_3` FOREIGN KEY (`Commission_ID`) REFERENCES `commission` (`Commission_ID`) ON DELETE CASCADE ON UPDATE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
