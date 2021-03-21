-- phpMyAdmin SQL Dump
-- version 5.1.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Erstellungszeit: 21. Mrz 2021 um 12:32
-- Server-Version: 10.4.18-MariaDB
-- PHP-Version: 8.0.3

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Datenbank: `holiday_booking`
--

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `flats`
--

CREATE TABLE `flats` (
                         `id` int(11) NOT NULL,
                         `name` varchar(30) DEFAULT NULL,
                         `size` int(4) NOT NULL,
                         `price` int(5) NOT NULL,
                         `info` text NOT NULL,
                         `adress` varchar(255) DEFAULT NULL,
                         `singlebed` int(3) NOT NULL,
                         `doublebed` int(3) NOT NULL,
                         `wifi` tinyint(1) DEFAULT 0,
                         `tv` tinyint(1) DEFAULT 0,
                         `shower` tinyint(1) DEFAULT 0,
                         `kitchen` tinyint(1) DEFAULT 0,
                         `washer` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `flats`
--

INSERT INTO `flats` (`id`, `name`, `size`, `price`, `info`, `adress`, `singlebed`, `doublebed`, `wifi`, `tv`, `shower`, `kitchen`, `washer`) VALUES
(1, 'Wohnung 1', 22, 210, 'Geile Wohnung', 'Mannheimer Straße 5-7', 1, 0, 1, 1, 1, 1, 0),
(2, 'Wohnung 2', 19, 190, 'Geile Wohnung', 'Mannheimer Straße 5-7', 1, 0, 1, 0, 1, 1, 1);

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `reservation`
--

CREATE TABLE `reservation` (
                               `id` int(11) NOT NULL,
                               `user_id` int(11) DEFAULT NULL,
                               `flat_id` int(11) DEFAULT NULL,
                               `start` timestamp NULL DEFAULT NULL,
                               `end` timestamp NULL DEFAULT NULL,
                               `status` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- --------------------------------------------------------

--
-- Tabellenstruktur für Tabelle `users`
--

CREATE TABLE `users` (
                         `id` int(11) NOT NULL,
                         `firstname` varchar(30) DEFAULT NULL,
                         `lastname` varchar(30) DEFAULT NULL,
                         `email` varchar(50) DEFAULT NULL,
                         `role` varchar(20) NOT NULL,
                         `password` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Daten für Tabelle `users`
--

INSERT INTO `users` (`id`, `firstname`, `lastname`, `email`, `role`, `password`) VALUES
(1, 'Hans', 'Günther', 'hansguenther@freemail.lul', 'guest', '1509442'),
(2, 'Manfred', 'Auerbach', 'Auerhauer@freemail.lul', 'guest', '1509442');

--
-- Indizes der exportierten Tabellen
--

--
-- Indizes für die Tabelle `flats`
--
ALTER TABLE `flats`
    ADD PRIMARY KEY (`id`);

--
-- Indizes für die Tabelle `reservation`
--
ALTER TABLE `reservation`
    ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `flat_id` (`flat_id`);

--
-- Indizes für die Tabelle `users`
--
ALTER TABLE `users`
    ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT für exportierte Tabellen
--

--
-- AUTO_INCREMENT für Tabelle `flats`
--
ALTER TABLE `flats`
    MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=1003;

--
-- AUTO_INCREMENT für Tabelle `reservation`
--
ALTER TABLE `reservation`
    MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT für Tabelle `users`
--
ALTER TABLE `users`
    MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- Constraints der exportierten Tabellen
--

--
-- Constraints der Tabelle `reservation`
--
ALTER TABLE `reservation`
    ADD CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`flat_id`) REFERENCES `flats` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
