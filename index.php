<?php
/*
+---------------------------------------------------------------------------+
| MICROSCRIPT MICROTRADER v 5.3                                             |
| ============                                                              |
| Copyright (c) by «Microscript» LLC.                                       |
| For contact details:                                                      |
| https://microscript.net                                                   |
| support@microscript.net                                                   |
|                                                                           |
| PHP8 & MYSQL5                                                             |
+---------------------------------------------------------------------------+
*/

// --- Produção: sem debug em tela ---
ini_set('display_errors', '0');
ini_set('display_startup_errors', '0');
error_reporting(0);

// Flags globais
define('DEBUG', false);
define('DEMO',  false);

// Cache-busting opcional (só ativa em DEBUG)
$cache = DEBUG ? time() : 0;

session_start();

// Fuso-horário (ajuste se quiser)
date_default_timezone_set('America/Sao_Paulo');

// PrimePag
require_once __DIR__ . '/classes/primepag.php';

// Banco de Dados
require_once __DIR__ . '/classes/db.class.php';
$db = new sql_db();
$db->getConnect();

// Core
require_once __DIR__ . '/classes/core.class.php';
$core = new Core();

// Globais de conveniência
$url      = $core->url;
$conf     = $core->conf;
$form     = $core->form;
$mess     = $core->mess;
$user     = $core->user;
$lang     = $core->lang;
$protocol = $core->protocol;
$agent    = $core->agent;
$ip       = $core->ip;
$ref      = $core->ref;
$get      = $core->get;
$host     = $core->host;

// CORS (parceiro)
header('Access-Control-Allow-Credentials: true');
header('Access-Control-Allow-Origin: https://partner.' . $host);

// Controller
require_once __DIR__ . '/pages/controller.php';

// Fecha conexão
$db->connectClose();
