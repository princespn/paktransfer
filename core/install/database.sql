-- phpMyAdmin SQL Dump
-- version 5.0.4
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Generation Time: Dec 01, 2021 at 12:18 PM
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
-- Database: `xcash_1_5`
--

-- --------------------------------------------------------

--
-- Table structure for table `admins`
--

CREATE TABLE `admins` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `username` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_verified_at` timestamp NULL DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `admins`
--

INSERT INTO `admins` (`id`, `name`, `email`, `username`, `email_verified_at`, `image`, `password`, `created_at`, `updated_at`) VALUES
(1, 'Super Admin', 'admin@site.com', 'admin', NULL, '5ff1c3531ed3f1609679699.jpg', '$2y$10$2qcOUKrDIUqyyCklvHp7IO8fGNcJ1gAXtxouTn1isZPHu6H8CfHPq', NULL, '2021-05-07 07:54:06');

-- --------------------------------------------------------

--
-- Table structure for table `admin_notifications`
--

CREATE TABLE `admin_notifications` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `user_type` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `read_status` tinyint(1) NOT NULL DEFAULT 0,
  `click_url` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `admin_password_resets`
--

CREATE TABLE `admin_password_resets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `agents`
--

CREATE TABLE `agents` (
  `id` int(11) UNSIGNED NOT NULL,
  `firstname` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastname` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `username` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `country_code` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ref_by` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `balance` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'contains full address',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '0: banned, 1: active',
  `kyc_status` tinyint(1) NOT NULL DEFAULT 0,
  `kyc_info` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `kyc_reject_reasons` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ev` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0: email unverified, 1: email verified',
  `sv` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0: sms unverified, 1: sms verified',
  `ver_code` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'stores verification code',
  `ver_code_send_at` datetime DEFAULT NULL COMMENT 'verification send time',
  `ts` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0: 2fa off, 1: 2fa on',
  `tv` tinyint(1) NOT NULL DEFAULT 1 COMMENT '0: 2fa unverified, 1: 2fa verified',
  `tsc` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `agent_password_resets`
--

CREATE TABLE `agent_password_resets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int(1) UNSIGNED NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `api_payments`
--

CREATE TABLE `api_payments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `ip` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trx` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `merchant_id` int(11) NOT NULL,
  `payer_id` int(11) DEFAULT NULL,
  `identifier` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `currency_id` int(11) NOT NULL,
  `amount` decimal(28,8) NOT NULL,
  `details` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ipn_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `cancel_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `success_url` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `site_logo` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `checkout_theme` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `customer_name` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `customer_email` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `ver_code` int(11) DEFAULT NULL,
  `ver_code_at` datetime DEFAULT NULL,
  `status` tinyint(4) NOT NULL DEFAULT 0,
  `type` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `charge_logs`
--

CREATE TABLE `charge_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `user_type` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(28,8) NOT NULL,
  `currency_id` int(11) NOT NULL,
  `trx` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remark` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `operation_type` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `currencies`
--

CREATE TABLE `currencies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `currency_code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `currency_symbol` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `currency_fullname` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `currency_type` tinyint(1) UNSIGNED NOT NULL COMMENT '1 => fiat, 2 => crypto',
  `rate` decimal(28,8) DEFAULT NULL,
  `is_default` tinyint(1) UNSIGNED NOT NULL DEFAULT 0,
  `status` tinyint(1) UNSIGNED NOT NULL COMMENT '1 => active, 0 => inactive',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `currencies`
--

INSERT INTO `currencies` (`id`, `currency_code`, `currency_symbol`, `currency_fullname`, `currency_type`, `rate`, `is_default`, `status`, `created_at`, `updated_at`) VALUES
(1, 'USD', '$', 'United States Dollar', 1, '1.00000000', 1, 1, '2021-06-08 06:45:52', '2021-10-24 07:28:20');

-- --------------------------------------------------------

--
-- Table structure for table `deposits`
--

CREATE TABLE `deposits` (
  `id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `user_type` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `wallet_id` int(11) DEFAULT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `method_code` int(10) UNSIGNED NOT NULL,
  `amount` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `method_currency` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `charge` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `rate` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `final_amo` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `detail` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `btc_amo` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `btc_wallet` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trx` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `try` int(10) NOT NULL DEFAULT 0,
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1=>success, 2=>pending, 3=>cancel',
  `from_api` tinyint(1) NOT NULL DEFAULT 0,
  `admin_feedback` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `email_logs`
--

CREATE TABLE `email_logs` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `user_type` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `mail_sender` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_from` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_to` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `message` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `email_sms_templates`
--

CREATE TABLE `email_sms_templates` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `act` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `subj` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_body` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sms_body` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shortcodes` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `email_status` tinyint(1) NOT NULL DEFAULT 1,
  `sms_status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `email_sms_templates`
--

INSERT INTO `email_sms_templates` (`id`, `act`, `name`, `subj`, `email_body`, `sms_body`, `shortcodes`, `email_status`, `sms_status`, `created_at`, `updated_at`) VALUES
(1, 'PASS_RESET_CODE', 'Password Reset', 'Password Reset', '<div>We have received a request to reset the password for your account on <b>{{time}} .<br></b></div><div>Requested From IP: <b>{{ip}}</b> using <b>{{browser}}</b> on <b>{{operating_system}} </b>.</div><div><br></div><br><div><div><div>Your account recovery code is:&nbsp;&nbsp; <font size=\"6\"><b>{{code}}</b></font></div><div><br></div></div></div><div><br></div><div><font size=\"4\" color=\"#CC0000\">If you do not wish to reset your password, please disregard this message.&nbsp;</font><br></div><br>', 'Your account recovery code is: {{code}}', ' {\"code\":\"Password Reset Code\",\"ip\":\"IP of User\",\"browser\":\"Browser of User\",\"operating_system\":\"Operating System of User\",\"time\":\"Request Time\"}', 1, 1, '2019-09-24 23:04:05', '2021-01-06 00:49:06'),
(2, 'PASS_RESET_DONE', 'Password Reset Confirmation', 'You have Reset your password', '<div><p>\r\n    You have successfully reset your password.</p><p>You changed from&nbsp; IP: <b>{{ip}}</b> using <b>{{browser}}</b> on <b>{{operating_system}}&nbsp;</b> on <b>{{time}}</b></p><p><b><br></b></p><p><font color=\"#FF0000\"><b>If you did not changed that, Please contact with us as soon as possible.</b></font><br></p></div>', 'Your password has been changed successfully', '{\"ip\":\"IP of User\",\"browser\":\"Browser of User\",\"operating_system\":\"Operating System of User\",\"time\":\"Request Time\"}', 1, 1, '2019-09-24 23:04:05', '2020-03-07 10:23:47'),
(3, 'EVER_CODE', 'Email Verification', 'Please verify your email address', '<div><br></div><div>Thanks For join with us. <br></div><div>Please use below code to verify your email address.<br></div><div><br></div><div>Your email verification code is:<font size=\"6\"><b> {{code}}</b></font></div>', 'Your email verification code is: {{code}}', '{\"code\":\"Verification code\"}', 1, 1, '2019-09-24 23:04:05', '2021-01-03 23:35:10'),
(4, 'SVER_CODE', 'SMS Verification ', 'Please verify your phone', 'Your phone verification code is: {{code}}', 'Your phone verification code is: {{code}}', '{\"code\":\"Verification code\"}', 0, 1, '2019-09-24 23:04:05', '2020-03-08 01:28:52'),
(5, '2FA_ENABLE', 'Google Two Factor - Enable', 'Google Two Factor Authentication is now  Enabled for Your Account', '<div>You just enabled Google Two Factor Authentication for Your Account.</div><div><br></div><div>Enabled at <b>{{time}} </b>From IP: <b>{{ip}}</b> using <b>{{browser}}</b> on <b>{{operating_system}} </b>.</div>', 'Your verification code is: {{code}}', '{\"ip\":\"IP of User\",\"browser\":\"Browser of User\",\"operating_system\":\"Operating System of User\",\"time\":\"Request Time\"}', 1, 1, '2019-09-24 23:04:05', '2020-03-08 01:42:59'),
(6, '2FA_DISABLE', 'Google Two Factor Disable', 'Google Two Factor Authentication is now  Disabled for Your Account', '<div>You just Disabled Google Two Factor Authentication for Your Account.</div><div><br></div><div>Disabled at <b>{{time}} </b>From IP: <b>{{ip}}</b> using <b>{{browser}}</b> on <b>{{operating_system}} </b>.</div>', 'Google two factor verification is disabled', '{\"ip\":\"IP of User\",\"browser\":\"Browser of User\",\"operating_system\":\"Operating System of User\",\"time\":\"Request Time\"}', 1, 1, '2019-09-24 23:04:05', '2020-03-08 01:43:46'),
(16, 'ADMIN_SUPPORT_REPLY', 'Support Ticket Reply ', 'Reply Support Ticket', '<div><p><span style=\"font-size: 11pt;\" data-mce-style=\"font-size: 11pt;\"><strong>A member from our support team has replied to the following ticket:</strong></span></p><p><b><span style=\"font-size: 11pt;\" data-mce-style=\"font-size: 11pt;\"><strong><br></strong></span></b></p><p><b>[Ticket#{{ticket_id}}] {{ticket_subject}}<br><br>Click here to reply:&nbsp; {{link}}</b></p><p>----------------------------------------------</p><p>Here is the reply : <br></p><p> {{reply}}<br></p></div><div><br></div>', '{{subject}}\r\n\r\n{{reply}}\r\n\r\n\r\nClick here to reply:  {{link}}', '{\"ticket_id\":\"Support Ticket ID\", \"ticket_subject\":\"Subject Of Support Ticket\", \"reply\":\"Reply from Staff/Admin\",\"link\":\"Ticket URL For relpy\"}', 1, 1, '2020-06-08 18:00:00', '2020-05-04 02:24:40'),
(206, 'DEPOSIT_COMPLETE', 'Automated Deposit - Successful', 'Add money Completed Successfully', '<div>Your payment of <b>{{amount}} {{currency}}</b> is via&nbsp; <b>{{method_name}} </b>has been completed Successfully.<b><br></b></div><div><b><br></b></div><div><b>Details of your Deposit :<br></b></div><div><br></div><div>Amount : {{amount}} {{currency}}</div><div>Charge: <font color=\"#000000\">{{charge}} {{method_currency}}</font></div><div><br></div><div>Conversion Rate : 1 {{currency}} = {{rate}} {{method_currency}}</div><div>Payable : {{method_amount}} {{method_currency}} <br></div><div>Paid via :&nbsp; {{method_name}}</div><div><br></div><div>Transaction Number : {{trx}}</div><div><font size=\"5\"><b><br></b></font></div><div><font size=\"5\">Your current Balance is <b>{{post_balance}} {{currency}}</b></font></div><div><br></div><div><br><br><br></div>', '{{amount}} {{currrency}} Deposit successfully by {{gateway_name}}', '{\"trx\":\"Transaction Number\",\"amount\":\"Request Amount By user\",\"charge\":\"Gateway Charge\",\"currency\":\"Site Currency\",\"rate\":\"Conversion Rate\",\"method_name\":\"Deposit Method Name\",\"method_currency\":\"Deposit Method Currency\",\"method_amount\":\"Deposit Method Amount After Conversion\", \"post_balance\":\"Users Balance After this operation\"}', 1, 1, '2020-06-24 18:00:00', '2021-07-01 06:09:23'),
(207, 'DEPOSIT_REQUEST', 'Manual Deposit - User Requested', 'Add money Request Submitted Successfully', '<div>Your Add money request of <b>{{amount}} {{currency}}</b> is via&nbsp; <b>{{method_name}} </b>submitted successfully<b> .<br></b></div><div><b><br></b></div><div><b>Details of your Deposit :<br></b></div><div><br></div><div>Amount : {{amount}} {{currency}}</div><div>Charge: <font color=\"#FF0000\">{{charge}} {{method_currency}}</font></div><div><br></div><div>Conversion Rate : 1 {{currency}} = {{rate}} {{method_currency}}</div><div>Payable : {{method_amount}} {{method_currency}} <br></div><div>Pay via :&nbsp; {{method_name}}</div><div><br></div><div>Transaction Number : {{trx}}</div><div><br></div><div><br></div>', '{{amount}} Deposit requested by {{method}}. Charge: {{charge}} . Trx: {{trx}}\r\n', '{\"trx\":\"Transaction Number\",\"amount\":\"Request Amount By user\",\"charge\":\"Gateway Charge\",\"currency\":\"Site Currency\",\"rate\":\"Conversion Rate\",\"method_name\":\"Deposit Method Name\",\"method_currency\":\"Deposit Method Currency\",\"method_amount\":\"Deposit Method Amount After Conversion\"}', 1, 1, '2020-05-31 18:00:00', '2021-07-01 06:10:02'),
(208, 'DEPOSIT_APPROVE', 'Manual Deposit - Admin Approved', 'Your Deposit is Approved', '<div>Your deposit request of <b>{{amount}} {{currency}}</b> is via&nbsp; <b>{{method_name}} </b>is Approved .<b><br></b></div><div><b><br></b></div><div><b>Details of your Deposit :<br></b></div><div><br></div><div>Amount : {{amount}} {{currency}}</div><div>Charge: <font color=\"#FF0000\">{{charge}} {{currency}}</font></div><div><br></div><div>Conversion Rate : 1 {{currency}} = {{rate}} {{method_currency}}</div><div>Payable : {{method_amount}} {{method_currency}} <br></div><div>Paid via :&nbsp; {{method_name}}</div><div><br></div><div>Transaction Number : {{trx}}</div><div><font size=\"5\"><b><br></b></font></div><div><font size=\"5\">Your current Balance is <b>{{post_balance}} {{currency}}</b></font></div><div><br></div><div><br><br></div>', 'Admin Approve Your {{amount}} {{gateway_currency}} payment request by {{gateway_name}} transaction : {{transaction}}', '{\"trx\":\"Transaction Number\",\"amount\":\"Request Amount By user\",\"charge\":\"Gateway Charge\",\"currency\":\"Site Currency\",\"rate\":\"Conversion Rate\",\"method_name\":\"Deposit Method Name\",\"method_currency\":\"Deposit Method Currency\",\"method_amount\":\"Deposit Method Amount After Conversion\", \"post_balance\":\"Users Balance After this operation\"}', 1, 1, '2020-06-16 18:00:00', '2020-06-14 18:00:00'),
(209, 'DEPOSIT_REJECT', 'Manual Deposit - Admin Rejected', 'Your Deposit Request is Rejected', '<div>Your deposit request of <b>{{amount}} {{currency}}</b> is via&nbsp; <b>{{method_name}} has been rejected</b>.<b><br></b></div><br><div>Transaction Number was : {{trx}}</div><div><br></div><div>if you have any query, feel free to contact us.<br></div><br><div><br><br></div>\r\n\r\n\r\n\r\n{{rejection_message}}', 'Admin Rejected Your {{amount}} {{gateway_currency}} payment request by {{gateway_name}}\r\n\r\n{{rejection_message}}', '{\"trx\":\"Transaction Number\",\"amount\":\"Request Amount By user\",\"charge\":\"Gateway Charge\",\"currency\":\"Site Currency\",\"rate\":\"Conversion Rate\",\"method_name\":\"Deposit Method Name\",\"method_currency\":\"Deposit Method Currency\",\"method_amount\":\"Deposit Method Amount After Conversion\",\"rejection_message\":\"Rejection message\"}', 1, 1, '2020-06-09 18:00:00', '2020-06-14 18:00:00'),
(210, 'WITHDRAW_REQUEST', 'Withdraw  - User Requested', 'Withdraw Request Submitted Successfully', '<div>Your withdraw request of <b>{{amount}} {{currency}}</b>&nbsp; via&nbsp; <b>{{method_name}} </b>has been submitted Successfully.<b><br></b></div><div><b><br></b></div><div><b>Details of your withdraw:<br></b></div><div><br></div><div>Amount : {{amount}} {{currency}}</div><div>Charge: <font color=\"#FF0000\">{{charge}} {{currency}}</font></div><div><br></div><div>You will get: {{method_amount}} {{method_currency}} <br></div><div>Via :&nbsp; {{method_name}}</div><div><br></div><div>Transaction Number : {{trx}}</div><div><font size=\"4\" color=\"#FF0000\"><b><br></b></font></div><div><font size=\"4\" color=\"#FF0000\"></font><br></div><div><font size=\"5\"><b><br></b></font></div><div><font size=\"5\"><b><br></b></font></div><div><font size=\"5\">Your current Balance is <b>{{post_balance}} {{currency}}</b></font></div><div><br></div><div><br><br><br><br></div>', '{{amount}} {{currency}} withdraw requested by {{method_name}}. You will get {{method_amount}} {{method_currency}} in {{delay}}. Trx: {{trx}}', '{\"trx\":\"Transaction Number\",\"amount\":\"Request Amount By user\",\"charge\":\"Gateway Charge\",\"currency\":\"Site Currency\",\"rate\":\"Conversion Rate\",\"method_name\":\"Deposit Method Name\",\"method_currency\":\"Deposit Method Currency\",\"method_amount\":\"Deposit Method Amount After Conversion\", \"post_balance\":\"Users Balance After this operation\", \"delay\":\"Delay time for processing\"}', 1, 1, '2020-06-07 18:00:00', '2021-05-08 06:49:06'),
(211, 'WITHDRAW_REJECT', 'Withdraw - Admin Rejected', 'Withdraw Request has been Rejected and your money is refunded to your account', '<div>Your withdraw request of <b>{{amount}} {{</b><b>method_currency}}</b>&nbsp; via&nbsp; <b>{{method_name}} </b>has been Rejected.<b><br></b></div><div><b><br></b></div><div><b>Details of your withdraw:<br></b></div><div><br></div><div>Amount : {{amount}} {{method_currency}}</div><div>Charge: <font color=\"#FF0000\">{{charge}} {{</font><font color=\"#FF0000\">method_currency}}</font></div><div><br></div><div>You should get: {{method_amount}} {{method_currency}} <br></div><div>Via :&nbsp; {{method_name}}</div><div><br></div><div>Transaction Number : {{trx}}</div><div><br></div><div>----</div><div><font size=\"3\"><br></font></div><div><font size=\"3\"> {{amount}} {{</font><font size=\"3\">method_currency}} has been <b>refunded </b>to your account and your current Balance is <b>{{post_balance}}</b><b> {{</b></font><font size=\"3\"><b>method_currency}}</b></font></div><div><br></div><div>-----</div><div><br></div><div><font size=\"4\">Details of Rejection :</font></div><div><font size=\"4\"><b>{{admin_details}}</b></font></div><div><br></div><div><br><br><br><br><br><br></div>', 'Admin Rejected Your {{amount}} {{currency}} withdraw request. Your Main Balance {{main_balance}}  {{method}} , Transaction {{transaction}}', '{\"trx\":\"Transaction Number\",\"amount\":\"Request Amount By user\",\"charge\":\"Gateway Charge\",\"method_name\":\"Deposit Method Name\",\"method_currency\":\"Deposit Method Currency\",\"method_amount\":\"Deposit Method Amount After Conversion\", \"post_balance\":\"Users Balance After this operation\", \"admin_details\":\"Details Provided By Admin\"}', 1, 1, '2020-06-09 18:00:00', '2021-07-01 05:02:47'),
(212, 'WITHDRAW_APPROVE', 'Withdraw - Admin  Approved', 'Withdraw Request has been Processed and your money is sent', '<div>Your withdraw request of <b>{{amount}} </b>{{method_currency}}&nbsp; via&nbsp; <b>{{method_name}} </b>has been Processed Successfully.<b><br></b></div><div><b><br></b></div><div><b>Details of your withdraw:<br></b></div><div><br></div><div>Amount : {{amount}} {{method_currency}}</div><div>Charge: <font color=\"#FF0000\"><font color=\"#000000\">{{charge}}</font> </font>{{method_currency}} </div><div><br></div><div>You will get: {{method_amount}} {{method_currency}} <br></div><div>Via :&nbsp; {{method_name}}</div><div><br></div><div>Transaction Number : {{trx}}</div><div><br></div><div>-----</div><div><br></div><div><font size=\"4\">Details of Processed Payment :</font></div><div><font size=\"4\"><b>{{admin_details}}</b></font></div><div><br></div><div><br><br><br><br><br></div>', 'Admin Approve Your {{amount}} {{currency}} withdraw request by {{method}}. Transaction {{trx}}', '{\"trx\":\"Transaction Number\",\"amount\":\"Request Amount By user\",\"charge\":\"Gateway Charge\",\"method_name\":\"Deposit Method Name\",\"method_currency\":\"Deposit Method Currency\",\"method_amount\":\"Deposit Method Amount After Conversion\", \"admin_details\":\"Details Provided By Admin\"}', 1, 1, '2020-06-10 18:00:00', '2021-07-01 05:10:13'),
(215, 'BAL_ADD', 'Balance Add by Admin', 'Your Account has been Credited', '<div>{{amount}} {{currency}} has been added to your account .</div><div><br></div><div>Transaction Number : {{trx}}</div><div><br></div>Your Current Balance is : <font size=\"3\"><b>{{post_balance}}&nbsp; {{currency}}&nbsp;</b></font>', '{{amount}} {{currency}} credited in your account. Your Current Balance {{remaining_balance}} {{currency}} . Transaction: #{{trx}}', '{\"trx\":\"Transaction Number\",\"amount\":\"Request Amount By Admin\",\"currency\":\"Site Currency\", \"post_balance\":\"Users Balance After this operation\"}', 1, 1, '2019-09-14 19:14:22', '2021-01-06 00:46:18'),
(216, 'BAL_SUB', 'Balance Subtracted by Admin', 'Your Account has been Debited', '<div>{{amount}} {{currency}} has been subtracted from your account .</div><div><br></div><div>Transaction Number : {{trx}}</div><div><br></div>Your Current Balance is : <font size=\"3\"><b>{{post_balance}}&nbsp; {{currency}}</b></font>', '{{amount}} {{currency}} debited from your account. Your Current Balance {{remaining_balance}} {{currency}} . Transaction: #{{trx}}', '{\"trx\":\"Transaction Number\",\"amount\":\"Request Amount By Admin\",\"currency\":\"Site Currency\", \"post_balance\":\"Users Balance After this operation\"}', 1, 1, '2019-09-14 19:14:22', '2019-11-10 09:07:12'),
(217, 'SEND_INVOICE_MAIL', 'Send Invoice to mail', 'Invoice Of your payment', 'You have an invoice to pay. Please follow the URL below to successful payment.<br><b>Invoice URL : <a class=\"btn btn--info\" href=\" {{url}}\">Click</a><br><br></b><div>You can also download the invoice via below URL,</div><div><b>Download : <a href=\"{{download_url}}\" class=\"btn btn--info\">Download</a></b><br></div>', NULL, '{\"url\":\"invoice url\",\"download_url\":\"Download link of invoice\"}', 1, 1, '2019-09-14 19:14:22', '2021-06-21 05:55:52'),
(218, 'MONEY_OUT', 'Money Out', 'Money Out', '<div>Money Out  <b>{{amount}} {{curr_code}}</b> to <b>{{agent}}</b> successful. <br></div><div>Charge <b>{{charge}} {{curr_code}}</b>, Remaining Balance <b>{{balance}} {{curr_code}}</b>. </div><div>TrxID <b>{{trx}}</b> at <b>{{time}}</b>.</div>', 'Cash Out  {{amount}} {{curr_code}} to {{agent}} successful.\r\nCharge {{charge}} {{curr_code}}. Remaining Balance {{balance}} {{curr_code}}. TrxID {{trx}} at {{time}}.', '{\"amount\":\"Cash out amount\",\"curr_code\":\"currency code\", \"agent\":\"Agent user name or mail\",\"charge\":\"Cash out charge\",\"trx\":\"transaction id\",\"time\":\"cash out time and date\",\"balance\":\"Remaining Balance\"}', 1, 1, '2019-09-14 19:14:22', '2021-08-17 12:57:07'),
(219, 'MONEY_OUT_TO_AGENT', 'Money Out To Agent', 'Money Out', '<div>Money Out  <b>{{amount}} {{curr_code}}</b> from <b>{{user}}</b> successful. <br></div><div>Your New Balance <b>{{balance}} {{curr_code}}</b>. </div><div>TrxID <b>{{trx}}</b> at <b>{{time}}</b>.</div>', '<div>Cash Out  <b>{{amount}} {{curr_code}}</b> from <b>{{user}}</b> successful. <br></div><div>Your New Balance <b>{{balance}} {{curr_code}}</b>. </div><div>TrxID <b>{{trx}}</b> at <b>{{time}}</b>.</div>', '{\"amount\":\"Cash out amount\",\"curr_code\":\"currency code\", \"user\":\"User name or email\",\"trx\":\"transaction id\",\"time\":\"cash out time and date\",\"balance\":\"Remaining Balance\"}', 1, 1, '2019-09-14 19:14:22', '2021-08-17 12:57:35'),
(220, 'MONEY_OUT_COMMISSION_AGENT', 'Money Out Commission of Agent', 'Money out Commission', '<div>Commission of <b>{{amount}} {{curr_code}}</b> money out received successfully. <br></div><div>Total Commission : {{commission}} {{curr_code}}</div><div>Your New Balance <b>{{balance}} {{curr_code}}</b>. </div><div>TrxID <b>{{trx}}</b> at <b>{{time}}</b>.</div>', '<div>Cash Out  <b>{{amount}} {{curr_code}}</b> from <b>{{user}}</b> successful. <br></div><div>Your New Balance <b>{{balance}} {{curr_code}}</b>. </div><div>TrxID <b>{{trx}}</b> at <b>{{time}}</b>.</div>', '{\"amount\":\"Cash out amount\",\"curr_code\":\"currency code\", \"trx\":\"transaction id\",\"time\":\"cash out time and date\",\"balance\":\"Remaining Balance\",\"commission\":\"Cash out commission to agent\"}', 1, 1, '2019-09-14 19:14:22', '2021-08-17 12:56:47'),
(221, 'MAKE_PAYMENT', 'Make Payment', 'Make Payment', '<div>Payment <b>{{amount}} {{curr_code}}</b> to <b>{{merchant}}</b> successful. <br></div><div>Charge <b>{{charge}} {{curr_code}}</b>, Remaining Balance <b>{{balance}} {{curr_code}}</b>. </div><div>TrxID <b>{{trx}}</b> at <b>{{time}}</b>.</div>', '<div>Payment <b>{{amount}} {{curr_code}}</b> to <b>{{marchant}}</b> successful. <br></div><div>Charge <b>{{charge}} {{curr_code}}</b>, Remaining Balance <b>{{balance}} {{curr_code}}</b>. </div><div>TrxID <b>{{trx}}</b> at <b>{{time}}</b>.</div>', '{\"amount\":\"Payment amount\",\"curr_code\":\"currency code\", \"marchant\":\"Marchant user name or mail\",\"charge\":\"Payment charge\",\"trx\":\"transaction id\",\"time\":\"payment time and date\",\"balance\":\"Remaining Balance\"}', 1, 1, '2019-09-14 19:14:22', '2021-08-19 08:12:00'),
(222, 'MAKE_PAYMENT_MERCHANT', 'Make Payment marchant', 'Make Payment', '<div>Payment <b>{{amount}} {{curr_code}}</b> received from <b>{{user}}</b> successful. <br></div><div>Charge <b>{{charge}} {{curr_code}}</b>, Remaining Balance <b>{{balance}} {{curr_code}}</b>. </div><div>TrxID <b>{{trx}}</b> at <b>{{time}}</b>.</div>', '<div>Payment <b>{{amount}} {{curr_code}}</b> to <b>{{marchant}}</b> successful. <br></div><div>Charge <b>{{charge}} {{curr_code}}</b>, Remaining Balance <b>{{balance}} {{curr_code}}</b>. </div><div>TrxID <b>{{trx}}</b> at <b>{{time}}</b>.</div>', '{\"amount\":\"Payment amount\",\"curr_code\":\"currency code\", \"user\":\"User username or mail\",\"charge\":\"Payment charge\",\"trx\":\"transaction id\",\"time\":\"payment time and date\",\"balance\":\"Remaining Balance\"}', 1, 1, '2019-09-14 19:14:22', '2021-06-30 08:15:11'),
(223, 'EXCHANGE_MONEY', 'Exchange Money', 'Exchange Money', 'Exchanged <b>{{from_wallet_amount}}</b> <b>{{from_wallet_curr}}</b> from wallet ( <b>{{from_wallet_curr}}</b> ) To wallet ( <b>{{to_wallet_curr}}</b> ) successful.<br><div>Exchanged amount : <b>{{to_wallet_amount}}</b> <b>{{to_wallet_curr}}.</b></div><div><br>Remaining balance of&nbsp;<b><b> ( </b><b><b>{{from_wallet_curr}} </b>) </b></b>is :<b> <b>{{from_balance}} </b><b>{{from_wallet_curr}}</b><br></b>New balance of<b><b><b>&nbsp; ( </b><b><b>{{to_wallet_curr}} </b>) </b></b></b>is :<b><b><b> </b></b><b><b>{{to_balance}}</b><b>&nbsp; </b></b><b><b><b><b><b>{{to_wallet_curr}}</b></b></b></b></b></b></div><div><b><b><b><b><b><b><br></b></b></b></b></b></b></div><div>TrxID :<b> {{trx}}</b></div><div>Time :<b>&nbsp; {{time}}<br></b></div>', 'Exchanged {{from_wallet_amount}} {{from_wallet_curr}} from wallet ( {{from_wallet_curr}} ) To wallet ( {{to_wallet_curr}} ) successful.\r\nExchanged amount : {{to_wallet_amount}} {{to_wallet_curr}}.\r\n\r\nRemaining balance of  ( {{from_wallet_curr}} ) is : {{from_balance}} {{from_wallet_curr}}\r\nNew balance of  ( {{to_wallet_curr}} ) is : {{to_balance}}  {{to_wallet_curr}}\r\n\r\nTrxID : {{trx}}\r\nTime :  {{time}}', '{\"from_wallet_amount\":\"Amount from wallet\",\"from_wallet_curr\":\"From wallet currency\",\"to_wallet_amount\":\"Amount to wallet\",\"to_wallet_curr\":\"To wallet currency\",\"from_balance\":\"From wallet remaining balance\",\"to_balance\":\"To wallet new balance\",\"trx\":\"Transaction id\",\"time\":\"Exchange Time\"}', 1, 1, '2019-09-14 19:14:22', '2021-06-30 09:08:43'),
(224, 'TRANSFER_MONEY', 'Transfer Money', 'Transfer Money', '<div>Tranfer Money <b>{{amount}} {{curr_code}}</b> to <b>{{to_user}}</b> successful. <br></div><div>Charge <b>{{charge}} {{curr_code}}</b>, Remaining Balance <b>{{balance}} {{curr_code}}</b>. </div><div>TrxID <b>{{trx}}</b> at <b>{{time}}</b>.</div>', 'Tranfer Money {{amount}} {{curr_code}} to {{to_user}} successful.\r\nCharge {{charge}} {{curr_code}}, Remaining Balance {{balance}} {{curr_code}}.\r\nTrxID {{trx}} at {{time}}.', '{\"amount\":\"Transfer amount\",\"curr_code\":\"currency code\", \"to_user\":\"user name or mail of receiver\",\"charge\":\"Transfer charge\",\"trx\":\"transaction id\",\"time\":\"Transfer time and date\",\"balance\":\"Remaining Balance\"}', 1, 1, '2019-09-14 19:14:22', '2021-06-30 09:09:44'),
(225, 'RECEIVED_MONEY', 'Received Money', 'Received Money', '<div>Received Money <b>{{amount}} {{curr_code}}</b> from <b>{{from_user}}</b> successful. <br></div><div>New Balance <b>{{balance}} {{curr_code}}</b>. </div><div>TrxID <b>{{trx}}</b> at <b>{{time}}</b>.</div>', 'Tranfer Money {{amount}} {{curr_code}} to {{to_user}} successful.\r\nCharge {{charge}} {{curr_code}}, Remaining Balance {{balance}} {{curr_code}}.\r\nTrxID {{trx}} at {{time}}.', '{\"amount\":\"Receive amount\",\"curr_code\":\"currency code\", \"from_user\":\"user name or mail of sender\",\"trx\":\"transaction id\",\"time\":\"Received time and date\",\"balance\":\"New Balance\"}', 1, 1, '2019-09-14 19:14:22', '2021-06-30 09:15:55'),
(226, 'REQUEST_MONEY', 'Request Money', 'Request Money', '<div>Money Request <b>{{amount}} {{curr_code}}</b> from <b>{{requestor}}</b>&nbsp; at <b>{{time}}</b>.&nbsp;</div><div><br></div><div><b>Requestor Note</b>: {{note}}<br></div>', 'Money Request {{amount}} {{curr_code}} from {{requestor}}  at {{time}}.', '{\"amount\":\"Receive amount\",\"curr_code\":\"currency code\", \"requestor\":\"user name or mail of requestor\",\"time\":\"Request time and date\",\"note\":\"Note from requestor\"}', 1, 1, '2019-09-14 19:14:22', '2021-06-30 10:17:24'),
(227, 'ACCEPT_REQUEST_MONEY_REQUESTOR', 'Accept request money mail to requestor', 'Accept Request Money', '<div>Your Money Request <b>{{amount}} {{curr_code}}</b> to<b> {{to_requested}}</b>&nbsp; has been accepted at <b>{{time}}</b>.&nbsp; Charge: <b>{{charge}}</b> <b>{{curr_code}}</b></div><div>Your new balance is : <b>{{balance}}</b> <b>{{curr_code}}</b></div><div>TrxID : <b>{{trx}}</b><br></div>', 'Money Request {{amount}} {{curr_code}} from {{requestor}}  at {{time}}.', '{\"amount\":\"Request amount\",\"curr_code\":\"currency code\", \"to_requested\":\"Requeted to whom\",\"time\":\"Request time and date\",\"balance\":\"New Balance\",\"trx\":\"Transaction id\",\"charge\":\"money request charge\"}', 1, 1, '2019-09-14 19:14:22', '2021-06-30 11:03:02'),
(228, 'ACCEPT_REQUEST_MONEY', 'Accept request money', 'Accept Request Money', '<div>Your\'ve Accepted Money Request <b>{{amount}} {{curr_code}}</b> from&nbsp;<b> {{requestor}}</b>&nbsp; at <b>{{time}}</b>.&nbsp;</div><div>Your new balance is : <b>{{balance}}</b> <b>{{curr_code}}</b></div><div>TrxID : <b>{{trx}}</b><br></div>', 'Your\'ve Accepted Money Request {{amount}} {{curr_code}} from  {{requestor}}  at {{time}}. \r\nYour new balance is : {{balance}} {{curr_code}}\r\nTrxID : {{trx}}', '{\"amount\":\"Request amount\",\"curr_code\":\"currency code\", \"requestor\":\"Requestor\",\"time\":\"Accept time and date\",\"balance\":\"New Balance\",\"trx\":\"Transaction id\"}', 1, 1, '2019-09-14 19:14:22', '2021-06-30 10:50:39'),
(229, 'GET_INVOICE_PAYMENT', 'Get Invoice Payment', 'Get Invoice Payment', 'Payment <b>{{total_amount}} {{curr_code}}</b>&nbsp; of Invoice <b>#{{invoice_id}} </b>has been received successfully, from <b>{{from_user}}</b> at <b>{{time}}.<br></b><div>You got after charge<b> : {{get_amount}} </b>{{curr_code}} .<br></div><div>Charge : {{charge}} {{curr_code}} .<br>TrxID : {{trx}}.<br><br>Your New Balance is {{post_balance}} {{curr_code}} .<br></div>', 'Payment {{total_amount}} {{curr_code}}  of Invoice #{{invoice_id}} has been received successfully, from {{from_user}} at {{time}}.\r\nYou got after charge : {{get_amount}} {{curr_code}} .\r\nCharge : {{charge}} {{curr_code}} .\r\nTrxID : {{trx}}.\r\n\r\nYour New Balance is {{post_balance}} {{curr_code}} .', '{\"total_amount\":\"invoice total amount\",\"get_amount\":\"get amount after charge\",\"charge\":\"invoice charge\",\"curr_code\":\"currency code\",\"invoice_id\":\"invoice id\",\"time\":\"payment time and date\",\"from_user\":\"from whom get payment\",\"trx\":\"Transaction id\",\"post_balance\":\"post balance\"}', 1, 1, '2019-09-14 19:14:22', '2021-07-01 05:52:12'),
(230, 'PAY_INVOICE_PAYMENT', 'Pay Invoice Payment', 'Pay Invoice Payment', 'Payment <b>{{total_amount}} {{curr_code}}</b>&nbsp; of Invoice <b>#{{invoice_id}} </b>has been&nbsp; successful, to<b> {{to_user}}</b> at <b>{{time}}.<br></b><div><br></div><div>TrxID : {{trx}}.</div><br>Your New Balance is {{post_balance}} {{curr_code}} .', '', '{\"total_amount\":\"invoice total amount\",\"curr_code\":\"currency code\",\"invoice_id\":\"invoice id\",\"time\":\"payment time and date\",\"to_user\":\"to whom pay the payment\",\"trx\":\"Transaction id\",\"post_balance\":\"post balance\"}', 1, 1, '2019-09-14 19:14:22', '2021-07-01 05:53:35'),
(231, 'MONEY_IN', 'Money In', 'Money In', '<div>Cash In <b>{{amount}} {{curr_code}}</b> from <b>{{agent}}</b> successful. <br></div>Your New Balance <b>{{balance}} {{curr_code}}</b>. <div>TrxID <b>{{trx}}</b> at <b>{{time}}</b>.</div>', 'Cash In  {{amount}} {{curr_code}} from {{agent}} successful.\r\nYour New Balance {{balance}} {{curr_code}}. TrxID {{trx}} at {{time}}.', '{\"amount\":\"Cash in amount\",\"curr_code\":\"currency code\", \"agent\":\"Agent user name or mail\",\"trx\":\"transaction id\",\"time\":\"cash in time and date\",\"balance\":\"New Balance\"}', 1, 1, '2019-09-14 19:14:22', '2021-08-10 11:53:02'),
(232, 'MONEY_IN_AGENT', 'Money In  Agent', 'Money In', '<div>Cash In <b>{{amount}} {{curr_code}}</b> to <b>{{user}}</b> successful.&nbsp; Charge {{charge}} {{curr_code}}<br></div><div>Your Remaining Balance <b>{{balance}} {{curr_code}}</b>. </div><div>TrxID <b>{{trx}}</b> at <b>{{time}}</b>.</div>', '<div>Cash in <b>{{amount}} {{curr_code}}</b> to <b>{{user}}</b> successful. <br></div><div>Your Remaining Balance <b>{{balance}} {{curr_code}}</b>. </div><div>TrxID <b>{{trx}}</b> at <b>{{time}}</b>.</div>', '{\"amount\":\"Cash in amount\",\"curr_code\":\"currency code\", \"user\":\"User name or email\",\"trx\":\"transaction id\",\"time\":\"cash in time and date\",\"balance\":\"Remaining Balance\",\"charge\":\"cash in charge\"}', 1, 1, '2019-09-14 19:14:22', '2021-08-10 11:53:14'),
(233, 'MONEY_IN_COMMISSION_AGENT', 'Money In Commission of Agent', 'Cash In Commission', '<div>Commission of <b>{{amount}} {{curr_code}}</b> Cash in received successfully. <br></div><div>Total Commission : {{commission}} {{curr_Code}}<br></div><div>Your New Balance <b>{{balance}} {{curr_code}}</b>. </div><div>TrxID <b>{{trx}}</b> at <b>{{time}}</b>.</div>', '<div>Commission of <b>{{amount}} {{curr_code}}</b> cash in received successfully. <br></div><div>Your New Balance <b>{{balance}} {{curr_code}}</b>. </div><div>TrxID <b>{{trx}}</b> at <b>{{time}}</b>.</div>', '{\"amount\":\"Cash in amount\",\"curr_code\":\"currency code\", \"trx\":\"transaction id\",\"time\":\"cash in time and date\",\"balance\":\"New Balance\",\"commission\":\"Cash in commission to agent\"}', 1, 1, '2019-09-14 19:14:22', '2021-07-01 08:34:27'),
(234, 'PAYMENT_VER_CODE', 'Payment Verification', 'Payment Verification', '<div>Please use below code to verify your payment.<br></div><div><br></div><div>Your payment verification code is:<font size=\"6\"><b> {{code}}</b></font></div>', NULL, '{\"code\":\"Verification code\"}', 1, 1, '2019-09-24 23:04:05', '2021-01-03 23:35:10'),
(235, 'MERCHANT_PAYMENT', 'Merchant Payment', 'Payment Successful.', '<div>Payment <b>{{amount}} {{curr_code}}</b> received from&nbsp;<b>{{</b><span style=\"white-space: nowrap;\"><b style=\"\"><font size=\"3\">customer_name</font></b></span><b>}}</b> successful. <br></div><div>Charge <b>{{charge}} {{curr_code}}</b>, Remaining Balance <b>{{balance}} {{curr_code}}</b>. </div><div>TrxID <b>{{trx}}</b> at <b>{{time}}</b>.</div>', '<div>Payment <b>{{amount}} {{curr_code}}</b> from <b>{{customer_name}}</b> successful. <br></div><div>Charge <b>{{charge}} {{curr_code}}</b>, New Balance  is <b>{{balance}} {{curr_code}}</b>. </div><div>TrxID <b>{{trx}}</b> at <b>{{time}}</b>.</div>', '{\"amount\":\"Payment amount\",\"curr_code\":\"currency code\", \"customer_name\":\"Customer name or mail\",\"charge\":\"Payment charge\",\"trx\":\"transaction id\",\"time\":\"payment time and date\",\"balance\":\"Remaining Balance\"}', 1, 1, '2019-09-14 19:14:22', '2021-08-21 05:33:40'),
(236, 'OTP', 'OTP Verification', 'OTP Verification', '', '', '{\"code\":\"Verification Code\"}', 1, 1, '2019-09-14 19:14:22', '2021-08-21 05:33:40');

-- --------------------------------------------------------

--
-- Table structure for table `extensions`
--

CREATE TABLE `extensions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `act` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `script` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `shortcode` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'object',
  `support` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'help section',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1=>enable, 2=>disable',
  `deleted_at` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `extensions`
--

INSERT INTO `extensions` (`id`, `act`, `name`, `description`, `image`, `script`, `shortcode`, `support`, `status`, `deleted_at`, `created_at`, `updated_at`) VALUES
(1, 'tawk-chat', 'Tawk.to', 'Key location is shown bellow', 'tawky_big.png', '<script>\r\n                        var Tawk_API=Tawk_API||{}, Tawk_LoadStart=new Date();\r\n                        (function(){\r\n                        var s1=document.createElement(\"script\"),s0=document.getElementsByTagName(\"script\")[0];\r\n                        s1.async=true;\r\n                        s1.src=\"https://embed.tawk.to/{{app_key}}\";\r\n                        s1.charset=\"UTF-8\";\r\n                        s1.setAttribute(\"crossorigin\",\"*\");\r\n                        s0.parentNode.insertBefore(s1,s0);\r\n                        })();\r\n                    </script>', '{\"app_key\":{\"title\":\"App Key\",\"value\":\"------\"}}', 'twak.png', 0, NULL, '2019-10-18 23:16:05', '2021-05-18 05:37:12'),
(2, 'google-recaptcha2', 'Google Recaptcha 2', 'Key location is shown bellow', 'recaptcha3.png', '\r\n<script src=\"https://www.google.com/recaptcha/api.js\"></script>\r\n<div class=\"g-recaptcha\" data-sitekey=\"{{sitekey}}\" data-callback=\"verifyCaptcha\"></div>\r\n<div id=\"g-recaptcha-error\"></div>', '{\"sitekey\":{\"title\":\"Site Key\",\"value\":\"6Lfpm3cUAAAAAGIjbEJKhJNKS4X1Gns9ANjh8MfH\"}}', 'recaptcha.png', 0, NULL, '2019-10-18 23:16:05', '2021-08-21 05:59:34'),
(3, 'custom-captcha', 'Custom Captcha', 'Just Put Any Random String', 'customcaptcha.png', NULL, '{\"random_key\":{\"title\":\"Random String\",\"value\":\"SecureString\"}}', 'na', 0, NULL, '2019-10-18 23:16:05', '2021-08-21 05:59:47'),
(4, 'google-analytics', 'Google Analytics', 'Key location is shown bellow', 'google_analytics.png', '<script async src=\"https://www.googletagmanager.com/gtag/js?id={{app_key}}\"></script>\r\n                <script>\r\n                  window.dataLayer = window.dataLayer || [];\r\n                  function gtag(){dataLayer.push(arguments);}\r\n                  gtag(\"js\", new Date());\r\n                \r\n                  gtag(\"config\", \"{{app_key}}\");\r\n                </script>', '{\"app_key\":{\"title\":\"App Key\",\"value\":\"------\"}}', 'ganalytics.png', 0, NULL, NULL, '2021-05-04 10:19:12'),
(5, 'fb-comment', 'Facebook Comment ', 'Key location is shown bellow', 'Facebook.png', '<div id=\"fb-root\"></div><script async defer crossorigin=\"anonymous\" src=\"https://connect.facebook.net/en_GB/sdk.js#xfbml=1&version=v4.0&appId={{app_key}}&autoLogAppEvents=1\"></script>', '{\"app_key\":{\"title\":\"App Key\",\"value\":\"----\"}}', 'fb_com.PNG', 0, NULL, NULL, '2021-10-24 07:41:51');

-- --------------------------------------------------------

--
-- Table structure for table `frontends`
--

CREATE TABLE `frontends` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `data_keys` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `data_values` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `frontends`
--

INSERT INTO `frontends` (`id`, `data_keys`, `data_values`, `created_at`, `updated_at`) VALUES
(1, 'seo.data', '{\"seo_image\":\"1\",\"keywords\":[\"wallet\",\"currency\",\"e-wallet\"],\"description\":\"Online wallet\",\"social_title\":\"xCash\",\"social_description\":\"xCash\",\"image\":\"617565ac84b331635083692.png\"}', '2020-07-04 23:42:52', '2021-10-24 07:54:52'),
(24, 'about.content', '{\"has_image\":\"1\",\"title\":\"ABOUT US\",\"heading\":\"We\'re expert in this field whole over the world\",\"short_details\":\"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt.\",\"button_name\":\"Know More\",\"button_link\":\"\\/about-us\",\"experience_year\":\"10\",\"experience_text\":\"Years of Experience\",\"background_image\":\"60bf46022ee3b1623148034.jpg\"}', '2020-10-28 00:51:20', '2021-08-19 10:23:49'),
(25, 'blog.content', '{\"title\":\"Our latest Announces\",\"heading\":\"Our Announces and Articles\",\"sub_heading\":\"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae\"}', '2020-10-28 00:51:34', '2021-08-19 09:23:15'),
(28, 'counter.content', '{\"heading\":\"Latest News\",\"sub_heading\":\"Register New Account\"}', '2020-10-28 01:04:02', '2020-10-28 01:04:02'),
(31, 'social_icon.element', '{\"title\":\"Facebook\",\"social_icon\":\"<i class=\\\"fab fa-facebook-square\\\"><\\/i>\",\"url\":\"https:\\/\\/www.facebook.com\\/\"}', '2020-11-12 04:07:30', '2021-08-17 05:19:58'),
(33, 'feature.content', '{\"has_image\":\"1\",\"heading\":\"Approve more transactions\",\"sub_heading\":\"Experience more approvals on every single payment with local and global payment processing, data-driven optimizations, and powerful risk management. All within a fully connected single payments system.\",\"forground_image\":\"60bf5998429fc1623153048.jpg\",\"background_image\":\"60bf59985d0b51623153048.png\"}', '2021-01-03 23:40:54', '2021-06-08 11:20:48'),
(36, 'service.content', '{\"has_image\":\"1\",\"heading\":\"What we serve our customer\",\"sub_heading\":\"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis\",\"background_image\":\"60bf51c7b1d1d1623151047.png\"}', '2021-03-06 01:27:34', '2021-06-08 10:47:28'),
(39, 'banner.content', '{\"has_image\":\"1\",\"title\":\"We are xCash\",\"heading\":\"The Ultimate Solution for e-Wallet Service\",\"sub_heading\":\"Complete solution for mobile money and wallet system. Comes with User, Agent, and Merchant system with eCommerce API and QR code ready.\",\"button_name\":\"Get Started\",\"button_link\":\"\\/login\",\"video_button_name\":\"See How\",\"video_link\":\"https:\\/\\/www.youtube.com\\/embed\\/WOb4cj7izpE\",\"background_image\":\"60bf37e777a821623144423.jpg\"}', '2021-05-02 06:09:30', '2021-10-24 08:37:40'),
(41, 'cookie.data', '{\"link\":\"#\",\"description\":\"<font color=\\\"#ffffff\\\" face=\\\"Exo, sans-serif\\\"><span style=\\\"font-size: 18px;\\\">We may use cookies or any other tracking technologies when you visit our website, including any other media form, mobile website, or mobile application related or connected to help customize the Site and improve your experience.<\\/span><\\/font><br>\",\"status\":1}', '2020-07-04 23:42:52', '2021-06-06 09:43:37'),
(42, 'brands.content', '{\"heading\":\"Our payment gateway integrate about 50+ platform.\"}', '2021-06-08 09:33:30', '2021-06-08 09:33:30'),
(47, 'about.element', '{\"has_image\":\"1\",\"award_logo\":\"60bf47780d6471623148408.png\"}', '2021-06-08 09:58:30', '2021-06-08 10:03:28'),
(48, 'about.element', '{\"has_image\":\"1\",\"award_logo\":\"60bf477e3bb9f1623148414.png\"}', '2021-06-08 09:58:38', '2021-06-08 10:03:34'),
(49, 'about.element', '{\"has_image\":\"1\",\"award_logo\":\"60bf47843cb481623148420.png\"}', '2021-06-08 09:58:43', '2021-06-08 10:03:40'),
(50, 'service.element', '{\"service_icon\":\"<i class=\\\"las la-wallet\\\"><\\/i>\",\"title\":\"Complete Wallet\",\"description\":\"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis.\"}', '2021-06-08 10:21:55', '2021-10-24 08:43:25'),
(51, 'service.element', '{\"service_icon\":\"<i class=\\\"las la-directions\\\"><\\/i>\",\"title\":\"Money Transfer\",\"description\":\"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis\"}', '2021-06-08 10:23:13', '2021-10-24 08:42:04'),
(52, 'service.element', '{\"service_icon\":\"<i class=\\\"las la-file-invoice\\\"><\\/i>\",\"title\":\"Email Invoicing\",\"description\":\"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis\"}', '2021-06-08 10:24:02', '2021-10-24 08:42:56'),
(53, 'why_choose_us.content', '{\"has_image\":\"1\",\"heading\":\"Why are so many people switching to xCash?\",\"sub_heading\":\"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis\",\"background_image\":\"60bf510b1a10b1623150859.png\"}', '2021-06-08 10:44:19', '2021-06-08 10:44:19'),
(54, 'why_choose_us.element', '{\"has_image\":\"1\",\"title\":\"Lowest payment processing fees. Period.\",\"short_details\":\"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis\",\"icon\":\"60bf513ed98031623150910.png\"}', '2021-06-08 10:45:10', '2021-06-08 10:45:10'),
(55, 'why_choose_us.element', '{\"has_image\":\"1\",\"title\":\"No locked-in contracts. Ever.\",\"short_details\":\"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis\",\"icon\":\"60bf514ea8e3c1623150926.png\"}', '2021-06-08 10:45:26', '2021-06-08 10:45:26'),
(56, 'why_choose_us.element', '{\"has_image\":\"1\",\"title\":\"Full transparency. Always.\",\"short_details\":\"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis\",\"icon\":\"60bf51628abdb1623150946.png\"}', '2021-06-08 10:45:46', '2021-06-08 10:45:46'),
(57, 'why_choose_us.element', '{\"has_image\":\"1\",\"title\":\"Get your money in less than a day.\",\"short_details\":\"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis\",\"icon\":\"60bf51771654c1623150967.png\"}', '2021-06-08 10:46:07', '2021-06-08 10:46:07'),
(58, 'why_choose_us.element', '{\"has_image\":\"1\",\"title\":\"Payment technology that works.\",\"short_details\":\"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis\",\"icon\":\"60bf518cdca201623150988.png\"}', '2021-06-08 10:46:28', '2021-06-08 10:46:28'),
(59, 'why_choose_us.element', '{\"has_image\":\"1\",\"title\":\"A membership plan with wholesale rates.\",\"short_details\":\"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis\",\"icon\":\"60bf51a0ed98c1623151008.png\"}', '2021-06-08 10:46:48', '2021-06-08 10:46:49'),
(60, 'feature.element', '{\"has_image\":\"1\",\"title\":\"Currencies Accepted\",\"short_details\":\"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis\",\"icon\":\"60bf59e5dd11e1623153125.png\"}', '2021-06-08 11:22:05', '2021-06-08 11:22:05'),
(61, 'feature.element', '{\"has_image\":\"1\",\"title\":\"Payment Types Accepted\",\"short_details\":\"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis\",\"icon\":\"60bf59f392d4e1623153139.png\"}', '2021-06-08 11:22:19', '2021-06-08 11:22:19'),
(62, 'feature.element', '{\"has_image\":\"1\",\"title\":\"Marchent Control Pannel\",\"short_details\":\"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis\",\"icon\":\"60bf5a075de9b1623153159.png\"}', '2021-06-08 11:22:39', '2021-06-08 11:22:39'),
(63, 'business.content', '{\"title\":\"Our top client\",\"heading\":\"We\'ve build solutions for\",\"sub_heading\":\"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis\"}', '2021-06-08 11:42:58', '2021-06-08 11:46:52'),
(64, 'business.element', '{\"has_image\":\"1\",\"client_logo\":\"6175773447e541635088180.png\"}', '2021-06-08 11:43:23', '2021-10-24 09:09:40'),
(65, 'business.element', '{\"has_image\":\"1\",\"client_logo\":\"6175773e450c11635088190.png\"}', '2021-06-08 11:43:31', '2021-10-24 09:09:50'),
(66, 'business.element', '{\"has_image\":\"1\",\"client_logo\":\"61757765397ff1635088229.png\"}', '2021-06-08 11:43:39', '2021-10-24 09:10:29'),
(67, 'business.element', '{\"has_image\":\"1\",\"client_logo\":\"61757793c8a101635088275.png\"}', '2021-06-08 11:45:11', '2021-10-24 09:11:15'),
(68, 'business.element', '{\"has_image\":\"1\",\"client_logo\":\"6175776e39fa91635088238.png\"}', '2021-06-08 11:47:25', '2021-10-24 09:10:38'),
(70, 'overview.content', '{\"has_image\":\"1\",\"heading\":\"We provide best payment gateway service.\",\"sub_heading\":\"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis\",\"video_link\":\"https:\\/\\/www.youtube.com\\/embed\\/6agL8KHQlA0\",\"background_image\":\"60bf63b3ca29c1623155635.jpg\"}', '2021-06-08 11:57:07', '2021-06-08 12:03:56'),
(71, 'overview.element', '{\"title\":\"Total User\",\"counter_digit\":\"22 M\"}', '2021-06-08 11:57:36', '2021-06-08 11:57:36'),
(72, 'overview.element', '{\"title\":\"Total Transaction\",\"counter_digit\":\"45 M\"}', '2021-06-08 11:57:57', '2021-06-08 11:57:57'),
(73, 'overview.element', '{\"title\":\"Merchant Accounts\",\"counter_digit\":\"500+\"}', '2021-06-08 11:58:16', '2021-06-08 11:58:16'),
(74, 'testimonial.content', '{\"title\":\"Our client testimonial\",\"heading\":\"What people say\",\"sub_heading\":\"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque\"}', '2021-06-08 12:08:14', '2021-06-08 12:08:14'),
(75, 'testimonial.element', '{\"has_image\":\"1\",\"author_name\":\"Taylor Otwell\",\"designation\":\"Laravel Developer\",\"quote\":\"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo\",\"author_image\":\"60bf64e5804e01623155941.jpg\"}', '2021-06-08 12:09:01', '2021-06-08 12:09:01'),
(76, 'testimonial.element', '{\"has_image\":\"1\",\"author_name\":\"Jeffrey Way\",\"designation\":\"Laravel Developer\",\"quote\":\"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo Nemo.\",\"author_image\":\"60bf6510ed6f71623155984.jpg\"}', '2021-06-08 12:09:44', '2021-06-08 12:09:45'),
(77, 'blog.element', '{\"has_image\":[\"1\"],\"title\":\"Mollitia saepe ipsam nihil soluta quaerat vitae commodi placeat.\",\"description_nic\":\"<div style=\\\"text-align:justify;\\\"><span style=\\\"font-family:arial;font-size:medium;color:rgb(102,102,102);\\\">Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur? At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere<\\/span><\\/div>\",\"blog_image\":\"6175643ac1c651635083322.jpg\"}', '2021-06-08 12:22:22', '2021-10-24 07:48:42'),
(78, 'blog.element', '{\"has_image\":[\"1\"],\"title\":\"Mollitia saepe ipsam nihil soluta quaerat vitae commodi placeat.\",\"description_nic\":\"<div style=\\\"text-align:justify;\\\"><span style=\\\"font-size:medium;color:rgb(102,102,102);\\\"><font face=\\\"arial\\\">Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur? At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere<\\/font><\\/span><\\/div>\",\"blog_image\":\"6175647c5e8f61635083388.jpg\"}', '2021-06-08 12:23:00', '2021-10-24 07:49:48'),
(79, 'login.content', '{\"has_image\":\"1\",\"heading\":\"Sign In\",\"sub_heading\":\"Welcome to xCash\",\"background_image\":\"60c04f4797d8f1623215943.jpg\"}', '2021-06-09 04:49:03', '2021-06-09 04:49:04'),
(80, 'breadcrumb.content', '{\"has_image\":\"1\",\"background_image\":\"60c05008a217f1623216136.jpg\"}', '2021-06-09 04:52:16', '2021-06-09 04:52:16'),
(81, 'footer.content', '{\"has_image\":\"1\",\"box_heading\":\"Do you want to send money anytime to anywhere?\",\"box_button_name\":\"Get Started\",\"box_button_link\":\"\\/login\",\"short_details\":\"The Ultimate Solution for e-Wallet Service\\r\\n\\r\\nComplete solution for mobile money and wallet system. Comes with User, Agent, and Merchant system with eCommerce API and QR code ready.\",\"background_image\":\"60f2d17525c9a1626526069.png\"}', '2021-07-17 12:17:49', '2021-10-24 08:49:32'),
(82, 'contact_us.content', '{\"title\":\"Contact with us\",\"heading\":\"Get in touch for any kind of help and informations\",\"email_address\":\"company@email.com\",\"address\":\"22 bekar streat, London, England\",\"contact_number\":\"+1212121245545\"}', '2021-07-17 12:26:23', '2021-07-17 12:26:23'),
(83, 'contact_us.element', '{\"social_icon\":\"<i class=\\\"lab la-facebook-f\\\"><\\/i>\",\"social_icon_link\":\"https:\\/\\/facebook.com\"}', '2021-07-17 12:46:45', '2021-07-17 12:46:45'),
(84, 'policies.element', '{\"title\":\"Privacy Policy\",\"description\":\"<div class=\\\"mb-5\\\" style=\\\"color:rgb(111,111,111);font-family:Nunito, sans-serif;margin-bottom:3rem;\\\"><h3 class=\\\"mb-3\\\" style=\\\"font-weight:600;line-height:1.3;font-size:24px;font-family:Exo, sans-serif;color:rgb(54,54,54);\\\">What information do we collect?<\\/h3><p class=\\\"font-18\\\" style=\\\"margin-right:0px;margin-left:0px;font-size:18px;\\\">We gather data from you when you register on our site, submit a request, buy any services, react to an overview, or round out a structure. At the point when requesting any assistance or enrolling on our site, as suitable, you might be approached to enter your: name, email address, or telephone number. You may, nonetheless, visit our site anonymously.<\\/p><\\/div><div class=\\\"mb-5\\\" style=\\\"color:rgb(111,111,111);font-family:Nunito, sans-serif;margin-bottom:3rem;\\\"><h3 class=\\\"mb-3\\\" style=\\\"font-weight:600;line-height:1.3;font-size:24px;font-family:Exo, sans-serif;color:rgb(54,54,54);\\\">How do we protect your information?<\\/h3><p class=\\\"font-18\\\" style=\\\"margin-right:0px;margin-left:0px;font-size:18px;\\\">All provided delicate\\/credit data is sent through Stripe.<br \\/>After an exchange, your private data (credit cards, social security numbers, financials, and so on) won\'t be put away on our workers.<\\/p><\\/div><div class=\\\"mb-5\\\" style=\\\"color:rgb(111,111,111);font-family:Nunito, sans-serif;margin-bottom:3rem;\\\"><h3 class=\\\"mb-3\\\" style=\\\"font-weight:600;line-height:1.3;font-size:24px;font-family:Exo, sans-serif;color:rgb(54,54,54);\\\">Do we disclose any information to outside parties?<\\/h3><p class=\\\"font-18\\\" style=\\\"margin-right:0px;margin-left:0px;font-size:18px;\\\">We don\'t sell, exchange, or in any case move to outside gatherings by and by recognizable data. This does exclude confided in outsiders who help us in working our site, leading our business, or adjusting you, since those gatherings consent to keep this data private. We may likewise deliver your data when we accept discharge is suitable to follow the law, implement our site strategies, or ensure our own or others\' rights, property, or wellbeing.<\\/p><\\/div><div class=\\\"mb-5\\\" style=\\\"color:rgb(111,111,111);font-family:Nunito, sans-serif;margin-bottom:3rem;\\\"><h3 class=\\\"mb-3\\\" style=\\\"font-weight:600;line-height:1.3;font-size:24px;font-family:Exo, sans-serif;color:rgb(54,54,54);\\\">Children\'s Online Privacy Protection Act Compliance<\\/h3><p class=\\\"font-18\\\" style=\\\"margin-right:0px;margin-left:0px;font-size:18px;\\\">We are consistent with the prerequisites of COPPA (Children\'s Online Privacy Protection Act), we don\'t gather any data from anybody under 13 years old. Our site, items, and administrations are completely coordinated to individuals who are in any event 13 years of age or more established.<\\/p><\\/div><div class=\\\"mb-5\\\" style=\\\"color:rgb(111,111,111);font-family:Nunito, sans-serif;margin-bottom:3rem;\\\"><h3 class=\\\"mb-3\\\" style=\\\"font-weight:600;line-height:1.3;font-size:24px;font-family:Exo, sans-serif;color:rgb(54,54,54);\\\">Changes to our Privacy Policy<\\/h3><p class=\\\"font-18\\\" style=\\\"margin-right:0px;margin-left:0px;font-size:18px;\\\">If we decide to change our privacy policy, we will post those changes on this page.<\\/p><\\/div><div class=\\\"mb-5\\\" style=\\\"color:rgb(111,111,111);font-family:Nunito, sans-serif;margin-bottom:3rem;\\\"><h3 class=\\\"mb-3\\\" style=\\\"font-weight:600;line-height:1.3;font-size:24px;font-family:Exo, sans-serif;color:rgb(54,54,54);\\\">How long we retain your information?<\\/h3><p class=\\\"font-18\\\" style=\\\"margin-right:0px;margin-left:0px;font-size:18px;\\\">At the point when you register for our site, we cycle and keep your information we have about you however long you don\'t erase the record or withdraw yourself (subject to laws and guidelines).<\\/p><\\/div><h2 class=\\\"inner-hero__title\\\" style=\\\"font-weight:600;line-height:1.3;font-size:32px;font-family:Exo, sans-serif;color:rgb(255,255,255);text-align:center;\\\">y<\\/h2>\"}', '2021-08-17 04:58:21', '2021-08-17 05:10:52'),
(85, 'policies.element', '{\"title\":\"Terms of Service\",\"description\":\"<div class=\\\"mb-5\\\" style=\\\"color:rgb(111,111,111);font-family:Nunito, sans-serif;margin-bottom:3rem;\\\"><p class=\\\"font-18\\\" style=\\\"margin-right:0px;margin-left:0px;font-size:18px;\\\">We claim all authority to dismiss, end, or handicap any help with or without cause per administrator discretion. This is a Complete independent facilitating, on the off chance that you misuse our ticket or Livechat or emotionally supportive network by submitting solicitations or protests we will impair your record. The solitary time you should reach us about the seaward facilitating is if there is an issue with the worker. We have not many substance limitations and everything is as per laws and guidelines. Try not to join on the off chance that you intend to do anything contrary to the guidelines, we do check these things and we will know, don\'t burn through our own and your time by joining on the off chance that you figure you will have the option to sneak by us and break the terms.<\\/p><\\/div><div class=\\\"mb-5\\\" style=\\\"color:rgb(111,111,111);font-family:Nunito, sans-serif;margin-bottom:3rem;\\\"><ul class=\\\"font-18\\\" style=\\\"padding-left:15px;list-style-type:disc;font-size:18px;\\\"><li style=\\\"margin-top:0px;margin-right:0px;margin-left:0px;\\\">Configuration requests - If you have a fully managed dedicated server with us then we offer custom PHP\\/MySQL configurations, firewalls for dedicated IPs, DNS, and httpd configurations.<\\/li><li style=\\\"margin-top:0px;margin-right:0px;margin-left:0px;\\\">Software requests - Cpanel Extension Installation will be granted as long as it does not interfere with the security, stability, and performance of other users on the server.<\\/li><li style=\\\"margin-top:0px;margin-right:0px;margin-left:0px;\\\">Emergency Support - We do not provide emergency support \\/ Phone Support \\/ LiveChat Support. Support may take some hours sometimes.<\\/li><li style=\\\"margin-top:0px;margin-right:0px;margin-left:0px;\\\">Webmaster help - We do not offer any support for webmaster related issues and difficulty including coding, &amp; installs, Error solving. if there is an issue where a library or configuration of the server then we can help you if it\'s possible from our end.<\\/li><li style=\\\"margin-top:0px;margin-right:0px;margin-left:0px;\\\">Backups - We keep backups but we are not responsible for data loss, you are fully responsible for all backups.<\\/li><li style=\\\"margin-top:0px;margin-right:0px;margin-left:0px;\\\">We Don\'t support any child porn or such material.<\\/li><li style=\\\"margin-top:0px;margin-right:0px;margin-left:0px;\\\">No spam-related sites or material, such as email lists, mass mail programs, and scripts, etc.<\\/li><li style=\\\"margin-top:0px;margin-right:0px;margin-left:0px;\\\">No harassing material that may cause people to retaliate against you.<\\/li><li style=\\\"margin-top:0px;margin-right:0px;margin-left:0px;\\\">No phishing pages.<\\/li><li style=\\\"margin-top:0px;margin-right:0px;margin-left:0px;\\\">You may not run any exploitation script from the server. reason can be terminated immediately.<\\/li><li style=\\\"margin-top:0px;margin-right:0px;margin-left:0px;\\\">If Anyone attempting to hack or exploit the server by using your script or hosting, we will terminate your account to keep safe other users.<\\/li><li style=\\\"margin-top:0px;margin-right:0px;margin-left:0px;\\\">Malicious Botnets are strictly forbidden.<\\/li><li style=\\\"margin-top:0px;margin-right:0px;margin-left:0px;\\\">Spam, mass mailing, or email marketing in any way are strictly forbidden here.<\\/li><li style=\\\"margin-top:0px;margin-right:0px;margin-left:0px;\\\">Malicious hacking materials, trojans, viruses, &amp; malicious bots running or for download are forbidden.<\\/li><li style=\\\"margin-top:0px;margin-right:0px;margin-left:0px;\\\">Resource and cronjob abuse is forbidden and will result in suspension or termination.<\\/li><li style=\\\"margin-top:0px;margin-right:0px;margin-left:0px;\\\">Php\\/CGI proxies are strictly forbidden.<\\/li><li style=\\\"margin-top:0px;margin-right:0px;margin-left:0px;\\\">CGI-IRC is strictly forbidden.<\\/li><li style=\\\"margin-top:0px;margin-right:0px;margin-left:0px;\\\">No fake or disposal mailers, mass mailing, mail bombers, SMS bombers, etc.<\\/li><li style=\\\"margin-top:0px;margin-right:0px;margin-left:0px;\\\">NO CREDIT OR REFUND will be granted for interruptions of service, due to User Agreement violations.<\\/li><\\/ul><\\/div><div class=\\\"mb-5\\\" style=\\\"color:rgb(111,111,111);font-family:Nunito, sans-serif;margin-bottom:3rem;\\\"><h3 class=\\\"mb-3\\\" style=\\\"font-weight:600;line-height:1.3;font-size:24px;font-family:Exo, sans-serif;color:rgb(54,54,54);\\\">Terms &amp; Conditions for Users<\\/h3><p class=\\\"font-18\\\" style=\\\"margin-right:0px;margin-left:0px;font-size:18px;\\\">Before getting to this site, you are consenting to be limited by these site Terms and Conditions of Use, every single appropriate law, and guidelines, and concur that you are answerable for consistency with any material neighborhood laws. If you disagree with any of these terms, you are restricted from utilizing or getting to this site.<\\/p><\\/div><div class=\\\"mb-5\\\" style=\\\"color:rgb(111,111,111);font-family:Nunito, sans-serif;margin-bottom:3rem;\\\"><h3 class=\\\"mb-3\\\" style=\\\"font-weight:600;line-height:1.3;font-size:24px;font-family:Exo, sans-serif;color:rgb(54,54,54);\\\">Support<\\/h3><p class=\\\"font-18\\\" style=\\\"margin-right:0px;margin-left:0px;font-size:18px;\\\">Whenever you have downloaded our item, you may get in touch with us for help through email and we will give a valiant effort to determine your issue. We will attempt to answer using the Email for more modest bug fixes, after which we will refresh the center bundle. Content help is offered to confirmed clients by Tickets as it were. Backing demands made by email and Livechat.<\\/p><p class=\\\"my-3 font-18 font-weight-bold\\\" style=\\\"margin-right:0px;margin-left:0px;font-size:18px;\\\">On the off chance that your help requires extra adjustment of the System, at that point, you have two alternatives:<\\/p><ul class=\\\"font-18\\\" style=\\\"padding-left:15px;list-style-type:disc;font-size:18px;\\\"><li style=\\\"margin-top:0px;margin-right:0px;margin-left:0px;\\\">Hang tight for additional update discharge.<\\/li><li style=\\\"margin-top:0px;margin-right:0px;margin-left:0px;\\\">Or on the other hand, enlist a specialist (We offer customization for extra charges).<\\/li><\\/ul><\\/div><div class=\\\"mb-5\\\" style=\\\"color:rgb(111,111,111);font-family:Nunito, sans-serif;margin-bottom:3rem;\\\"><h3 class=\\\"mb-3\\\" style=\\\"font-weight:600;line-height:1.3;font-size:24px;font-family:Exo, sans-serif;color:rgb(54,54,54);\\\">Ownership<\\/h3><p class=\\\"font-18\\\" style=\\\"margin-right:0px;margin-left:0px;font-size:18px;\\\">You may not guarantee scholarly or selective possession of any of our items, altered or unmodified. All items are property, we created them. Our items are given \\\"with no guarantees\\\" without guarantee of any sort, either communicated or suggested. On no occasion will our juridical individual be subject to any harms including, however not restricted to, immediate, roundabout, extraordinary, accidental, or significant harms or different misfortunes emerging out of the utilization of or powerlessness to utilize our items.<\\/p><\\/div><div class=\\\"mb-5\\\" style=\\\"color:rgb(111,111,111);font-family:Nunito, sans-serif;margin-bottom:3rem;\\\"><h3 class=\\\"mb-3\\\" style=\\\"font-weight:600;line-height:1.3;font-size:24px;font-family:Exo, sans-serif;color:rgb(54,54,54);\\\">Warranty<\\/h3><p class=\\\"font-18\\\" style=\\\"margin-right:0px;margin-left:0px;font-size:18px;\\\">We don\'t offer any guarantee or assurance of these Services in any way. When our Services have been modified we can\'t ensure they will work with all outsider plugins, modules, or internet browsers. Program similarity ought to be tried against the show formats on the demo worker. If you don\'t mind guarantee that the programs you use will work with the component, as we can not ensure that our systems will work with all program mixes.<\\/p><\\/div><div class=\\\"mb-5\\\" style=\\\"color:rgb(111,111,111);font-family:Nunito, sans-serif;margin-bottom:3rem;\\\"><h3 class=\\\"mb-3\\\" style=\\\"font-weight:600;line-height:1.3;font-size:24px;font-family:Exo, sans-serif;color:rgb(54,54,54);\\\">Unauthorized\\/Illegal Usage<\\/h3><p class=\\\"font-18\\\" style=\\\"margin-right:0px;margin-left:0px;font-size:18px;\\\">You may not utilize our things for any illicit or unapproved reason or may you, in the utilization of the stage, disregard any laws in your locale (counting yet not restricted to copyright laws) just as the laws of your nation and International law. Specifically, it is disallowed to utilize the things on our foundation for pages that advance: brutality, illegal intimidation, hard sexual entertainment, bigotry, obscenity content or warez programming joins.<br \\/><br \\/>You can\'t imitate, copy, duplicate, sell, exchange or adventure any of our segment, utilization of the offered on our things, or admittance to the administration without the express composed consent by us or item proprietor.<br \\/><br \\/>Our Members are liable for all substance posted on the discussion and demo and movement that happens under your record.<br \\/><br \\/>We hold the chance of hindering your participation account quickly if we will think about a particularly not allowed conduct.<br \\/><br \\/>If you make a record on our site, you are liable for keeping up the security of your record, and you are completely answerable for all exercises that happen under the record and some other activities taken regarding the record. You should quickly inform us, of any unapproved employments of your record or some other penetrates of security.<\\/p><\\/div><div class=\\\"mb-5\\\" style=\\\"color:rgb(111,111,111);font-family:Nunito, sans-serif;margin-bottom:3rem;\\\"><h3 class=\\\"mb-3\\\" style=\\\"font-weight:600;line-height:1.3;font-size:24px;font-family:Exo, sans-serif;color:rgb(54,54,54);\\\">Fiverr, Seoclerks Sellers Or Affiliates<\\/h3><p class=\\\"font-18\\\" style=\\\"margin-right:0px;margin-left:0px;font-size:18px;\\\">We do NOT ensure full SEO campaign conveyance within 24 hours. We make no assurance for conveyance time by any means. We give our best assessment to orders during the putting in of requests, anyway, these are gauges. We won\'t be considered liable for loss of assets, negative surveys or you being prohibited for late conveyance. If you are selling on a site that requires time touchy outcomes, utilize Our SEO Services at your own risk.<\\/p><\\/div><div class=\\\"mb-5\\\" style=\\\"color:rgb(111,111,111);font-family:Nunito, sans-serif;margin-bottom:3rem;\\\"><h3 class=\\\"mb-3\\\" style=\\\"font-weight:600;line-height:1.3;font-size:24px;font-family:Exo, sans-serif;color:rgb(54,54,54);\\\">Payment\\/Refund Policy<\\/h3><p class=\\\"font-18\\\" style=\\\"margin-right:0px;margin-left:0px;font-size:18px;\\\">No refund or cash back will be made. After a deposit has been finished, it is extremely unlikely to invert it. You should utilize your equilibrium on requests our administrations, Hosting, SEO campaign. You concur that once you complete a deposit, you won\'t document a debate or a chargeback against us in any way, shape, or form.<br \\/><br \\/>If you document a debate or chargeback against us after a deposit, we claim all authority to end every single future request, prohibit you from our site. False action, for example, utilizing unapproved or taken charge cards will prompt the end of your record. There are no special cases.<\\/p><\\/div><div class=\\\"mb-5\\\" style=\\\"color:rgb(111,111,111);font-family:Nunito, sans-serif;margin-bottom:3rem;\\\"><h3 class=\\\"mb-3\\\" style=\\\"font-weight:600;line-height:1.3;font-size:24px;font-family:Exo, sans-serif;color:rgb(54,54,54);\\\">Free Balance \\/ Coupon Policy<\\/h3><p class=\\\"font-18\\\" style=\\\"margin-right:0px;margin-left:0px;font-size:18px;\\\">We offer numerous approaches to get FREE Balance, Coupons and Deposit offers yet we generally reserve the privilege to audit it and deduct it from your record offset with any explanation we may it is a sort of misuse. If we choose to deduct a few or all of free Balance from your record balance, and your record balance becomes negative, at that point the record will naturally be suspended. If your record is suspended because of a negative Balance you can request to make a custom payment to settle your equilibrium to actuate your record.<\\/p><\\/div>\"}', '2021-08-17 04:58:42', '2021-08-17 04:58:42'),
(86, 'policies.element', '{\"title\":\"Security Policy\",\"description\":\"<h2 class=\\\"comp mntl-sc-block money-sc-block-heading mntl-sc-block-heading\\\" style=\\\"margin-top:2rem;padding:0px;font-size:1.5rem;line-height:1.2;font-family:Publico, Georgia, serif;\\\"><span class=\\\"mntl-sc-block-heading__text\\\"><font color=\\\"#000000\\\">Password\\/PIN Policy<\\/font><\\/span><\\/h2><p class=\\\"comp text-passage mntl-sc-block mntl-sc-block-html\\\" style=\\\"margin:0.5rem 0px 0.875rem;padding:0px;font-family:Rubik, Arial, sans-serif;color:rgb(34,34,34);font-size:17px;\\\">Developing a password and personal identification number policy helps ensure employees are creating their login or access credentials in a secure manner. Common guidance is to not use birthdays, names, or other information that is easily attainable.<\\/p><div class=\\\"comp mntl-sc-block mntl-sc-block-adslot mntl-block\\\" style=\\\"margin:0px;padding:0px;color:rgb(34,34,34);font-family:Rubik, Arial, sans-serif;font-size:17px;\\\"><div class=\\\"comp mntl-block\\\" style=\\\"margin:0px;padding:0px;\\\"><\\/div><\\/div><span class=\\\"heading-toc\\\" style=\\\"color:rgb(34,34,34);font-family:Rubik, Arial, sans-serif;font-size:17px;\\\"><\\/span><span style=\\\"color:rgb(34,34,34);font-family:Rubik, Arial, sans-serif;font-size:17px;\\\"><\\/span><h2 class=\\\"comp mntl-sc-block money-sc-block-heading mntl-sc-block-heading\\\" style=\\\"margin-top:2rem;padding:0px;font-size:1.5rem;line-height:1.2;font-family:Publico, Georgia, serif;\\\"><span class=\\\"mntl-sc-block-heading__text\\\"><font color=\\\"#000000\\\">Device Controls<\\/font><\\/span><\\/h2><p class=\\\"comp text-passage mntl-sc-block mntl-sc-block-html\\\" style=\\\"margin:0.5rem 0px 0.875rem;padding:0px;font-family:Rubik, Arial, sans-serif;color:rgb(34,34,34);font-size:17px;\\\">Proper methods of access to computers, tablets, and smartphones should be established to control access to information. Methods can include access card readers, passwords, and PINs.<\\/p><div class=\\\"comp mntl-sc-block mntl-sc-block-adslot mntl-block\\\" style=\\\"margin:0px;padding:0px;color:rgb(34,34,34);font-family:Rubik, Arial, sans-serif;font-size:17px;\\\"><\\/div><p class=\\\"comp text-passage mntl-sc-block mntl-sc-block-html\\\" style=\\\"margin:0.5rem 0px 0.875rem;padding:0px;font-family:Rubik, Arial, sans-serif;color:rgb(34,34,34);font-size:17px;\\\">Devices should be locked when the user steps away. Access cards should be removed, and passwords and PINs should not be written down or stored where they might be accessed.<\\/p><div class=\\\"comp mntl-sc-block mntl-sc-block-adslot mntl-block\\\" style=\\\"margin:0px;padding:0px;color:rgb(34,34,34);font-family:Rubik, Arial, sans-serif;font-size:17px;\\\"><\\/div><p class=\\\"comp text-passage mntl-sc-block mntl-sc-block-html\\\" style=\\\"margin:0.5rem 0px 0.875rem;padding:0px;font-family:Rubik, Arial, sans-serif;color:rgb(34,34,34);font-size:17px;\\\">Assess whether employees should be allowed to bring and access their own devices in the workplace or during business hours. Personal devices have the potential to distract employees from their duties, as well as create accidental breaches of information security.<\\/p><div class=\\\"comp mntl-sc-block mntl-sc-block-adslot mntl-block\\\" style=\\\"margin:0px;padding:0px;color:rgb(34,34,34);font-family:Rubik, Arial, sans-serif;font-size:17px;\\\"><\\/div><p class=\\\"comp text-passage mntl-sc-block mntl-sc-block-html\\\" style=\\\"margin:0.5rem 0px 0.875rem;padding:0px;font-family:Rubik, Arial, sans-serif;color:rgb(34,34,34);font-size:17px;\\\">As you design policies for personal device use, take employee welfare into consideration. Families and loved ones need contact with employees if there is a situation at home that requires their attention. This may mean providing a way for families to get messages to their loved ones.<\\/p><div class=\\\"comp mntl-sc-block mntl-sc-block-adslot mntl-block\\\" style=\\\"margin:0px;padding:0px;color:rgb(34,34,34);font-family:Rubik, Arial, sans-serif;font-size:17px;\\\"><\\/div><p class=\\\"comp text-passage mntl-sc-block mntl-sc-block-html\\\" style=\\\"margin:0.5rem 0px 0.875rem;padding:0px;font-family:Rubik, Arial, sans-serif;color:rgb(34,34,34);font-size:17px;\\\">Procedures for reporting loss and damage of business-related devices should be developed. You may want to include an investigation method\\u00a0to determine fault and the extent of information loss.<\\/p><div class=\\\"comp mntl-sc-block mntl-sc-block-adslot mntl-block\\\" style=\\\"margin:0px;padding:0px;color:rgb(34,34,34);font-family:Rubik, Arial, sans-serif;font-size:17px;\\\"><div class=\\\"comp mntl-block\\\" style=\\\"margin:0px;padding:0px;\\\"><div class=\\\"comp mntl-native\\\" style=\\\"margin:0px;padding:0px;width:672px;\\\"><\\/div><\\/div><\\/div><span class=\\\"heading-toc\\\" style=\\\"color:rgb(34,34,34);font-family:Rubik, Arial, sans-serif;font-size:17px;\\\"><\\/span><span style=\\\"color:rgb(34,34,34);font-family:Rubik, Arial, sans-serif;font-size:17px;\\\"><\\/span><h2 class=\\\"comp mntl-sc-block money-sc-block-heading mntl-sc-block-heading\\\" style=\\\"margin-top:2rem;padding:0px;font-size:1.5rem;line-height:1.2;font-family:Publico, Georgia, serif;\\\"><span class=\\\"mntl-sc-block-heading__text\\\"><font color=\\\"#000000\\\">Internet\\/Web Usage<\\/font><\\/span><\\/h2><p class=\\\"comp text-passage mntl-sc-block mntl-sc-block-html\\\" style=\\\"margin:0.5rem 0px 0.875rem;padding:0px;font-family:Rubik, Arial, sans-serif;color:rgb(34,34,34);font-size:17px;\\\">Internet access in the workplace should be restricted to business needs only. Not only does personal web use tie up resources, but it also introduces the risks of viruses and can give hackers access to information.<\\/p><div class=\\\"comp mntl-sc-block mntl-sc-block-adslot mntl-block\\\" style=\\\"margin:0px;padding:0px;color:rgb(34,34,34);font-family:Rubik, Arial, sans-serif;font-size:17px;\\\"><div class=\\\"comp mntl-block\\\" style=\\\"margin:0px;padding:0px;\\\"><\\/div><\\/div><p class=\\\"comp text-passage mntl-sc-block mntl-sc-block-html\\\" style=\\\"margin:0.5rem 0px 0.875rem;padding:0px;font-family:Rubik, Arial, sans-serif;color:rgb(34,34,34);font-size:17px;\\\">Email should be conducted through business email servers and clients only unless your business is built around a model that doesn\'t allow for it.<\\/p><div class=\\\"comp mntl-sc-block mntl-sc-block-adslot mntl-block\\\" style=\\\"margin:0px;padding:0px;color:rgb(34,34,34);font-family:Rubik, Arial, sans-serif;font-size:17px;\\\"><div class=\\\"comp mntl-block\\\" style=\\\"margin:0px;padding:0px;\\\"><\\/div><\\/div><p class=\\\"comp text-passage mntl-sc-block mntl-sc-block-html\\\" style=\\\"margin:0.5rem 0px 0.875rem;padding:0px;font-family:Rubik, Arial, sans-serif;color:rgb(34,34,34);font-size:17px;\\\">Many scams and attempts to infiltrate businesses are initiated through email. Guidance for dealing with links, apparent phishing attempts, or emails from unknown sources is recommended.<\\/p><div class=\\\"comp mntl-sc-block mntl-sc-block-adslot mntl-block\\\" style=\\\"margin:0px;padding:0px;color:rgb(34,34,34);font-family:Rubik, Arial, sans-serif;font-size:17px;\\\"><div class=\\\"comp mntl-block\\\" style=\\\"margin:0px;padding:0px;\\\"><\\/div><\\/div><p class=\\\"comp text-passage mntl-sc-block mntl-sc-block-html\\\" style=\\\"margin:0.5rem 0px 0.875rem;padding:0px;font-family:Rubik, Arial, sans-serif;color:rgb(34,34,34);font-size:17px;\\\">Develop agreements with employees that will minimize the risk of workplace information exposure through social media or other personal networking sites, unless it is business-related.<\\/p><div class=\\\"comp mntl-sc-block mntl-sc-block-adslot mntl-block\\\" style=\\\"margin:0px;padding:0px;color:rgb(34,34,34);font-family:Rubik, Arial, sans-serif;font-size:17px;\\\"><div class=\\\"comp mntl-block\\\" style=\\\"margin:0px;padding:0px;\\\"><\\/div><\\/div><span class=\\\"heading-toc\\\" style=\\\"color:rgb(34,34,34);font-family:Rubik, Arial, sans-serif;font-size:17px;\\\"><\\/span><span style=\\\"color:rgb(34,34,34);font-family:Rubik, Arial, sans-serif;font-size:17px;\\\"><\\/span><h2 class=\\\"comp mntl-sc-block money-sc-block-heading mntl-sc-block-heading\\\" style=\\\"margin-top:2rem;padding:0px;font-size:1.5rem;line-height:1.2;font-family:Publico, Georgia, serif;\\\"><span class=\\\"mntl-sc-block-heading__text\\\"><font color=\\\"#000000\\\">Encryption and Physical Security<\\/font><\\/span><\\/h2><p class=\\\"comp text-passage mntl-sc-block mntl-sc-block-html\\\" style=\\\"margin:0.5rem 0px 0.875rem;padding:0px;font-family:Rubik, Arial, sans-serif;color:rgb(34,34,34);font-size:17px;\\\">You may want to develop encryption procedures for your information. If your business has information such as client credit card numbers stored in a database, encrypting the files adds an extra measure of protection.<\\/p><div class=\\\"comp mntl-sc-block mntl-sc-block-adslot mntl-block\\\" style=\\\"margin:0px;padding:0px;color:rgb(34,34,34);font-family:Rubik, Arial, sans-serif;font-size:17px;\\\"><\\/div><p class=\\\"comp text-passage mntl-sc-block mntl-sc-block-html\\\" style=\\\"margin:0.5rem 0px 0.875rem;padding:0px;font-family:Rubik, Arial, sans-serif;color:rgb(34,34,34);font-size:17px;\\\">Key and key card control procedures such as key issue logs or separate keys for different areas can help control access to information storage areas.<\\/p><div class=\\\"comp mntl-sc-block mntl-sc-block-adslot mntl-block\\\" style=\\\"margin:0px;padding:0px;color:rgb(34,34,34);font-family:Rubik, Arial, sans-serif;font-size:17px;\\\"><\\/div><p class=\\\"comp text-passage mntl-sc-block mntl-sc-block-html\\\" style=\\\"margin:0.5rem 0px 0.875rem;padding:0px;font-family:Rubik, Arial, sans-serif;color:rgb(34,34,34);font-size:17px;\\\">If identification is needed, develop a method of issuing, logging, displaying, and periodically inspecting identification.<\\/p><div class=\\\"comp mntl-sc-block mntl-sc-block-adslot mntl-block\\\" style=\\\"margin:0px;padding:0px;color:rgb(34,34,34);font-family:Rubik, Arial, sans-serif;font-size:17px;\\\"><\\/div><p class=\\\"comp text-passage mntl-sc-block mntl-sc-block-html\\\" style=\\\"margin:0.5rem 0px 0.875rem;padding:0px;font-family:Rubik, Arial, sans-serif;color:rgb(34,34,34);font-size:17px;\\\">Establish a visitor procedure. Visitor check-in, access badges, and logs will keep unnecessary visitations in check.<\\/p><div class=\\\"comp mntl-sc-block mntl-sc-block-adslot mntl-block\\\" style=\\\"margin:0px;padding:0px;color:rgb(34,34,34);font-family:Rubik, Arial, sans-serif;font-size:17px;\\\"><\\/div><span class=\\\"heading-toc\\\" style=\\\"color:rgb(34,34,34);font-family:Rubik, Arial, sans-serif;font-size:17px;\\\"><\\/span><span style=\\\"color:rgb(34,34,34);font-family:Rubik, Arial, sans-serif;font-size:17px;\\\"><\\/span><h2 class=\\\"comp mntl-sc-block money-sc-block-heading mntl-sc-block-heading\\\" style=\\\"margin-top:2rem;padding:0px;font-size:1.5rem;line-height:1.2;font-family:Publico, Georgia, serif;\\\"><span class=\\\"mntl-sc-block-heading__text\\\"><font color=\\\"#000000\\\">Security Policy Reporting Requirements<\\/font><\\/span><\\/h2><p class=\\\"comp text-passage mntl-sc-block mntl-sc-block-html\\\" style=\\\"margin:0.5rem 0px 0.875rem;padding:0px;font-family:Rubik, Arial, sans-serif;color:rgb(34,34,34);font-size:17px;\\\">Employees need to understand what they need to report, how they need to report it, and who to report it to. Clear instructions should be published. Training should be implemented into the policy and be conducted to ensure all employees understand reporting procedures.<\\/p><div class=\\\"comp mntl-sc-block mntl-sc-block-adslot mntl-block\\\" style=\\\"margin:0px;padding:0px;color:rgb(34,34,34);font-family:Rubik, Arial, sans-serif;font-size:17px;\\\"><\\/div><span class=\\\"heading-toc\\\" style=\\\"color:rgb(34,34,34);font-family:Rubik, Arial, sans-serif;font-size:17px;\\\"><\\/span><span style=\\\"color:rgb(34,34,34);font-family:Rubik, Arial, sans-serif;font-size:17px;\\\"><\\/span><h2 class=\\\"comp mntl-sc-block money-sc-block-heading mntl-sc-block-heading\\\" style=\\\"margin-top:2rem;padding:0px;font-size:1.5rem;line-height:1.2;font-family:Publico, Georgia, serif;\\\"><span class=\\\"mntl-sc-block-heading__text\\\"><font color=\\\"#000000\\\">Empower Your Team<\\/font><\\/span><\\/h2><p class=\\\"comp text-passage mntl-sc-block mntl-sc-block-html\\\" style=\\\"margin:0.5rem 0px 0.875rem;padding:0px;font-family:Rubik, Arial, sans-serif;color:rgb(34,34,34);font-size:17px;\\\">One key to creating effective policies is to make sure that the policies are clear, easy to comply with, and realistic. Policies that are overly complicated or controlling will encourage people to bypass the system. If you communicate the need for information security and empower your employees to act if they discover a security issue, you will develop a secure environment where information is safe.<\\/p>\"}', '2021-08-17 05:01:31', '2021-08-21 06:10:22'),
(87, 'social_icon.element', '{\"title\":\"Twitter\",\"social_icon\":\"<i class=\\\"lab la-twitter\\\"><\\/i>\",\"url\":\"https:\\/\\/twitter.com\"}', '2021-08-17 05:18:33', '2021-08-17 05:18:33'),
(88, 'social_icon.element', '{\"title\":\"LinkedIn\",\"social_icon\":\"<i class=\\\"fab fa-linkedin-in\\\"><\\/i>\",\"url\":\"https:\\/\\/linkedin.com\"}', '2021-08-17 05:19:16', '2021-08-17 05:19:16'),
(89, 'social_icon.element', '{\"title\":\"Pinterest\",\"social_icon\":\"<i class=\\\"fab fa-pinterest-p\\\"><\\/i>\",\"url\":\"https:\\/\\/pinterest.com\"}', '2021-08-17 05:19:40', '2021-08-17 05:19:40'),
(90, 'blog.element', '{\"has_image\":[\"1\"],\"title\":\"Mollitia saepe ipsam nihil soluta\",\"description_nic\":\"<h2 class=\\\"blog-details-title mb-3\\\" style=\\\"line-height:1.2;font-family:\'Maven Pro\', sans-serif;color:rgb(55,62,74);\\\"><span style=\\\"color:rgb(102,102,102);font-family:arial;text-align:justify;\\\"><font size=\\\"3\\\">Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur? At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere<\\/font><\\/span><br \\/><\\/h2>\",\"blog_image\":\"611e2294421811629364884.jpg\"}', '2021-08-19 08:51:24', '2021-08-19 08:51:24'),
(91, 'agent_login.content', '{\"has_image\":\"1\",\"background_image\":\"6124cc14cabf41629801492.jpg\"}', '2021-08-24 09:13:27', '2021-08-24 10:08:13'),
(92, 'merchant_login.content', '{\"has_image\":\"1\",\"background_image\":\"6124bf70515351629798256.jpg\"}', '2021-08-24 09:14:16', '2021-08-24 09:14:16');
INSERT INTO `frontends` (`id`, `data_keys`, `data_values`, `created_at`, `updated_at`) VALUES
(93, 'blog.element', '{\"has_image\":[\"1\"],\"title\":\"Mollitia saepe ipsam nihil soluta quaerat vitae commodi placeat.\",\"description_nic\":\"<div style=\\\"text-align:justify;\\\"><span style=\\\"font-size:medium;color:rgb(102,102,102);\\\"><font face=\\\"arial\\\">Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur? At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere<\\/font><\\/span><\\/div>\",\"blog_image\":\"61756460ca6301635083360.jpg\"}', '2021-06-08 12:23:00', '2021-10-24 07:49:20'),
(94, 'blog.element', '{\"has_image\":[\"1\"],\"title\":\"Mollitia saepe ipsam nihil soluta quaerat vitae commodi placeat.\",\"description_nic\":\"<div style=\\\"text-align:justify;\\\"><span style=\\\"font-size:medium;color:rgb(102,102,102);\\\"><font face=\\\"arial\\\">Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur? At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere<\\/font><\\/span><\\/div>\",\"blog_image\":\"6175649507ef71635083413.jpg\"}', '2021-06-08 12:23:00', '2021-10-24 07:50:13'),
(95, 'blog.element', '{\"has_image\":[\"1\"],\"title\":\"Mollitia saepe ipsam nihil soluta quaerat vitae commodi placeat.\",\"description_nic\":\"<div style=\\\"text-align:justify;\\\"><span style=\\\"font-size:medium;color:rgb(102,102,102);\\\"><font face=\\\"arial\\\">Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis et quasi architecto beatae vitae dicta sunt explicabo. Nemo enim ipsam voluptatem quia voluptas sit aspernatur aut odit aut fugit, sed quia consequuntur magni dolores eos qui ratione voluptatem sequi nesciunt. Neque porro quisquam est, qui dolorem ipsum quia dolor sit amet, consectetur, adipisci velit, sed quia non numquam eius modi tempora incidunt ut labore et dolore magnam aliquam quaerat voluptatem. Ut enim ad minima veniam, quis nostrum exercitationem ullam corporis suscipit laboriosam, nisi ut aliquid ex ea commodi consequatur? Quis autem vel eum iure reprehenderit qui in ea voluptate velit esse quam nihil molestiae consequatur, vel illum qui dolorem eum fugiat quo voluptas nulla pariatur? At vero eos et accusamus et iusto odio dignissimos ducimus qui blanditiis praesentium voluptatum deleniti atque corrupti quos dolores et quas molestias excepturi sint occaecati cupiditate non provident, similique sunt in culpa qui officia deserunt mollitia animi, id est laborum et dolorum fuga. Et harum quidem rerum facilis est et expedita distinctio. Nam libero tempore, cum soluta nobis est eligendi optio cumque nihil impedit quo minus id quod maxime placeat facere<\\/font><\\/span><\\/div>\",\"blog_image\":\"617564b4438a71635083444.jpg\"}', '2021-06-08 12:23:00', '2021-10-24 07:50:44'),
(96, 'service.element', '{\"service_icon\":\"<i class=\\\"las la-cloud-download-alt\\\"><\\/i>\",\"title\":\"Cash Out\",\"description\":\"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis\"}', '2021-10-24 08:38:55', '2021-10-24 08:40:04'),
(97, 'service.element', '{\"service_icon\":\"<i class=\\\"las la-cloud-upload-alt\\\"><\\/i>\",\"title\":\"Cash in\",\"description\":\"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis\"}', '2021-10-24 08:39:08', '2021-10-24 08:43:43'),
(98, 'service.element', '{\"service_icon\":\"<i class=\\\"fas fa-qrcode\\\"><\\/i>\",\"title\":\"Make Payment\",\"description\":\"Sed ut perspiciatis unde omnis iste natus error sit voluptatem accusantium doloremque laudantium, totam rem aperiam, eaque ipsa quae ab illo inventore veritatis\"}', '2021-10-24 08:41:19', '2021-10-24 08:41:19'),
(101, 'brands.element', '{\"has_image\":\"1\",\"brand_logo\":\"61757400817021635087360.png\"}', '2021-10-24 08:56:00', '2021-10-24 08:56:00'),
(102, 'brands.element', '{\"has_image\":\"1\",\"brand_logo\":\"61757414ed9e91635087380.png\"}', '2021-10-24 08:56:20', '2021-10-24 08:56:21'),
(103, 'brands.element', '{\"has_image\":\"1\",\"brand_logo\":\"6175743fbc2831635087423.png\"}', '2021-10-24 08:57:03', '2021-10-24 08:57:03'),
(104, 'brands.element', '{\"has_image\":\"1\",\"brand_logo\":\"617574ca34c391635087562.png\"}', '2021-10-24 08:57:26', '2021-10-24 08:59:22'),
(107, 'business.element', '{\"has_image\":\"1\",\"client_logo\":\"6175771fbe0fc1635088159.png\"}', '2021-10-24 09:09:19', '2021-10-24 09:09:19');

-- --------------------------------------------------------

--
-- Table structure for table `gateways`
--

CREATE TABLE `gateways` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `code` int(10) DEFAULT NULL,
  `name` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `alias` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL DEFAULT 'NULL',
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '1=>enable, 2=>disable',
  `gateway_parameters` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `supported_currencies` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `crypto` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0: fiat currency, 1: crypto currency',
  `extra` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `input_form` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `gateways`
--

INSERT INTO `gateways` (`id`, `code`, `name`, `alias`, `image`, `status`, `gateway_parameters`, `supported_currencies`, `crypto`, `extra`, `description`, `input_form`, `created_at`, `updated_at`) VALUES
(1, 101, 'Paypal', 'Paypal', '5f6f1bd8678601601117144.jpg', 1, '{\"paypal_email\":{\"title\":\"PayPal Email\",\"global\":true,\"value\":\"sb-owud61543012@business.example.com\"}}', '{\"AUD\":\"AUD\",\"BRL\":\"BRL\",\"CAD\":\"CAD\",\"CZK\":\"CZK\",\"DKK\":\"DKK\",\"EUR\":\"EUR\",\"HKD\":\"HKD\",\"HUF\":\"HUF\",\"INR\":\"INR\",\"ILS\":\"ILS\",\"JPY\":\"JPY\",\"MYR\":\"MYR\",\"MXN\":\"MXN\",\"TWD\":\"TWD\",\"NZD\":\"NZD\",\"NOK\":\"NOK\",\"PHP\":\"PHP\",\"PLN\":\"PLN\",\"GBP\":\"GBP\",\"RUB\":\"RUB\",\"SGD\":\"SGD\",\"SEK\":\"SEK\",\"CHF\":\"CHF\",\"THB\":\"THB\",\"USD\":\"USD\"}', 0, NULL, NULL, NULL, '2019-09-14 13:14:22', '2021-05-21 00:04:38'),
(2, 102, 'Perfect Money', 'PerfectMoney', '5f6f1d2a742211601117482.jpg', 1, '{\"passphrase\":{\"title\":\"ALTERNATE PASSPHRASE\",\"global\":true,\"value\":\"hR26aw02Q1eEeUPSIfuwNypXX\"},\"wallet_id\":{\"title\":\"PM Wallet\",\"global\":false,\"value\":\"\"}}', '{\"USD\":\"$\",\"EUR\":\"\\u20ac\"}', 0, NULL, NULL, NULL, '2019-09-14 13:14:22', '2021-05-21 01:35:33'),
(3, 103, 'Stripe Hosted', 'Stripe', '5f6f1d4bc69e71601117515.jpg', 1, '{\"secret_key\":{\"title\":\"Secret Key\",\"global\":true,\"value\":\"sk_test_51I6GGiCGv1sRiQlEi5v1or9eR0HVbuzdMd2rW4n3DxC8UKfz66R4X6n4yYkzvI2LeAIuRU9H99ZpY7XCNFC9xMs500vBjZGkKG\"},\"publishable_key\":{\"title\":\"PUBLISHABLE KEY\",\"global\":true,\"value\":\"pk_test_51I6GGiCGv1sRiQlEOisPKrjBqQqqcFsw8mXNaZ2H2baN6R01NulFS7dKFji1NRRxuchoUTEDdB7ujKcyKYSVc0z500eth7otOM\"}}', '{\"USD\":\"USD\",\"AUD\":\"AUD\",\"BRL\":\"BRL\",\"CAD\":\"CAD\",\"CHF\":\"CHF\",\"DKK\":\"DKK\",\"EUR\":\"EUR\",\"GBP\":\"GBP\",\"HKD\":\"HKD\",\"INR\":\"INR\",\"JPY\":\"JPY\",\"MXN\":\"MXN\",\"MYR\":\"MYR\",\"NOK\":\"NOK\",\"NZD\":\"NZD\",\"PLN\":\"PLN\",\"SEK\":\"SEK\",\"SGD\":\"SGD\"}', 0, NULL, NULL, NULL, '2019-09-14 13:14:22', '2021-05-21 00:48:36'),
(4, 104, 'Skrill', 'Skrill', '5f6f1d41257181601117505.jpg', 1, '{\"pay_to_email\":{\"title\":\"Skrill Email\",\"global\":true,\"value\":\"merchant@skrill.com\"},\"secret_key\":{\"title\":\"Secret Key\",\"global\":true,\"value\":\"---\"}}', '{\"AED\":\"AED\",\"AUD\":\"AUD\",\"BGN\":\"BGN\",\"BHD\":\"BHD\",\"CAD\":\"CAD\",\"CHF\":\"CHF\",\"CZK\":\"CZK\",\"DKK\":\"DKK\",\"EUR\":\"EUR\",\"GBP\":\"GBP\",\"HKD\":\"HKD\",\"HRK\":\"HRK\",\"HUF\":\"HUF\",\"ILS\":\"ILS\",\"INR\":\"INR\",\"ISK\":\"ISK\",\"JOD\":\"JOD\",\"JPY\":\"JPY\",\"KRW\":\"KRW\",\"KWD\":\"KWD\",\"MAD\":\"MAD\",\"MYR\":\"MYR\",\"NOK\":\"NOK\",\"NZD\":\"NZD\",\"OMR\":\"OMR\",\"PLN\":\"PLN\",\"QAR\":\"QAR\",\"RON\":\"RON\",\"RSD\":\"RSD\",\"SAR\":\"SAR\",\"SEK\":\"SEK\",\"SGD\":\"SGD\",\"THB\":\"THB\",\"TND\":\"TND\",\"TRY\":\"TRY\",\"TWD\":\"TWD\",\"USD\":\"USD\",\"ZAR\":\"ZAR\",\"COP\":\"COP\"}', 0, NULL, NULL, NULL, '2019-09-14 13:14:22', '2021-05-21 01:30:16'),
(5, 105, 'PayTM', 'Paytm', '5f6f1d1d3ec731601117469.jpg', 1, '{\"MID\":{\"title\":\"Merchant ID\",\"global\":true,\"value\":\"DIY12386817555501617\"},\"merchant_key\":{\"title\":\"Merchant Key\",\"global\":true,\"value\":\"bKMfNxPPf_QdZppa\"},\"WEBSITE\":{\"title\":\"Paytm Website\",\"global\":true,\"value\":\"DIYtestingweb\"},\"INDUSTRY_TYPE_ID\":{\"title\":\"Industry Type\",\"global\":true,\"value\":\"Retail\"},\"CHANNEL_ID\":{\"title\":\"CHANNEL ID\",\"global\":true,\"value\":\"WEB\"},\"transaction_url\":{\"title\":\"Transaction URL\",\"global\":true,\"value\":\"https:\\/\\/pguat.paytm.com\\/oltp-web\\/processTransaction\"},\"transaction_status_url\":{\"title\":\"Transaction STATUS URL\",\"global\":true,\"value\":\"https:\\/\\/pguat.paytm.com\\/paytmchecksum\\/paytmCallback.jsp\"}}', '{\"AUD\":\"AUD\",\"ARS\":\"ARS\",\"BDT\":\"BDT\",\"BRL\":\"BRL\",\"BGN\":\"BGN\",\"CAD\":\"CAD\",\"CLP\":\"CLP\",\"CNY\":\"CNY\",\"COP\":\"COP\",\"HRK\":\"HRK\",\"CZK\":\"CZK\",\"DKK\":\"DKK\",\"EGP\":\"EGP\",\"EUR\":\"EUR\",\"GEL\":\"GEL\",\"GHS\":\"GHS\",\"HKD\":\"HKD\",\"HUF\":\"HUF\",\"INR\":\"INR\",\"IDR\":\"IDR\",\"ILS\":\"ILS\",\"JPY\":\"JPY\",\"KES\":\"KES\",\"MYR\":\"MYR\",\"MXN\":\"MXN\",\"MAD\":\"MAD\",\"NPR\":\"NPR\",\"NZD\":\"NZD\",\"NGN\":\"NGN\",\"NOK\":\"NOK\",\"PKR\":\"PKR\",\"PEN\":\"PEN\",\"PHP\":\"PHP\",\"PLN\":\"PLN\",\"RON\":\"RON\",\"RUB\":\"RUB\",\"SGD\":\"SGD\",\"ZAR\":\"ZAR\",\"KRW\":\"KRW\",\"LKR\":\"LKR\",\"SEK\":\"SEK\",\"CHF\":\"CHF\",\"THB\":\"THB\",\"TRY\":\"TRY\",\"UGX\":\"UGX\",\"UAH\":\"UAH\",\"AED\":\"AED\",\"GBP\":\"GBP\",\"USD\":\"USD\",\"VND\":\"VND\",\"XOF\":\"XOF\"}', 0, NULL, NULL, NULL, '2019-09-14 13:14:22', '2021-05-21 03:00:44'),
(6, 106, 'Payeer', 'Payeer', '5f6f1bc61518b1601117126.jpg', 0, '{\"merchant_id\":{\"title\":\"Merchant ID\",\"global\":true,\"value\":\"866989763\"},\"secret_key\":{\"title\":\"Secret key\",\"global\":true,\"value\":\"7575\"}}', '{\"USD\":\"USD\",\"EUR\":\"EUR\",\"RUB\":\"RUB\"}', 0, '{\"status\":{\"title\": \"Status URL\",\"value\":\"ipn.Payeer\"}}', NULL, NULL, '2019-09-14 13:14:22', '2020-12-28 01:26:58'),
(7, 107, 'PayStack', 'Paystack', '5f7096563dfb71601214038.jpg', 1, '{\"public_key\":{\"title\":\"Public key\",\"global\":true,\"value\":\"pk_test_cd330608eb47970889bca397ced55c1dd5ad3783\"},\"secret_key\":{\"title\":\"Secret key\",\"global\":true,\"value\":\"sk_test_8a0b1f199362d7acc9c390bff72c4e81f74e2ac3\"}}', '{\"USD\":\"USD\",\"NGN\":\"NGN\"}', 0, '{\"callback\":{\"title\": \"Callback URL\",\"value\":\"ipn.Paystack\"},\"webhook\":{\"title\": \"Webhook URL\",\"value\":\"ipn.Paystack\"}}\r\n', NULL, NULL, '2019-09-14 13:14:22', '2021-05-21 01:49:51'),
(8, 108, 'VoguePay', 'Voguepay', '5f6f1d5951a111601117529.jpg', 1, '{\"merchant_id\":{\"title\":\"MERCHANT ID\",\"global\":true,\"value\":\"demo\"}}', '{\"USD\":\"USD\",\"GBP\":\"GBP\",\"EUR\":\"EUR\",\"GHS\":\"GHS\",\"NGN\":\"NGN\",\"ZAR\":\"ZAR\"}', 0, NULL, NULL, NULL, '2019-09-14 13:14:22', '2021-05-21 01:22:38'),
(9, 109, 'Flutterwave', 'Flutterwave', '5f6f1b9e4bb961601117086.jpg', 1, '{\"public_key\":{\"title\":\"Public Key\",\"global\":true,\"value\":\"----------------\"},\"secret_key\":{\"title\":\"Secret Key\",\"global\":true,\"value\":\"-----------------------\"},\"encryption_key\":{\"title\":\"Encryption Key\",\"global\":true,\"value\":\"------------------\"}}', '{\"BIF\":\"BIF\",\"CAD\":\"CAD\",\"CDF\":\"CDF\",\"CVE\":\"CVE\",\"EUR\":\"EUR\",\"GBP\":\"GBP\",\"GHS\":\"GHS\",\"GMD\":\"GMD\",\"GNF\":\"GNF\",\"KES\":\"KES\",\"LRD\":\"LRD\",\"MWK\":\"MWK\",\"MZN\":\"MZN\",\"NGN\":\"NGN\",\"RWF\":\"RWF\",\"SLL\":\"SLL\",\"STD\":\"STD\",\"TZS\":\"TZS\",\"UGX\":\"UGX\",\"USD\":\"USD\",\"XAF\":\"XAF\",\"XOF\":\"XOF\",\"ZMK\":\"ZMK\",\"ZMW\":\"ZMW\",\"ZWD\":\"ZWD\"}', 0, NULL, NULL, NULL, '2019-09-14 13:14:22', '2021-06-05 11:37:45'),
(10, 110, 'RazorPay', 'Razorpay', '5f6f1d3672dd61601117494.jpg', 1, '{\"key_id\":{\"title\":\"Key Id\",\"global\":true,\"value\":\"rzp_test_kiOtejPbRZU90E\"},\"key_secret\":{\"title\":\"Key Secret \",\"global\":true,\"value\":\"osRDebzEqbsE1kbyQJ4y0re7\"}}', '{\"INR\":\"INR\"}', 0, NULL, NULL, NULL, '2019-09-14 13:14:22', '2021-05-21 02:51:32'),
(11, 111, 'Stripe Storefront', 'StripeJs', '5f7096a31ed9a1601214115.jpg', 1, '{\"secret_key\":{\"title\":\"Secret Key\",\"global\":true,\"value\":\"sk_test_51I6GGiCGv1sRiQlEi5v1or9eR0HVbuzdMd2rW4n3DxC8UKfz66R4X6n4yYkzvI2LeAIuRU9H99ZpY7XCNFC9xMs500vBjZGkKG\"},\"publishable_key\":{\"title\":\"PUBLISHABLE KEY\",\"global\":true,\"value\":\"pk_test_51I6GGiCGv1sRiQlEOisPKrjBqQqqcFsw8mXNaZ2H2baN6R01NulFS7dKFji1NRRxuchoUTEDdB7ujKcyKYSVc0z500eth7otOM\"}}', '{\"USD\":\"USD\",\"AUD\":\"AUD\",\"BRL\":\"BRL\",\"CAD\":\"CAD\",\"CHF\":\"CHF\",\"DKK\":\"DKK\",\"EUR\":\"EUR\",\"GBP\":\"GBP\",\"HKD\":\"HKD\",\"INR\":\"INR\",\"JPY\":\"JPY\",\"MXN\":\"MXN\",\"MYR\":\"MYR\",\"NOK\":\"NOK\",\"NZD\":\"NZD\",\"PLN\":\"PLN\",\"SEK\":\"SEK\",\"SGD\":\"SGD\"}', 0, NULL, NULL, NULL, '2019-09-14 13:14:22', '2021-05-21 00:53:10'),
(12, 112, 'Instamojo', 'Instamojo', '5f6f1babbdbb31601117099.jpg', 1, '{\"api_key\":{\"title\":\"API KEY\",\"global\":true,\"value\":\"test_2241633c3bc44a3de84a3b33969\"},\"auth_token\":{\"title\":\"Auth Token\",\"global\":true,\"value\":\"test_279f083f7bebefd35217feef22d\"},\"salt\":{\"title\":\"Salt\",\"global\":true,\"value\":\"19d38908eeff4f58b2ddda2c6d86ca25\"}}', '{\"INR\":\"INR\"}', 0, NULL, NULL, NULL, '2019-09-14 13:14:22', '2021-05-21 02:56:20'),
(13, 501, 'Blockchain', 'Blockchain', '5f6f1b2b20c6f1601116971.jpg', 1, '{\"api_key\":{\"title\":\"API Key\",\"global\":true,\"value\":\"55529946-05ca-48ff-8710-f279d86b1cc5\"},\"xpub_code\":{\"title\":\"XPUB CODE\",\"global\":true,\"value\":\"xpub6CKQ3xxWyBoFAF83izZCSFUorptEU9AF8TezhtWeMU5oefjX3sFSBw62Lr9iHXPkXmDQJJiHZeTRtD9Vzt8grAYRhvbz4nEvBu3QKELVzFK\"}}', '{\"BTC\":\"BTC\"}', 1, NULL, NULL, NULL, '2019-09-14 13:14:22', '2021-05-21 02:25:00'),
(14, 502, 'Block.io', 'Blockio', '5f6f19432bedf1601116483.jpg', 1, '{\"api_key\":{\"title\":\"API Key\",\"global\":false,\"value\":\"1658-8015-2e5e-9afb\"},\"api_pin\":{\"title\":\"API PIN\",\"global\":true,\"value\":\"75757575\"}}', '{\"BTC\":\"BTC\",\"LTC\":\"LTC\"}', 1, '{\"cron\":{\"title\": \"Cron URL\",\"value\":\"ipn.Blockio\"}}', NULL, NULL, '2019-09-14 13:14:22', '2021-05-21 02:31:09'),
(15, 503, 'CoinPayments', 'Coinpayments', '5f6f1b6c02ecd1601117036.jpg', 1, '{\"public_key\":{\"title\":\"Public Key\",\"global\":true,\"value\":\"---------------\"},\"private_key\":{\"title\":\"Private Key\",\"global\":true,\"value\":\"------------\"},\"merchant_id\":{\"title\":\"Merchant ID\",\"global\":true,\"value\":\"93a1e014c4ad60a7980b4a7239673cb4\"}}', '{\"BTC\":\"BTC\",\"BTC.LN\":\"BTC.LN\",\"LTC\":\"LTC\",\"CPS\":\"CPS\",\"VLX\":\"VLX\",\"APL\":\"APL\",\"AYA\":\"AYA\",\"BAD\":\"BAD\",\"BCD\":\"BCD\",\"BCH\":\"BCH\",\"BCN\":\"BCN\",\"BEAM\":\"BEAM\",\"BITB\":\"BITB\",\"BLK\":\"BLK\",\"BSV\":\"BSV\",\"BTAD\":\"BTAD\",\"BTG\":\"BTG\",\"BTT\":\"BTT\",\"CLOAK\":\"CLOAK\",\"CLUB\":\"CLUB\",\"CRW\":\"CRW\",\"CRYP\":\"CRYP\",\"CRYT\":\"CRYT\",\"CURE\":\"CURE\",\"DASH\":\"DASH\",\"DCR\":\"DCR\",\"DEV\":\"DEV\",\"DGB\":\"DGB\",\"DOGE\":\"DOGE\",\"EBST\":\"EBST\",\"EOS\":\"EOS\",\"ETC\":\"ETC\",\"ETH\":\"ETH\",\"ETN\":\"ETN\",\"EUNO\":\"EUNO\",\"EXP\":\"EXP\",\"Expanse\":\"Expanse\",\"FLASH\":\"FLASH\",\"GAME\":\"GAME\",\"GLC\":\"GLC\",\"GRS\":\"GRS\",\"KMD\":\"KMD\",\"LOKI\":\"LOKI\",\"LSK\":\"LSK\",\"MAID\":\"MAID\",\"MUE\":\"MUE\",\"NAV\":\"NAV\",\"NEO\":\"NEO\",\"NMC\":\"NMC\",\"NVST\":\"NVST\",\"NXT\":\"NXT\",\"OMNI\":\"OMNI\",\"PINK\":\"PINK\",\"PIVX\":\"PIVX\",\"POT\":\"POT\",\"PPC\":\"PPC\",\"PROC\":\"PROC\",\"PURA\":\"PURA\",\"QTUM\":\"QTUM\",\"RES\":\"RES\",\"RVN\":\"RVN\",\"RVR\":\"RVR\",\"SBD\":\"SBD\",\"SMART\":\"SMART\",\"SOXAX\":\"SOXAX\",\"STEEM\":\"STEEM\",\"STRAT\":\"STRAT\",\"SYS\":\"SYS\",\"TPAY\":\"TPAY\",\"TRIGGERS\":\"TRIGGERS\",\"TRX\":\"TRX\",\"UBQ\":\"UBQ\",\"UNIT\":\"UNIT\",\"USDT\":\"USDT\",\"VTC\":\"VTC\",\"WAVES\":\"WAVES\",\"XCP\":\"XCP\",\"XEM\":\"XEM\",\"XMR\":\"XMR\",\"XSN\":\"XSN\",\"XSR\":\"XSR\",\"XVG\":\"XVG\",\"XZC\":\"XZC\",\"ZEC\":\"ZEC\",\"ZEN\":\"ZEN\"}', 1, NULL, NULL, NULL, '2019-09-14 13:14:22', '2021-05-21 02:07:14'),
(16, 504, 'CoinPayments Fiat', 'CoinpaymentsFiat', '5f6f1b94e9b2b1601117076.jpg', 1, '{\"merchant_id\":{\"title\":\"Merchant ID\",\"global\":true,\"value\":\"6515561\"}}', '{\"USD\":\"USD\",\"AUD\":\"AUD\",\"BRL\":\"BRL\",\"CAD\":\"CAD\",\"CHF\":\"CHF\",\"CLP\":\"CLP\",\"CNY\":\"CNY\",\"DKK\":\"DKK\",\"EUR\":\"EUR\",\"GBP\":\"GBP\",\"HKD\":\"HKD\",\"INR\":\"INR\",\"ISK\":\"ISK\",\"JPY\":\"JPY\",\"KRW\":\"KRW\",\"NZD\":\"NZD\",\"PLN\":\"PLN\",\"RUB\":\"RUB\",\"SEK\":\"SEK\",\"SGD\":\"SGD\",\"THB\":\"THB\",\"TWD\":\"TWD\"}', 0, NULL, NULL, NULL, '2019-09-14 13:14:22', '2021-05-21 02:07:44'),
(17, 505, 'Coingate', 'Coingate', '5f6f1b5fe18ee1601117023.jpg', 1, '{\"api_key\":{\"title\":\"API Key\",\"global\":true,\"value\":\"6354mwVCEw5kHzRJ6thbGo-N\"}}', '{\"USD\":\"USD\",\"EUR\":\"EUR\"}', 0, NULL, NULL, NULL, '2019-09-14 13:14:22', '2021-05-21 02:49:30'),
(18, 506, 'Coinbase Commerce', 'CoinbaseCommerce', '5f6f1b4c774af1601117004.jpg', 1, '{\"api_key\":{\"title\":\"API Key\",\"global\":true,\"value\":\"c47cd7df-d8e8-424b-a20a\"},\"secret\":{\"title\":\"Webhook Shared Secret\",\"global\":true,\"value\":\"55871878-2c32-4f64-ab66\"}}', '{\"USD\":\"USD\",\"EUR\":\"EUR\",\"JPY\":\"JPY\",\"GBP\":\"GBP\",\"AUD\":\"AUD\",\"CAD\":\"CAD\",\"CHF\":\"CHF\",\"CNY\":\"CNY\",\"SEK\":\"SEK\",\"NZD\":\"NZD\",\"MXN\":\"MXN\",\"SGD\":\"SGD\",\"HKD\":\"HKD\",\"NOK\":\"NOK\",\"KRW\":\"KRW\",\"TRY\":\"TRY\",\"RUB\":\"RUB\",\"INR\":\"INR\",\"BRL\":\"BRL\",\"ZAR\":\"ZAR\",\"AED\":\"AED\",\"AFN\":\"AFN\",\"ALL\":\"ALL\",\"AMD\":\"AMD\",\"ANG\":\"ANG\",\"AOA\":\"AOA\",\"ARS\":\"ARS\",\"AWG\":\"AWG\",\"AZN\":\"AZN\",\"BAM\":\"BAM\",\"BBD\":\"BBD\",\"BDT\":\"BDT\",\"BGN\":\"BGN\",\"BHD\":\"BHD\",\"BIF\":\"BIF\",\"BMD\":\"BMD\",\"BND\":\"BND\",\"BOB\":\"BOB\",\"BSD\":\"BSD\",\"BTN\":\"BTN\",\"BWP\":\"BWP\",\"BYN\":\"BYN\",\"BZD\":\"BZD\",\"CDF\":\"CDF\",\"CLF\":\"CLF\",\"CLP\":\"CLP\",\"COP\":\"COP\",\"CRC\":\"CRC\",\"CUC\":\"CUC\",\"CUP\":\"CUP\",\"CVE\":\"CVE\",\"CZK\":\"CZK\",\"DJF\":\"DJF\",\"DKK\":\"DKK\",\"DOP\":\"DOP\",\"DZD\":\"DZD\",\"EGP\":\"EGP\",\"ERN\":\"ERN\",\"ETB\":\"ETB\",\"FJD\":\"FJD\",\"FKP\":\"FKP\",\"GEL\":\"GEL\",\"GGP\":\"GGP\",\"GHS\":\"GHS\",\"GIP\":\"GIP\",\"GMD\":\"GMD\",\"GNF\":\"GNF\",\"GTQ\":\"GTQ\",\"GYD\":\"GYD\",\"HNL\":\"HNL\",\"HRK\":\"HRK\",\"HTG\":\"HTG\",\"HUF\":\"HUF\",\"IDR\":\"IDR\",\"ILS\":\"ILS\",\"IMP\":\"IMP\",\"IQD\":\"IQD\",\"IRR\":\"IRR\",\"ISK\":\"ISK\",\"JEP\":\"JEP\",\"JMD\":\"JMD\",\"JOD\":\"JOD\",\"KES\":\"KES\",\"KGS\":\"KGS\",\"KHR\":\"KHR\",\"KMF\":\"KMF\",\"KPW\":\"KPW\",\"KWD\":\"KWD\",\"KYD\":\"KYD\",\"KZT\":\"KZT\",\"LAK\":\"LAK\",\"LBP\":\"LBP\",\"LKR\":\"LKR\",\"LRD\":\"LRD\",\"LSL\":\"LSL\",\"LYD\":\"LYD\",\"MAD\":\"MAD\",\"MDL\":\"MDL\",\"MGA\":\"MGA\",\"MKD\":\"MKD\",\"MMK\":\"MMK\",\"MNT\":\"MNT\",\"MOP\":\"MOP\",\"MRO\":\"MRO\",\"MUR\":\"MUR\",\"MVR\":\"MVR\",\"MWK\":\"MWK\",\"MYR\":\"MYR\",\"MZN\":\"MZN\",\"NAD\":\"NAD\",\"NGN\":\"NGN\",\"NIO\":\"NIO\",\"NPR\":\"NPR\",\"OMR\":\"OMR\",\"PAB\":\"PAB\",\"PEN\":\"PEN\",\"PGK\":\"PGK\",\"PHP\":\"PHP\",\"PKR\":\"PKR\",\"PLN\":\"PLN\",\"PYG\":\"PYG\",\"QAR\":\"QAR\",\"RON\":\"RON\",\"RSD\":\"RSD\",\"RWF\":\"RWF\",\"SAR\":\"SAR\",\"SBD\":\"SBD\",\"SCR\":\"SCR\",\"SDG\":\"SDG\",\"SHP\":\"SHP\",\"SLL\":\"SLL\",\"SOS\":\"SOS\",\"SRD\":\"SRD\",\"SSP\":\"SSP\",\"STD\":\"STD\",\"SVC\":\"SVC\",\"SYP\":\"SYP\",\"SZL\":\"SZL\",\"THB\":\"THB\",\"TJS\":\"TJS\",\"TMT\":\"TMT\",\"TND\":\"TND\",\"TOP\":\"TOP\",\"TTD\":\"TTD\",\"TWD\":\"TWD\",\"TZS\":\"TZS\",\"UAH\":\"UAH\",\"UGX\":\"UGX\",\"UYU\":\"UYU\",\"UZS\":\"UZS\",\"VEF\":\"VEF\",\"VND\":\"VND\",\"VUV\":\"VUV\",\"WST\":\"WST\",\"XAF\":\"XAF\",\"XAG\":\"XAG\",\"XAU\":\"XAU\",\"XCD\":\"XCD\",\"XDR\":\"XDR\",\"XOF\":\"XOF\",\"XPD\":\"XPD\",\"XPF\":\"XPF\",\"XPT\":\"XPT\",\"YER\":\"YER\",\"ZMW\":\"ZMW\",\"ZWL\":\"ZWL\"}\r\n\r\n', 0, '{\"endpoint\":{\"title\": \"Webhook Endpoint\",\"value\":\"ipn.CoinbaseCommerce\"}}', NULL, NULL, '2019-09-14 13:14:22', '2021-05-21 02:02:47'),
(24, 113, 'Paypal Express', 'PaypalSdk', '5f6f1bec255c61601117164.jpg', 1, '{\"clientId\":{\"title\":\"Paypal Client ID\",\"global\":true,\"value\":\"Ae0-tixtSV7DvLwIh3Bmu7JvHrjh5EfGdXr_cEklKAVjjezRZ747BxKILiBdzlKKyp-W8W_T7CKH1Ken\"},\"clientSecret\":{\"title\":\"Client Secret\",\"global\":true,\"value\":\"EOhbvHZgFNO21soQJT1L9Q00M3rK6PIEsdiTgXRBt2gtGtxwRer5JvKnVUGNU5oE63fFnjnYY7hq3HBA\"}}', '{\"AUD\":\"AUD\",\"BRL\":\"BRL\",\"CAD\":\"CAD\",\"CZK\":\"CZK\",\"DKK\":\"DKK\",\"EUR\":\"EUR\",\"HKD\":\"HKD\",\"HUF\":\"HUF\",\"INR\":\"INR\",\"ILS\":\"ILS\",\"JPY\":\"JPY\",\"MYR\":\"MYR\",\"MXN\":\"MXN\",\"TWD\":\"TWD\",\"NZD\":\"NZD\",\"NOK\":\"NOK\",\"PHP\":\"PHP\",\"PLN\":\"PLN\",\"GBP\":\"GBP\",\"RUB\":\"RUB\",\"SGD\":\"SGD\",\"SEK\":\"SEK\",\"CHF\":\"CHF\",\"THB\":\"THB\",\"USD\":\"$\"}', 0, NULL, NULL, NULL, '2019-09-14 13:14:22', '2021-05-20 23:01:08'),
(25, 114, 'Stripe Checkout', 'StripeV3', '5f709684736321601214084.jpg', 1, '{\"secret_key\":{\"title\":\"Secret Key\",\"global\":true,\"value\":\"sk_test_51I6GGiCGv1sRiQlEi5v1or9eR0HVbuzdMd2rW4n3DxC8UKfz66R4X6n4yYkzvI2LeAIuRU9H99ZpY7XCNFC9xMs500vBjZGkKG\"},\"publishable_key\":{\"title\":\"PUBLISHABLE KEY\",\"global\":true,\"value\":\"pk_test_51I6GGiCGv1sRiQlEOisPKrjBqQqqcFsw8mXNaZ2H2baN6R01NulFS7dKFji1NRRxuchoUTEDdB7ujKcyKYSVc0z500eth7otOM\"},\"end_point\":{\"title\":\"End Point Secret\",\"global\":true,\"value\":\"whsec_lUmit1gtxwKTveLnSe88xCSDdnPOt8g5\"}}', '{\"USD\":\"USD\",\"AUD\":\"AUD\",\"BRL\":\"BRL\",\"CAD\":\"CAD\",\"CHF\":\"CHF\",\"DKK\":\"DKK\",\"EUR\":\"EUR\",\"GBP\":\"GBP\",\"HKD\":\"HKD\",\"INR\":\"INR\",\"JPY\":\"JPY\",\"MXN\":\"MXN\",\"MYR\":\"MYR\",\"NOK\":\"NOK\",\"NZD\":\"NZD\",\"PLN\":\"PLN\",\"SEK\":\"SEK\",\"SGD\":\"SGD\"}', 0, '{\"webhook\":{\"title\": \"Webhook Endpoint\",\"value\":\"ipn.StripeV3\"}}', NULL, NULL, '2019-09-14 13:14:22', '2021-05-21 00:58:38'),
(27, 115, 'Mollie', 'Mollie', '5f6f1bb765ab11601117111.jpg', 1, '{\"mollie_email\":{\"title\":\"Mollie Email \",\"global\":true,\"value\":\"vi@gmail.com\"},\"api_key\":{\"title\":\"API KEY\",\"global\":true,\"value\":\"test_cucfwKTWfft9s337qsVfn5CC4vNkrn\"}}', '{\"AED\":\"AED\",\"AUD\":\"AUD\",\"BGN\":\"BGN\",\"BRL\":\"BRL\",\"CAD\":\"CAD\",\"CHF\":\"CHF\",\"CZK\":\"CZK\",\"DKK\":\"DKK\",\"EUR\":\"EUR\",\"GBP\":\"GBP\",\"HKD\":\"HKD\",\"HRK\":\"HRK\",\"HUF\":\"HUF\",\"ILS\":\"ILS\",\"ISK\":\"ISK\",\"JPY\":\"JPY\",\"MXN\":\"MXN\",\"MYR\":\"MYR\",\"NOK\":\"NOK\",\"NZD\":\"NZD\",\"PHP\":\"PHP\",\"PLN\":\"PLN\",\"RON\":\"RON\",\"RUB\":\"RUB\",\"SEK\":\"SEK\",\"SGD\":\"SGD\",\"THB\":\"THB\",\"TWD\":\"TWD\",\"USD\":\"USD\",\"ZAR\":\"ZAR\"}', 0, NULL, NULL, NULL, '2019-09-14 13:14:22', '2021-05-21 02:44:45'),
(30, 116, 'Cashmaal', 'Cashmaal', '5f9a8b62bb4dd1603963746.png', 1, '{\"web_id\":{\"title\":\"Web Id\",\"global\":true,\"value\":\"3748\"},\"ipn_key\":{\"title\":\"IPN Key\",\"global\":true,\"value\":\"546254628759524554647987\"}}', '{\"PKR\":\"PKR\",\"USD\":\"USD\"}', 0, '{\"webhook\":{\"title\": \"IPN URL\",\"value\":\"ipn.Cashmaal\"}}', NULL, NULL, NULL, '2021-05-21 02:43:26'),
(36, 119, 'Mercado Pago', 'MercadoPago', '60f2ad85a82951626516869.png', 1, '{\"access_token\":{\"title\":\"Access Token\",\"global\":true,\"value\":\"3Vee5S2F\"}}', '{\"USD\":\"USD\",\"CAD\":\"CAD\",\"CHF\":\"CHF\",\"DKK\":\"DKK\",\"EUR\":\"EUR\",\"GBP\":\"GBP\",\"NOK\":\"NOK\",\"PLN\":\"PLN\",\"SEK\":\"SEK\",\"AUD\":\"AUD\",\"NZD\":\"NZD\"}', 0, NULL, NULL, NULL, NULL, '2021-06-22 02:04:23');

-- --------------------------------------------------------

--
-- Table structure for table `gateway_currencies`
--

CREATE TABLE `gateway_currencies` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `symbol` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `method_code` int(10) DEFAULT NULL,
  `gateway_alias` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `min_amount` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `max_amount` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `percent_charge` decimal(5,2) NOT NULL DEFAULT 0.00,
  `fixed_charge` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `rate` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `gateway_parameter` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `general_settings`
--

CREATE TABLE `general_settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `sitename` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cur_text` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'currency text',
  `cur_sym` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'currency symbol',
  `email_from` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email_template` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sms_api` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `base_color` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mail_config` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'email configuration',
  `sms_config` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `otp_verification` int(11) NOT NULL DEFAULT 0,
  `otp_expiration` decimal(10,0) NOT NULL DEFAULT 0,
  `ev` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'email verification, 0 - dont check, 1 - check',
  `en` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'email notification, 0 - dont send, 1 - send',
  `sv` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'sms verication, 0 - dont check, 1 - check',
  `sn` tinyint(1) NOT NULL DEFAULT 0 COMMENT 'sms notification, 0 - dont send, 1 - send',
  `force_ssl` tinyint(1) NOT NULL DEFAULT 0,
  `secure_password` tinyint(1) NOT NULL DEFAULT 0,
  `agree` tinyint(1) NOT NULL DEFAULT 0,
  `registration` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0: Off	, 1: On',
  `active_template` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `sys_version` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `fiat_currency_api` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `crypto_currency_api` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `qr_template` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `cron_run` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `general_settings`
--

INSERT INTO `general_settings` (`id`, `sitename`, `cur_text`, `cur_sym`, `email_from`, `email_template`, `sms_api`, `base_color`, `mail_config`, `sms_config`, `otp_verification`, `otp_expiration`, `ev`, `en`, `sv`, `sn`, `force_ssl`, `secure_password`, `agree`, `registration`, `active_template`, `sys_version`, `fiat_currency_api`, `crypto_currency_api`, `qr_template`, `cron_run`, `created_at`, `updated_at`) VALUES
(1, 'xCash', 'USD', '$', 'do-not-reply@viserlab.com', '<meta http-equiv=\"Content-Type\" content=\"text/html; charset=utf-8\">\r\n  <!--[if !mso]><!-->\r\n  <meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\">\r\n  <!--<![endif]-->\r\n  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n  <title></title>\r\n  <style type=\"text/css\">\r\n.ReadMsgBody { width: 100%; background-color: #ffffff; }\r\n.ExternalClass { width: 100%; background-color: #ffffff; }\r\n.ExternalClass, .ExternalClass p, .ExternalClass span, .ExternalClass font, .ExternalClass td, .ExternalClass div { line-height: 100%; }\r\nhtml { width: 100%; }\r\nbody { -webkit-text-size-adjust: none; -ms-text-size-adjust: none; margin: 0; padding: 0; }\r\ntable { border-spacing: 0; table-layout: fixed; margin: 0 auto;border-collapse: collapse; }\r\ntable table table { table-layout: auto; }\r\n.yshortcuts a { border-bottom: none !important; }\r\nimg:hover { opacity: 0.9 !important; }\r\na { color: #0087ff; text-decoration: none; }\r\n.textbutton a { font-family: \'open sans\', arial, sans-serif !important;}\r\n.btn-link a { color:#FFFFFF !important;}\r\n\r\n@media only screen and (max-width: 480px) {\r\nbody { width: auto !important; }\r\n*[class=\"table-inner\"] { width: 90% !important; text-align: center !important; }\r\n*[class=\"table-full\"] { width: 100% !important; text-align: center !important; }\r\n/* image */\r\nimg[class=\"img1\"] { width: 100% !important; height: auto !important; }\r\n}\r\n</style>\r\n\r\n\r\n\r\n  <table bgcolor=\"#414a51\" width=\"100%\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">\r\n    <tbody><tr>\r\n      <td height=\"50\"></td>\r\n    </tr>\r\n    <tr>\r\n      <td align=\"center\" style=\"text-align:center;vertical-align:top;font-size:0;\">\r\n        <table align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\">\r\n          <tbody><tr>\r\n            <td align=\"center\" width=\"600\">\r\n              <!--header-->\r\n              <table class=\"table-inner\" width=\"95%\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">\r\n                <tbody><tr>\r\n                  <td bgcolor=\"#0087ff\" style=\"border-top-left-radius:6px; border-top-right-radius:6px;text-align:center;vertical-align:top;font-size:0;\" align=\"center\">\r\n                    <table width=\"90%\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">\r\n                      <tbody><tr>\r\n                        <td height=\"20\"></td>\r\n                      </tr>\r\n                      <tr>\r\n                        <td align=\"center\" style=\"font-family: \'Open sans\', Arial, sans-serif; color:#FFFFFF; font-size:16px; font-weight: bold;\">This is a System Generated Email</td>\r\n                      </tr>\r\n                      <tr>\r\n                        <td height=\"20\"></td>\r\n                      </tr>\r\n                    </tbody></table>\r\n                  </td>\r\n                </tr>\r\n              </tbody></table>\r\n              <!--end header-->\r\n              <table class=\"table-inner\" width=\"95%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n                <tbody><tr>\r\n                  <td bgcolor=\"#FFFFFF\" align=\"center\" style=\"text-align:center;vertical-align:top;font-size:0;\">\r\n                    <table align=\"center\" width=\"90%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n                      <tbody><tr>\r\n                        <td height=\"35\"></td>\r\n                      </tr>\r\n                      <!--logo-->\r\n                      <tr>\r\n                        <td align=\"center\" style=\"vertical-align:top;font-size:0;\">\r\n                          <a href=\"#\">\r\n                            <img style=\"display:block; line-height:0px; font-size:0px; border:0px;\" src=\"https://i.imgur.com/Z1qtvtV.png\" alt=\"img\">\r\n                          </a>\r\n                        </td>\r\n                      </tr>\r\n                      <!--end logo-->\r\n                      <tr>\r\n                        <td height=\"40\"></td>\r\n                      </tr>\r\n                      <!--headline-->\r\n                      <tr>\r\n                        <td align=\"center\" style=\"font-family: \'Open Sans\', Arial, sans-serif; font-size: 22px;color:#414a51;font-weight: bold;\">Hello {{fullname}} ({{username}})</td>\r\n                      </tr>\r\n                      <!--end headline-->\r\n                      <tr>\r\n                        <td align=\"center\" style=\"text-align:center;vertical-align:top;font-size:0;\">\r\n                          <table width=\"40\" border=\"0\" align=\"center\" cellpadding=\"0\" cellspacing=\"0\">\r\n                            <tbody><tr>\r\n                              <td height=\"20\" style=\" border-bottom:3px solid #0087ff;\"></td>\r\n                            </tr>\r\n                          </tbody></table>\r\n                        </td>\r\n                      </tr>\r\n                      <tr>\r\n                        <td height=\"20\"></td>\r\n                      </tr>\r\n                      <!--content-->\r\n                      <tr>\r\n                        <td align=\"left\" style=\"font-family: \'Open sans\', Arial, sans-serif; color:#7f8c8d; font-size:16px; line-height: 28px;\">{{message}}</td>\r\n                      </tr>\r\n                      <!--end content-->\r\n                      <tr>\r\n                        <td height=\"40\"></td>\r\n                      </tr>\r\n              \r\n                    </tbody></table>\r\n                  </td>\r\n                </tr>\r\n                <tr>\r\n                  <td height=\"45\" align=\"center\" bgcolor=\"#f4f4f4\" style=\"border-bottom-left-radius:6px;border-bottom-right-radius:6px;\">\r\n                    <table align=\"center\" width=\"90%\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\">\r\n                      <tbody><tr>\r\n                        <td height=\"10\"></td>\r\n                      </tr>\r\n                      <!--preference-->\r\n                      <tr>\r\n                        <td class=\"preference-link\" align=\"center\" style=\"font-family: \'Open sans\', Arial, sans-serif; color:#95a5a6; font-size:14px;\">\r\n                          © 2021 <a href=\"#\">Website Name</a> . All Rights Reserved. \r\n                        </td>\r\n                      </tr>\r\n                      <!--end preference-->\r\n                      <tr>\r\n                        <td height=\"10\"></td>\r\n                      </tr>\r\n                    </tbody></table>\r\n                  </td>\r\n                </tr>\r\n              </tbody></table>\r\n            </td>\r\n          </tr>\r\n        </tbody></table>\r\n      </td>\r\n    </tr>\r\n    <tr>\r\n      <td height=\"60\"></td>\r\n    </tr>\r\n  </tbody></table>', 'hi {{name}}, {{message}}', '7966ff', '{\"name\":\"php\"}', '{\"clickatell_api_key\":\"----------------------------\",\"infobip_username\":\"--------------\",\"infobip_password\":\"----------------------\",\"message_bird_api_key\":\"-------------------\",\"nexmo_api_key\":\"----------------------\",\"nexmo_api_secret\":\"----------------------\",\"sms_broadcast_username\":\"----------------------\",\"sms_broadcast_password\":\"-----------------------------\",\"account_sid\":\"-----------------------\",\"auth_token\":\"---------------------------\",\"from\":\"----------------------\",\"text_magic_username\":\"-----------------------\",\"apiv2_key\":\"-------------------------------\",\"name\":\"clickatell\"}', 0, '0', 0, 1, 0, 0, 0, 0, 0, 1, 'basic', NULL, '14360e0ed85986d6bf9c3aa1a7fd8508', 'f45ece6d-9f1a-4ed5-841c-647a603d4c08', '617569babbeb21635084730.png', '{\"fiat_cron\":\"2021-10-24T13:28:21.505940Z\",\"crypto_cron\":\"2021-10-24T13:28:16.481555Z\"}', NULL, '2021-10-24 08:12:14');

-- --------------------------------------------------------

--
-- Table structure for table `invoices`
--

CREATE TABLE `invoices` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `user_type` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `invoice_num` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `invoice_to` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `address` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `currency_id` int(11) NOT NULL,
  `charge` decimal(28,8) NOT NULL,
  `total_amount` decimal(28,8) NOT NULL,
  `get_amount` decimal(28,8) NOT NULL,
  `pay_status` tinyint(4) NOT NULL COMMENT '1 => paid, 0 => not paid',
  `status` tinyint(4) NOT NULL COMMENT '1 => published, 0 => not published , 2 => cancel',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `invoice_items`
--

CREATE TABLE `invoice_items` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `invoice_id` int(11) NOT NULL,
  `item_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(28,8) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `kyc_forms`
--

CREATE TABLE `kyc_forms` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `form_data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(4) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `kyc_forms`
--

INSERT INTO `kyc_forms` (`id`, `user_type`, `form_data`, `status`, `created_at`, `updated_at`) VALUES
(1, 'USER', '{\"nid_name\":{\"field_name\":\"nid_name\",\"field_level\":\"NID Name\",\"type\":\"text\",\"validation\":\"required\"},\"nid_number\":{\"field_name\":\"nid_number\",\"field_level\":\"NID number\",\"type\":\"text\",\"validation\":\"required\"},\"nid_copy\":{\"field_name\":\"nid_copy\",\"field_level\":\"NID Copy\",\"type\":\"file\",\"validation\":\"required\"}}', 1, NULL, '2021-08-08 06:19:30'),
(2, 'AGENT', '{\"nid_name\":{\"field_name\":\"nid_name\",\"field_level\":\"NID name\",\"type\":\"text\",\"validation\":\"required\"},\"nid_number\":{\"field_name\":\"nid_number\",\"field_level\":\"NID number\",\"type\":\"text\",\"validation\":\"required\"},\"nid_scan_copy\":{\"field_name\":\"nid_scan_copy\",\"field_level\":\"NID scan copy\",\"type\":\"file\",\"validation\":\"required\"}}', 1, NULL, '2021-08-10 05:43:42'),
(3, 'MERCHANT', '{\"nid_name\":{\"field_name\":\"nid_name\",\"field_level\":\"NID name\",\"type\":\"text\",\"validation\":\"required\"},\"nid_number\":{\"field_name\":\"nid_number\",\"field_level\":\"NID number\",\"type\":\"text\",\"validation\":\"required\"},\"nid_scan_copy\":{\"field_name\":\"nid_scan_copy\",\"field_level\":\"NID scan copy\",\"type\":\"file\",\"validation\":\"required\"}}', 1, NULL, '2021-08-10 05:43:34');

-- --------------------------------------------------------

--
-- Table structure for table `languages`
--

CREATE TABLE `languages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `code` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `icon` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `text_align` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0: left to right text align, 1: right to left text align',
  `is_default` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0: not default language, 1: default language',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `languages`
--

INSERT INTO `languages` (`id`, `name`, `code`, `icon`, `text_align`, `is_default`, `created_at`, `updated_at`) VALUES
(1, 'English', 'en', '5f15968db08911595250317.png', 0, 1, '2020-07-06 03:47:55', '2021-06-08 07:58:22'),
(9, 'Bangla', 'bn', NULL, 0, 0, '2021-03-14 04:37:41', '2021-05-12 05:34:06'),
(10, 'Spanish', 'es', NULL, 0, 0, '2021-10-24 08:24:02', '2021-10-24 08:24:02'),
(11, 'Portuguese', 'pt-br', NULL, 0, 0, '2021-10-24 08:24:23', '2021-10-24 08:24:23'),
(12, 'French', 'fr', NULL, 0, 0, '2021-10-24 08:25:07', '2021-10-24 08:25:07'),
(13, 'Russian', 'ru', NULL, 0, 0, '2021-10-24 08:25:17', '2021-10-24 08:25:17');

-- --------------------------------------------------------

--
-- Table structure for table `merchants`
--

CREATE TABLE `merchants` (
  `id` int(11) UNSIGNED NOT NULL,
  `firstname` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastname` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `username` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `country_code` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ref_by` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `balance` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'contains full address',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '0: banned, 1: active',
  `kyc_status` tinyint(1) NOT NULL DEFAULT 0,
  `kyc_info` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `kyc_reject_reasons` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ev` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0: email unverified, 1: email verified',
  `sv` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0: sms unverified, 1: sms verified',
  `ver_code` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'stores verification code',
  `ver_code_send_at` datetime DEFAULT NULL COMMENT 'verification send time',
  `ts` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0: 2fa off, 1: 2fa on',
  `tv` tinyint(1) NOT NULL DEFAULT 1 COMMENT '0: 2fa unverified, 1: 2fa verified',
  `tsc` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `public_api_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `secret_api_key` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `merchant_reset_passwords`
--

CREATE TABLE `merchant_reset_passwords` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` int(10) UNSIGNED NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `migrations`
--

CREATE TABLE `migrations` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `migration` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `batch` int(10) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `module_settings`
--

CREATE TABLE `module_settings` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_type` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `slug` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL COMMENT '1 = on, 0 = off',
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `module_settings`
--

INSERT INTO `module_settings` (`id`, `user_type`, `slug`, `status`, `created_at`, `updated_at`) VALUES
(1, 'USER', 'transfer_money', 1, '2021-06-15 11:45:01', '2021-10-12 03:32:28'),
(2, 'USER', 'request_money', 1, '2021-06-15 11:45:01', '2021-10-12 03:32:29'),
(3, 'USER', 'money_out', 1, '2021-06-15 11:45:01', '2021-10-21 02:54:55'),
(4, 'USER', 'make_payment', 1, '2021-06-15 11:45:01', '2021-10-12 03:32:47'),
(5, 'USER', 'add_money', 1, '2021-06-15 11:45:01', '2021-10-12 03:32:30'),
(6, 'USER', 'withdraw_money', 1, '2021-06-15 11:45:01', '2021-10-12 03:32:31'),
(7, 'USER', 'create_voucher', 1, '2021-06-15 11:45:01', '2021-10-12 03:32:47'),
(8, 'USER', 'create_invoice', 1, '2021-06-15 11:45:01', '2021-10-12 03:17:35'),
(9, 'USER', 'money_exchange', 1, '2021-06-15 11:45:01', '2021-10-24 04:01:15'),
(15, 'AGENT', 'add_money', 1, '2021-06-15 11:45:01', '2021-10-17 01:15:53'),
(16, 'AGENT', 'withdraw_money', 1, '2021-06-15 11:45:01', '2021-10-12 03:22:38'),
(19, 'MERCHANT', 'withdraw_money', 1, '2021-06-15 11:45:01', '2021-10-24 04:01:01');

-- --------------------------------------------------------

--
-- Table structure for table `pages`
--

CREATE TABLE `pages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `slug` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `tempname` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'template name',
  `secs` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `is_default` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `pages`
--

INSERT INTO `pages` (`id`, `name`, `slug`, `tempname`, `secs`, `is_default`, `created_at`, `updated_at`) VALUES
(1, 'HOME', 'home', 'templates.basic.', '[\"about\",\"service\",\"why_choose_us\",\"feature\",\"business\",\"overview\",\"testimonial\",\"blog\"]', 1, '2020-07-11 06:23:58', '2021-06-08 13:01:49'),
(2, 'About', 'about-us', 'templates.basic.', '[\"about\",\"service\",\"testimonial\"]', 0, '2020-07-11 06:35:35', '2021-08-19 06:35:20');

-- --------------------------------------------------------

--
-- Table structure for table `password_resets`
--

CREATE TABLE `password_resets` (
  `email` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `personal_access_tokens`
--

CREATE TABLE `personal_access_tokens` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `tokenable_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `tokenable_id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `token` varchar(64) COLLATE utf8mb4_unicode_ci NOT NULL,
  `abilities` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `last_used_at` timestamp NULL DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `qr_codes`
--

CREATE TABLE `qr_codes` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `user_type` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `unique_code` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `request_money`
--

CREATE TABLE `request_money` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `currency_id` int(11) NOT NULL,
  `wallet_id` int(11) NOT NULL,
  `charge` decimal(28,8) NOT NULL,
  `request_amount` decimal(28,8) NOT NULL,
  `sender_id` int(11) UNSIGNED NOT NULL,
  `receiver_id` int(11) UNSIGNED NOT NULL,
  `note` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `support_attachments`
--

CREATE TABLE `support_attachments` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `support_message_id` int(10) UNSIGNED NOT NULL,
  `attachment` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `support_messages`
--

CREATE TABLE `support_messages` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `supportticket_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `admin_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `message` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `support_tickets`
--

CREATE TABLE `support_tickets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) DEFAULT 0,
  `user_type` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `name` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `email` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ticket` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `subject` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL COMMENT '0: Open, 1: Answered, 2: Replied, 3: Closed',
  `priority` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1 = Low, 2 = medium, 3 = heigh',
  `last_reply` datetime DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transactions`
--

CREATE TABLE `transactions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `user_type` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `receiver_id` int(11) DEFAULT NULL,
  `receiver_type` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currency_id` int(11) DEFAULT NULL,
  `wallet_id` int(11) NOT NULL,
  `before_charge` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `charge` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `amount` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `post_balance` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `trx_type` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `charge_type` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `trx` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `operation_type` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `remark` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `details` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `transaction_charges`
--

CREATE TABLE `transaction_charges` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `slug` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `fixed_charge` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `percent_charge` decimal(5,2) NOT NULL DEFAULT 0.00,
  `min_limit` decimal(28,8) DEFAULT 0.00000000,
  `max_limit` decimal(28,8) DEFAULT 0.00000000,
  `agent_commission_fixed` decimal(28,8) DEFAULT 0.00000000,
  `agent_commission_percent` decimal(5,2) DEFAULT 0.00,
  `merchant_fixed_charge` decimal(28,8) DEFAULT 0.00000000,
  `merchant_percent_charge` decimal(5,2) DEFAULT 0.00,
  `monthly_limit` decimal(28,8) DEFAULT 0.00000000,
  `daily_limit` decimal(28,8) DEFAULT 0.00000000,
  `voucher_limit` int(11) NOT NULL DEFAULT 0,
  `cap` decimal(28,8) DEFAULT 0.00000000,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Dumping data for table `transaction_charges`
--

INSERT INTO `transaction_charges` (`id`, `slug`, `fixed_charge`, `percent_charge`, `min_limit`, `max_limit`, `agent_commission_fixed`, `agent_commission_percent`, `merchant_fixed_charge`, `merchant_percent_charge`, `monthly_limit`, `daily_limit`, `voucher_limit`, `cap`, `created_at`, `updated_at`) VALUES
(1, 'money_transfer', '2.00000000', '1.00', '10.00000000', '1000.00000000', NULL, NULL, NULL, NULL, NULL, '2000.00000000', 0, '20.00000000', '2021-06-12 01:02:22', '2021-10-18 21:35:54'),
(2, 'request_money', '2.00000000', '1.00', '0.00000000', '0.00000000', NULL, NULL, NULL, NULL, NULL, NULL, 0, '20.00000000', '2021-06-12 01:02:22', '2021-06-12 01:02:22'),
(3, 'invoice_charge', '2.00000000', '1.00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '20.00000000', '2021-06-12 01:02:22', '2021-08-10 06:25:33'),
(4, 'exchange_charge', '2.00000000', '1.00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '20.00000000', '2021-06-12 01:02:22', '2021-08-10 06:27:00'),
(5, 'api_charge', '2.00000000', '1.00', NULL, NULL, NULL, NULL, NULL, NULL, NULL, NULL, 0, '-1.00000000', '2021-06-12 01:02:22', '2021-08-18 00:05:38'),
(6, 'voucher_charge', '2.00000000', '1.00', '50.00000000', '1000.00000000', NULL, NULL, NULL, NULL, NULL, NULL, 1, '20.00000000', '2021-06-12 01:02:22', '2021-08-18 02:03:54'),
(7, 'money_out_charge', '2.00000000', '1.00', '50.00000000', '1000.00000000', '3.00000000', '2.00', NULL, NULL, '200000.00000000', '5000.00000000', 0, NULL, '2021-06-12 01:02:22', '2021-10-18 21:36:01'),
(8, 'money_in_charge', '2.00000000', '1.00', '50.00000000', '1000.00000000', '2.00000000', '2.00', NULL, NULL, '200000.00000000', '5000.00000000', 0, NULL, '2021-06-12 01:02:22', '2021-10-18 21:36:07'),
(9, 'make_payment', '2.00000000', '1.00', NULL, NULL, NULL, NULL, '3.00000000', '2.00', NULL, NULL, 0, NULL, '2021-06-12 01:02:22', '2021-06-23 00:00:29');

-- --------------------------------------------------------

--
-- Table structure for table `users`
--

CREATE TABLE `users` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `company_name` varchar(60) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `firstname` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `lastname` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `username` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `country_code` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `mobile` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ref_by` int(10) UNSIGNED NOT NULL DEFAULT 0,
  `balance` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `address` text COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'contains full address',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '0: banned, 1: active',
  `kyc_status` tinyint(1) NOT NULL DEFAULT 0,
  `kyc_info` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `kyc_reject_reasons` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `ev` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0: email unverified, 1: email verified',
  `sv` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0: sms unverified, 1: sms verified',
  `ver_code` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'stores verification code',
  `ver_code_send_at` datetime DEFAULT NULL COMMENT 'verification send time',
  `ts` tinyint(1) NOT NULL DEFAULT 0 COMMENT '0: 2fa off, 1: 2fa on',
  `tv` tinyint(1) NOT NULL DEFAULT 1 COMMENT '0: 2fa unverified, 1: 2fa verified',
  `tsc` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `remember_token` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_actions`
--

CREATE TABLE `user_actions` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `is_otp` tinyint(1) NOT NULL DEFAULT 0,
  `otp` int(11) NOT NULL DEFAULT 0,
  `user_id` int(11) NOT NULL DEFAULT 0,
  `user_type` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `type` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `act` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL COMMENT 'Action',
  `details` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `send_at` datetime DEFAULT NULL,
  `used_at` datetime DEFAULT NULL,
  `expired_at` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_logins`
--

CREATE TABLE `user_logins` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED DEFAULT NULL,
  `agent_id` int(10) UNSIGNED DEFAULT NULL,
  `merchant_id` int(10) UNSIGNED DEFAULT NULL,
  `user_ip` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `city` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `country_code` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `longitude` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `latitude` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `browser` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `os` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `user_withdraw_methods`
--

CREATE TABLE `user_withdraw_methods` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_id` int(11) NOT NULL,
  `user_type` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `method_id` int(11) NOT NULL,
  `currency_id` int(11) NOT NULL,
  `user_data` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `vouchers`
--

CREATE TABLE `vouchers` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `user_type` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(28,8) NOT NULL,
  `currency_id` int(11) NOT NULL,
  `voucher_code` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `is_used` tinyint(1) NOT NULL DEFAULT 0,
  `redeemer_id` int(11) DEFAULT 0,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `wallets`
--

CREATE TABLE `wallets` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `user_id` int(11) NOT NULL,
  `user_type` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `currency_id` int(11) NOT NULL,
  `currency_code` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `balance` decimal(28,8) NOT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `withdrawals`
--

CREATE TABLE `withdrawals` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `method_id` int(10) UNSIGNED NOT NULL,
  `user_id` int(10) UNSIGNED NOT NULL,
  `user_type` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `amount` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `currency_id` int(11) NOT NULL,
  `wallet_id` int(11) NOT NULL,
  `currency` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `charge` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `trx` varchar(40) COLLATE utf8mb4_unicode_ci NOT NULL,
  `final_amount` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `after_charge` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `rate` decimal(18,8) DEFAULT 0.00000000,
  `withdraw_information` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0 COMMENT '1=>success, 2=>pending, 3=>cancel,  ',
  `admin_feedback` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Table structure for table `withdraw_methods`
--

CREATE TABLE `withdraw_methods` (
  `id` bigint(20) UNSIGNED NOT NULL,
  `name` varchar(40) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `currencies` text COLLATE utf8mb4_unicode_ci NOT NULL,
  `user_guards` text COLLATE utf8mb4_unicode_ci NOT NULL COMMENT '\r\n',
  `min_limit` decimal(28,8) DEFAULT 0.00000000,
  `max_limit` decimal(28,8) NOT NULL DEFAULT 0.00000000,
  `fixed_charge` decimal(28,8) DEFAULT 0.00000000,
  `percent_charge` decimal(5,2) DEFAULT NULL,
  `user_data` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `description` text COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 1,
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
  ADD UNIQUE KEY `email` (`email`,`username`);

--
-- Indexes for table `admin_notifications`
--
ALTER TABLE `admin_notifications`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `admin_password_resets`
--
ALTER TABLE `admin_password_resets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `agents`
--
ALTER TABLE `agents`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `agent_password_resets`
--
ALTER TABLE `agent_password_resets`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `api_payments`
--
ALTER TABLE `api_payments`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `charge_logs`
--
ALTER TABLE `charge_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `currencies`
--
ALTER TABLE `currencies`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `currencies_currency_code_unique` (`currency_code`);

--
-- Indexes for table `deposits`
--
ALTER TABLE `deposits`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `email_logs`
--
ALTER TABLE `email_logs`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `email_sms_templates`
--
ALTER TABLE `email_sms_templates`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `extensions`
--
ALTER TABLE `extensions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `frontends`
--
ALTER TABLE `frontends`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gateways`
--
ALTER TABLE `gateways`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `gateway_currencies`
--
ALTER TABLE `gateway_currencies`
  ADD PRIMARY KEY (`id`);

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
-- Indexes for table `invoice_items`
--
ALTER TABLE `invoice_items`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `kyc_forms`
--
ALTER TABLE `kyc_forms`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `languages`
--
ALTER TABLE `languages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `merchants`
--
ALTER TABLE `merchants`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `merchant_reset_passwords`
--
ALTER TABLE `merchant_reset_passwords`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `migrations`
--
ALTER TABLE `migrations`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `module_settings`
--
ALTER TABLE `module_settings`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `pages`
--
ALTER TABLE `pages`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `personal_access_tokens_token_unique` (`token`),
  ADD KEY `personal_access_tokens_tokenable_type_tokenable_id_index` (`tokenable_type`,`tokenable_id`);

--
-- Indexes for table `qr_codes`
--
ALTER TABLE `qr_codes`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `request_money`
--
ALTER TABLE `request_money`
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
-- Indexes for table `transactions`
--
ALTER TABLE `transactions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `transaction_charges`
--
ALTER TABLE `transaction_charges`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `slug` (`slug`);

--
-- Indexes for table `users`
--
ALTER TABLE `users`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `username` (`username`,`email`);

--
-- Indexes for table `user_actions`
--
ALTER TABLE `user_actions`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_logins`
--
ALTER TABLE `user_logins`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `user_withdraw_methods`
--
ALTER TABLE `user_withdraw_methods`
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
  ADD PRIMARY KEY (`id`);

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
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT for table `admin_notifications`
--
ALTER TABLE `admin_notifications`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `admin_password_resets`
--
ALTER TABLE `admin_password_resets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `agents`
--
ALTER TABLE `agents`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `agent_password_resets`
--
ALTER TABLE `agent_password_resets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `api_payments`
--
ALTER TABLE `api_payments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `charge_logs`
--
ALTER TABLE `charge_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `currencies`
--
ALTER TABLE `currencies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `deposits`
--
ALTER TABLE `deposits`
  MODIFY `id` int(10) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `email_logs`
--
ALTER TABLE `email_logs`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `email_sms_templates`
--
ALTER TABLE `email_sms_templates`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=237;

--
-- AUTO_INCREMENT for table `extensions`
--
ALTER TABLE `extensions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT for table `frontends`
--
ALTER TABLE `frontends`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=109;

--
-- AUTO_INCREMENT for table `gateways`
--
ALTER TABLE `gateways`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=37;

--
-- AUTO_INCREMENT for table `gateway_currencies`
--
ALTER TABLE `gateway_currencies`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `general_settings`
--
ALTER TABLE `general_settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `invoices`
--
ALTER TABLE `invoices`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `invoice_items`
--
ALTER TABLE `invoice_items`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `kyc_forms`
--
ALTER TABLE `kyc_forms`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `languages`
--
ALTER TABLE `languages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=14;

--
-- AUTO_INCREMENT for table `merchants`
--
ALTER TABLE `merchants`
  MODIFY `id` int(11) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `merchant_reset_passwords`
--
ALTER TABLE `merchant_reset_passwords`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `migrations`
--
ALTER TABLE `migrations`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `module_settings`
--
ALTER TABLE `module_settings`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=20;

--
-- AUTO_INCREMENT for table `pages`
--
ALTER TABLE `pages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT for table `personal_access_tokens`
--
ALTER TABLE `personal_access_tokens`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `qr_codes`
--
ALTER TABLE `qr_codes`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `request_money`
--
ALTER TABLE `request_money`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `support_attachments`
--
ALTER TABLE `support_attachments`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `support_messages`
--
ALTER TABLE `support_messages`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `support_tickets`
--
ALTER TABLE `support_tickets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transactions`
--
ALTER TABLE `transactions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `transaction_charges`
--
ALTER TABLE `transaction_charges`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT for table `users`
--
ALTER TABLE `users`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_actions`
--
ALTER TABLE `user_actions`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_logins`
--
ALTER TABLE `user_logins`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `user_withdraw_methods`
--
ALTER TABLE `user_withdraw_methods`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `vouchers`
--
ALTER TABLE `vouchers`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `wallets`
--
ALTER TABLE `wallets`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `withdrawals`
--
ALTER TABLE `withdrawals`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `withdraw_methods`
--
ALTER TABLE `withdraw_methods`
  MODIFY `id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
