-- phpMyAdmin SQL Dump
-- version 5.0.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Sep 17, 2020 at 05:13 PM
-- Server version: 10.4.13-MariaDB
-- PHP Version: 7.4.7

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hidroponik`
--

-- --------------------------------------------------------

--
-- Table structure for table `pelanggan`
--

CREATE TABLE `pelanggan` (
  `id` int(11) NOT NULL,
  `nama_pelanggan` varchar(45) NOT NULL,
  `hp` varchar(15) NOT NULL,
  `alamat` text NOT NULL,
  `sayuran_id` int(11) NOT NULL,
  `jumlah` varchar(50) NOT NULL,
  `email` varchar(50) NOT NULL,
  `password` varchar(40) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `pelanggan`
--

INSERT INTO `pelanggan` (`id`, `nama_pelanggan`, `hp`, `alamat`, `sayuran_id`, `jumlah`, `email`, `password`) VALUES
(3, 'saipudin', '0897778909', 'papua', 0, '', 'saipudin@gmail.com', '123456789'),
(4, 'zaianal', '08977789099', 'papuass', 0, '', 'saipudinaa@gmail.com', '1234567679'),
(5, 'saipudin', '0897778909', 'papua', 0, '', 'saipudin@gmail.com', '1234567679'),
(6, 'saipudin', '0897778909', 'papua', 0, '', 'saipudin@gmail.com', '1234567679'),
(10, 'david sowet', '0897778909', 'papua', 0, '', 'saipudin@gmail.com', '123e543'),
(11, 'zainal', '45678765678765', 'papua nunggini', 0, '', 'zainal@gmail.com', '1234567898765432'),
(12, 'rizki', '083247893273', 'kalbar', 0, '', 'riski@gmail.com', 'kalbar'),
(13, 'QWQW', 'QWQWQ', 'QWQW', 0, '', 'QWQWQ', 'QWQWQ'),
(14, 'QWQWdsds', 'dsde23', '2323', 0, '', 'asasasd', '3223223');

-- --------------------------------------------------------

--
-- Table structure for table `sayuran`
--

CREATE TABLE `sayuran` (
  `id` int(11) NOT NULL,
  `nama` varchar(100) NOT NULL,
  `harga` double NOT NULL,
  `status` enum('Tersedia','Habis') NOT NULL,
  `gambar` varchar(45) DEFAULT NULL,
  `keterangan` text DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sayuran`
--

INSERT INTO `sayuran` (`id`, `nama`, `harga`, `status`, `gambar`, `keterangan`) VALUES
(1, 'kangkung', 22500, 'Tersedia', 'kangkung.jpg', 'fresh'),
(2, 'selada keriting', 15000, 'Habis', 'selada.jpg', 'fresh'),
(3, 'selada merah', 15000, 'Habis', 'seladamerah.jpg', 'fresh'),
(5, 'bayam', 6000, 'Habis', 'bayam.jpg', 'fress'),
(8, 'Cabai Keriting', 7000, 'Tersedia', 'cabaikeriting.jpg', 'Fress Quantity 4 berat 250 gr'),
(9, 'Cabai Besar', 6000, 'Tersedia', 'cabaibesar.jpg', 'Fress Quantity berat 250 gr'),
(10, 'Daun Bawang', 10000, 'Tersedia', 'daunbawang.jpg', 'fress'),
(11, 'Kale', 12000, 'Tersedia', 'kale.jpg', 'Fress'),
(12, 'Baby Roman', 8000, 'Tersedia', 'babyroman.jpg', 'Fress'),
(13, 'Kembang Kol', 20000, 'Tersedia', 'kembangkol.jpg', 'fress'),
(14, 'Romaine', 12000, 'Tersedia', 'romaine.jpg', 'Fress'),
(15, 'Strawberry', 27000, 'Tersedia', 'strowbery.jpg', 'Fress Quantity 2 berat 170 gr');

-- --------------------------------------------------------

--
-- Table structure for table `user`
--

CREATE TABLE `user` (
  `id` int(11) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(40) NOT NULL,
  `email` varchar(45) NOT NULL,
  `role` enum('admin','staff') NOT NULL,
  `foto` varchar(45) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `user`
--

INSERT INTO `user` (`id`, `username`, `password`, `email`, `role`, `foto`) VALUES
(1, 'admin', 'd033e22ae348aeb5660fc2140aec35850c4da997', 'admin@gmail.com', 'admin', 'admin.jpg'),
(2, 'staff', '987654321', 'staff@gmail.com', 'staff', 'staff.jpg'),
(3, 'andi', 'e36239fa654773ac4df03a65adbb43352b89eb1e', 'andi@gmail.com', 'staff', 'andi.jpg');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `pelanggan`
--
ALTER TABLE `pelanggan`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sayuran`
--
ALTER TABLE `sayuran`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `nama_UNIQUE` (`nama`);

--
-- Indexes for table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `pass_UNIQUE` (`username`),
  ADD UNIQUE KEY `email_UNIQUE` (`email`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `pelanggan`
--
ALTER TABLE `pelanggan`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `sayuran`
--
ALTER TABLE `sayuran`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=42;

--
-- AUTO_INCREMENT for table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
