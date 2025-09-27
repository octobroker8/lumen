-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Tempo de geração: 22/01/2025 às 04:04
-- Versão do servidor: 10.4.32-MariaDB
-- Versão do PHP: 8.2.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `3333333`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `alerts`
--

CREATE TABLE `alerts` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `time` int(11) NOT NULL,
  `status` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `auth`
--

CREATE TABLE `auth` (
  `id` int(11) NOT NULL,
  `status` enum('login','error') NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `login` varchar(255) NOT NULL,
  `time` int(11) NOT NULL,
  `ip` varchar(45) NOT NULL,
  `agent` text NOT NULL,
  `cookie` varchar(255) NOT NULL,
  `country` varchar(10) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `chats`
--

CREATE TABLE `chats` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `user_from` int(11) NOT NULL,
  `user_to` int(11) NOT NULL,
  `public_chat` tinyint(1) DEFAULT 0,
  `last_message` text NOT NULL,
  `last_time` int(11) NOT NULL,
  `online` varchar(255) NOT NULL DEFAULT 'offline'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `chat_messages`
--

CREATE TABLE `chat_messages` (
  `id` int(11) NOT NULL,
  `chat_id` int(11) NOT NULL,
  `message` text NOT NULL,
  `user_from` int(11) NOT NULL,
  `user_to` int(11) NOT NULL,
  `time` int(11) NOT NULL,
  `count` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `conf`
--

CREATE TABLE `conf` (
  `id` int(11) NOT NULL,
  `k` varchar(255) DEFAULT NULL,
  `v` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `copy_traders`
--

CREATE TABLE `copy_traders` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `trader_id` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `country`
--

CREATE TABLE `country` (
  `id` int(11) NOT NULL,
  `name_en` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `currency`
--

CREATE TABLE `currency` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `k` varchar(255) NOT NULL,
  `forex` varchar(255) DEFAULT NULL,
  `course` decimal(15,8) NOT NULL DEFAULT 0.00000000,
  `category` varchar(255) DEFAULT NULL,
  `time_status` tinyint(4) NOT NULL DEFAULT 1,
  `time` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `profit` int(11) DEFAULT NULL,
  `sort` int(11) NOT NULL DEFAULT 0,
  `top` int(11) NOT NULL DEFAULT 0,
  `spread` decimal(10,0) NOT NULL DEFAULT 0,
  `change_5m` decimal(10,0) NOT NULL DEFAULT 0,
  `leverage` varchar(255) DEFAULT NULL,
  `binarytime` varchar(255) DEFAULT NULL,
  `category_name` varchar(255) DEFAULT 'Crypto',
  `timeopen` varchar(500) DEFAULT NULL,
  `ico` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `currency_fav`
--

CREATE TABLE `currency_fav` (
  `id` int(11) NOT NULL,
  `currency_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `indicators`
--

CREATE TABLE `indicators` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `category` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `indicators_user`
--

CREATE TABLE `indicators_user` (
  `id` int(11) NOT NULL,
  `indicator_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `window_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `invest`
--

CREATE TABLE `invest` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `status` int(11) NOT NULL,
  `tarif_id` int(11) NOT NULL,
  `time_start` int(11) NOT NULL,
  `time_end` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `profit` decimal(10,2) NOT NULL,
  `profit_day` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `invest_tarifs`
--

CREATE TABLE `invest_tarifs` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `days` int(11) NOT NULL,
  `profit` decimal(10,2) NOT NULL,
  `amount_min` decimal(10,2) NOT NULL,
  `amount_max` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `lang_list`
--

CREATE TABLE `lang_list` (
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `levels`
--

CREATE TABLE `levels` (
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `lots`
--

CREATE TABLE `lots` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `lot` decimal(15,2) NOT NULL,
  `trend` enum('up','down') NOT NULL,
  `profit` decimal(15,2) NOT NULL DEFAULT 0.00,
  `current_balance` decimal(15,2) NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0,
  `course_start` decimal(15,8) NOT NULL,
  `course_end` decimal(15,8) DEFAULT NULL,
  `currency_k` varchar(255) NOT NULL,
  `currency` varchar(255) NOT NULL,
  `currency_id` int(11) NOT NULL,
  `time_start` int(11) NOT NULL,
  `time_end` int(11) NOT NULL DEFAULT 0,
  `demo` tinyint(4) NOT NULL DEFAULT 0,
  `partner_cron` tinyint(4) NOT NULL DEFAULT 0,
  `option_type` tinyint(4) NOT NULL DEFAULT 0,
  `forex` tinyint(4) NOT NULL DEFAULT 1,
  `leverage` int(11) NOT NULL,
  `stoploss_amount` decimal(15,2) DEFAULT NULL,
  `stoploss_course` decimal(15,8) DEFAULT NULL,
  `takeprofit_amount` decimal(15,2) DEFAULT NULL,
  `takeprofit_course` decimal(15,8) DEFAULT NULL,
  `marketing` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `lots_history`
--

CREATE TABLE `lots_history` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `profit` decimal(10,2) DEFAULT 0.00,
  `marketing` int(11) DEFAULT 0,
  `demo` tinyint(1) DEFAULT 0,
  `status` int(11) DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `messages`
--

CREATE TABLE `messages` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `time` int(11) NOT NULL,
  `message` text NOT NULL,
  `status` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `partner_gerente`
--

CREATE TABLE `partner_gerente` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `regs` int(11) NOT NULL,
  `deposits` decimal(10,2) NOT NULL,
  `deposito` decimal(10,2) NOT NULL,
  `saques` decimal(10,2) NOT NULL,
  `lots` int(11) NOT NULL,
  `profit` decimal(10,2) NOT NULL,
  `refprofit` decimal(10,2) NOT NULL,
  `login` varchar(255) NOT NULL,
  `rev` decimal(10,2) NOT NULL,
  `i` int(11) NOT NULL,
  `f` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `partner_stat`
--

CREATE TABLE `partner_stat` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `regs` int(11) NOT NULL,
  `deposits` decimal(10,2) NOT NULL,
  `deposito` decimal(10,2) NOT NULL,
  `saques` decimal(10,2) NOT NULL,
  `lots` int(11) NOT NULL,
  `profit` decimal(10,2) NOT NULL,
  `refprofit` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `payin`
--

CREATE TABLE `payin` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `amount` decimal(10,2) NOT NULL,
  `time` int(11) NOT NULL,
  `metadata` text DEFAULT NULL,
  `status` int(11) NOT NULL,
  `marketing` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `payin_types`
--

CREATE TABLE `payin_types` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `payout`
--

CREATE TABLE `payout` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `amount_pay` decimal(10,2) NOT NULL,
  `status` int(11) NOT NULL,
  `tipo` varchar(50) NOT NULL,
  `marketing` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `payout_types`
--

CREATE TABLE `payout_types` (
  `id` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `primepag`
--

CREATE TABLE `primepag` (
  `id` int(11) NOT NULL,
  `reference_code` varchar(255) DEFAULT NULL,
  `content` text DEFAULT NULL,
  `image_base64` text DEFAULT NULL,
  `transacao` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `promocodes`
--

CREATE TABLE `promocodes` (
  `id` int(11) NOT NULL,
  `promocode` varchar(255) NOT NULL,
  `percent` decimal(5,2) NOT NULL,
  `unico` tinyint(1) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `promocodes_log`
--

CREATE TABLE `promocodes_log` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `code_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `referals`
--

CREATE TABLE `referals` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `referal_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `stats`
--

CREATE TABLE `stats` (
  `id` int(11) NOT NULL,
  `time` int(11) NOT NULL,
  `ip` varchar(45) NOT NULL,
  `country` varchar(2) NOT NULL,
  `ref` text DEFAULT NULL,
  `action` varchar(255) DEFAULT NULL,
  `agent` text DEFAULT NULL,
  `timeview` int(11) DEFAULT 0,
  `online` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `user_login` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tabs`
--

CREATE TABLE `tabs` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `currency_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `timezone`
--

CREATE TABLE `timezone` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `time` datetime NOT NULL DEFAULT current_timestamp(),
  `timezone` varchar(255) NOT NULL DEFAULT 'Etc/UTC',
  `count` int(11) NOT NULL DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `users`
--

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `name` varchar(255) DEFAULT NULL,
  `birth` varchar(255) DEFAULT NULL,
  `login` varchar(255) NOT NULL,
  `pass` varchar(255) NOT NULL,
  `blocked` tinyint(1) DEFAULT 0,
  `2fa` tinyint(1) DEFAULT 0,
  `email_confirm` tinyint(1) DEFAULT 0,
  `level` int(11) DEFAULT 0,
  `demo` tinyint(1) DEFAULT 1,
  `balance` decimal(15,2) DEFAULT 0.00,
  `balance_demo` decimal(15,2) DEFAULT 1000.00,
  `balance_invest` decimal(15,2) DEFAULT 0.00,
  `partner_balance` decimal(15,2) DEFAULT 0.00,
  `partner_month` int(11) NOT NULL,
  `partner_traders` int(11) DEFAULT 0,
  `lang` varchar(10) DEFAULT 'en',
  `lots` decimal(15,2) DEFAULT 0.00,
  `profit` decimal(15,2) DEFAULT 0.00,
  `sound` tinyint(1) DEFAULT 1,
  `timezone` varchar(50) DEFAULT 'Etc/UTC',
  `hash` varchar(255) NOT NULL,
  `window` tinyint(1) DEFAULT 0,
  `w1` int(11) DEFAULT 91,
  `w2` int(11) DEFAULT 92,
  `w1_type` tinyint(1) DEFAULT 1,
  `w2_type` tinyint(1) DEFAULT 1,
  `i` varchar(255) DEFAULT NULL,
  `f` varchar(255) DEFAULT NULL,
  `o` varchar(255) DEFAULT NULL,
  `q` int(11) NOT NULL DEFAULT 1,
  `sex` varchar(255) DEFAULT NULL,
  `cpf` varchar(14) DEFAULT NULL,
  `tel` varchar(255) DEFAULT NULL,
  `time` varchar(255) DEFAULT NULL,
  `bonus` decimal(10,2) DEFAULT 0.00,
  `balance_afiliado` decimal(10,2) DEFAULT 0.00,
  `copy` varchar(11) DEFAULT '0',
  `ranking` int(11) DEFAULT 0,
  `scan1` varchar(255) DEFAULT NULL,
  `scan2` varchar(255) DEFAULT NULL,
  `photo` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `country` varchar(255) DEFAULT NULL,
  `verified` int(11) DEFAULT 0,
  `newmess` int(11) DEFAULT 0,
  `passportn` varchar(255) DEFAULT NULL,
  `passports` varchar(255) DEFAULT NULL,
  `online` tinyint(4) NOT NULL DEFAULT 0,
  `profit_today` int(11) NOT NULL DEFAULT 0,
  `profit_three` int(11) NOT NULL DEFAULT 0,
  `profit_seven` int(11) NOT NULL DEFAULT 0,
  `profit_percent` varchar(255) NOT NULL DEFAULT '0',
  `last_trade_time` varchar(255) DEFAULT NULL,
  `rev` int(11) NOT NULL DEFAULT 0,
  `depositante` varchar(255) DEFAULT NULL,
  `w1_resolution` varchar(255) DEFAULT '1',
  `w1_time` varchar(255) DEFAULT '1',
  `cargo` varchar(50) NOT NULL DEFAULT 'padrao'
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `alerts`
--
ALTER TABLE `alerts`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Índices de tabela `auth`
--
ALTER TABLE `auth`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `chats`
--
ALTER TABLE `chats`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `chat_messages`
--
ALTER TABLE `chat_messages`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `conf`
--
ALTER TABLE `conf`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `copy_traders`
--
ALTER TABLE `copy_traders`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `trader_id` (`trader_id`);

--
-- Índices de tabela `country`
--
ALTER TABLE `country`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `currency`
--
ALTER TABLE `currency`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `indicators`
--
ALTER TABLE `indicators`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `indicators_user`
--
ALTER TABLE `indicators_user`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `invest`
--
ALTER TABLE `invest`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `invest_tarifs`
--
ALTER TABLE `invest_tarifs`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `lang_list`
--
ALTER TABLE `lang_list`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `levels`
--
ALTER TABLE `levels`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `lots`
--
ALTER TABLE `lots`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `lots_history`
--
ALTER TABLE `lots_history`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Índices de tabela `messages`
--
ALTER TABLE `messages`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Índices de tabela `partner_gerente`
--
ALTER TABLE `partner_gerente`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `partner_stat`
--
ALTER TABLE `partner_stat`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `payin`
--
ALTER TABLE `payin`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`);

--
-- Índices de tabela `payin_types`
--
ALTER TABLE `payin_types`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `payout`
--
ALTER TABLE `payout`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `payout_types`
--
ALTER TABLE `payout_types`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `primepag`
--
ALTER TABLE `primepag`
  ADD PRIMARY KEY (`id`),
  ADD KEY `transacao` (`transacao`);

--
-- Índices de tabela `promocodes`
--
ALTER TABLE `promocodes`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `promocode` (`promocode`);

--
-- Índices de tabela `promocodes_log`
--
ALTER TABLE `promocodes_log`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `code_id` (`code_id`);

--
-- Índices de tabela `referals`
--
ALTER TABLE `referals`
  ADD PRIMARY KEY (`id`),
  ADD KEY `user_id` (`user_id`),
  ADD KEY `referal_id` (`referal_id`);

--
-- Índices de tabela `stats`
--
ALTER TABLE `stats`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `tabs`
--
ALTER TABLE `tabs`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `timezone`
--
ALTER TABLE `timezone`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `login` (`login`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `alerts`
--
ALTER TABLE `alerts`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `auth`
--
ALTER TABLE `auth`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `chats`
--
ALTER TABLE `chats`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `chat_messages`
--
ALTER TABLE `chat_messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `conf`
--
ALTER TABLE `conf`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `copy_traders`
--
ALTER TABLE `copy_traders`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `country`
--
ALTER TABLE `country`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `currency`
--
ALTER TABLE `currency`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `indicators`
--
ALTER TABLE `indicators`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `indicators_user`
--
ALTER TABLE `indicators_user`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `invest`
--
ALTER TABLE `invest`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `invest_tarifs`
--
ALTER TABLE `invest_tarifs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `lang_list`
--
ALTER TABLE `lang_list`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `levels`
--
ALTER TABLE `levels`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `lots`
--
ALTER TABLE `lots`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `lots_history`
--
ALTER TABLE `lots_history`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `messages`
--
ALTER TABLE `messages`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `partner_gerente`
--
ALTER TABLE `partner_gerente`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `partner_stat`
--
ALTER TABLE `partner_stat`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `payin`
--
ALTER TABLE `payin`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `payin_types`
--
ALTER TABLE `payin_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `payout`
--
ALTER TABLE `payout`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `payout_types`
--
ALTER TABLE `payout_types`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `primepag`
--
ALTER TABLE `primepag`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `promocodes`
--
ALTER TABLE `promocodes`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `promocodes_log`
--
ALTER TABLE `promocodes_log`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `referals`
--
ALTER TABLE `referals`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `stats`
--
ALTER TABLE `stats`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `tabs`
--
ALTER TABLE `tabs`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `timezone`
--
ALTER TABLE `timezone`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `users`
--
ALTER TABLE `users`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `alerts`
--
ALTER TABLE `alerts`
  ADD CONSTRAINT `alerts_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Restrições para tabelas `copy_traders`
--
ALTER TABLE `copy_traders`
  ADD CONSTRAINT `copy_traders_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `copy_traders_ibfk_2` FOREIGN KEY (`trader_id`) REFERENCES `users` (`id`);

--
-- Restrições para tabelas `lots_history`
--
ALTER TABLE `lots_history`
  ADD CONSTRAINT `lots_history_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Restrições para tabelas `messages`
--
ALTER TABLE `messages`
  ADD CONSTRAINT `messages_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Restrições para tabelas `payin`
--
ALTER TABLE `payin`
  ADD CONSTRAINT `payin_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Restrições para tabelas `primepag`
--
ALTER TABLE `primepag`
  ADD CONSTRAINT `primepag_ibfk_1` FOREIGN KEY (`transacao`) REFERENCES `payin` (`id`);

--
-- Restrições para tabelas `promocodes_log`
--
ALTER TABLE `promocodes_log`
  ADD CONSTRAINT `promocodes_log_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `promocodes_log_ibfk_2` FOREIGN KEY (`code_id`) REFERENCES `promocodes` (`id`);

--
-- Restrições para tabelas `referals`
--
ALTER TABLE `referals`
  ADD CONSTRAINT `referals_ibfk_1` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  ADD CONSTRAINT `referals_ibfk_2` FOREIGN KEY (`referal_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
