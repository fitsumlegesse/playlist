-- phpMyAdmin SQL Dump
-- version 4.4.15.10
-- https://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Mar 18, 2020 at 07:58 PM
-- Server version: 5.5.64-MariaDB
-- PHP Version: 5.4.16

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `Playlist`
--

-- --------------------------------------------------------

--
-- Table structure for table `Album`
--

CREATE TABLE IF NOT EXISTS `Album` (
  `albumID` int(15) NOT NULL,
  `artistID` int(15) DEFAULT NULL,
  `albumTitle` varchar(255) DEFAULT NULL,
  `albumCoverArt` blob,
  `albumRelDate` datetime DEFAULT NULL,
  `genreID` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Artist`
--

CREATE TABLE IF NOT EXISTS `Artist` (
  `artistID` int(15) NOT NULL,
  `firstLast` varchar(255) NOT NULL,
  `artistCountry` varchar(255) NOT NULL,
  `artistBio` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Genres`
--

CREATE TABLE IF NOT EXISTS `Genres` (
  `genreID` int(15) NOT NULL,
  `genreName` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `NewSong`
--

CREATE TABLE IF NOT EXISTS `NewSong` (
  `newSongID` int(15) NOT NULL,
  `songID` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Songs`
--

CREATE TABLE IF NOT EXISTS `Songs` (
  `songID` int(15) NOT NULL,
  `songName` varchar(255) NOT NULL,
  `albumID` int(15) NOT NULL,
  `genreID` int(15) NOT NULL,
  `releaseDate` datetime NOT NULL,
  `songCoverArt` blob NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `StreamingPlatform`
--

CREATE TABLE IF NOT EXISTS `StreamingPlatform` (
  `platformID` int(15) NOT NULL,
  `playlistName` varchar(255) NOT NULL,
  `creationDate` datetime NOT NULL,
  `userID` int(255) NOT NULL,
  `platformPassword` varchar(255) NOT NULL,
  `playlistID` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `TrendingMusic`
--

CREATE TABLE IF NOT EXISTS `TrendingMusic` (
  `TrendingMusicID` int(15) NOT NULL,
  `songID` int(15) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `UserPlaylist`
--

CREATE TABLE IF NOT EXISTS `UserPlaylist` (
  `playlistID` int(15) NOT NULL DEFAULT '0',
  `playlistName` varchar(255) DEFAULT NULL,
  `creationDate` date DEFAULT NULL,
  `userID` int(15) DEFAULT NULL,
  `songID` int(15) DEFAULT NULL,
  `playlistPicture` blob
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

-- --------------------------------------------------------

--
-- Table structure for table `Users`
--

CREATE TABLE IF NOT EXISTS `Users` (
  `userID` int(15) NOT NULL,
  `firstLast` varchar(255) DEFAULT NULL,
  `birthDate` date DEFAULT NULL,
  `userName` varchar(255) DEFAULT NULL,
  `userEmail` varchar(255) DEFAULT NULL,
  `userPhone` int(15) DEFAULT NULL,
  `userPassword` int(18) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `Album`
--
ALTER TABLE `Album`
  ADD PRIMARY KEY (`albumID`),
  ADD KEY `artistID` (`artistID`),
  ADD KEY `genreID` (`genreID`);

--
-- Indexes for table `Artist`
--
ALTER TABLE `Artist`
  ADD PRIMARY KEY (`artistID`);

--
-- Indexes for table `Genres`
--
ALTER TABLE `Genres`
  ADD PRIMARY KEY (`genreID`);

--
-- Indexes for table `NewSong`
--
ALTER TABLE `NewSong`
  ADD PRIMARY KEY (`newSongID`),
  ADD KEY `songID` (`songID`);

--
-- Indexes for table `Songs`
--
ALTER TABLE `Songs`
  ADD PRIMARY KEY (`songID`),
  ADD KEY `albumID` (`albumID`),
  ADD KEY `genreID` (`genreID`);

--
-- Indexes for table `StreamingPlatform`
--
ALTER TABLE `StreamingPlatform`
  ADD PRIMARY KEY (`platformID`),
  ADD KEY `playlistID` (`playlistID`),
  ADD KEY `userID` (`userID`);

--
-- Indexes for table `TrendingMusic`
--
ALTER TABLE `TrendingMusic`
  ADD PRIMARY KEY (`TrendingMusicID`),
  ADD KEY `songID` (`songID`);

--
-- Indexes for table `UserPlaylist`
--
ALTER TABLE `UserPlaylist`
  ADD PRIMARY KEY (`playlistID`),
  ADD KEY `userID` (`userID`),
  ADD KEY `songID` (`songID`);

--
-- Indexes for table `Users`
--
ALTER TABLE `Users`
  ADD PRIMARY KEY (`userID`);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `Album`
--
ALTER TABLE `Album`
  ADD CONSTRAINT `Album_ibfk_1` FOREIGN KEY (`artistID`) REFERENCES `Artist` (`artistID`),
  ADD CONSTRAINT `Album_ibfk_2` FOREIGN KEY (`genreID`) REFERENCES `Genres` (`genreID`);

--
-- Constraints for table `NewSong`
--
ALTER TABLE `NewSong`
  ADD CONSTRAINT `NewSong_ibfk_1` FOREIGN KEY (`songID`) REFERENCES `Songs` (`songID`);

--
-- Constraints for table `Songs`
--
ALTER TABLE `Songs`
  ADD CONSTRAINT `Songs_ibfk_1` FOREIGN KEY (`albumID`) REFERENCES `Album` (`albumID`),
  ADD CONSTRAINT `Songs_ibfk_2` FOREIGN KEY (`genreID`) REFERENCES `Genres` (`genreID`);

--
-- Constraints for table `StreamingPlatform`
--
ALTER TABLE `StreamingPlatform`
  ADD CONSTRAINT `StreamingPlatform_ibfk_2` FOREIGN KEY (`userID`) REFERENCES `Users` (`userID`),
  ADD CONSTRAINT `StreamingPlatform_ibfk_1` FOREIGN KEY (`playlistID`) REFERENCES `UserPlaylist` (`playlistID`);

--
-- Constraints for table `TrendingMusic`
--
ALTER TABLE `TrendingMusic`
  ADD CONSTRAINT `TrendingMusic_ibfk_1` FOREIGN KEY (`songID`) REFERENCES `Songs` (`songID`);

--
-- Constraints for table `UserPlaylist`
--
ALTER TABLE `UserPlaylist`
  ADD CONSTRAINT `UserPlaylist_ibfk_3` FOREIGN KEY (`songID`) REFERENCES `Songs` (`songID`),
  ADD CONSTRAINT `UserPlaylist_ibfk_1` FOREIGN KEY (`userID`) REFERENCES `Users` (`userID`),
  ADD CONSTRAINT `UserPlaylist_ibfk_2` FOREIGN KEY (`userID`) REFERENCES `Users` (`userID`);

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
