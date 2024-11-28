-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Servidor: 127.0.0.1
-- Tiempo de generación: 08-08-2022 a las 14:02:06
-- Versión del servidor: 10.4.24-MariaDB
-- Versión de PHP: 8.1.6


SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de datos: `gomovies`
--

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `actor`
--
drop database gomovies

create database gomovies

use  gomovies

CREATE TABLE `actor` (
  `idact` int(11) NOT NULL,
  `nomact` varchar(35) COLLATE utf8_unicode_ci NOT NULL,
  `apedoc` varchar(35) COLLATE utf8_unicode_ci NOT NULL,
  `foto` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `naci` date NOT NULL,
  `status` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `fere` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `actor`
--

INSERT INTO `actor` (`idact`, `nomact`, `apedoc`, `foto`, `naci`, `status`, `fere`) VALUES
(2, 'Chiwetel', 'Ejiofor', '98741.jpg', '1977-07-10', '1', '2022-07-29 01:30:19'),
(3, 'Benedict Timothy', 'Carlton Cumberbatch', '14954.png', '1976-09-19', '1', '2022-07-29 01:32:07');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `customer`
--

CREATE TABLE `customer` (
  `idcli` int(11) NOT NULL,
  `nomcli` varchar(35) COLLATE utf8_unicode_ci NOT NULL,
  `apecli` varchar(35) COLLATE utf8_unicode_ci NOT NULL,
  `gener` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `tele` char(14) COLLATE utf8_unicode_ci NOT NULL,
  `status` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `foto` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `usuario` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `correo` varchar(35) COLLATE utf8_unicode_ci NOT NULL,
  `clave` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `rol` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `fere` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `customer`
--

INSERT INTO `customer` (`idcli`, `nomcli`, `apecli`, `gener`, `tele`, `status`, `foto`, `usuario`, `correo`, `clave`, `rol`, `fere`) VALUES
(2, 'Marco', 'Rosales', 'Masculino', '+51988776477', '1', '109950.png', 'mmcar22', 'mmcar22@gmail.com', 'b0baee9d279d34fa1dfd71aadb908c3f', '2', '2022-07-30 10:32:28'),
(3, 'Manuela', 'Torres', 'Femenino', '+51999765456', '1', '406217.png', 'manu33', 'manuu1a@gmail.com', 'b0baee9d279d34fa1dfd71aadb908c3f', '2', '2022-07-30 10:32:33'),
(4, 'Laura', 'Yovera', 'Femenino', '+51999876788', '1', '123831.png', 'lau22', 'lau22@gmail.com', 'b0baee9d279d34fa1dfd71aadb908c3f', '2', '2022-07-30 12:22:25');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `gender`
--

CREATE TABLE `gender` (
  `idge` int(11) NOT NULL,
  `nomge` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `descp` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `status` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `foto` varchar(100) COLLATE utf8_unicode_ci NOT NULL,
  `fere` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `gender`
--

INSERT INTO `gender` (`idge`, `nomge`, `descp`, `status`, `foto`, `fere`) VALUES
(3, 'Acción', 'Acción', '1', '953518.jpg', '2022-07-29 00:32:15'),
(4, 'Ciencia Ficción', 'Ciencia Ficción', '1', '889912.jpg', '2022-07-28 22:44:08'),
(5, 'Comedia', 'Comedia', '1', '642657.jpg', '2022-07-28 22:44:21'),
(6, 'Drama', 'Drama', '1', 'nn.jpg', '2022-07-29 00:21:04'),
(7, 'Terror', 'terror ', '1', '592502.jpg', '2022-07-29 00:41:18');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `movie`
--

CREATE TABLE `movie` (
  `idmovi` int(11) NOT NULL,
  `nommo` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `desmo` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `calim` char(2) COLLATE utf8_unicode_ci NOT NULL,
  `idge` int(11) NOT NULL,
  `idact` int(11) NOT NULL,
  `foto` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `durac` varchar(15) COLLATE utf8_unicode_ci NOT NULL,
  `fecmo` date NOT NULL,
  `video` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `fere` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `movie`
--

INSERT INTO `movie` (`idmovi`, `nommo`, `desmo`, `calim`, `idge`, `idact`, `foto`, `durac`, `fecmo`, `video`, `fere`) VALUES
(1, 'Sonic 2: La película', 'Después de establecerse en Green Hills, Sonic se muere por demostrar que tiene madera de auténtico héroe. ', 'HD', 4, 2, '74031.jpg', '122 min', '2022-10-08', 'videoplayback-707.mp4', '2022-08-08 09:49:28'),
(2, 'DC LIGA DE SUPERMASCOTAS', 'Película de animación protagonizada por las mascotas de los superhéroes de DC Cómics. Una pandilla que se dedica a la lucha contra el crimen mientras sus dueños, Superman, Batman, Aquaman, Linterna Verde y Wonder Woman', 'HD', 4, 3, '579314.jpg', '1h 46min', '2022-07-22', 'videoplayback-313.mp4', '2022-08-08 10:24:40');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `per_user`
--

CREATE TABLE `per_user` (
  `idperus` int(11) NOT NULL,
  `id` int(11) NOT NULL,
  `usuario` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `clave` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `rol` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `estado` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `foto` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `fere` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `per_user`
--

INSERT INTO `per_user` (`idperus`, `id`, `usuario`, `clave`, `rol`, `estado`, `foto`, `fere`) VALUES
(1, 11, 'maanan', 'b0baee9d279d34fa1dfd71aadb908c3f', '3', '1', '1.png', '2022-08-07 07:57:43'),
(2, 11, 'ddddd', 'b0baee9d279d34fa1dfd71aadb908c3f', '3', '1', '3.png', '2022-08-07 07:58:03');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `suscrp`
--

CREATE TABLE `suscrp` (
  `idsus` int(11) NOT NULL,
  `noms` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `descr` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `foto` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `status` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `preci` decimal(10,2) NOT NULL,
  `dura` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `fere` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `suscrp`
--

INSERT INTO `suscrp` (`idsus`, `noms`, `descr`, `foto`, `status`, `preci`, `dura`, `fere`) VALUES
(1, 'FREE', 'FREE', '397594.png', '1', '0.00', 'FREE', '2022-08-07 08:29:59'),
(2, 'STANDARD', 'STANDARD', '751259.png', '1', '16.90', '3 meses', '2022-08-07 08:31:33'),
(3, 'PREMIUM', 'PREMIUM', '318757.png', '1', '24.90', '6 meses', '2022-08-07 08:32:01');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `sus_clie`
--

CREATE TABLE `sus_clie` (
  `idsucli` int(11) NOT NULL,
  `idcli` int(11) NOT NULL,
  `idsus` int(11) NOT NULL,
  `feini` date NOT NULL,
  `fefin` date NOT NULL,
  `total` decimal(10,2) NOT NULL,
  `status` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `fere` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `sus_clie`
--

INSERT INTO `sus_clie` (`idsucli`, `idcli`, `idsus`, `feini`, `fefin`, `total`, `status`, `fere`) VALUES
(1, 2, 1, '2022-08-07', '0000-00-00', '0.00', '1', '2022-08-07 10:08:57'),
(2, 3, 2, '2022-08-07', '2022-11-07', '16.90', '1', '2022-08-07 10:09:34');

-- --------------------------------------------------------

--
-- Estructura de tabla para la tabla `usuarios`
--

CREATE TABLE `usuarios` (
  `id` int(11) NOT NULL,
  `usuario` varchar(25) COLLATE utf8_unicode_ci NOT NULL,
  `nombre` varchar(35) COLLATE utf8_unicode_ci NOT NULL,
  `correo` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `clave` varchar(255) COLLATE utf8_unicode_ci NOT NULL,
  `rol` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `estado` char(1) COLLATE utf8_unicode_ci NOT NULL,
  `foto` varchar(150) COLLATE utf8_unicode_ci NOT NULL,
  `fere` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;

--
-- Volcado de datos para la tabla `usuarios`
--

INSERT INTO `usuarios` (`id`, `usuario`, `nombre`, `correo`, `clave`, `rol`, `estado`, `foto`, `fere`) VALUES
(1, 'admin', 'JORDAN ROKE', 'admin@gmail.com', 'b0baee9d279d34fa1dfd71aadb908c3f', '1', '1', '', '2022-08-08 11:36:07'),
(10, 'manue222', 'Manuel Torres Perales', 'manuu@gmail.com', 'b0baee9d279d34fa1dfd71aadb908c3f', '2', '1', 'user1.png', '2022-08-05 20:43:48'),
(11, 'laur222q', 'Laura Lorena Torres Suarez', 'laruza@gmai.com', 'b0baee9d279d34fa1dfd71aadb908c3f', '2', '1', 'user6.png', '2022-08-06 03:05:12');

--
-- Índices para tablas volcadas
--

--
-- Indices de la tabla `actor`
--
ALTER TABLE `actor`
  ADD PRIMARY KEY (`idact`);

--
-- Indices de la tabla `customer`
--
ALTER TABLE `customer`
  ADD PRIMARY KEY (`idcli`);

--
-- Indices de la tabla `gender`
--
ALTER TABLE `gender`
  ADD PRIMARY KEY (`idge`);

--
-- Indices de la tabla `movie`
--
ALTER TABLE `movie`
  ADD PRIMARY KEY (`idmovi`),
  ADD KEY `idge` (`idge`),
  ADD KEY `idact` (`idact`);

--
-- Indices de la tabla `per_user`
--
ALTER TABLE `per_user`
  ADD PRIMARY KEY (`idperus`),
  ADD KEY `id` (`id`);

--
-- Indices de la tabla `suscrp`
--
ALTER TABLE `suscrp`
  ADD PRIMARY KEY (`idsus`);

--
-- Indices de la tabla `sus_clie`
--
ALTER TABLE `sus_clie`
  ADD PRIMARY KEY (`idsucli`),
  ADD KEY `idcli` (`idcli`),
  ADD KEY `idsus` (`idsus`);

--
-- Indices de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT de las tablas volcadas
--

--
-- AUTO_INCREMENT de la tabla `actor`
--
ALTER TABLE `actor`
  MODIFY `idact` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `customer`
--
ALTER TABLE `customer`
  MODIFY `idcli` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT de la tabla `gender`
--
ALTER TABLE `gender`
  MODIFY `idge` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT de la tabla `movie`
--
ALTER TABLE `movie`
  MODIFY `idmovi` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `per_user`
--
ALTER TABLE `per_user`
  MODIFY `idperus` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `suscrp`
--
ALTER TABLE `suscrp`
  MODIFY `idsus` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT de la tabla `sus_clie`
--
ALTER TABLE `sus_clie`
  MODIFY `idsucli` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT de la tabla `usuarios`
--
ALTER TABLE `usuarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Restricciones para tablas volcadas
--

--
-- Filtros para la tabla `movie`
--
ALTER TABLE `movie`
  ADD CONSTRAINT `movie_ibfk_1` FOREIGN KEY (`idge`) REFERENCES `gender` (`idge`),
  ADD CONSTRAINT `movie_ibfk_2` FOREIGN KEY (`idact`) REFERENCES `actor` (`idact`);

--
-- Filtros para la tabla `per_user`
--
ALTER TABLE `per_user`
  ADD CONSTRAINT `per_user_ibfk_1` FOREIGN KEY (`id`) REFERENCES `usuarios` (`id`);

--
-- Filtros para la tabla `sus_clie`
--
ALTER TABLE `sus_clie`
  ADD CONSTRAINT `sus_clie_ibfk_1` FOREIGN KEY (`idcli`) REFERENCES `customer` (`idcli`),
  ADD CONSTRAINT `sus_clie_ibfk_2` FOREIGN KEY (`idsus`) REFERENCES `suscrp` (`idsus`);
COMMIT;

40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT ;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
