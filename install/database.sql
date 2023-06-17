-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Feb 10, 2021 at 07:55 AM
-- Server version: 10.4.16-MariaDB
-- PHP Version: 7.4.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `xenwallet`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mobile` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 1,
  `admin_access` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `login_time` datetime DEFAULT current_timestamp(),
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `name`, `username`, `email`, `mobile`, `image`, `status`, `admin_access`, `password`, `remember_token`, `email_verified_at`, `login_time`, `created_at`, `updated_at`) VALUES
(1, 'Supper Admin', 'admin', 'admin@thesoftking.com', '5641568161', '5d96324d9b46e1570124365.jpg', 1, '[\"1\",\"2\",\"3\",\"4\",\"5\",\"6\",\"7\",\"8\",\"9\",\"10\",\"11\",\"12\",\"13\",\"14\"]', '$2y$10$BoX0SmMs8i6UUSfvZLnjJePLi9aut8g.bQDiedFd2ofHoE9pnFslK', 'wpwiRk6GvDvybZJX7mmzSgRWiYBCnaeqdY13uGwADQHndBXqkwXJ2JkH8K8r', NULL, NULL, NULL, '2021-02-04 08:06:50');

-- --------------------------------------------------------

--
-- Table structure for table `admin_password_resets`
--

CREATE TABLE `admin_password_resets` (
  `id` int(10) UNSIGNED NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `contact_topics`
--

CREATE TABLE `contact_topics` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `currencies`
--

CREATE TABLE `currencies` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(30) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `rate` decimal(18,8) DEFAULT 0.00000000,
  `status` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `deposits`
--

CREATE TABLE `deposits` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `currency_id` int(11) DEFAULT NULL COMMENT 'currency for wallet',
  `wallet_amount` varchar(11) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `api_id` tinyint(4) NOT NULL DEFAULT 0,
  `invoice_id` tinyint(4) NOT NULL DEFAULT 0,
  `method_code` int(10) UNSIGNED NOT NULL,
  `method_currency` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(18,8) NOT NULL,
  `gate_rate` decimal(18,8) NOT NULL,
  `cur_rate` decimal(18,8) NOT NULL,
  `charge` decimal(18,8) NOT NULL,
  `final_amo` decimal(11,2) DEFAULT NULL,
  `btc_amo` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `btc_wallet` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trx` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `try` int(11) NOT NULL DEFAULT 0,
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '1=> confirm , 2 => pending, -2 => rejected',
  `verify_image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `detail` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `email_sms_templates`
--

CREATE TABLE `email_sms_templates` (
  `id` int(10) UNSIGNED NOT NULL,
  `act` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subj` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_body` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sms_body` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shortcodes` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_status` tinyint(4) NOT NULL DEFAULT 1,
  `sms_status` tinyint(4) NOT NULL DEFAULT 1,
  `sort` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `email_sms_templates`
--

INSERT INTO `email_sms_templates` (`id`, `act`, `name`, `subj`, `email_body`, `sms_body`, `shortcodes`, `email_status`, `sms_status`, `sort`, `created_at`, `updated_at`) VALUES
(1, 'ACCOUNT_RECOVERY_CODE', 'Password Reset Code', 'Account recovery code', 'Your account recovery code is: {{code}}\r\n\r\nIP: {{ip}},  Browswer: {{browser}},  Time {{time}},', 'Your account recovery code is: {{code}} IP: {{ip}}, Browswer: {{browser}}, Time {{time}},', '{\"code\":\"Recovery code\",\"ip\":\"IP address of User\",\"time\":\"time when requested\",\"browser\":\" Browser of User\"}', 1, 1, 'ACCOUNT_RECOVERY_CODE', '2019-09-25 05:04:05', '2019-11-06 06:33:18'),
(2, 'money_transfer_receiver', 'Receive Money', 'Receive Money transfer', '{{amount}} {{currency}} Send From  {{from_email}}.&nbsp;<div><br></div><div>Sender Username : {{from_username}}</div><div><div>Sender Full Name: {{from_fullname}}</div></div><div><div><br></div></div><div><br></div><div><br></div><div>Your Current Balance: {{current_balance}} {{currency}}<br><div><br></div><div>Your Transaction ID : #{{transaction_id}}</div>{{message}}</div>', '{{amount}} {{currency}} Send From {{from_email}}. \r\n\r\nSender Username : {{from_username}}\r\nSender Full Name: {{from_fullname}}\r\n\r\n\r\n\r\nYour Current Balance: {{current_balance}} {{currency}}\r\n\r\nYour Transaction ID : #{{transaction_id}}\r\n{{message}}', '{\"amount\":\"Amount\",\"currency\":\"currency\",\"from_username\":\"from username\",\"from_fullname\":\"from_fullname\",\"from_email\":\"from_email\",\"transaction_id\":\"Transaction Id\",\"message\":\"message\",\"current_balance\":\"current balance\"}', 1, 1, 'TRANSFER', '2019-09-25 05:04:05', '2019-11-06 00:40:52'),
(3, 'deal_transfer', 'Protected Money Transfer', 'Deal for Money transfer', '{{amount}} {{currency_code}} make a deal by&nbsp; {{user_name}}.&nbsp;<div><br></div>{{message}}', '{{amount}} {{currency_code}} make a deal by  {{user_name}}. \r\n\r\n{{message}}', '{\"amount\":\"Amount\",\"currency_code\":\"currency code\",\"user_name\":\"Username\",\"message\":\"message\"}', 1, 1, 'TRANSFER', '2019-09-25 05:04:05', '2019-11-06 06:33:47'),
(4, 'exchange', 'Exchange Money', 'Exchange Money', 'Exchange {{from_amount}} {{from_currency}} to {{to_amount}} {{to_currency}}<div><br></div><div>&nbsp;Your Main Balance  {{from_new_balance}} {{from_currency}}  and    {{to_new_balance}} {{to_currency}}&nbsp;</div><div><br></div><div>&nbsp;Transaction ID: {{transaction_id}}</div>', 'Exchange {{from_amount}} {{from_currency}} to {{to_amount}} {{to_currency}}\r\n\r\n Your Main Balance {{from_new_balance}} {{from_currency}} and {{to_new_balance}} {{to_currency}} \r\n\r\n Transaction ID: {{transaction_id}}', '{\"from_amount\":\"from amount\",\"from_currency\":\"from currency\",\"from_new_balance\":\"from_new_balance\",\"to_amount\":\"to_amount\",\"to_currency\":\"to_currency\",\"to_new_balance\":\"to_new_balance\",\"transaction_id\":\"transaction id\"}', 1, 1, 'EXCHANGE', '2019-09-25 05:04:05', '2019-11-06 06:34:01'),
(6, 'request_money', 'Request Money- request by', 'Request For Money transfer', '{{request_amount}} {{request_currency}} money&nbsp;<span style=\"font-family: &quot;Open Sans&quot;, sans-serif;\">request&nbsp;</span>&nbsp;by  {{sender}}&nbsp;<div><span style=\"font-family: var(--para-font);\"><br></span></div><div><span style=\"font-family: var(--para-font);\">&nbsp;{{message}}</span><br></div><div><span style=\"font-family: var(--para-font);\"><br></span></div><div><span style=\"font-family: var(--para-font);\">&nbsp;{{details}}</span><br></div>', '{{request_amount}} {{request_currency}} money request  by {{sender}} \r\n\r\n {{message}}\r\n\r\n {{details}}', '{\"request_amount\":\"Amount\",\"request_currency\":\"currency \",\"sender\":\"sender mail\",\"message\":\"message\",\"details\":\"details\"}', 1, 1, 'REQUEST_MONEY', '2019-09-25 05:04:05', '2019-11-06 06:34:25'),
(7, 'voucher_create', 'Voucher Created', 'Voucher Create', '{{amount}} {{currency}} voucher created succeessfully.&nbsp;<div>Voucher Number: {{voucher_number}}&nbsp;<br><div>Charge:   {{charge}} {{currency}}</div><div>&nbsp;Total Pay:  {{total}} {{currency}}</div><div>Tranasction : #{{transaction_id}}</div><div>Your Main Balance {{new_balance}} {{currency}}</div></div>', '{{amount}} {{currency}} voucher created succeessfully. \r\nVoucher Number: {{voucher_number}} \r\nCharge: {{charge}} {{currency}}\r\n Total Pay: {{total}} {{currency}}\r\nTranasction : #{{transaction_id}}\r\nYour Main Balance {{new_balance}} {{currency}}', '{\"amount\":\"Amount\",\"charge\":\"charge\",\"total\":\"total\",\"currency\":\"currency\",\"new_balance\":\"new_balance\",\"transaction_id\":\"transaction\",\"voucher_number\":\"voucher_number\"}', 1, 1, 'VOUCHER', '2019-09-25 05:04:05', '2019-11-06 06:34:39'),
(8, '2fa', 'Two Factor Verification', 'Two Factor Verification', 'Google auhtentication {{message}} succeffully.<div><br></div><div>IP : {{ip}}</div><div><br></div><div>Browser: {{browser}}</div><div><br></div><div><span style=\"font-family: &quot;Open Sans&quot;, sans-serif;\">Time: {{time}}</span><br></div>', 'Google auhtentication {{message}} succeffully.\r\n\r\nIP : {{ip}}\r\n\r\nBrowser: {{browser}}\r\n\r\nTime: {{time}}', '{\"action\":\"action\",\"ip\":\"ip\",\"browser\":\"browser\",\"time\":\"time\"}', 1, 1, 'TWO_FACTOR', '2019-09-25 05:04:05', '2019-11-06 06:34:53'),
(9, 'payment', 'Deposit Successful', 'Payment Successfully', '{{amount}} {{currency}} Deposit successfully by {{gateway_name}}<div><br></div><div>Your main Balance: {{new_balance}} {{currency}}</div><div><br></div><div>Transaction {{transaction_id}}</div>', '{{amount}} {{currency}} Deposit successfully by {{gateway_name}}\r\n\r\nYour main Balance: {{new_balance}} {{currency}}\r\n\r\nTransaction {{transaction_id}}', '{\"amount\":\"amount\",\"currency\":\"currency\",\"gateway_currency\":\"gateway_currency\",\"gateway_name\":\"gateway_name\",\"new_balance\":\"new_balance\",\"transaction_id\":\"transaction ID\"}', 1, 1, 'DEPOSIT_CONFIRM', '2019-09-25 05:04:05', '2020-01-01 04:09:47'),
(10, 'DEPOSIT_PENDING', 'Manual deposit requested ', 'Payment Request Send Successfully', '{{amount}}  Deposit requested by {{method}}.     Charge: {{charge}} .   Trx: {{trx}}', '{{amount}} Deposit requested by {{method}}. Charge: {{charge}} . Trx: {{trx}}', '{\"trx\":\"trx\",\"amount\":\"amount\",\"method\":\"method\",\"charge\":\"charge\"}', 1, 1, 'DEPOSIT_PENDING', '2019-09-25 05:04:05', '2019-11-06 06:36:17'),
(11, 'withdraw_request', 'Withdraw Requested', 'Withdraw Request Send Successfully', '{{amount}} {{currency}}  withdraw requested by {{withdraw_method}}.  You will get {{method_amount}}  {{method_currency}}  in {{duration}}.  Trx: {{trx}}', '{{amount}} {{currency}} withdraw requested by {{withdraw_method}}. You will get {{method_amount}} {{method_currency}} in {{duration}}. Trx: {{trx}}', '{\"trx\":\"trx\",\"amount\":\"amount\",\"currency\":\"currency\",\"withdraw_method\":\"withdraw_method\",\"method_amount\":\"method_amount\",\"method_currency\":\"method_currency\",\"duration\":\"duration\"}', 1, 1, 'WITHDRAW_REQUEST', '2019-09-25 05:04:05', '2019-11-06 06:36:28'),
(12, 'invoice-create', 'Invoice created - To Payer', 'Payment Invoice', '{{amount}} {{currency}} invoice created for You By  {{creator_email}}.<div><br></div><div>&nbsp;Payment Link: <a href=\"{{payment_link}}\">{{payment_link}}</a> &nbsp;</div><div><br></div><div>&nbsp;Download Link: <a href=\"{{download_link}}\">{{download_link}}</a></div>', '{{amount}} {{currency}} invoice created for You By {{creator_email}}.\r\n\r\n Payment Link: {{payment_link}}  \r\n\r\n Download Link: {{download_link}}', '{\"amount\":\"amount\",\"currency\":\"currency\",\"creator_email\":\"creator email\",\"payment_link\":\"payment link\",\"download_link\":\"download link\"}', 1, 1, 'INVOICE_CREATE', '2019-09-25 05:04:05', '2019-11-06 06:36:43'),
(13, 'invoice-payment-send', 'Invoice Paid - To Payer', 'Payment Send Successfully', 'You have  paid  {{amount}} {{currency}} invoice payment successfully  to {{receiver_email}} By  {{gateway}}.<div><br></div><div>Invoice No: {{invoice_no}}&nbsp;</div><div><br></div><div>&nbsp;Download Link: {{download_link}}</div>', 'You have paid {{amount}} {{currency}} invoice payment successfully to {{receiver_email}} By {{gateway}}.\r\n\r\nInvoice No: {{invoice_no}} \r\n\r\n Download Link: {{download_link}}', '{\"amount\":\"amount\",\"currency\":\"currency\",\"gateway\":\"gateway\",\"invoice_no\":\"invoice_no\",\"download_link\":\"download link\",\"receiver_email\":\"receiver_email\"}', 1, 1, 'INVOICE_PAYMENT', '2019-09-25 05:04:05', '2019-11-06 06:36:59'),
(14, 'invoice-payment-get', 'Invoice Paid - Creator', 'Invoice Payment Received Successfully', 'You have  got {{amount}} {{currency}} invoice payment successfully  from {{sender_email}} By  {{gateway}}.<div><br></div><div>&nbsp;Invoice No: {{invoice_no}}&nbsp;</div><div><br></div><div>&nbsp;Download Link: {{download_link}}</div>', 'You have got {{amount}} {{currency}} invoice payment successfully from {{sender_email}} By {{gateway}}.\r\n\r\n Invoice No: {{invoice_no}} \r\n\r\n Download Link: {{download_link}}', '{\"amount\":\"amount\",\"currency\":\"currency\",\"gateway\":\"gateway\",\"invoice_no\":\"invoice_no\",\"download_link\":\"download link\",\"sender_email\":\"sender email\"}', 1, 1, 'INVOICE_PAYMENT', '2019-09-25 05:04:05', '2019-11-06 06:37:43'),
(15, 'admin-add-balance', 'Balance added By admin', 'Balance added By admin', '{{amount}} {{currency}} added in your account by Admin. Your Current Balance  {{remaining_balance}}  {{currency}}. Transaction {{transaction}}', '{{amount}} {{currency}} added in your account by Admin. Your Current Balance {{remaining_balance}} {{currency}}. Transaction {{transaction}}', '{\"amount\":\"amount\",\"currency\":\"currency\",\"remaining_balance\":\"remaining balance\",\"transaction\":\"transaction\"}', 1, 1, 'ADMIN_MANAGE_BALANCE', '2019-09-25 05:04:05', '2019-11-06 06:37:58'),
(16, 'admin-sub-balance', 'Substract Balance  By admin', 'Substract Balance added By admin', '{{amount}} {{currency}} substracted  from your account by Admin. Your Current Balance  {{remaining_balance}}  {{currency}}. Transaction {{transaction}}', '{{amount}} {{currency}} substracted from your account by Admin. Your Current Balance {{remaining_balance}} {{currency}}. Transaction {{transaction}}', '{\"amount\":\"amount\",\"currency\":\"currency\",\"remaining_balance\":\"remaining balance\",\"transaction\":\"transaction\"}', 1, 1, 'ADMIN_MANAGE_BALANCE', '2019-09-25 05:04:05', '2019-11-06 06:38:11'),
(17, 'deposit_approve', 'Manual Deposit Approved', 'Payment Approval Successful', 'Admin Approve Your  {{amount}} {{gateway_currency}}  payment request by {{gateway_name}} transaction : {{transaction}}', 'Admin Approve Your {{amount}} {{gateway_currency}} payment request by {{gateway_name}} transaction : {{transaction}}', '{\"amount\":\"amount\",\"gateway_currency\":\"gateway_currency\",\"gateway_name\":\"gateway_name\",\"transaction\":\"transaction\"}', 1, 1, 'DEPOSIT', '2019-09-25 05:04:05', '2019-11-06 06:38:23'),
(18, 'deposit_reject', 'Manual Deposit Rejected', 'Payment Request Cancel', 'Admin Rejected Your  {{amount}} {{gateway_currency}}  payment request by {{gateway_name}}', 'Admin Rejected Your {{amount}} {{gateway_currency}} payment request by {{gateway_name}}', '{\"amount\":\"amount\",\"gateway_currency\":\"gateway_currency\",\"gateway_name\":\"gateway_name\"}', 1, 1, 'DEPOSIT', '2019-09-25 05:04:05', '2019-11-06 06:38:36'),
(19, 'withdraw_reject', 'Withdraw Request refunded', 'Withdraw Request Cancel', 'Admin Rejected Your  {{amount}} {{currency}}  withdraw request by {{method}}. Your Main Balance  {{main_balance}} {{currency}} , Transaction {{transaction}}', 'Admin Rejected Your {{amount}} {{currency}} withdraw request by {{method}}. Your Main Balance {{main_balance}} {{currency}} , Transaction {{transaction}}', '{\"amount\":\"amount\",\"currency\":\"currency\",\"main_balance\":\"main_balance\",\"method\":\"method\",\"transaction\":\"transaction\"}', 1, 1, 'WITHDRAW', '2019-09-25 05:04:05', '2019-11-06 06:38:49'),
(20, 'withdraw_approve', 'Withdraw Request Confirm', 'Withdraw Request Confirm', 'Admin Approve Your  {{amount}} {{currency}}  withdraw request by {{method}}.  Transaction {{transaction}}', 'Admin Approve Your {{amount}} {{currency}} withdraw request by {{method}}. Transaction {{transaction}}', '{\"amount\":\"amount\",\"currency\":\"currency\",\"method\":\"method\",\"transaction\":\"transaction\"}', 1, 1, 'WITHDRAW', '2019-09-25 05:04:05', '2019-11-06 06:39:02'),
(21, 'admin-reply-support', 'Support Ticket Reply ', 'Reply Support Ticket ', '{{subject}}\r\n\r\n{{replied}}', '{{subject}}\r\n\r\n{{replied}}', '{\"subject\":\"subject\",\"replied\":\"reply from staff/admin\"}', 1, 1, 'REPLY_SUPPORT', '2019-09-25 05:04:05', '2019-10-20 07:16:02'),
(22, 'api_payment', 'Payment received - API', 'GET Payment Successfully', '{{amount}} {{gateway_currency}}  payment successfully by {{gateway_name}} transaction {{trx}}', '{{amount}} {{gateway_currency}} payment successfully by {{gateway_name}} transaction {{trx}}', '{\"amount\":\"amount\",\"gateway_currency\":\"gatway_currency\",\"gateway_name\":\"gateway_name\",\"trx\":\"transaction\"}', 1, 1, 'PAYMENT_API', '2019-09-25 05:04:05', '2019-11-06 06:40:28'),
(23, 'direct-wallet-pay', 'Money Sent - API', 'Paid Payment Successfully', 'You have  paid\r\n {{amount}} {{currency}}   For  {{itemname}} From {{paytoname}} . Main account  {{main_amo}} {{currency}}  . trx {{trx}}', 'You have paid {{amount}} {{currency}} For {{itemname}} From {{paytoname}} . Main account {{main_amo}} {{currency}} . trx {{trx}}', '{\"amount\":\"amount\",\"currency\":\"currency\",\"main_amo\":\"main_amo\",\"trx\":\"transaction\",\"itemname\":\"item name\",\"paytoname\":\"pay to name\"}', 1, 1, 'PAYMENT', '2019-09-25 05:04:05', '2019-11-06 06:42:09'),
(24, 'direct-wallet-receive', 'Money Received  - API', 'Receive Payment Successfully', 'You have  Received \r\n {{amount}} {{currency}}   For  {{itemname}} From {{user_mail}} . Main account  {{main_amo}} {{currency}}  . trx {{trx}}', 'You have Received {{amount}} {{currency}} For {{itemname}} From {{user_mail}} . Main account {{main_amo}} {{currency}} . trx {{trx}}', '{\"amount\":\"amount\",\"currency\":\"currency\",\"main_amo\":\"main_amo\",\"trx\":\"transaction\",\"itemname\":\"item name\",\"user_mail\":\"user mail\"}', 1, 1, 'PAYMENT', '2019-09-25 05:04:05', '2019-11-06 06:43:59'),
(25, 'login-notify', 'Login Notify', 'Login Notify', 'Your account login from another device. Ip Address\r\n {{ip}}  Browser:  {{browser}}   Time {{time}} ', 'Your account login from another device. Ip Address\r\n {{ip}}  Browser:  {{browser}}   Time {{time}} ', '{\"ip\":\"ip\",\"time\":\"time\",\"browser\":\"browser\"}', 1, 1, 'LOGIN_NOTIFY', '2019-09-25 05:04:05', '2019-10-20 07:16:02'),
(26, 'money_transfer_send', 'Send Money', 'Send Money transfer', '{{amount}} {{currency}} Send TO {{to_email}}.&nbsp;<div><br></div><div>&nbsp;Receiver Username : {{to_username}}&nbsp;</div><div>Receiver Full Name: {{to_fullname}}</div><div><br></div><div>&nbsp;Your Current Balance: {{current_balance}} {{currency}}&nbsp;</div><div><br></div><div>&nbsp;Your Transaction ID : #{{transaction_id}}\r\n{{message}}</div>', '{{amount}} {{currency}} Send TO {{to_email}}. \r\n\r\n Receiver Username : {{to_username}} \r\nReceiver Full Name: {{to_fullname}}\r\n\r\n Your Current Balance: {{current_balance}} {{currency}} \r\n\r\n Your Transaction ID : #{{transaction_id}} {{message}}', '{\"amount\":\"Amount\",\"currency\":\"currency\",\"to_username\":\"to_username\",\"to_fullname\":\"to_fullname\",\"to_email\":\"to_email\",\"transaction_id\":\"Transaction Id\",\"message\":\"message\",\"current_balance\":\"current balance\"}', 1, 1, 'TRANSFER', '2019-09-25 05:04:05', '2019-11-06 06:44:34'),
(27, 'request_to_money', 'Request Money- request to', 'Request For Money transfer', '{{request_amount}} {{request_currency}} money&nbsp;<span style=\"font-family: &quot;Open Sans&quot;, sans-serif;\">request&nbsp;</span>&nbsp;by  {{sender}}&nbsp;<div><span style=\"font-family: var(--para-font);\"><br></span></div><div><span style=\"font-family: var(--para-font);\">&nbsp;{{message}}</span><br></div><div><span style=\"font-family: var(--para-font);\"><br></span></div><div><span style=\"font-family: var(--para-font);\">&nbsp;{{details}}</span><br></div>', '{{request_amount}} {{request_currency}} money request  by {{sender}} \r\n\r\n {{message}}\r\n\r\n {{details}}', '{\"request_amount\":\"Amount\",\"request_currency\":\"currency \",\"sender\":\"sender mail\",\"message\":\"message\",\"details\":\"details\"}', 1, 1, 'REQUEST_MONEY', '2019-09-25 05:04:05', '2019-11-06 06:44:46'),
(28, 'request_money_send', 'Request Money sent', 'Request Money Send', '{{amount}} {{currency}} money&nbsp;<span style=\"font-family: &quot;Open Sans&quot;, sans-serif;\">request&nbsp;</span>&nbsp;Accpeted By You.<div>Your Main Balance {{main_balance}} {{currency}}<span style=\"font-family: &quot;Open Sans&quot;, sans-serif;\"><br></span><br>Receiver username: {{by_username}}<br><span style=\"font-family: &quot;Open Sans&quot;, sans-serif;\">Receiver fullname: {{by_fullname}}</span></div><div><span style=\"font-family: &quot;Open Sans&quot;, sans-serif;\">Receiver Email: {{by_email}}</span><span style=\"font-family: &quot;Open Sans&quot;, sans-serif;\"><br></span></div><div><br><div><span style=\"font-family: var(--para-font);\">&nbsp;{{message}}</span><br></div><div><span style=\"font-family: var(--para-font);\"><br></span></div><div><span style=\"font-family: var(--para-font);\">&nbsp;{{details}}</span><br></div></div>', '{{amount}} {{currency}} money request  Accpeted By You.\r\nYour Main Balance {{main_balance}} {{currency}}\r\n\r\nReceiver username: {{by_username}}\r\nReceiver fullname: {{by_fullname}}\r\nReceiver Email: {{by_email}}\r\n\r\n {{message}}\r\n\r\n {{details}}', '{\"amount\":\"Amount\",\"main_balance\":\"main balance\",\"currency\":\"currency\",\"by_username\":\"by_username\",\"by_fullname\":\"by_fullname\",\"by_email\":\"by_email\",\"message\":\"message\",\"details\":\"details\"}', 1, 1, 'REQUEST_MONEY', '2019-09-25 05:04:05', '2019-11-06 06:45:00'),
(29, 'request_money_receive', 'Request Money Received', 'Request Money Receive', '{{amount}} {{currency}} money send &nbsp;By&nbsp;<span style=\"font-family: &quot;Open Sans&quot;, sans-serif;\">&nbsp;{{to_username}}</span>.<div>Your Main Balance {{main_balance}} {{currency}}<span style=\"font-family: &quot;Open Sans&quot;, sans-serif;\"><br></span><br>Receiver username: {{to_username}}<br><span style=\"font-family: &quot;Open Sans&quot;, sans-serif;\">Receiver fullname: {{to_fullname}}</span></div><div><span style=\"font-family: &quot;Open Sans&quot;, sans-serif;\">Receiver Email: {{to_email}}</span><span style=\"font-family: &quot;Open Sans&quot;, sans-serif;\"><br></span></div><div><br><div><span style=\"font-family: var(--para-font);\">&nbsp;{{message}}</span><br></div><div><span style=\"font-family: var(--para-font);\"><br></span></div><div><span style=\"font-family: var(--para-font);\">&nbsp;{{details}}</span><br></div></div>', '{{amount}} {{currency}} money send  By  {{to_username}}.\r\nYour Main Balance {{main_balance}} {{currency}}\r\n\r\nReceiver username: {{to_username}}\r\nReceiver fullname: {{to_fullname}}\r\nReceiver Email: {{to_email}}\r\n\r\n {{message}}\r\n\r\n {{details}}', '{\"amount\":\"Amount\",\"main_balance\":\"main balance\",\"currency\":\"currency\",\"to_username\":\"to_username\",\"to_fullname\":\"to_fullname\",\"to_email\":\"to_email\",\"message\":\"message\",\"details\":\"details\"}', 1, 1, 'REQUEST_MONEY', '2019-09-25 05:04:05', '2019-11-06 06:45:12'),
(30, 'voucher_redeem', 'Voucher redeemed', 'Voucher Active', '{{amount}} {{currency}} voucher created succeessfully.&nbsp;<div>Voucher Number: {{voucher_number}}&nbsp;<br><div>Charge:   {{charge}} {{currency}}</div><div>&nbsp;Total Pay:  {{total}} {{currency}}</div><div>Tranasction : #{{transaction_id}}</div><div>Your Main Balance {{new_balance}} {{currency}}</div></div>', '{{amount}} {{currency}} voucher redeemed succeessfully. \r\nVoucher Number: {{voucher_number}} \r\nCharge: {{charge}} {{currency}}\r\n Total Pay: {{total}} {{currency}}\r\nTranasction : #{{transaction_id}}\r\nYour Main Balance {{new_balance}} {{currency}}', '{\"amount\":\"Amount\",\"charge\":\"charge\",\"total\":\"total\",\"currency\":\"currency\",\"new_balance\":\"new_balance\",\"transaction_id\":\"transaction\",\"voucher_number\":\"voucher_number\"}', 1, 1, 'VOUCHER', '2019-09-25 05:04:05', '2019-11-06 06:45:29'),
(31, 'voucher_redeem_creator', 'Your Voucher redeemed', 'Your Voucher Redeem', '{{amount}} {{currency}} voucher Redeem succeessfully.&nbsp;<div>Voucher Number: {{voucher_number}}&nbsp;</div><div><br></div><div>Username: {{by_username}}</div><div><span style=\"font-family: &quot;Open Sans&quot;, sans-serif;\">Fullname: {{by_fullname}}</span></div><div><span style=\"font-family: &quot;Open Sans&quot;, sans-serif;\">Email: {{by_email}}</span><span style=\"font-family: &quot;Open Sans&quot;, sans-serif;\"><br></span></div>', '{{amount}} {{currency}} voucher Redeem succeessfully. \r\nVoucher Number: {{voucher_number}} \r\n\r\nUsername: {{by_username}}\r\nFullname: {{by_fullname}}\r\nEmail: {{by_email}}', '{\"amount\":\"Amount\",\"currency\":\"currency\",\"voucher_number\":\"voucher_number\",\"by_username\":\"by_username\",\"by_fullname\":\"by_fullname\",\"by_email\":\"by_email\"}', 1, 1, 'VOUCHER', '2019-09-25 05:04:05', '2019-11-06 06:45:42'),
(32, 'EVER_CODE', 'Email Verification code send', 'Please verify your email address', 'Your email verification code is: {{code}}', 'Your email verification code is: {{code}}', '{\"code\":\"Verification code\"}', 1, 1, NULL, NULL, NULL),
(33, 'SVER_CODE', 'Phone Verification code send', 'Please verify your phone', 'Your phone verification code is: {{code}}', 'Your phone verification code is: {{code}}', '{\"code\":\"Verification code\"}', 1, 1, NULL, NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `exchange_money`
--

CREATE TABLE `exchange_money` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `from_currency_id` int(11) DEFAULT NULL,
  `from_currency_amount` decimal(18,8) NOT NULL DEFAULT 0.00000000,
  `from_currency_charge` decimal(18,8) NOT NULL DEFAULT 0.00000000,
  `to_currency_id` int(11) DEFAULT NULL,
  `to_currency_amount` decimal(18,8) NOT NULL DEFAULT 0.00000000,
  `trx` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `express_payments`
--

CREATE TABLE `express_payments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `payto_id` int(11) DEFAULT NULL COMMENT 'merchant_id',
  `paidby_id` int(11) DEFAULT NULL COMMENT 'user_id',
  `wallet_id` int(11) DEFAULT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `trx` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` decimal(18,8) NOT NULL,
  `charge` decimal(18,8) NOT NULL,
  `wallet_amount` decimal(18,8) NOT NULL,
  `status` int(11) NOT NULL DEFAULT 0,
  `all_data` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'amount, currency,  public_key, custom, details, ipn_url, success_url, cancel_url  ',
  `merchant_wallet` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `frontends`
--

CREATE TABLE `frontends` (
  `id` int(10) UNSIGNED NOT NULL,
  `data_keys` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data_values` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `frontends`
--

INSERT INTO `frontends` (`id`, `data_keys`, `data_values`, `created_at`, `updated_at`) VALUES
(1, 'seo', '{\"keywords\":[\"wallet\",\"money transaction\",\"send money\",\"receive money\",\"bitcoin\",\"invoice\",\"payment api\",\"payment gateway\",\"ewallet\",\"justwallet\",\"just wallet\"],\"description\":\"SEND & RECEIVE MONEY JUST IN A SECOND AROUND THE GLOBE\",\"social_title\":\"XenWallet\",\"social_description\":\"SEND & RECEIVE MONEY JUST IN A SECOND AROUND THE GLOBE\",\"image\":\"5e31b641d43751580316225.jpg\"}', '2019-09-25 05:04:05', '2021-02-09 16:24:18'),
(3, 'gauth', '{\"id\":\"DEMO\",\"secret\":\"DEMO\"}', '2019-09-25 05:04:05', '2019-09-25 05:04:05'),
(4, 'fauth', '{\"id\":\"DEMO\",\"secret\":\"DEMO\"}', '2019-09-25 05:04:05', '2019-09-25 05:04:05'),
(18, 'faq', '{\"title\":\"What bonuses are for regular customers?\",\"body\":\"<span style=\\\"color: rgb(33, 37, 41); font-family: &quot;Open Sans&quot;, sans-serif; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;\\\">Any registered user, making any exchange, is already involved in the formation of its cumulative discount. After reaching any of the stages of our loyalty program, you will receive a coefficient that is applied to the formation of a more favorable exchange rate just for you at each subsequent exchange. That is, you get a discount on any exchange in any direction. You can get acquainted with more detailed information after registration in your Personal Account.<\\/span>\"}', NULL, '2021-02-09 16:15:04'),
(21, 'company_policy', '{\"title\":\"Privacy Policy\",\"body\":\"<p style=\\\"margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; text-align: justify; color: rgb(0, 0, 0); font-family: &quot;Open Sans&quot;, Arial, sans-serif;\\\">It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).<\\/p><div><p style=\\\"margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; text-align: justify; color: rgb(0, 0, 0); font-family: &quot;Open Sans&quot;, Arial, sans-serif;\\\">It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).<\\/p><\\/div><div><p style=\\\"margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; text-align: justify; color: rgb(0, 0, 0); font-family: &quot;Open Sans&quot;, Arial, sans-serif;\\\">It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).<\\/p><\\/div><div><p style=\\\"margin-right: 0px; margin-bottom: 15px; margin-left: 0px; padding: 0px; text-align: justify; color: rgb(0, 0, 0); font-family: &quot;Open Sans&quot;, Arial, sans-serif;\\\">It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).<\\/p><\\/div><div><br><\\/div>\"}', '2019-10-13 06:17:55', '2019-11-05 05:53:25'),
(23, 'contact', '{\"title\":\"Any Asking To Us?\",\"short_details\":\"We are here for you always! please fill up the information and feel free ask if you have any query.\",\"form_heading\":\"Send us an email\",\"email_address\":\"Xenwallet@example.com\",\"contact_details\":\"130 Hollister Church Rd, Palatka, FL, 32177  745 Old Springville\",\"contact_number\":\"+01800 000 000\"}', '2019-10-13 06:41:26', '2021-02-09 16:18:58'),
(24, 'faq', '{\"title\":\"Do you have an affiliate program?\",\"body\":\"<span style=\\\"color: rgb(33, 37, 41); font-family: &quot;Open Sans&quot;, sans-serif; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;\\\">Yes. We have a very clear and transparent affiliate program, according to which you can receive 25% of our earnings for exchanging the users you cited. Remuneration payments are from 1 PMUSD. In your office you can track the operations of your referrals online. You can get acquainted with more detailed information after registration in your Personal Account. <\\/span><br><span style=\\\"color: rgb(33, 37, 41); font-family: &quot;Open Sans&quot;, sans-serif; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;\\\"><span style=\\\"color: rgb(33, 37, 41); font-family: &quot;Open Sans&quot;, sans-serif; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;\\\">You can get acquainted with more detailed information after registration in your Personal Account.<\\/span><\\/span>\"}', NULL, '2021-02-09 16:15:48'),
(25, 'faq', '{\"title\":\"I did not specify a payment note. It is necessary?\",\"body\":\"<span style=\\\"color: rgb(33, 37, 41); font-family: &quot;Open Sans&quot;, sans-serif; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;\\\">When you make an application, you will receive on your monitor exact instructions on what payment you must indicate when making a payment. If this note is not indicated, then we reserve the right to return the amount to the requisites indicated in the application. <\\/span><span style=\\\"color: rgb(33, 37, 41); font-family: &quot;Open Sans&quot;, sans-serif; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;\\\"><span style=\\\"color: rgb(33, 37, 41); font-family: &quot;Open Sans&quot;, sans-serif; font-size: 14px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: left; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;\\\">The procedure can take up to 6 days. At the same time, all commissions are charged to the client. <\\/span>The procedure can take up to 6 days. At the same time, all commissions are charged to the client.<\\/span>\"}', NULL, '2021-02-09 16:16:56'),
(27, 'blog.post', '{\"title\":\"Warren Buffett: Do the Research\",\"body\":\"<h2 id=\\\"mntl-sc-block_1-0-15\\\" class=\\\"comp mntl-sc-block finance-sc-block-heading mntl-sc-block-heading\\\" style=\\\"box-sizing: border-box; font-weight: 400; line-height: 1.2; color: rgb(17, 17, 17); font-size: 1.625rem; margin: 0px; font-family: SourceSansPro, sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\\\"><span class=\\\"mntl-sc-block-heading__text\\\" style=\\\"box-sizing: border-box;\\\"><br><\\/span><\\/h2><p id=\\\"mntl-sc-block_1-0-16\\\" class=\\\"comp mntl-sc-block finance-sc-block-html mntl-sc-block-html\\\" style=\\\"box-sizing: border-box; margin-bottom: 1.75rem; margin-top: 0px; counter-reset: section 0; color: rgb(17, 17, 17); font-family: SourceSansPro, sans-serif; font-size: 17.6px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\\\"><a href=\\\"https:\\/\\/www.investopedia.com\\/articles\\/01\\/071801.asp\\\" data-component=\\\"link\\\" data-source=\\\"inlineLink\\\" data-type=\\\"internalLink\\\" data-ordinal=\\\"1\\\" rel=\\\"noopener noreferrer\\\" style=\\\"box-sizing: border-box; color: rgb(44, 64, 208); text-decoration: underline;\\\">Warren Buffett<\\/a><span>&nbsp;<\\/span>is widely considered to be the most successful investor in history. Not only is he one of the richest men in the world, but he also has had the financial ear of numerous presidents and world leaders. When Buffett talks, world markets move based on his words.<\\/p><blockquote id=\\\"mntl-sc-block_1-0-18\\\" class=\\\"comp mntl-sc-block finance-sc-block-html mntl-sc-block-html\\\" style=\\\"box-sizing: border-box; margin-bottom: 1.75rem; margin-top: 0px; font-style: italic; padding-left: 3rem; padding-right: 3rem; counter-reset: section 0; color: rgb(17, 17, 17); font-family: SourceSansPro, sans-serif; font-size: 17.6px; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\\\">\\\"It\'s far better to buy a wonderful company at a fair price than a fair company at a wonderful price.\\\" \\u2014Warren Buffett<span class=\\\"mntl-inline-citation mntl-dynamic-tooltip--trigger\\\" data-id=\\\"#citation-9\\\" style=\\\"box-sizing: border-box; text-decoration: none; vertical-align: super; font-size: 13.2px; cursor: pointer; color: rgb(0, 0, 238); position: inherit; padding-bottom: 15px; font-weight: 400; letter-spacing: 0.07em; margin-left: 2px;\\\"><span style=\\\"box-sizing: border-box; pointer-events: none;\\\">3<\\/span><\\/span>\\ufeff<\\/blockquote><p id=\\\"mntl-sc-block_1-0-20\\\" class=\\\"comp mntl-sc-block finance-sc-block-html mntl-sc-block-html\\\" style=\\\"box-sizing: border-box; margin-bottom: 1.75rem; margin-top: 0px; counter-reset: section 0; color: rgb(17, 17, 17); font-family: SourceSansPro, sans-serif; font-size: 17.6px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\\\">Buffett is also known as being a prolific teacher. His annual letter to investors in his company,<span>&nbsp;<\\/span><a href=\\\"https:\\/\\/www.investopedia.com\\/terms\\/b\\/berkshire-hathaway.asp\\\" data-component=\\\"link\\\" data-source=\\\"inlineLink\\\" data-type=\\\"internalLink\\\" data-ordinal=\\\"1\\\" rel=\\\"noopener noreferrer\\\" style=\\\"box-sizing: border-box; color: rgb(44, 64, 208); text-decoration: underline;\\\">Berkshire Hathaway<\\/a>, is used in college finance classes in the largest and most prestigious universities.<\\/p><p id=\\\"mntl-sc-block_1-0-22\\\" class=\\\"comp mntl-sc-block finance-sc-block-html mntl-sc-block-html\\\" style=\\\"box-sizing: border-box; margin-bottom: 1.75rem; margin-top: 0px; counter-reset: section 0; color: rgb(17, 17, 17); font-family: SourceSansPro, sans-serif; font-size: 17.6px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\\\">Buffett gives two key pieces of advice when evaluating a company: First, look at the quality of the company, then at the price. Looking at the quality of a company&nbsp;requires that you read<span>&nbsp;<\\/span><a href=\\\"https:\\/\\/www.investopedia.com\\/terms\\/f\\/financial-statements.asp\\\" data-component=\\\"link\\\" data-source=\\\"inlineLink\\\" data-type=\\\"internalLink\\\" data-ordinal=\\\"1\\\" rel=\\\"noopener noreferrer\\\" style=\\\"box-sizing: border-box; color: rgb(44, 64, 208); text-decoration: underline;\\\">financial statements<\\/a>, listen to conference calls, and vet management. Then, only after you have confidence in the quality of the company, should the price be evaluated.<\\/p><div id=\\\"mntl-sc-block_1-0-24\\\" class=\\\"comp mntl-sc-block finance-sc-block-callout mntl-block\\\" style=\\\"box-sizing: border-box; color: rgb(17, 17, 17); font-family: SourceSansPro, sans-serif; font-size: 17.6px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\\\"><div id=\\\"mntl-sc-block_1-0-25\\\" class=\\\"comp theme-note mntl-sc-block mntl-sc-block-callout mntl-block\\\" data-tracking-id=\\\"mntl-sc-block-callout\\\" data-tracking-container=\\\"true\\\" style=\\\"box-sizing: border-box;\\\"><div id=\\\"mntl-sc-block-callout-body_1-0-1\\\" class=\\\"comp mntl-sc-block-callout-body mntl-text-block\\\" style=\\\"box-sizing: border-box; padding: 0px 1rem 0.6rem; position: relative; margin-bottom: 1rem;\\\"><p style=\\\"box-sizing: border-box; margin-bottom: 0px; margin-top: 0px; font-size: 1.25rem; line-height: 1.75rem; font-weight: 400; font-style: italic;\\\">If a company isn\'t a quality company, don\'t buy it just because the price is low. Bargain-bin companies often produce bargain-bin results.<\\/p><\\/div><\\/div><\\/div>\",\"image\":\"60225fda390db1612865498.jpg\"}', '2020-01-27 05:54:46', '2021-02-09 16:11:38'),
(28, 'blog.post', '{\"title\":\"Prince Alwaleed: Patience Is Key\",\"body\":\"<p id=\\\"mntl-sc-block_1-0-27\\\" class=\\\"comp mntl-sc-block finance-sc-block-html mntl-sc-block-html\\\" style=\\\"box-sizing: border-box; margin-bottom: 1.75rem; margin-top: 0px; counter-reset: section 0; color: rgb(17, 17, 17); font-family: SourceSansPro, sans-serif; font-size: 17.6px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\\\">Bill Gross is the co-founder of<span>&nbsp;<\\/span><a href=\\\"https:\\/\\/www.investopedia.com\\/terms\\/p\\/pimco.asp\\\" data-component=\\\"link\\\" data-source=\\\"inlineLink\\\" data-type=\\\"internalLink\\\" data-ordinal=\\\"1\\\" rel=\\\"noopener noreferrer\\\" style=\\\"box-sizing: border-box; color: rgb(44, 64, 208); text-decoration: underline;\\\">PIMCO<\\/a>. He managed the PIMCO Total Return Fund, one of the largest bond funds in the world, and was the firm\'s chief investment officer before leaving in 2014.<span class=\\\"mntl-inline-citation mntl-dynamic-tooltip--trigger\\\" data-id=\\\"#citation-6\\\" data-tooltip-position-x=\\\"center\\\" data-tooltip-position-y=\\\"top\\\" style=\\\"box-sizing: border-box; text-decoration: none; vertical-align: super; font-size: 13.2px; cursor: pointer; color: rgb(0, 0, 238); position: inherit; padding-bottom: 15px; font-weight: 400; letter-spacing: 0.07em; margin-left: 2px;\\\"><span style=\\\"box-sizing: border-box; pointer-events: none;\\\">4<\\/span><\\/span><\\/p><div id=\\\"mntl-dynamic-tooltip\\\" class=\\\"mntl-dynamic-tooltip\\\" data-tracking-container=\\\"true\\\" style=\\\"box-sizing: border-box; position: absolute; background: 0px 0px; left: 0px; pointer-events: none; z-index: 2; opacity: 0; transition: none 0s ease 0s; color: initial; visibility: hidden; width: var(--content-width); right: auto; transform: translateX(0px) translateY(-5px); max-width: 100%;\\\"><div class=\\\"mntl-dynamic-tooltip--content\\\" style=\\\"box-sizing: border-box; background: rgb(255, 255, 255); border: 1px solid rgb(187, 187, 187); padding: 1.125rem; margin-top: 5px; z-index: 2; overflow: hidden;\\\"><p style=\\\"box-sizing: border-box; margin: 0px; letter-spacing: 0.02em; line-height: 1.5;\\\"><a href=\\\"https:\\/\\/www.pimco.com\\/en-us\\/our-firm\\/press-release\\/2014\\/pimco-cio-william-h-gross-to-leave-the-firm\\\" data-component=\\\"link\\\" data-source=\\\"inlineLink\\\" data-type=\\\"externalLink\\\" data-ordinal=\\\"1\\\" rel=\\\"noopener noreferrer nofollow\\\" target=\\\"_blank\\\" style=\\\"box-sizing: border-box; color: rgb(44, 64, 208); text-decoration: underline;\\\"><span style=\\\"box-sizing: border-box; pointer-events: none;\\\"><\\/span><\\/a><\\/p><\\/div><\\/div>\\ufeff<p id=\\\"mntl-sc-block_1-0-29\\\" class=\\\"comp mntl-sc-block finance-sc-block-html mntl-sc-block-html\\\" style=\\\"box-sizing: border-box; margin-bottom: 1.75rem; margin-top: 0px; counter-reset: section 0; color: rgb(17, 17, 17); font-family: SourceSansPro, sans-serif; font-size: 17.6px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\\\">Gross\' rule focuses on portfolio management.<\\/p><blockquote id=\\\"mntl-sc-block_1-0-31\\\" class=\\\"comp mntl-sc-block finance-sc-block-html mntl-sc-block-html\\\" style=\\\"box-sizing: border-box; margin-bottom: 1.75rem; margin-top: 0px; font-style: italic; padding-left: 3rem; padding-right: 3rem; counter-reset: section 0; color: rgb(17, 17, 17); font-family: SourceSansPro, sans-serif; font-size: 17.6px; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\\\">\\\"Do you really like a particular stock? Put 10% or so of your portfolio on it. Make the idea count. Good [investment] ideas should not be diversified away into meaningless oblivion.\\\" \\u2014Bill Gross<span class=\\\"mntl-inline-citation mntl-dynamic-tooltip--trigger\\\" data-id=\\\"#citation-10\\\" style=\\\"box-sizing: border-box; text-decoration: none; vertical-align: super; font-size: 13.2px; cursor: pointer; color: rgb(0, 0, 238); position: inherit; padding-bottom: 15px; font-weight: 400; letter-spacing: 0.07em; margin-left: 2px;\\\"><span style=\\\"box-sizing: border-box; pointer-events: none;\\\">5<\\/span><\\/span>\\ufeff<\\/blockquote><p id=\\\"mntl-sc-block_1-0-33\\\" class=\\\"comp mntl-sc-block finance-sc-block-html mntl-sc-block-html\\\" style=\\\"box-sizing: border-box; margin-bottom: 1.75rem; margin-top: 0px; counter-reset: section 0; color: rgb(17, 17, 17); font-family: SourceSansPro, sans-serif; font-size: 17.6px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\\\">A universal rule that most young investors know is<span>&nbsp;<\\/span><a href=\\\"https:\\/\\/www.investopedia.com\\/terms\\/d\\/diversification.asp\\\" data-component=\\\"link\\\" data-source=\\\"inlineLink\\\" data-type=\\\"internalLink\\\" data-ordinal=\\\"1\\\" rel=\\\"noopener noreferrer\\\" style=\\\"box-sizing: border-box; color: rgb(44, 64, 208); text-decoration: underline;\\\">diversification<\\/a>, i.e. don\'t put all of your investing capital into one name. Diversification is a good rule of thumb, but it can also diminish your profits when one of your picks makes a big move while other names don\'t.<\\/p><p id=\\\"mntl-sc-block_1-0-35\\\" class=\\\"comp mntl-sc-block finance-sc-block-html mntl-sc-block-html\\\" style=\\\"box-sizing: border-box; margin-bottom: 1.75rem; margin-top: 0px; counter-reset: section 0; color: rgb(17, 17, 17); font-family: SourceSansPro, sans-serif; font-size: 17.6px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\\\">Making money in the market is also about taking chances based on exhaustive research. Always keep some cash in your account for those opportunities that need a little more capital and don\'t be afraid to act when you believe that your research is pointing to a real winner.<\\/p>\",\"image\":\"60226002c4ed61612865538.jpg\"}', '2020-01-27 00:29:46', '2021-02-09 16:12:48'),
(29, 'blog.post', '{\"title\":\"Profits Of Successful Investment\",\"body\":\"<p id=\\\"mntl-sc-block_1-0\\\" class=\\\"comp mntl-sc-block finance-sc-block-html mntl-sc-block-html\\\" style=\\\"box-sizing: border-box; margin-bottom: 1.75rem; margin-top: 0px; counter-reset: section 0; color: rgb(17, 17, 17); font-family: SourceSansPro, sans-serif; font-size: 17.6px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\\\">Investors don\'t agree on much, but they do agree that making money in the market comes with a steadfast strategy that is built around a set of rules. Think for a moment about your early days as an<span>&nbsp;<\\/span><a href=\\\"https:\\/\\/www.investopedia.com\\/terms\\/i\\/investor.asp\\\" data-component=\\\"link\\\" data-source=\\\"inlineLink\\\" data-type=\\\"internalLink\\\" data-ordinal=\\\"1\\\" rel=\\\"noopener noreferrer\\\" style=\\\"box-sizing: border-box; color: rgb(44, 64, 208); text-decoration: underline;\\\">investor<\\/a>. If you\'re like many, you jumped in with very little knowledge of the markets. When you bought, you didn\'t know what a<span>&nbsp;<\\/span><a href=\\\"https:\\/\\/www.investopedia.com\\/terms\\/b\\/bid-askspread.asp\\\" data-component=\\\"link\\\" data-source=\\\"inlineLink\\\" data-type=\\\"internalLink\\\" data-ordinal=\\\"2\\\" rel=\\\"noopener noreferrer\\\" style=\\\"box-sizing: border-box; color: rgb(44, 64, 208); text-decoration: underline;\\\">bid-ask spread<\\/a><span>&nbsp;<\\/span>was, and you sold either too early if the stock went up or too late if the stock dropped.<\\/p><p id=\\\"mntl-sc-block_1-0-2\\\" class=\\\"comp mntl-sc-block finance-sc-block-html mntl-sc-block-html\\\" style=\\\"box-sizing: border-box; margin-bottom: 1.75rem; margin-top: 0px; counter-reset: section 0; color: rgb(17, 17, 17); font-family: SourceSansPro, sans-serif; font-size: 17.6px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\\\">If you don\'t have your own carefully crafted suite of investing rules, now is the time to do it, and the best place to start is to ask the people who have had success in their investing careers. We not only found people who can claim success but who are also some of the most successful investors in history.<\\/p><div id=\\\"mntl-sc-block_1-0-4\\\" class=\\\"comp mntl-sc-block finance-sc-block-callout mntl-block\\\" style=\\\"box-sizing: border-box; color: rgb(17, 17, 17); font-family: SourceSansPro, sans-serif; font-size: 17.6px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\\\"><div id=\\\"mntl-sc-block_1-0-5\\\" class=\\\"comp theme-whatyouneedtoknow mntl-sc-block mntl-sc-block-callout mntl-block\\\" data-tracking-id=\\\"mntl-sc-block-callout\\\" data-tracking-container=\\\"true\\\" style=\\\"box-sizing: border-box; margin: 1rem 0px 2rem; position: relative;\\\"><h3 id=\\\"mntl-sc-block-callout-heading_1-0\\\" class=\\\"comp mntl-sc-block-callout-heading mntl-text-block\\\" style=\\\"box-sizing: border-box; font-weight: 400; line-height: 1.2; margin: 0px; font-size: 1rem; text-transform: uppercase; letter-spacing: 0.05rem; font-family: Cabin-semi-bold, sans-serif; display: block; padding: 1.5625rem 1.25rem 0.5625rem;\\\">KEY TAKEAWAYS<\\/h3><div id=\\\"mntl-sc-block-callout-body_1-0\\\" class=\\\"comp mntl-sc-block-callout-body mntl-text-block\\\" style=\\\"box-sizing: border-box; padding: 0px 1.25rem 1.25rem;\\\"><ul style=\\\"box-sizing: border-box; margin-bottom: 0px; margin-top: 0px; padding-left: 1.5rem; list-style: disc;\\\"><li style=\\\"box-sizing: border-box; padding-bottom: 0.375rem;\\\">Successful investors all have one thing in common\\u2014they have rules.<\\/li><li style=\\\"box-sizing: border-box; padding-bottom: 0.375rem;\\\">Notable investors like Warren Buffett say to focus on fundamentals and management quality before looking at the price of a stock.<\\/li><li style=\\\"box-sizing: border-box; padding-bottom: 0.375rem; margin-bottom: 0px;\\\">Other major investors advise on betting big when you have an edge and to always be forward-thinking.<\\/li><\\/ul><\\/div><\\/div><\\/div><span style=\\\"color: rgb(17, 17, 17); font-family: SourceSansPro, sans-serif; font-size: 17.6px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial; display: inline !important; float: none;\\\"><\\/span><h2 id=\\\"mntl-sc-block_1-0-6\\\" class=\\\"comp mntl-sc-block finance-sc-block-heading mntl-sc-block-heading\\\" style=\\\"box-sizing: border-box; font-weight: 400; line-height: 1.2; color: rgb(17, 17, 17); font-size: 1.625rem; margin: 0px; font-family: SourceSansPro, sans-serif; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\\\"><span class=\\\"mntl-sc-block-heading__text\\\" style=\\\"box-sizing: border-box;\\\">1. Dennis Gartman: Let Winners Run<\\/span><\\/h2><p id=\\\"mntl-sc-block_1-0-7\\\" class=\\\"comp mntl-sc-block finance-sc-block-html mntl-sc-block-html\\\" style=\\\"box-sizing: border-box; margin-bottom: 1.75rem; margin-top: 0px; counter-reset: section 0; color: rgb(17, 17, 17); font-family: SourceSansPro, sans-serif; font-size: 17.6px; font-style: normal; font-variant-ligatures: normal; font-variant-caps: normal; font-weight: 400; letter-spacing: normal; orphans: 2; text-align: start; text-indent: 0px; text-transform: none; white-space: normal; widows: 2; word-spacing: 0px; -webkit-text-stroke-width: 0px; background-color: rgb(255, 255, 255); text-decoration-thickness: initial; text-decoration-style: initial; text-decoration-color: initial;\\\">Dennis Gartman began publishing The Gartman Letter<em style=\\\"box-sizing: border-box;\\\"><span>&nbsp;<\\/span><\\/em>in 1987. It is a daily commentary of global<span>&nbsp;<\\/span><a href=\\\"https:\\/\\/www.investopedia.com\\/terms\\/c\\/capitalmarkets.asp\\\" data-component=\\\"link\\\" data-source=\\\"inlineLink\\\" data-type=\\\"internalLink\\\" data-ordinal=\\\"1\\\" rel=\\\"noopener noreferrer\\\" style=\\\"box-sizing: border-box; color: rgb(44, 64, 208); text-decoration: underline;\\\">capital markets<\\/a><span>&nbsp;<\\/span>that is delivered to hedge funds, brokerage firms, mutual funds, and grain and trading firms around the world each morning. Gartman is also an accomplished trader and a frequent guest on financial<\\/p>\",\"image\":\"60225f99b71571612865433.jpg\"}', '2020-01-29 05:54:46', '2021-02-09 16:10:51'),
(30, 'team.caption', '{\"title\":\"who makes us strong\",\"short_details\":\"Meet Our Teammates\"}', '2019-10-13 06:41:26', '2020-01-02 01:10:15'),
(46, 'testimonial.caption', '{\"title\":\"What Users Say About Us\",\"short_details\":\"A huge number of people trust us and here are the words of some of them.\"}', '2019-10-13 06:41:26', '2021-02-09 16:03:35'),
(47, 'about', '{\"title\":\"What We Do\",\"sub_title\":\"About Us\",\"details\":\"We are an international company which performed by the qualified professional transaction through the wallet. Our goal is to utilize your money and provide a source of high income while minimizing any possibility of risk also ensuring a high-quality service, allowing us to have a good relation with our investors. We work to ensure a successful and safe transaction via Xenwallet. We look forward to you being a part of our company.\"}', '2019-10-13 06:41:26', '2021-02-09 16:19:30'),
(48, 'howitwork.caption', '{\"title\":\"Why Choose Us\",\"short_details\":\"Our goal is to provide our a good and reliable wallet service for the user while ensuring them safe and secure transactions.\"}', '2019-10-13 06:41:26', '2021-02-09 15:24:22'),
(52, 'whychoose.caption', '{\"title\":\"Our Services\",\"short_details\":\"All your digital assets in one place, Take full control of your tokens and collectibles by storing them on your own wallet.\"}', '2019-10-13 06:41:26', '2021-02-09 15:56:05'),
(56, 'flowstep.caption', '{\"title\":\"How The System Works\",\"short_details\":\"The easy way to transfer foreign currency withe Xenwallet a easy task. Take full control and collectibles by storing them on your own device with system.\"}', '2019-10-13 06:41:26', '2021-02-09 15:22:47'),
(59, 'flowstep', '{\"title\":\"Send\",\"icon\":\"<i class=\\\"fas fa-arrow-circle-up\\\"><\\/i>\",\"details\":\"Send money overseas easily and securely with Xenwallet. Transfer money to your friends and family worldwide.\"}', '2019-10-15 01:49:09', '2021-02-09 15:12:16'),
(60, 'flowstep', '{\"title\":\"Receive\",\"icon\":\"<i class=\\\"fas fa-arrow-circle-down\\\"><\\/i>\",\"details\":\"let you get paid by Xenwallet worldwide. You can use Xenwallet by receiving payments from anywhere\"}', '2019-10-15 01:49:50', '2021-02-09 15:15:05'),
(63, 'flowstep', '{\"title\":\"Wallet\",\"icon\":\"<i class=\\\"fas fa-wallet\\\"><\\/i>\",\"details\":\"Use the wallet! Do the transaction with the most secure and fastest wallet system to anywhere\"}', '2019-10-15 01:49:50', '2021-02-09 15:19:42'),
(66, 'homecontent', '{\"title\":\"Make Transaction Worldwide\",\"sub_title\":\"SEND & RECEIVE MONEY JUST IN A SECOND\",\"details\":\"MULTI CURRENCY - DEVELOPER FRIENDLY - READY TO USE <br>\",\"web_footer\":\"The safest and most popular wallet for investing and storing cryptocurrencies.\"}', '2019-10-13 06:41:26', '2021-02-09 15:03:31'),
(68, 'company_policy', '{\"title\":\"Terms of Use\",\"body\":\"<p style=\\\"margin-right: 0px; margin-bottom: 15px; margin-left: 0px; font-family: &quot;Open Sans&quot;, Arial, sans-serif; padding: 0px; text-align: justify; color: rgb(0, 0, 0);\\\">It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).<\\/p><div><p style=\\\"margin-right: 0px; margin-bottom: 15px; margin-left: 0px; font-family: &quot;Open Sans&quot;, Arial, sans-serif; padding: 0px; text-align: justify; color: rgb(0, 0, 0);\\\">It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).<\\/p><\\/div><div><p style=\\\"margin-right: 0px; margin-bottom: 15px; margin-left: 0px; font-family: &quot;Open Sans&quot;, Arial, sans-serif; padding: 0px; text-align: justify; color: rgb(0, 0, 0);\\\">It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).<\\/p><\\/div><div><p style=\\\"margin-right: 0px; margin-bottom: 15px; margin-left: 0px; font-family: &quot;Open Sans&quot;, Arial, sans-serif; padding: 0px; text-align: justify; color: rgb(0, 0, 0);\\\">It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).<\\/p><\\/div><div><br><\\/div>\"}', '2019-11-05 04:05:04', '2019-11-05 05:54:04'),
(69, 'company_policy', '{\"title\":\"Legal & Licensing\",\"body\":\"<p style=\\\"margin-right: 0px; margin-bottom: 15px; margin-left: 0px; font-family: &quot;Open Sans&quot;, Arial, sans-serif; padding: 0px; text-align: justify; color: rgb(0, 0, 0);\\\">It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).<\\/p><div><p style=\\\"margin-right: 0px; margin-bottom: 15px; margin-left: 0px; font-family: &quot;Open Sans&quot;, Arial, sans-serif; padding: 0px; text-align: justify; color: rgb(0, 0, 0);\\\">It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).<\\/p><\\/div><div><p style=\\\"margin-right: 0px; margin-bottom: 15px; margin-left: 0px; font-family: &quot;Open Sans&quot;, Arial, sans-serif; padding: 0px; text-align: justify; color: rgb(0, 0, 0);\\\">It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).<\\/p><\\/div><div><p style=\\\"margin-right: 0px; margin-bottom: 15px; margin-left: 0px; font-family: &quot;Open Sans&quot;, Arial, sans-serif; padding: 0px; text-align: justify; color: rgb(0, 0, 0);\\\">It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout. The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using \'Content here, content here\', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as their default model text, and a search for \'lorem ipsum\' will uncover many web sites still in their infancy. Various versions have evolved over the years, sometimes by accident, sometimes on purpose (injected humour and the like).<\\/p><\\/div><div><br><\\/div>\"}', '2019-11-05 04:05:30', '2020-01-02 01:10:35'),
(70, 'social.item', '{\"title\":\"Youtube\",\"icon\":\"<i class=\\\"fab fa-youtube\\\"><\\/i>\",\"url\":\"#\"}', '2019-11-05 04:13:03', '2019-11-05 04:13:03'),
(71, 'social.item', '{\"title\":\"Twitter\",\"icon\":\"<i class=\\\"fab fa-twitter\\\"><\\/i>\",\"url\":\"#\"}', '2019-11-05 04:13:34', '2019-11-05 04:13:34'),
(72, 'social.item', '{\"title\":\"Linkedin\",\"icon\":\"<i class=\\\"fab fa-linkedin\\\"><\\/i>\",\"url\":\"#\"}', '2019-11-05 04:13:52', '2019-11-05 04:13:52'),
(73, 'social.item', '{\"title\":\"Instagram\",\"icon\":\"<i class=\\\"fab fa-instagram\\\"><\\/i>\",\"url\":\"#\"}', '2019-11-05 04:14:19', '2019-11-05 04:14:19'),
(77, 'whychoose', '{\"title\":\"Money Transaction\",\"sub_title\":\"The most supported payment methods and many wallet currencies, use your balance to send money or spend anywhere\",\"icon\":\"<i class=\\\"far fa-money-bill-alt\\\"><\\/i>\"}', NULL, '2021-02-09 15:06:03'),
(82, 'service.item', '{\"title\":\"movie\",\"sub_title\":\"dfdfdfdfdfdf\",\"icon\":\"fa fa-facebook\"}', '2020-01-29 06:43:37', '2020-01-29 06:43:37'),
(83, 'whychoose', '{\"title\":\"Online Shopping\",\"sub_title\":\"Xenwallet is a secure platform that makes it easy to buy, sell, and store cryptocurrency like Bitcoin, Ethereum, and more.\",\"icon\":\"<i class=\\\"fas fa-shopping-cart\\\"><\\/i>\"}', '2020-01-29 06:44:52', '2021-02-09 15:06:40'),
(84, 'whychoose', '{\"title\":\"Crypto Supported\",\"sub_title\":\"We support crypto for buying, selling, depositing, and withdrawing supported cryptocurrencies or local currencies over the world\",\"icon\":\"<i class=\\\"fab fa-btc\\\"><\\/i>\"}', '2020-01-29 06:47:56', '2021-02-09 15:54:20'),
(86, 'howitwork', '{\"title\":\"API Ready\",\"sub_title\":\"XenWallet supports different types of payment gateway APIs. So all our requests are received once requested.\",\"icon\":\"<i class=\\\"fas fa-code\\\"><\\/i>\"}', '2020-01-29 09:28:48', '2021-02-09 15:59:35'),
(87, 'howitwork', '{\"title\":\"Multiple Currency\",\"sub_title\":\"Our platform supports all types of cryptocurrency having an easy deposit and withdraw system.\",\"icon\":\"<i class=\\\"fas fa-money-bill-wave\\\"><\\/i>\"}', '2020-01-29 09:30:15', '2021-02-09 15:26:15'),
(88, 'howitwork', '{\"title\":\"Low Fees\",\"sub_title\":\"Xenwallet support very low fees and by using this service you get the best wallet system worldwide.\",\"icon\":\"<i class=\\\"fas fa-hockey-puck\\\"><\\/i>\"}', '2020-01-29 09:30:27', '2021-02-09 16:03:02'),
(89, 'howitwork', '{\"title\":\"Certified\",\"sub_title\":\"We are a certified company which conducts absolutely legal activities. We are certified and safe.\",\"icon\":\"<i class=\\\"far fa-copy\\\"><\\/i>\"}', '2020-01-29 10:36:42', '2021-02-09 16:01:29'),
(90, 'howitwork', '{\"title\":\"Secure\",\"sub_title\":\"We constantly work on improving our system and level of our security to minimize any potential risks.\",\"icon\":\"<i class=\\\"fas fa-lock\\\"><\\/i>\"}', '2020-01-29 10:37:03', '2021-02-09 15:59:08'),
(91, 'howitwork', '{\"title\":\"Global\",\"sub_title\":\"We are an international company working globally having clients from different parts of the world.\",\"icon\":\"<i class=\\\"fas fa-globe\\\"><\\/i>\"}', '2020-01-29 10:37:21', '2021-02-09 16:00:55');

-- --------------------------------------------------------

--
-- Table structure for table `gateways`
--

CREATE TABLE `gateways` (
  `id` int(10) UNSIGNED NOT NULL,
  `code` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alias` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `parameter_list` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `extra` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `supported_currencies` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `crypto` tinyint(4) DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `gateways`
--

INSERT INTO `gateways` (`id`, `code`, `name`, `alias`, `image`, `status`, `parameter_list`, `extra`, `supported_currencies`, `crypto`, `description`, `created_at`, `updated_at`) VALUES
(1, 101, 'Paypal', 'Paypal', '5e47d8b5e7c541581766837.jpg', 1, '{\"paypal_email\":{\"title\":\"PayPal Email\",\"global\":true,\"value\":\"test@gmail.com\"}}', NULL, '{\"AUD\":\"AUD\",\"BRL\":\"BRL\",\"CAD\":\"CAD\",\"CZK\":\"CZK\",\"DKK\":\"DKK\",\"EUR\":\"EUR\",\"HKD\":\"HKD\",\"HUF\":\"HUF\",\"INR\":\"INR\",\"ILS\":\"ILS\",\"JPY\":\"JPY\",\"MYR\":\"MYR\",\"MXN\":\"MXN\",\"TWD\":\"TWD\",\"NZD\":\"NZD\",\"NOK\":\"NOK\",\"PHP\":\"PHP\",\"PLN\":\"PLN\",\"GBP\":\"GBP\",\"RUB\":\"RUB\",\"SGD\":\"SGD\",\"SEK\":\"SEK\",\"CHF\":\"CHF\",\"THB\":\"THB\",\"USD\":\"$\"}', 0, 'PayPal allows customers to establish an account on its platform, which is connected to a user\'s credit card or checking account. PayPal is a fast, simple, and secure way to make a payment online.', '2019-09-14 19:14:22', '2020-04-14 12:25:19'),
(2, 102, 'Perfect Money', 'Perfect Money', '5e49134a7e6ec1581847370.jpg', 1, '{\"passphrase\":{\"title\":\"ALTERNATE PASSPHRASE\",\"global\":true,\"value\":\"U5376900\"},\"wallet_id\":{\"title\":\"PM Wallet\",\"global\":false,\"value\":\"\"}}', NULL, '{\"USD\":\"$\",\"EUR\":\"\\u20ac\"}', 0, 'Paytm is largest mobile payments and commerce platform. It started with online mobile recharge and bill payments and has an online marketplace today. To keep things at ease, you can also use Paytm Wallet.', '2019-09-14 19:14:22', '2020-02-16 04:02:50'),
(3, 103, 'Stripe', 'Stripe', '5e47d88ddd3761581766797.jpg', 1, '{\"secret_key\":{\"title\":\"Secret Key\",\"global\":true,\"value\":\"sk_test_aat3tzBCCXXBkS4sxY3M8A1B\"},\"publishable_key\":{\"title\":\"PUBLISHABLE KEY\",\"global\":true,\"value\":\"pk_test_AU3G7doZ1sbdpJLj0NaozPBu\"}}', NULL, '{\"USD\":\"USD\",\"AUD\":\"AUD\",\"BRL\":\"BRL\",\"CAD\":\"CAD\",\"CHF\":\"CHF\",\"DKK\":\"DKK\",\"EUR\":\"EUR\",\"GBP\":\"GBP\",\"HKD\":\"HKD\",\"INR\":\"INR\",\"JPY\":\"JPY\",\"MXN\":\"MXN\",\"MYR\":\"MYR\",\"NOK\":\"NOK\",\"NZD\":\"NZD\",\"PLN\":\"PLN\",\"SEK\":\"SEK\",\"SGD\":\"SGD\"}', 0, 'Stripe is a third-party payments processor built around a simple idea: make it easy for companies to do business online.', '2019-09-14 19:14:22', '2020-02-15 05:39:57'),
(4, 104, 'Skrill', 'Skrill', '5e491427ded0e1581847591.jpg', 1, '{\"pay_to_email\":{\"title\":\"Skrill Email\",\"global\":true,\"value\":\"merchant@skrill.com\"},\"secret_key\":{\"title\":\"Secret Key\",\"global\":true,\"value\":\"TheSoftKing\"}}', NULL, '{\"AED\":\"AED\",\"AUD\":\"AUD\",\"BGN\":\"BGN\",\"BHD\":\"BHD\",\"CAD\":\"CAD\",\"CHF\":\"CHF\",\"CZK\":\"CZK\",\"DKK\":\"DKK\",\"EUR\":\"EUR\",\"GBP\":\"GBP\",\"HKD\":\"HKD\",\"HRK\":\"HRK\",\"HUF\":\"HUF\",\"ILS\":\"ILS\",\"INR\":\"INR\",\"ISK\":\"ISK\",\"JOD\":\"JOD\",\"JPY\":\"JPY\",\"KRW\":\"KRW\",\"KWD\":\"KWD\",\"MAD\":\"MAD\",\"MYR\":\"MYR\",\"NOK\":\"NOK\",\"NZD\":\"NZD\",\"OMR\":\"OMR\",\"PLN\":\"PLN\",\"QAR\":\"QAR\",\"RON\":\"RON\",\"RSD\":\"RSD\",\"SAR\":\"SAR\",\"SEK\":\"SEK\",\"SGD\":\"SGD\",\"THB\":\"THB\",\"TND\":\"TND\",\"TRY\":\"TRY\",\"TWD\":\"TWD\",\"USD\":\"USD\",\"ZAR\":\"ZAR\",\"COP\":\"COP\"}', 0, 'Skrill is one of the most popular electronic payment systems in the world. In addition to rapid processing of payments and low commissions, the system’s advantages include the ability to use credit cards. Making a deposit using Skrill is possible through a form in the Personal Account.', '2019-09-14 19:14:22', '2020-02-16 04:06:31'),
(5, 105, 'PayTM', 'PayTM', '5e4a28d58d39e1581918421.jpg', 1, '{\"MID\":{\"title\":\"Merchant ID\",\"global\":true,\"value\":\"DIY12386817555501617\"},\"merchant_key\":{\"title\":\"Merchant Key\",\"global\":true,\"value\":\"bKMfNxPPf_QdZppa\"},\"WEBSITE\":{\"title\":\"Paytm Website\",\"global\":true,\"value\":\"DIYtestingweb\"},\"INDUSTRY_TYPE_ID\":{\"title\":\"Industry Type\",\"global\":true,\"value\":\"Retail\"},\"CHANNEL_ID\":{\"title\":\"CHANNEL ID\",\"global\":true,\"value\":\"WEB\"},\"transaction_url\":{\"title\":\"Transaction URL\",\"global\":true,\"value\":\"https:\\/\\/pguat.paytm.com\\/oltp-web\\/processTransaction\"},\"transaction_status_url\":{\"title\":\"Transaction STATUS URL\",\"global\":true,\"value\":\"https:\\/\\/pguat.paytm.com\\/paytmchecksum\\/paytmCallback.jsp\"}}', NULL, '{\"AUD\":\"AUD\",\"ARS\":\"ARS\",\"BDT\":\"BDT\",\"BRL\":\"BRL\",\"BGN\":\"BGN\",\"CAD\":\"CAD\",\"CLP\":\"CLP\",\"CNY\":\"CNY\",\"COP\":\"COP\",\"HRK\":\"HRK\",\"CZK\":\"CZK\",\"DKK\":\"DKK\",\"EGP\":\"EGP\",\"EUR\":\"EUR\",\"GEL\":\"GEL\",\"GHS\":\"GHS\",\"HKD\":\"HKD\",\"HUF\":\"HUF\",\"INR\":\"INR\",\"IDR\":\"IDR\",\"ILS\":\"ILS\",\"JPY\":\"JPY\",\"KES\":\"KES\",\"MYR\":\"MYR\",\"MXN\":\"MXN\",\"MAD\":\"MAD\",\"NPR\":\"NPR\",\"NZD\":\"NZD\",\"NGN\":\"NGN\",\"NOK\":\"NOK\",\"PKR\":\"PKR\",\"PEN\":\"PEN\",\"PHP\":\"PHP\",\"PLN\":\"PLN\",\"RON\":\"RON\",\"RUB\":\"RUB\",\"SGD\":\"SGD\",\"ZAR\":\"ZAR\",\"KRW\":\"KRW\",\"LKR\":\"LKR\",\"SEK\":\"SEK\",\"CHF\":\"CHF\",\"THB\":\"THB\",\"TRY\":\"TRY\",\"UGX\":\"UGX\",\"UAH\":\"UAH\",\"AED\":\"AED\",\"GBP\":\"GBP\",\"USD\":\"USD\",\"VND\":\"VND\",\"XOF\":\"XOF\"}', 0, 'Paytm is largest mobile payments and commerce platform. It started with online mobile recharge and bill payments and has an online marketplace today. To keep things at ease, you can also use Paytm Wallet.', '2019-09-14 19:14:22', '2020-02-16 23:47:01'),
(6, 106, 'Payeer', 'Payeer', '5e4a28fd4e1641581918461.jpg', 1, '{\"merchant_id\":{\"title\":\"Merchant ID\",\"global\":true,\"value\":\"866989763\"},\"secret_key\":{\"title\":\"Secret key\",\"global\":true,\"value\":\"7575\"}}', '{\"status\":{\"title\": \"Status URL\",\"value\":\"ipn.g106\"}}', '{\"USD\":\"USD\",\"EUR\":\"EUR\",\"RUB\":\"RUB\"}', 0, 'Payeer is one of the many e-wallets available for use on betting sites. As mentioned, the payment gateway allows deposits through various methods.', '2019-09-14 19:14:22', '2020-02-16 23:47:41'),
(7, 107, 'PayStack', 'PayStack', '5e4a29270fcbb1581918503.jpg', 1, '{\"public_key\":{\"title\":\"Public key\",\"global\":true,\"value\":\"pk_test_3c9c87f51b13c15d99eb367ca6ebc52cc9eb1f33\"},\"secret_key\":{\"title\":\"Secret key\",\"global\":true,\"value\":\"sk_test_2a3f97a146ab5694801f993b60fcb81cd7254f12\"}}', '{\"callback\":{\"title\": \"Callback URL\",\"value\":\"ipn.g107\"},\"webhook\":{\"title\": \"Webhook URL\",\"value\":\"ipn.g107\"}}\r\n', '{\"USD\":\"USD\",\"NGN\":\"NGN\"}', 0, 'Paystack, a widely popular payment gateway for African business, facilitates to accept secure online payments. The payment gateway allows the businesses registered in Africa to accept the payments from global customers.', '2019-09-14 19:14:22', '2020-02-16 23:48:23'),
(8, 108, 'VoguePay', 'VoguePay', '5e4a29602e9e11581918560.jpg', 1, '{\"merchant_id\":{\"title\":\"MERCHANT ID\",\"global\":true,\"value\":\"demo\"}}', NULL, '{\"USD\":\"USD\",\"GBP\":\"GBP\",\"EUR\":\"EUR\",\"GHS\":\"GHS\",\"NGN\":\"NGN\",\"ZAR\":\"ZAR\"}', 0, 'VoguePay is an online payment gateway allows site owners to receive payment for their goods and services on their website without any setup fee for both local and International payments', '2019-09-14 19:14:22', '2020-02-16 23:49:20'),
(9, 109, 'Flutterwave', 'Flutterwave', '5e4a29db736761581918683.jpg', 1, '{\"public_key\":{\"title\":\"Public Key\",\"global\":true,\"value\":\"FLWPUBK_TEST-5d9bb05bba2c13aa6c7a1ec7d7526ba2-X\"},\"secret_key\":{\"title\":\"Secret Key\",\"global\":true,\"value\":\"FLWSECK_TEST-2ac7b05b6b9fa8a423eb58241fd7bbb6-X\"},\"encryption_key\":{\"title\":\"Encryption Key\",\"global\":true,\"value\":\"FLWSECK_TEST32e13665a95a\"}}', NULL, '{\"KES\":\"KES\",\"GHS\":\"GHS\",\"NGN\":\"NGN\",\"USD\":\"USD\",\"GBP\":\"GBP\",\"EUR\":\"EUR\",\"UGX\":\"UGX\",\"TZS\":\"TZS\"}', 0, 'Its process credit card and local alternative payments, like mobile money and ACH, across Africa. They make it possible for global merchants to process payments like a local African company.', '2019-09-14 19:14:22', '2020-02-16 23:51:23'),
(10, 110, 'RazorPay', 'RazorPay', '5e4a2a68b28ca1581918824.jpg', 1, '{\"key_id\":{\"title\":\"Key Id\",\"global\":true,\"value\":\"rzp_test_kiOtejPbRZU90E\"},\"key_secret\":{\"title\":\"Key Secret \",\"global\":true,\"value\":\"osRDebzEqbsE1kbyQJ4y0re7\"}}', NULL, '{\"INR\":\"INR\"}', 0, 'Razor’s payment gateway is one of the most ambitious in its sector. Razorpay allows online businesses to accept, process and disburse digital payments through several payment modes like debit cards, credit cards, net banking, UPI and prepaid digital wallets.', '2019-09-14 19:14:22', '2020-02-16 23:53:44'),
(11, 111, 'Stripe JS', 'Stripe JS', '5e4a2bc62a4af1581919174.jpg', 1, '{\"secret_key\":{\"title\":\"Secret Key\",\"global\":true,\"value\":\"sk_test_aat3tzBCCXXBkS4sxY3M8A1B\"},\"publishable_key\":{\"title\":\"PUBLISHABLE KEY\",\"global\":true,\"value\":\"pk_test_AU3G7doZ1sbdpJLj0NaozPBu\"}}', NULL, '{\"USD\":\"USD\",\"AUD\":\"AUD\",\"BRL\":\"BRL\",\"CAD\":\"CAD\",\"CHF\":\"CHF\",\"DKK\":\"DKK\",\"EUR\":\"EUR\",\"GBP\":\"GBP\",\"HKD\":\"HKD\",\"INR\":\"INR\",\"JPY\":\"JPY\",\"MXN\":\"MXN\",\"MYR\":\"MYR\",\"NOK\":\"NOK\",\"NZD\":\"NZD\",\"PLN\":\"PLN\",\"SEK\":\"SEK\",\"SGD\":\"SGD\"}', 0, 'Stripe JS is a third-party payments processor built around a simple idea: make it easy for companies to do business online. It’s not just about processing credit cards. Stripe JS primarily targets developers with a suite of tools that make it nearly effortless to handle everything from in-app payments to marketplace transactions.', '2019-09-14 19:14:22', '2020-02-16 23:59:34'),
(12, 112, 'Instamojo', 'Instamojo', '5e4a2c5c6637c1581919324.png', 1, '{\"api_key\":{\"title\":\"API KEY\",\"global\":true,\"value\":\"test_2241633c3bc44a3de84a3b33969\"},\"auth_token\":{\"title\":\"Auth Token\",\"global\":true,\"value\":\"test_279f083f7bebefd35217feef22d\"},\"salt\":{\"title\":\"Salt\",\"global\":true,\"value\":\"19d38908eeff4f58b2ddda2c6d86ca25\"}}', NULL, '{\"INR\":\"INR\"}', 0, 'Instamojo Payment Gateway in PHP As for indian Payment Gateway. It provides many solutions like test environment and signup process also is simple.', '2019-09-14 19:14:22', '2020-02-17 00:02:04'),
(13, 501, 'Blockchain', 'Blockchain', '5e4a2c884d7311581919368.jpg', 1, '{\"api_key\":{\"title\":\"API Key\",\"global\":true,\"value\":\"8df2e5a0-3798-4b74-871d-973615b57e7b\"},\"xpub_code\":{\"title\":\"XPUB CODE\",\"global\":true,\"value\":\"xpub6CXLqfWXj1xgXe79nEQb3pv2E7TGD13pZgHceZKrQAxqXdrC2FaKuQhm5CYVGyNcHLhSdWau4eQvq3EDCyayvbKJvXa11MX9i2cHPugpt3G\"}}', NULL, '{\"BTC\":\"BTC\"}', 1, 'Blockchain has been able to give under banked groups access to money, allows people to make cross-border payments and uses smart contracts to act as a means towards faster and safer payment processing', '2019-09-14 19:14:22', '2020-02-17 00:02:48'),
(14, 502, 'Block.io', 'Block.io', '5e4a2dfef1f171581919742.jpg', 1, '{\"api_key\":{\"title\":\"API Key\",\"global\":false,\"value\":\"1658-8015-2e5e-9afb\"},\"api_pin\":{\"title\":\"API PIN\",\"global\":true,\"value\":\"zamboozamboo\"}}', '{\"cron\":{\"title\": \"Cron URL\",\"value\":\"ipn.g502\"}}', '{\"BTC\":\"BTC\",\"LTC\":\"LTC\",\"DOGE\":\"DOGE\"}', 1, 'This method provides exponentially higher security for your Wallets and applications than single-signature addresses. This way, you spend coins yourself, without trusting Block.io with your credentials.', '2019-09-14 19:14:22', '2020-02-17 00:09:03'),
(15, 503, 'CoinPayments', 'CoinPayments', '5e4a2ed97518d1581919961.jpg', 1, '{\"public_key\":{\"title\":\"Public Key\",\"global\":true,\"value\":\"7638eebaf4061b7f7cdfceb14046318bbdabf7e2f64944773d6550bd59f70274\"},\"private_key\":{\"title\":\"Private Key\",\"global\":true,\"value\":\"Cb6dee7af8Eb9E0D4123543E690dA3673294147A5Dc8e7a621B5d484a3803207\"},\"merchant_id\":{\"title\":\"Merchant ID\",\"global\":true,\"value\":\"93a1e014c4ad60a7980b4a7239673cb4\"}}', NULL, '{\"BTC\":\"Bitcoin\",\"BTC.LN\":\"Bitcoin (Lightning Network)\",\"LTC\":\"Litecoin\",\"CPS\":\"CPS Coin\",\"VLX\":\"Velas\",\"APL\":\"Apollo\",\"AYA\":\"Aryacoin\",\"BAD\":\"Badcoin\",\"BCD\":\"Bitcoin Diamond\",\"BCH\":\"Bitcoin Cash\",\"BCN\":\"Bytecoin\",\"BEAM\":\"BEAM\",\"BITB\":\"Bean Cash\",\"BLK\":\"BlackCoin\",\"BSV\":\"Bitcoin SV\",\"BTAD\":\"Bitcoin Adult\",\"BTG\":\"Bitcoin Gold\",\"BTT\":\"BitTorrent\",\"CLOAK\":\"CloakCoin\",\"CLUB\":\"ClubCoin\",\"CRW\":\"Crown\",\"CRYP\":\"CrypticCoin\",\"CRYT\":\"CryTrExCoin\",\"CURE\":\"CureCoin\",\"DASH\":\"DASH\",\"DCR\":\"Decred\",\"DEV\":\"DeviantCoin\",\"DGB\":\"DigiByte\",\"DOGE\":\"Dogecoin\",\"EBST\":\"eBoost\",\"EOS\":\"EOS\",\"ETC\":\"Ether Classic\",\"ETH\":\"Ethereum\",\"ETN\":\"Electroneum\",\"EUNO\":\"EUNO\",\"EXP\":\"EXP\",\"Expanse\":\"Expanse\",\"FLASH\":\"FLASH\",\"GAME\":\"GameCredits\",\"GLC\":\"Goldcoin\",\"GRS\":\"Groestlcoin\",\"KMD\":\"Komodo\",\"LOKI\":\"LOKI\",\"LSK\":\"LSK\",\"MAID\":\"MaidSafeCoin\",\"MUE\":\"MonetaryUnit\",\"NAV\":\"NAV Coin\",\"NEO\":\"NEO\",\"NMC\":\"Namecoin\",\"NVST\":\"NVO Token\",\"NXT\":\"NXT\",\"OMNI\":\"OMNI\",\"PINK\":\"PinkCoin\",\"PIVX\":\"PIVX\",\"POT\":\"PotCoin\",\"PPC\":\"Peercoin\",\"PROC\":\"ProCurrency\",\"PURA\":\"PURA\",\"QTUM\":\"QTUM\",\"RES\":\"Resistance\",\"RVN\":\"Ravencoin\",\"RVR\":\"RevolutionVR\",\"SBD\":\"Steem Dollars\",\"SMART\":\"SmartCash\",\"SOXAX\":\"SOXAX\",\"STEEM\":\"STEEM\",\"STRAT\":\"STRAT\",\"SYS\":\"Syscoin\",\"TPAY\":\"TokenPay\",\"TRIGGERS\":\"Triggers\",\"TRX\":\" TRON\",\"UBQ\":\"Ubiq\",\"UNIT\":\"UniversalCurrency\",\"USDT\":\"Tether USD (Omni Layer)\",\"VTC\":\"Vertcoin\",\"WAVES\":\"Waves\",\"XCP\":\"Counterparty\",\"XEM\":\"NEM\",\"XMR\":\"Monero\",\"XSN\":\"Stakenet\",\"XSR\":\"SucreCoin\",\"XVG\":\"VERGE\",\"XZC\":\"ZCoin\",\"ZEC\":\"ZCash\",\"ZEN\":\"Horizen\"}', 1, 'CoinPayments is a cloud wallet solution that offers an easy way to integrate a checkout system for numerous cryptocurrencies. Its website offers payment solutions for multiple crypto-currencies such as bitcoin and litecoin.', '2019-09-14 19:14:22', '2020-02-17 00:12:41'),
(16, 504, 'CoinPayments Fiat', 'CoinPayments Fiat', '5e4a2f2d526ff1581920045.jpg', 1, '{\"merchant_id\":{\"title\":\"Merchant ID\",\"global\":true,\"value\":\"93a1e014c4ad60a7980b4a7239673cb4\"}}', NULL, '{\"USD\":\"USD\",\"AUD\":\"AUD\",\"BRL\":\"BRL\",\"CAD\":\"CAD\",\"CHF\":\"CHF\",\"CLP\":\"CLP\",\"CNY\":\"CNY\",\"DKK\":\"DKK\",\"EUR\":\"EUR\",\"GBP\":\"GBP\",\"HKD\":\"HKD\",\"INR\":\"INR\",\"ISK\":\"ISK\",\"JPY\":\"JPY\",\"KRW\":\"KRW\",\"NZD\":\"NZD\",\"PLN\":\"PLN\",\"RUB\":\"RUB\",\"SEK\":\"SEK\",\"SGD\":\"SGD\",\"THB\":\"THB\",\"TWD\":\"TWD\"}', 0, 'This is the same gateway as CoinPayments but we used fiat currency as calculation currency.', '2019-09-14 19:14:22', '2020-02-17 00:14:05'),
(17, 505, 'Coingate', 'Coingate', '5e4a2f592b8c71581920089.jpg', 1, '{\"api_key\":{\"title\":\"API Key\",\"global\":true,\"value\":\"Ba1VgPx6d437xLXGKCBkmwVCEw5kHzRJ6thbGo-N\"}}', NULL, '{\"USD\":\"USD\",\"EUR\":\"EUR\"}', 0, 'CoinGate Bitcoin Payment Processor is an online cryptocurrency platform that provides merchant services to businesses and individuals', '2019-09-14 19:14:22', '2020-02-17 00:14:49'),
(18, 506, 'Coinbase Commerce', 'Coinbase commerce', '5e4a2fc0cdbdc1581920192.jpg', 1, '{\"api_key\":{\"title\":\"API Key\",\"global\":true,\"value\":\"c47cd7df-d8e8-424b-a20a-\"},\"secret\":{\"title\":\"Webhook Shared Secret\",\"global\":true,\"value\":\"55871878-2c32-4f64-ab66-\"}}', '{\"endpoint\":{\"title\": \"Webhook Endpoint\",\"value\":\"ipn.g506\"}}', '{\"USD\":\"USD\",\"EUR\":\"EUR\",\"JPY\":\"JPY\",\"GBP\":\"GBP\",\"AUD\":\"AUD\",\"CAD\":\"CAD\",\"CHF\":\"CHF\",\"CNY\":\"CNY\",\"SEK\":\"SEK\",\"NZD\":\"NZD\",\"MXN\":\"MXN\",\"SGD\":\"SGD\",\"HKD\":\"HKD\",\"NOK\":\"NOK\",\"KRW\":\"KRW\",\"TRY\":\"TRY\",\"RUB\":\"RUB\",\"INR\":\"INR\",\"BRL\":\"BRL\",\"ZAR\":\"ZAR\",\"AED\":\"AED\",\"AFN\":\"AFN\",\"ALL\":\"ALL\",\"AMD\":\"AMD\",\"ANG\":\"ANG\",\"AOA\":\"AOA\",\"ARS\":\"ARS\",\"AWG\":\"AWG\",\"AZN\":\"AZN\",\"BAM\":\"BAM\",\"BBD\":\"BBD\",\"BDT\":\"BDT\",\"BGN\":\"BGN\",\"BHD\":\"BHD\",\"BIF\":\"BIF\",\"BMD\":\"BMD\",\"BND\":\"BND\",\"BOB\":\"BOB\",\"BSD\":\"BSD\",\"BTN\":\"BTN\",\"BWP\":\"BWP\",\"BYN\":\"BYN\",\"BZD\":\"BZD\",\"CDF\":\"CDF\",\"CLF\":\"CLF\",\"CLP\":\"CLP\",\"COP\":\"COP\",\"CRC\":\"CRC\",\"CUC\":\"CUC\",\"CUP\":\"CUP\",\"CVE\":\"CVE\",\"CZK\":\"CZK\",\"DJF\":\"DJF\",\"DKK\":\"DKK\",\"DOP\":\"DOP\",\"DZD\":\"DZD\",\"EGP\":\"EGP\",\"ERN\":\"ERN\",\"ETB\":\"ETB\",\"FJD\":\"FJD\",\"FKP\":\"FKP\",\"GEL\":\"GEL\",\"GGP\":\"GGP\",\"GHS\":\"GHS\",\"GIP\":\"GIP\",\"GMD\":\"GMD\",\"GNF\":\"GNF\",\"GTQ\":\"GTQ\",\"GYD\":\"GYD\",\"HNL\":\"HNL\",\"HRK\":\"HRK\",\"HTG\":\"HTG\",\"HUF\":\"HUF\",\"IDR\":\"IDR\",\"ILS\":\"ILS\",\"IMP\":\"IMP\",\"IQD\":\"IQD\",\"IRR\":\"IRR\",\"ISK\":\"ISK\",\"JEP\":\"JEP\",\"JMD\":\"JMD\",\"JOD\":\"JOD\",\"KES\":\"KES\",\"KGS\":\"KGS\",\"KHR\":\"KHR\",\"KMF\":\"KMF\",\"KPW\":\"KPW\",\"KWD\":\"KWD\",\"KYD\":\"KYD\",\"KZT\":\"KZT\",\"LAK\":\"LAK\",\"LBP\":\"LBP\",\"LKR\":\"LKR\",\"LRD\":\"LRD\",\"LSL\":\"LSL\",\"LYD\":\"LYD\",\"MAD\":\"MAD\",\"MDL\":\"MDL\",\"MGA\":\"MGA\",\"MKD\":\"MKD\",\"MMK\":\"MMK\",\"MNT\":\"MNT\",\"MOP\":\"MOP\",\"MRO\":\"MRO\",\"MUR\":\"MUR\",\"MVR\":\"MVR\",\"MWK\":\"MWK\",\"MYR\":\"MYR\",\"MZN\":\"MZN\",\"NAD\":\"NAD\",\"NGN\":\"NGN\",\"NIO\":\"NIO\",\"NPR\":\"NPR\",\"OMR\":\"OMR\",\"PAB\":\"PAB\",\"PEN\":\"PEN\",\"PGK\":\"PGK\",\"PHP\":\"PHP\",\"PKR\":\"PKR\",\"PLN\":\"PLN\",\"PYG\":\"PYG\",\"QAR\":\"QAR\",\"RON\":\"RON\",\"RSD\":\"RSD\",\"RWF\":\"RWF\",\"SAR\":\"SAR\",\"SBD\":\"SBD\",\"SCR\":\"SCR\",\"SDG\":\"SDG\",\"SHP\":\"SHP\",\"SLL\":\"SLL\",\"SOS\":\"SOS\",\"SRD\":\"SRD\",\"SSP\":\"SSP\",\"STD\":\"STD\",\"SVC\":\"SVC\",\"SYP\":\"SYP\",\"SZL\":\"SZL\",\"THB\":\"THB\",\"TJS\":\"TJS\",\"TMT\":\"TMT\",\"TND\":\"TND\",\"TOP\":\"TOP\",\"TTD\":\"TTD\",\"TWD\":\"TWD\",\"TZS\":\"TZS\",\"UAH\":\"UAH\",\"UGX\":\"UGX\",\"UYU\":\"UYU\",\"UZS\":\"UZS\",\"VEF\":\"VEF\",\"VND\":\"VND\",\"VUV\":\"VUV\",\"WST\":\"WST\",\"XAF\":\"XAF\",\"XAG\":\"XAG\",\"XAU\":\"XAU\",\"XCD\":\"XCD\",\"XDR\":\"XDR\",\"XOF\":\"XOF\",\"XPD\":\"XPD\",\"XPF\":\"XPF\",\"XPT\":\"XPT\",\"YER\":\"YER\",\"ZMW\":\"ZMW\",\"ZWL\":\"ZWL\"}\r\n\r\n', 0, 'Coinbase Commerce allows merchants to accept cryptocurrency payments in Bitcoin, Bitcoin Cash, Ethereum and Litecoin.', '2019-09-14 19:14:22', '2020-02-17 00:16:32');

-- --------------------------------------------------------

--
-- Table structure for table `gateway_currencies`
--

CREATE TABLE `gateway_currencies` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `symbol` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `method_code` int(10) UNSIGNED NOT NULL,
  `min_amount` decimal(18,8) NOT NULL,
  `max_amount` decimal(18,8) NOT NULL,
  `percent_charge` decimal(8,4) NOT NULL DEFAULT 0.0000,
  `fixed_charge` decimal(18,8) NOT NULL DEFAULT 0.00000000,
  `rate` decimal(18,8) NOT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gateway_parameter` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `general_settings`
--

CREATE TABLE `general_settings` (
  `id` int(10) UNSIGNED NOT NULL,
  `sitename` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cur_text` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'currency text',
  `cur_sym` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'currency symbol',
  `efrom` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'email sent from',
  `etemp` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'email template',
  `smsapi` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'sms api',
  `bclr` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Base Color',
  `sclr` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Secondary Color',
  `ev` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'email verification, 0 - dont check, 1 - check',
  `en` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'email notification, 0 - dont send, 1 - send',
  `mail_config` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'email configuration',
  `sv` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'sms verication, 0 - dont check, 1 - check',
  `sn` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'sms notification, 0 - dont send, 1 - send',
  `social_login` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'social login',
  `reg` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'allow registration',
  `alert` tinyint(4) NOT NULL DEFAULT 1 COMMENT '0 => none, 1 => iziToast, 2 => toaster',
  `active_template` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'active template folder name',
  `currency_api_key` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `money_transfer` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `money_exchange` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `request_money` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `invoice` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `voucher` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `api_charge` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mt_status` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'Money Transfer 0=> off, 1=> On',
  `exm_status` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'Money Exchange 0=> off, 1=> On',
  `rqm_status` tinyint(1) NOT NULL DEFAULT 0,
  `invoice_status` tinyint(1) NOT NULL DEFAULT 0,
  `voucher_status` tinyint(1) NOT NULL DEFAULT 0,
  `withdraw_status` tinyint(4) NOT NULL DEFAULT 0 COMMENT 'Withdraw 0=> off, 1=> On',
  `language_status` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `general_settings`
--

INSERT INTO `general_settings` (`id`, `sitename`, `email`, `cur_text`, `cur_sym`, `efrom`, `etemp`, `smsapi`, `bclr`, `sclr`, `ev`, `en`, `mail_config`, `sv`, `sn`, `social_login`, `reg`, `alert`, `active_template`, `currency_api_key`, `money_transfer`, `money_exchange`, `request_money`, `invoice`, `voucher`, `api_charge`, `mt_status`, `exm_status`, `rqm_status`, `invoice_status`, `voucher_status`, `withdraw_status`, `language_status`, `created_at`, `updated_at`) VALUES
(1, 'XenWallet', 'do-not-reply@thesoftking.com', 'USD', '$', 'noreply-tsk@thesoftking.com', '<br style=\"font-family: Lato, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, &quot;Helvetica Neue&quot;, Arial, sans-serif;\"><br style=\"font-family: Lato, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, &quot;Helvetica Neue&quot;, Arial, sans-serif;\"><div class=\"contents\" style=\"font-family: Lato, -apple-system, BlinkMacSystemFont, &quot;Segoe UI&quot;, Roboto, &quot;Helvetica Neue&quot;, Arial, sans-serif; max-width: 600px; margin: 0px auto; border: 2px solid rgb(0, 0, 54);\"><div class=\"header\" style=\"background-color: rgb(0, 0, 54); padding: 15px; text-align: center;\"><div class=\"logo\" style=\"width: 260px; margin: 0px auto;\"><img src=\"https://i.imgur.com/4NN55uD.png\" alt=\"THESOFTKING\" style=\"width: 260px;\">&nbsp;</div></div><div class=\"mailtext\" style=\"padding: 30px 15px; background-color: rgb(240, 248, 255); font-family: &quot;Open Sans&quot;, sans-serif; font-size: 16px; line-height: 26px;\">Hi {{name}},&nbsp;<br><br>{{message}}&nbsp;<br><br><br></div><div class=\"footer\" style=\"background-color: rgb(0, 0, 54); padding: 15px; text-align: center;\"><a href=\"https://thesoftking.com/\" style=\"color: rgb(255, 255, 255); background-color: rgb(46, 204, 113); padding: 10px 0px; margin: 10px; display: inline-block; width: 100px; text-transform: uppercase; font-weight: 600; border-radius: 4px;\">WEBSITE</a>&nbsp;<a href=\"https://thesoftking.com/products\" style=\"color: rgb(255, 255, 255); background-color: rgb(46, 204, 113); padding: 10px 0px; margin: 10px; display: inline-block; width: 100px; text-transform: uppercase; font-weight: 600; border-radius: 4px;\">PRODUCTS</a>&nbsp;<a href=\"https://thesoftking.com/contact\" style=\"color: rgb(255, 255, 255); background-color: rgb(46, 204, 113); padding: 10px 0px; margin: 10px; display: inline-block; width: 100px; text-transform: uppercase; font-weight: 600; border-radius: 4px;\">CONTACT</a></div><div class=\"footer\" style=\"background-color: rgb(0, 0, 54); padding: 15px; text-align: center; border-top: 1px solid rgba(255, 255, 255, 0.2);\"><span style=\"font-weight: bolder; color: rgb(255, 255, 255);\">© 2011 - 2020 THESOFTKING. All Rights Reserved.</span><p style=\"color: rgb(221, 221, 221);\">TheSoftKing is not partnered with any other company or person. We work as a team and do not have any reseller, distributor or partner!</p><div><br></div></div></div><table class=\"layout layout--no-gutter\" style=\"border-spacing: 0px; color: rgb(52, 73, 94); table-layout: fixed; margin-left: auto; margin-right: auto; overflow-wrap: break-word; word-break: break-word;\" align=\"center\"><tbody><tr></tr></tbody></table>', 'https://api.infobip.com/api/v3/sendsms/plain?user=*****&password=*****&sender=JustWallet&SMSText={{message}}&GSM={{number}}&type=longSMS', 'fd6500', '00ff36', 0, 1, '{\"name\":\"php\"}', 0, 0, 1, 1, 1, 'basic', 'fb7dd89a83be5e8ecb650c343edecd09', '{\"percent_charge\":0.05,\"fix_charge\":0.2,\"minimum_transfer\":0,\"maximum_transfer\":100000}', '{\"percent_charge\":0.01}', '{\"percent_charge\":0.02,\"fix_charge\":0.4,\"minimum_transfer\":1,\"maximum_transfer\":1000}', '{\"percent_charge\":0.09,\"fix_charge\":3}', '{\"new_voucher\":{\"percent_charge\":0.03,\"fix_charge\":0.1,\"minimum_amount\":1},\"active_voucher\":{\"percent_charge\":0.01,\"fix_charge\":1}}', '{\"percent_charge\":0.01,\"fix_charge\":0.25}', 1, 1, 0, 0, 0, 1, 1, '2019-09-25 05:04:05', '2020-04-14 12:10:21');

-- --------------------------------------------------------

--
-- Table structure for table `invoices`
--

CREATE TABLE `invoices` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `paidby_id` int(11) DEFAULT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `amount` decimal(18,2) NOT NULL DEFAULT 0.00,
  `charge` decimal(11,2) DEFAULT 0.00,
  `will_get` decimal(18,8) NOT NULL DEFAULT 0.00000000,
  `trx` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `details` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `published` tinyint(4) NOT NULL DEFAULT 0,
  `status` int(4) NOT NULL DEFAULT 0 COMMENT '0 => unpaid, 1=> Paid, -1 = cacnel',
  `gateway` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` date DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE `languages` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `icon` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `text_align` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0: left to right text align, 1: right to left text align',
  `is_default` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0: not default language, 1: default language',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `languages`
--

INSERT INTO `languages` (`id`, `name`, `code`, `icon`, `text_align`, `is_default`, `created_at`, `updated_at`) VALUES
(1, 'English', 'en', '5e4d0b21539391582107425.png', 0, 1, '2020-02-19 04:17:05', '2020-02-19 04:43:15');

-- --------------------------------------------------------

--
-- Table structure for table `money_transfers`
--

CREATE TABLE `money_transfers` (
  `id` int(10) UNSIGNED NOT NULL,
  `sender_id` int(11) DEFAULT NULL,
  `receiver_id` int(11) DEFAULT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `amount` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `charge` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code_protect` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `protection` varchar(20) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `note` longtext COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '1=> complted, 2=> hang on, -2 => Refund',
  `trx` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `id` int(10) UNSIGNED NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `plugins`
--

CREATE TABLE `plugins` (
  `id` int(10) UNSIGNED NOT NULL,
  `act` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `script` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `shortcode` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'object',
  `support` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `plugins`
--

INSERT INTO `plugins` (`id`, `act`, `name`, `description`, `image`, `script`, `shortcode`, `support`, `status`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'google-analytics', 'Google Analytics', 'Key location is shown bellow', 'google-analytics.png', '<script async src=\"https://www.googletagmanager.com/gtag/js?id={{app_key}}\"></script>\n                <script>\n                  window.dataLayer = window.dataLayer || [];\n                  function gtag(){dataLayer.push(arguments);}\n                  gtag(\"js\", new Date());\n                \n                  gtag(\"config\", \"{{app_key}}\");\n                </script>', '{\"app_key\":{\"title\":\"App Key\",\"value\":\"Demos\"}}', 'ganalytics.png', 1, NULL, '2019-09-25 05:04:05', '2019-11-07 00:26:52'),
(2, 'tawk-chat', 'Tawk Chat', 'Key location is shown bellow', 'tawky_big.png', '<script>\r\n                        var Tawk_API=Tawk_API||{}, Tawk_LoadStart=new Date();\r\n                        (function(){\r\n                        var s1=document.createElement(\"script\"),s0=document.getElementsByTagName(\"script\")[0];\r\n                        s1.async=true;\r\n                        s1.src=\"https://embed.tawk.to/{{app_key}}\";\r\n                        s1.charset=\"UTF-8\";\r\n                        s1.setAttribute(\"crossorigin\",\"*\");\r\n                        s0.parentNode.insertBefore(s1,s0);\r\n                        })();\r\n                    </script>', '{\"app_key\":{\"title\":\"App Key\",\"value\":\"5c025998fd65052a5c934ef7\\/default\"}}', 'twak.png', 1, NULL, '2019-09-25 05:04:05', '2021-02-08 00:36:10'),
(3, 'google-recaptcha3', 'Google Recaptch 3', 'Key location is shown bellow', 'recaptcha3.png', '<script type=\"text/javascript\">\n\n                            var onloadCallback = function() {\n                                grecaptcha.render(\"recaptcha\", {\n                                    \"sitekey\" : \"{{sitekey}}\",\n                                    \"callback\": function(token) {\n                                        $(\"#recaptcha\").parents(\"form:first\").submit();\n                                    } \n                                });\n                            };\n                        </script>\n                        <script src=\"https://www.google.com/recaptcha/api.js?onload=onloadCallback&render=explicit\" async defer></script>', '{\"sitekey\":{\"title\":\"Site Key\",\"value\":\"6Ldy8bUUAAAAALn0JWsmdKYvOBuL18qExf1PczsJ\"},\"secretkey\":{\"title\":\"Secret Key\",\"value\":\"6Ldy8bUUAAAAAHhCcckF_qpCbUX8ejBuGKa576oO\"}}', 'recaptcha.png', 0, NULL, '2019-09-25 05:04:05', '2019-10-03 01:03:28'),
(4, 'Facebook Comment', 'Facebook Comment', 'Easy on human, hard on bots.', 'chat.png', '\r\n<div id=\"fb-root\"></div>\r\n<script>\r\n    (function(d, s, id) {\r\n        var js, fjs = d.getElementsByTagName(s)[0];\r\n        if (d.getElementById(id)) return;\r\n        js = d.createElement(s); js.id = id;\r\n        js.src = \'https://connect.facebook.net/en_US/sdk.js#xfbml=1&version=v2.12&appId={{app_id}}&autoLogAppEvents=1\';\r\n        fjs.parentNode.insertBefore(js, fjs);\r\n    }(document, \'script\', \'facebook-jssdk\'));\r\n</script>', '{\"app_id\":{\"title\":\"APP ID\",\"value\":\"205856110142667\"}}', 'facebook-comment-embed-code.jpg', 0, NULL, NULL, '2019-11-07 00:15:16'),
(5, 'Google Map', 'Google Map', 'Easy on human, hard on bots.', 'map.png', ' <script src=\"http://maps.google.com/maps/api/js?key={{api_key}}\"></script>', '{\"app_key\":{\"title\":\"API Key\",\"value\":\"AIzaSyCo_pcAdFNbTDCAvMwAD19oRTuEmb9M50c\"},\"latitude\":{\"title\":\"Latitude\",\"value\":\"23.7500276\"},\"longitude\":{\"title\":\"Longitude\",\"value\":\"90.386923\"}}', NULL, 1, '2019-11-06 18:00:00', NULL, NULL);

-- --------------------------------------------------------

--
-- Table structure for table `request_moneys`
--

CREATE TABLE `request_moneys` (
  `id` int(10) UNSIGNED NOT NULL,
  `trx` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sender_id` int(11) DEFAULT NULL,
  `receiver_id` int(11) DEFAULT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `amount` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `charge` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` int(11) NOT NULL DEFAULT 0 COMMENT '0 => pending, 1 => paid, -1 => unpaid',
  `info` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sandboxes`
--

CREATE TABLE `sandboxes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `trx` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `amount` decimal(11,8) NOT NULL DEFAULT 0.00000000,
  `charge` decimal(11,8) NOT NULL DEFAULT 0.00000000,
  `wallet_amount` decimal(11,8) NOT NULL DEFAULT 0.00000000,
  `status` tinyint(4) NOT NULL DEFAULT 0,
  `all_data` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'amount, currency, public_key, custom, details, ipn_url, success_url, cancel_url',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `subscribers`
--

CREATE TABLE `subscribers` (
  `id` int(10) UNSIGNED NOT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `support_attachments`
--

CREATE TABLE `support_attachments` (
  `id` int(10) UNSIGNED NOT NULL,
  `support_message_id` int(11) NOT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `support_messages`
--

CREATE TABLE `support_messages` (
  `id` int(10) UNSIGNED NOT NULL,
  `supportticket_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `support_type` tinyint(4) NOT NULL,
  `message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `support_tickets`
--

CREATE TABLE `support_tickets` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ticket` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subject` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0=> open, 1=> answer, 2=> replied, 3=> closed',
  `department` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `priority` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `trxes`
--

CREATE TABLE `trxes` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `amount` decimal(11,2) DEFAULT 0.00,
  `main_amo` decimal(11,2) DEFAULT 0.00,
  `charge` decimal(11,2) DEFAULT 0.00,
  `trx_type` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT '+',
  `currency_id` int(11) DEFAULT NULL,
  `title` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remark` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trx` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` int(10) UNSIGNED NOT NULL,
  `firstname` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lastname` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `company_name` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mobile` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `balance` decimal(11,2) NOT NULL DEFAULT 0.00,
  `password` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'contains full address',
  `status` tinyint(4) NOT NULL DEFAULT 1 COMMENT '0: banned, 1: active',
  `ev` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0: email unverified, 1: email verified',
  `sv` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0: sms unverified, 1: sms verified',
  `ver_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'stores verification code',
  `ver_code_send_at` datetime DEFAULT NULL COMMENT 'verification send time',
  `ts` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0: 2fa off, 1: 2fa on',
  `tv` tinyint(4) NOT NULL DEFAULT 1 COMMENT '0: 2fa unverified, 1: 2fa verified',
  `tsc` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'secretcode',
  `merchant` tinyint(4) DEFAULT 0,
  `remember_token` varchar(100) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_api_keys`
--

CREATE TABLE `user_api_keys` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `public_key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `secret_key` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_logins`
--

CREATE TABLE `user_logins` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `user_ip` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `location` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `browser` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `os` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `longitude` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lat` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country_code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vouchers`
--

CREATE TABLE `vouchers` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `amount` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `charge` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `code` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency_id` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '0 => activated, 1=> expired',
  `use_id` int(11) DEFAULT NULL,
  `useable_amount` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `use_charge` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wallets`
--

CREATE TABLE `wallets` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(11) DEFAULT NULL,
  `wallet_id` int(11) DEFAULT NULL,
  `amount` varchar(191) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0,
  `deleted_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `withdrawals`
--

CREATE TABLE `withdrawals` (
  `id` int(10) UNSIGNED NOT NULL,
  `method_id` int(10) UNSIGNED NOT NULL COMMENT 'wallet method id',
  `user_id` int(10) UNSIGNED NOT NULL,
  `wallet_id` int(11) DEFAULT NULL COMMENT 'User Wallet ID',
  `currency_id` int(11) DEFAULT NULL COMMENT 'Currency ID',
  `trx` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(18,8) NOT NULL,
  `currency` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `method_rate` decimal(11,8) NOT NULL DEFAULT 0.00000000,
  `currency_rate` decimal(11,8) DEFAULT 0.00000000,
  `charge` decimal(18,8) NOT NULL,
  `wallet_charge` decimal(11,8) NOT NULL DEFAULT 0.00000000,
  `final_amount` decimal(18,8) NOT NULL DEFAULT 0.00000000,
  `delay` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `detail` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0 COMMENT '-1 = Default, 0 => pending, 1 => approved , 2 => reject',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `withdraw_methods`
--

CREATE TABLE `withdraw_methods` (
  `id` int(10) UNSIGNED NOT NULL,
  `name` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `min_limit` decimal(18,8) NOT NULL,
  `max_limit` decimal(18,8) NOT NULL DEFAULT 0.00000000,
  `delay` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fixed_charge` decimal(18,8) NOT NULL,
  `rate` decimal(18,8) NOT NULL,
  `percent_charge` decimal(5,2) NOT NULL,
  `currency` varchar(191) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_data` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '-1 = Default, 0 => pending, 1 => approved , 2 => reject',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Indexes for dumped tables
--

--
-- Indexes for table `admins`
--
ALTER TABLE `admins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `admins_email_unique` (`email`),
  ADD UNIQUE KEY `admins_username_unique` (`username`);

--
-- Indexes for table `admin_password_resets`
--
ALTER TABLE `admin_password_resets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `contact_topics`
--
ALTER TABLE `contact_topics`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `currencies`
--
ALTER TABLE `currencies`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `deposits`
--
ALTER TABLE `deposits`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `email_sms_templates`
--
ALTER TABLE `email_sms_templates`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email_sms_templates_act_unique` (`act`);

--
-- Indexes for table `exchange_money`
--
ALTER TABLE `exchange_money`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `express_payments`
--
ALTER TABLE `express_payments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `frontends`
--
ALTER TABLE `frontends`
  ADD PRIMARY KEY (`id`),
  ADD KEY `frontends_key_index` (`data_keys`);

--
-- Indexes for table `gateways`
--
ALTER TABLE `gateways`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `gateways_code_unique` (`code`);

--
-- Indexes for table `gateway_currencies`
--
ALTER TABLE `gateway_currencies`
  ADD PRIMARY KEY (`id`),
  ADD KEY `gateway_currencies_method_code_index` (`method_code`);

--
-- Indexes for table `general_settings`
--
ALTER TABLE `general_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `invoices`
--
ALTER TABLE `invoices`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `money_transfers`
--
ALTER TABLE `money_transfers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `password_resets`
--
ALTER TABLE `password_resets`
  ADD PRIMARY KEY (`id`),
  ADD KEY `password_resets_email_index` (`email`);

--
-- Indexes for table `plugins`
--
ALTER TABLE `plugins`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `plugins_act_unique` (`act`);

--
-- Indexes for table `request_moneys`
--
ALTER TABLE `request_moneys`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `sandboxes`
--
ALTER TABLE `sandboxes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `subscribers`
--
ALTER TABLE `subscribers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `support_attachments`
--
ALTER TABLE `support_attachments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `support_messages`
--
ALTER TABLE `support_messages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `support_tickets`
--
ALTER TABLE `support_tickets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `trxes`
--
ALTER TABLE `trxes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `users_username_unique` (`username`),
  ADD UNIQUE KEY `users_email_unique` (`email`);

--
-- Indexes for table `user_api_keys`
--
ALTER TABLE `user_api_keys`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_logins`
--
ALTER TABLE `user_logins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `vouchers`
--
ALTER TABLE `vouchers`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `wallets`
--
ALTER TABLE `wallets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `withdrawals`
--
ALTER TABLE `withdrawals`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `withdrawals_trx_unique` (`trx`);

--
-- Indexes for table `withdraw_methods`
--
ALTER TABLE `withdraw_methods`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `admins`
--
ALTER TABLE `admins`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `admin_password_resets`
--
ALTER TABLE `admin_password_resets`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `contact_topics`
--
ALTER TABLE `contact_topics`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `currencies`
--
ALTER TABLE `currencies`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `deposits`
--
ALTER TABLE `deposits`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `email_sms_templates`
--
ALTER TABLE `email_sms_templates`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=34;

--
-- AUTO_INCREMENT for table `exchange_money`
--
ALTER TABLE `exchange_money`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `express_payments`
--
ALTER TABLE `express_payments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `frontends`
--
ALTER TABLE `frontends`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=92;

--
-- AUTO_INCREMENT for table `gateways`
--
ALTER TABLE `gateways`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `gateway_currencies`
--
ALTER TABLE `gateway_currencies`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `general_settings`
--
ALTER TABLE `general_settings`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `invoices`
--
ALTER TABLE `invoices`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `languages`
--
ALTER TABLE `languages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `money_transfers`
--
ALTER TABLE `money_transfers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `password_resets`
--
ALTER TABLE `password_resets`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `plugins`
--
ALTER TABLE `plugins`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=6;

--
-- AUTO_INCREMENT for table `request_moneys`
--
ALTER TABLE `request_moneys`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sandboxes`
--
ALTER TABLE `sandboxes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `subscribers`
--
ALTER TABLE `subscribers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `support_attachments`
--
ALTER TABLE `support_attachments`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `support_messages`
--
ALTER TABLE `support_messages`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `support_tickets`
--
ALTER TABLE `support_tickets`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `trxes`
--
ALTER TABLE `trxes`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_api_keys`
--
ALTER TABLE `user_api_keys`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_logins`
--
ALTER TABLE `user_logins`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vouchers`
--
ALTER TABLE `vouchers`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `wallets`
--
ALTER TABLE `wallets`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `withdrawals`
--
ALTER TABLE `withdrawals`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `withdraw_methods`
--
ALTER TABLE `withdraw_methods`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
