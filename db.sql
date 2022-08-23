-- --------------------------------------------------------
-- Servidor:                     localhost
-- Versão do servidor:           5.1.72-community - MySQL Community Server (GPL)
-- OS do Servidor:               Win32
-- HeidiSQL Versão:              9.4.0.5125
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Copiando estrutura do banco de dados para test
CREATE DATABASE IF NOT EXISTS `test` /*!40100 DEFAULT CHARACTER SET utf8 COLLATE utf8_bin */;
USE `test`;

-- Copiando estrutura para tabela test.artigo
CREATE TABLE IF NOT EXISTS `artigo` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `titulo` varchar(50) COLLATE utf8_bin NOT NULL,
  `autor_correspondente` int(11) NOT NULL,
  `documento` int(11) NOT NULL,
  KEY `Index 1` (`id`),
  KEY `FK_artigo_autor` (`autor_correspondente`),
  KEY `FK_artigo_documento` (`documento`),
  CONSTRAINT `FK_artigo_autor` FOREIGN KEY (`autor_correspondente`) REFERENCES `autor` (`id`),
  CONSTRAINT `FK_artigo_documento` FOREIGN KEY (`documento`) REFERENCES `documento` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Copiando dados para a tabela test.artigo: ~1 rows (aproximadamente)
/*!40000 ALTER TABLE `artigo` DISABLE KEYS */;
INSERT INTO `artigo` (`id`, `titulo`, `autor_correspondente`, `documento`) VALUES
	(8, 'teste', 3, 2);
/*!40000 ALTER TABLE `artigo` ENABLE KEYS */;

-- Copiando estrutura para tabela test.artigo_tem_autor
CREATE TABLE IF NOT EXISTS `artigo_tem_autor` (
  `artigo` int(11) NOT NULL,
  `autor` int(11) NOT NULL,
  KEY `Index 1` (`artigo`,`autor`),
  KEY `FK_artigo_tem_autor_autor` (`autor`),
  CONSTRAINT `FK_artigo_tem_autor_artigo` FOREIGN KEY (`artigo`) REFERENCES `artigo` (`id`),
  CONSTRAINT `FK_artigo_tem_autor_autor` FOREIGN KEY (`autor`) REFERENCES `autor` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Copiando dados para a tabela test.artigo_tem_autor: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `artigo_tem_autor` DISABLE KEYS */;
INSERT INTO `artigo_tem_autor` (`artigo`, `autor`) VALUES
	(8, 1),
	(8, 3);
/*!40000 ALTER TABLE `artigo_tem_autor` ENABLE KEYS */;

-- Copiando estrutura para tabela test.artigo_tem_palavra_chave
CREATE TABLE IF NOT EXISTS `artigo_tem_palavra_chave` (
  `artigo` int(11) DEFAULT NULL,
  `palavra_chave` int(11) DEFAULT NULL,
  KEY `Index 1` (`artigo`,`palavra_chave`),
  KEY `FK_artigo_tem_palavra_chave_palavra_chave` (`palavra_chave`),
  CONSTRAINT `FK_artigo_tem_palavra_chave_artigo` FOREIGN KEY (`artigo`) REFERENCES `artigo` (`id`),
  CONSTRAINT `FK_artigo_tem_palavra_chave_palavra_chave` FOREIGN KEY (`palavra_chave`) REFERENCES `palavra_chave` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Copiando dados para a tabela test.artigo_tem_palavra_chave: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `artigo_tem_palavra_chave` DISABLE KEYS */;
/*!40000 ALTER TABLE `artigo_tem_palavra_chave` ENABLE KEYS */;

-- Copiando estrutura para tabela test.autor
CREATE TABLE IF NOT EXISTS `autor` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nome` text COLLATE utf8_bin,
  KEY `Index 1` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Copiando dados para a tabela test.autor: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `autor` DISABLE KEYS */;
INSERT INTO `autor` (`id`, `nome`) VALUES
	(1, 'Leonel Silima'),
	
/*!40000 ALTER TABLE `autor` ENABLE KEYS */;

-- Copiando estrutura para tabela test.documento
CREATE TABLE IF NOT EXISTS `documento` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `caminho` text COLLATE utf8_bin NOT NULL,
  `nome` text COLLATE utf8_bin NOT NULL,
  KEY `Index 1` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Copiando dados para a tabela test.documento: ~3 rows (aproximadamente)
/*!40000 ALTER TABLE `documento` DISABLE KEYS */;
INSERT INTO `documento` (`id`, `caminho`, `nome`) VALUES
	(1, 'C://documento/asdasds', 'asdasds'),
	(2, 'C://documento/teste.pdf', 'teste.pdf'),
	(3, 'C://documento/teste2.pdf', 'teste2.pdf');
/*!40000 ALTER TABLE `documento` ENABLE KEYS */;

-- Copiando estrutura para tabela test.palavra_chave
CREATE TABLE IF NOT EXISTS `palavra_chave` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `palavra` text COLLATE utf8_bin NOT NULL,
  KEY `Index 1` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_bin;

-- Copiando dados para a tabela test.palavra_chave: ~0 rows (aproximadamente)
/*!40000 ALTER TABLE `palavra_chave` DISABLE KEYS */;
/*!40000 ALTER TABLE `palavra_chave` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
