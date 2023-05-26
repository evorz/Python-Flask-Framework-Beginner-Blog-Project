-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Anamakine: 127.0.0.1
-- Üretim Zamanı: 26 May 2023, 21:43:23
-- Sunucu sürümü: 10.4.28-MariaDB
-- PHP Sürümü: 8.2.4

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Veritabanı: `evorzblog`
--

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `articles`
--

CREATE TABLE `articles` (
  `id` int(11) NOT NULL,
  `title` text NOT NULL,
  `author` text NOT NULL,
  `content` text NOT NULL,
  `created_date` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Tablo döküm verisi `articles`
--

INSERT INTO `articles` (`id`, `title`, `author`, `content`, `created_date`) VALUES
(1, 'Mustafa Kemal Atatürk\'ün Gençliğe Hitabesi', 'PirateJack', '<p><strong>Gen&ccedil;liğe Hitabe</strong></p>\r\n\r\n<p>Ey T&uuml;rk gen&ccedil;liği! Birinci vazifen; T&uuml;rk istiklalini, T&uuml;rk cumhuriyetini, ilelebet muhafaza ve m&uuml;dafaa etmektir.</p>\r\n\r\n<p>&nbsp; &nbsp;Mevcudiyetinin ve istikbalinin yeg&acirc;ne temeli budur. Bu temel, senin en kıymetli hazinendir. İstikbalde dahi seni bu hazineden mahrum etmek isteyecek d&acirc;hil&icirc; ve haric&icirc; bedhahların olacaktır. Bir g&uuml;n, istiklal ve cumhuriyeti m&uuml;dafaa mecburiyetine d&uuml;şersen, vazifeye atılmak i&ccedil;in i&ccedil;inde bulunacağın vaziyetin imk&acirc;n ve şeraitini d&uuml;ş&uuml;nmeyeceksin. Bu imk&acirc;n ve şerait, &ccedil;ok nam&uuml;sait bir mahiyette tezah&uuml;r edebilir. İstiklal ve cumhuriyetine kastedecek d&uuml;şmanlar, b&uuml;t&uuml;n d&uuml;nyada emsali g&ouml;r&uuml;lmemiş bir galibiyetin m&uuml;messili olabilirler. Cebren ve hile ile aziz vatanın b&uuml;t&uuml;n kaleleri zapt edilmiş, b&uuml;t&uuml;n tersanelerine girilmiş, b&uuml;t&uuml;n orduları dağıtılmış ve memleketin her k&ouml;şesi bilfiil işgal edilmiş olabilir. B&uuml;t&uuml;n bu şeraitten daha elim ve daha vahim olmak &uuml;zere, memleketin d&acirc;hilinde iktidara sahip olanlar, gaflet ve dalalet ve hatta hıyanet i&ccedil;inde bulunabilirler. Hatta bu iktidar sahipleri, şahsi menfaatlerini m&uuml;stevlilerin siyasi emelleriyle tevhit edebilirler. Millet, fakruzaruret i&ccedil;inde harap ve bitap d&uuml;şm&uuml;ş olabilir.</p>\r\n\r\n<p>&nbsp;&nbsp; Ey T&uuml;rk istikbalinin evladı! İşte, bu ahval ve şerait i&ccedil;inde dahi vazifen, T&uuml;rk istiklal ve cumhuriyetini kurtarmaktır. Muhta&ccedil; olduğun kudret, damarlarındaki asil kanda mevcuttur.</p>\r\n\r\n<p>&nbsp;</p>\r\n\r\n<p><img alt=\"\" src=\"https://www.21yyte.org/media/k2/items/cache/42fe694392be66d4470016b90c083bb6_XL.jpg\" style=\"height:770px; width:1400px\" /></p>\r\n', '2023-05-19 20:37:30'),
(3, 'deneme ', 'PirateJack', '<p>deneme</p>\r\n', '2023-05-26 19:33:46'),
(4, 'muasffsa', 'PirateJack', '<p>muasf asffas</p>\r\n', '2023-05-26 19:33:54'),
(5, 'saasfsaffsa', 'PirateJack', '<p>as</p>\r\n', '2023-05-26 19:34:07');

-- --------------------------------------------------------

--
-- Tablo için tablo yapısı `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` text NOT NULL,
  `email` text NOT NULL,
  `username` text NOT NULL,
  `password` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Tablo döküm verisi `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `username`, `password`) VALUES
(2, 'Jack Sparrow', 'pirate.killer@gmail.com', 'PirateJack', '$5$rounds=535000$wTU2byAUo22/nTuh$8siv19B1o4uxePybILce6lkPqFz/RGvw0fKbNYu4Ba0'),
(4, 'Ali Veli', 'ali.veli@hotmail.com', 'KırkyediElli', '$5$rounds=535000$IFFLcMiTqCT/WiE9$Zj1SJA9o7i5ggILRb7BqZ2YUu/VQzy/iJjHxo9Vt.5B'),
(6, 'saffasas', 'safsfaasffas@hotmail.com', 'asfasf', '$5$rounds=535000$mn/Oe0M3a1xK68Yc$v2qhGUleX4DdVFhbYgJZC/T.Y1j1fSjdm9E8qX0zBM1');

--
-- Dökümü yapılmış tablolar için indeksler
--

--
-- Tablo için indeksler `articles`
--
ALTER TABLE `articles`
  ADD PRIMARY KEY (`id`);

--
-- Tablo için indeksler `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`);

--
-- Dökümü yapılmış tablolar için AUTO_INCREMENT değeri
--

--
-- Tablo için AUTO_INCREMENT değeri `articles`
--
ALTER TABLE `articles`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- Tablo için AUTO_INCREMENT değeri `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
