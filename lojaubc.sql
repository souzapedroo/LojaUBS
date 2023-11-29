-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Tempo de geração: 29/11/2023 às 17:45
-- Versão do servidor: 8.2.0
-- Versão do PHP: 8.2.13

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `lojaubc`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `payments_picpays`
--

DROP TABLE IF EXISTS `payments_picpays`;
CREATE TABLE IF NOT EXISTS `payments_picpays` (
  `id` int NOT NULL AUTO_INCREMENT,
  `first_name` varchar(220) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(220) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `cpf` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(220) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `payment_url` varchar(220) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qrcode` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `expires_at` datetime NOT NULL,
  `product_id` int NOT NULL,
  `payments_statu_id` int NOT NULL DEFAULT '1',
  `created` datetime NOT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `payments_picpays`
--

INSERT INTO `payments_picpays` (`id`, `first_name`, `last_name`, `cpf`, `phone`, `email`, `payment_url`, `qrcode`, `expires_at`, `product_id`, `payments_statu_id`, `created`, `modified`) VALUES
(1, 'Cesar', 'Szpak', '123.456.789-10', '(27)12345-6789', 'teste@picpay.com', NULL, NULL, '2021-03-28 14:32:59', 1, 4, '2021-03-25 14:32:59', NULL),
(116, 'pedro', 'pinto', '539.211.028-20', '(11)983487-661', 'pedro.henrique6147@gmail.com', NULL, NULL, '2023-12-02 17:40:52', 2, 1, '2023-11-29 17:40:52', NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `payments_status`
--

DROP TABLE IF EXISTS `payments_status`;
CREATE TABLE IF NOT EXISTS `payments_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(42) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` varchar(42) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` varchar(220) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `obs` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci,
  `color` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `payments_status`
--

INSERT INTO `payments_status` (`id`, `name`, `status`, `description`, `obs`, `color`, `created`, `modified`) VALUES
(1, 'Iniciado', 'start', 'Compra iniciada.', NULL, 'primary', '2021-04-23 11:34:05', NULL),
(2, 'Criado', 'created', 'Registro criado.', NULL, 'primary', '2021-04-23 11:34:05', NULL),
(3, 'Expirado ', 'expired', 'Prazo para pagamento expirado ou ordem cancelada.', '', 'warning', '2021-04-23 13:32:47', NULL),
(4, 'Análise', 'analysis', 'Pago e em processo de análise anti-fraude.', '', 'info', '2021-04-23 13:32:47', NULL),
(5, 'Pago', 'paid', 'Pago.', '', 'success', '2021-04-23 13:32:47', NULL),
(6, 'Completo', 'completed', 'Pago e saldo disponível.', '', 'success', '2021-04-23 13:32:47', NULL),
(7, 'Devolvido', 'refunded', 'Pago e devolvido.', '', 'danger', '2021-04-23 13:32:47', NULL),
(8, 'Estorno', 'chargeback', 'Pago e com chargeback.', '', 'danger', '2021-04-23 13:32:47', NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `products`
--

DROP TABLE IF EXISTS `products`;
CREATE TABLE IF NOT EXISTS `products` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(220) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` double NOT NULL,
  `image` varchar(220) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created` datetime NOT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `products`
--

INSERT INTO `products` (`id`, `name`, `description`, `price`, `image`, `created`, `modified`) VALUES
(1, 'Curso de PHP Developer', '<p><strong>Seja um Desenvolvedor PHP Excepcional com o Nosso Curso Abrangente!</strong></p>\n\n    <p>Se você aspira se tornar um desenvolvedor PHP altamente qualificado e preparado para os desafios do mundo digital, nosso Curso de PHP Developer é a escolha certa para você. Este curso abrangente proporciona uma imersão completa no universo do PHP, capacitando você para criar aplicações web dinâmicas e robustas.</p>\n\n    <p>No decorrer deste curso prático, você explorará todos os aspectos essenciais para se tornar um desenvolvedor PHP de destaque. Veja o que está reservado para você:</p>\n\n    <p><strong>Domínio do PHP Básico e Avançado:</strong></p>\n    <p>Aprenda desde o básico até conceitos avançados da linguagem PHP.</p>\n    <p>Desenvolva habilidades sólidas para manipulação de dados, controle de fluxo e funções avançadas do PHP.</p>\n\n    <p><strong>Integração com Bancos de Dados (MySQLi):</strong></p>\n    <p>Explore técnicas de acesso e manipulação eficientes de dados usando MySQLi.</p>\n    <p>Desenvolva aplicações com interações dinâmicas e eficazes com bancos de dados.</p>\n\n    <p><strong>Construção de Interfaces com Bootstrap:</strong></p>\n    <p>Crie interfaces modernas e responsivas utilizando o framework Bootstrap.</p>\n    <p>Desenvolva habilidades de design web para tornar suas aplicações visualmente atraentes.</p>\n\n    <p><strong>Programação Orientada a Objetos (POO) em PHP:</strong></p>\n    <p>Mergulhe na programação orientada a objetos para escrever código mais modular e reutilizável.</p>\n    <p>Aprenda a estruturar seus projetos de forma eficiente com princípios de POO.</p>\n\n    <p><strong>Projetos Práticos e Desafios:</strong></p>\n    <p>Coloque seus conhecimentos em prática com projetos do mundo real.</p>\n    <p>Enfrente desafios para solidificar suas habilidades e aplicar o aprendizado de forma eficaz.</p>\n\n    <p><strong>Suporte Personalizado:</strong></p>\n    <p>Receba orientação individualizada e suporte de instrutores experientes em PHP.</p>\n    <p>Esclareça dúvidas e receba insights valiosos para sua jornada como desenvolvedor PHP.</p>\n\n    <p>Pronto para se destacar como um PHP Developer de sucesso? Matricule-se agora em nosso Curso de PHP Developer e inicie sua jornada para se tornar um profissional qualificado e altamente requisitado no mercado de desenvolvimento web!</p>\n</body>', 247, 'curso-de-php-developer.jpg', '2021-04-23 12:08:54', NULL),
(2, 'Curso de PHP Orientado Objetos', '<p><strong>Explore a Programação PHP de Forma Orientada a Objetos no Nosso Curso Especializado!</strong></p>\n\n    <p>Se você busca aprofundar seus conhecimentos em PHP e deseja dominar a programação orientada a objetos, nosso Curso de PHP Orientado a Objetos é ideal para você. Aprenda a desenvolver código mais modular, reutilizável e fácil de manter, uma habilidade essencial para programadores PHP avançados.</p>\n\n    <p>Neste curso prático e detalhado, você será guiado desde os conceitos fundamentais até a aplicação prática da programação orientada a objetos em projetos reais. Veja o que está à sua espera:</p>\n\n    <p><strong>Fundamentos de Programação Orientada a Objetos (POO):</strong></p>\n    <p>Compreenda os princípios essenciais da POO e como aplicá-los em PHP.</p>\n    <p>Aprenda sobre classes, objetos, herança, polimorfismo e encapsulamento.</p>\n\n    <p><strong>Desenvolvimento de Aplicações PHP Robustas:</strong></p>\n    <p>Utilize a POO para criar aplicações mais estruturadas e fáceis de manter.</p>\n    <p>Explore design patterns comuns e boas práticas de programação.</p>\n\n    <p><strong>Projetos Práticos e Desafios:</strong></p>\n    <p>Coloque seus conhecimentos em prática com projetos orientados a objetos.</p>\n    <p>Enfrente desafios para consolidar suas habilidades de programação.</p>\n\n    <p><strong>Suporte Personalizado:</strong></p>\n    <p>Receba suporte especializado de instrutores experientes em PHP e POO.</p>\n    <p>Esclareça dúvidas e receba orientação personalizada para maximizar seu aprendizado.</p>\n\n    <p>Eleve suas habilidades de programação PHP para o próximo nível com o Curso de PHP Orientado a Objetos. Esteja você buscando aprimorar suas capacidades profissionais ou embarcar em uma nova carreira, este curso é o passo certo para o seu sucesso. Matricule-se hoje e destaque-se como um desenvolvedor PHP especializado em programação orientada a objetos!</p>\n</body>\n<p>Sed sagittis quam quis enim placerat, non ultrices est semper. Suspendisse potenti. Duis vestibulum vitae quam sed maximus. Integer malesuada nulla eget blandit rhoncus. Morbi dignissim ac neque sit amet rhoncus. Pellentesque habitant morbi tristique senectus et netus et malesuada fames ac turpis egestas. Mauris in dignissim diam, sagittis auctor sapien. Ut ac odio sit amet nulla tincidunt eleifend eget quis nisl. In dignissim diam ut tellus mollis iaculis. Integer non metus volutpat tortor placerat eleifend. Maecenas ut nisi vehicula, rutrum ligula id, tempus nibh. Suspendisse lacinia enim lacus, id dapibus ex hendrerit in. Cras vulputate a lacus non elementum. Nulla sed orci sit amet risus fringilla gravida. Aliquam pellentesque mattis magna vel faucibus.</p>', 194.47, 'curso-de-php-orientado-a-objetos.jpg', '2021-04-23 12:08:54', NULL),
(3, 'Curso de PHP, MySQLi e Bootstrap', ' <p><strong>Explore o Universo da Programação Web com Nosso Curso em PHP, MySQLi e Bootstrap!</strong></p>\n\n    <p>Se você deseja criar aplicações dinâmicas e interativas, nosso Curso de PHP, MySQLi e Bootstrap é o caminho certo para você. Aprenda a construir websites poderosos e bancos de dados eficientes com as tecnologias mais requisitadas no mundo do desenvolvimento web.</p>\n\n    <p>Neste curso prático e abrangente, vamos guiar você desde os conceitos básicos até o desenvolvimento de aplicações web robustas. Veja o que você pode esperar:</p>\n\n    <p><strong>PHP Descomplicado:</strong></p>\n    <p>Compreenda os fundamentos da linguagem de programação PHP.</p>\n    <p>Aprenda a criar scripts dinâmicos para websites interativos.</p>\n\n    <p><strong>MySQLi e Gerenciamento de Banco de Dados:</strong></p>\n    <p>Explore o MySQLi para interagir eficientemente com bancos de dados.</p>\n    <p>Aprenda técnicas de design e otimização de bancos de dados.</p>\n\n    <p><strong>Construindo com Bootstrap:</strong></p>\n    <p>Integre o Bootstrap para criar interfaces elegantes e responsivas.</p>\n    <p>Crie layouts atrativos e consistentes para suas aplicações.</p>\n\n    <p><strong>Projetos Práticos e Desafios:</strong></p>\n    <p>Coloque seus conhecimentos em prática com projetos do mundo real.</p>\n    <p>Enfrente desafios para solidificar suas habilidades de programação.</p>\n\n    <p><strong>Suporte Personalizado:</strong></p>\n    <p>Conte com suporte especializado de instrutores experientes.</p>\n    <p>Receba orientação personalizada para superar seus desafios de programação.</p>\n\n    <p>Inicie sua jornada na programação web agora! Não importa se você está começando ou buscando aprimorar suas habilidades, este curso oferece o conhecimento necessário para se destacar como um desenvolvedor web. Matricule-se hoje e impulsione sua carreira!</p>', 149, 'curso-de-php-mysqli-e-bootstrap.jpg', '2021-04-23 14:33:05', NULL),
(4, 'Curso de HTML, CSS e Bootstrap4', '<p><strong>Domine o Mundo do Desenvolvimento Web com Nosso Curso Completo em HTML, CSS e Bootstrap 4!</strong></p>\n\n    <p>Você deseja criar sites incríveis e modernos? Quer aprender as habilidades essenciais que todo desenvolvedor web precisa? Seja bem-vindo ao nosso Curso de HTML, CSS e Bootstrap 4!</p>\n\n    <p>Neste curso empolgante e prático, vamos te guiar desde os conceitos básicos até a criação de páginas web dinâmicas e responsivas. Aqui está o que você pode esperar:</p>\n\n    <p><strong>HTML Descomplicado:</strong></p>\n    <p>Aprenda a estrutura fundamental de uma página web.</p>\n    <p>Explore as tags HTML essenciais para criar conteúdo.</p>\n\n    <p><strong>Estilizando com Maestria em CSS:</strong></p>\n    <p>Domine a arte de dar estilo a páginas web.</p>\n    <p>Saiba como aplicar estilos a elementos individuais e à página como um todo.</p>\n\n    <p><strong>Construindo com Bootstrap 4:</strong></p>\n    <p>Descubra como usar o Bootstrap, um framework poderoso e flexível.</p>\n    <p>Crie layouts responsivos e atraentes com facilidade.</p>\n\n    <p><strong>Projetos Práticos e Desafios:</strong></p>\n    <p>Aplique seus conhecimentos com projetos práticos.</p>\n    <p>Enfrente desafios para consolidar suas habilidades.</p>\n\n    <p><strong>Suporte Personalizado:</strong></p>\n    <p>Tenha acesso a suporte personalizado de instrutores experientes.</p>\n    <p>Esclareça dúvidas e receba orientação individualizada.</p>\n\n    <p>Comece sua jornada no mundo do desenvolvimento web agora mesmo! Não importa se você é um iniciante ou já tem alguma experiência, este curso é perfeito para quem quer aprimorar suas habilidades. Inscreva-se hoje e dê o próximo passo para se tornar um desenvolvedor web de destaque!</p>', 97, 'curso-de-html-css-bootstrap.jpg', '2021-04-23 14:33:05', NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `transactions_status`
--

DROP TABLE IF EXISTS `transactions_status`;
CREATE TABLE IF NOT EXISTS `transactions_status` (
  `id` int NOT NULL AUTO_INCREMENT,
  `authorization_id` varchar(220) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `payments_statu_id` int NOT NULL,
  `payments_picpay_id` int NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=25 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `transactions_status`
--

INSERT INTO `transactions_status` (`id`, `authorization_id`, `payments_statu_id`, `payments_picpay_id`, `created`, `modified`) VALUES
(1, NULL, 2, 13, '2021-03-27 13:22:54', NULL),
(19, NULL, 2, 114, '2021-03-30 12:18:59', NULL),
(20, NULL, 2, 114, '2021-03-30 12:19:13', NULL),
(21, NULL, 3, 114, '2021-03-30 12:19:15', NULL),
(22, NULL, 2, 115, '2021-03-30 12:23:51', NULL),
(23, NULL, 2, 115, '2021-03-30 12:23:58', NULL),
(24, NULL, 3, 115, '2021-03-30 12:23:59', NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(220) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(220) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `password` varchar(220) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `users`
--

INSERT INTO `users` (`id`, `name`, `email`, `password`, `created`, `modified`) VALUES
(1, 'Cesar', 'lojaubc@gmail.com', '$2y$10$gQXLKOyc5.YhfHihaoRSXOxA6nQ8qSTiqw.wR18UvhZ8CZNmc42HS', '2021-04-23 11:24:30', NULL);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
