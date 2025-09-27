<?php
error_reporting(E_ALL);
ini_set('display_errors', 1);
register_shutdown_function(function(){ $e = error_get_last(); if($e){ echo "<pre>FATAL:\n".print_r($e,true)."</pre>"; }});

$paths = [
  __DIR__ . '/classes/db.class.php',
  __DIR__ . '/html/classes/db.class.php',
  '/www/wwwroot/html/classes/db.class.php',
];
$loaded = false;
foreach ($paths as $p) {
  if (file_exists($p)) { require_once $p; $loaded = true; $usedPath = $p; break; }
}
if (!$loaded) { die("❌ Não achei db.class.php em: \n" . implode("\n", $paths)); }

if (!defined('DEBUG')) define('DEBUG', true);

echo "<pre>db.class.php: $usedPath\n";

$db = new sql_db();
if (!$db->getConnect()) { die("❌ Sem conexão\n"); }

// Mostra servidor
$ver = @mysqli_query($db->link, "SELECT @@hostname AS hostname, @@port AS port, @@socket AS socket, @@version AS version, @@version_comment AS comment");
$info = $ver ? mysqli_fetch_assoc($ver) : [];
echo "Servidor MySQL: " . json_encode($info, JSON_UNESCAPED_UNICODE) . "\n";

// Bancos visíveis
$res = @mysqli_query($db->link, "SHOW DATABASES");
if (!$res) die("❌ SHOW DATABASES falhou: ".mysqli_error($db->link)."\n");
echo "Bancos visíveis:\n";
$schemas = [];
while ($r = mysqli_fetch_assoc($res)) { $schemas[] = $r['Database']; echo " - ".$r['Database']."\n"; }

// Conta tabelas por banco (primeiros 30)
echo "\nContagem de tabelas por banco:\n";
foreach (array_slice($schemas, 0, 30) as $sch) {
  $sch_esc = mysqli_real_escape_string($db->link, $sch);
  $q = @mysqli_query($db->link, "SELECT COUNT(*) c FROM information_schema.tables WHERE table_schema = '$sch_esc'");
  $c = $q ? (int)mysqli_fetch_assoc($q)['c'] : -1;
  echo str_pad($sch, 30) . " => $c\n";
}

// Onde estão tabelas do dump
foreach (['alerts','users','payin','payout'] as $t) {
  $t_esc = mysqli_real_escape_string($db->link, $t);
  $q = @mysqli_query($db->link, "SELECT table_schema FROM information_schema.tables WHERE table_name = '$t_esc'");
  $list = [];
  while ($q && $row = mysqli_fetch_assoc($q)) $list[] = $row['table_schema'];
  echo "\nOnde existe a tabela '$t': " . (empty($list) ? "(nenhum)" : implode(', ', $list));
}

echo "\n\nBase configurada no código (\$base): " . ($db->base ?? '(null)') . "\n";
$cur = @mysqli_query($db->link, "SELECT DATABASE() AS db"); 
$curDb = $cur ? (mysqli_fetch_assoc($cur)['db'] ?? '') : '';
echo "DATABASE() atual: " . ($curDb ?: '(nenhum)') . "\n";

echo "</pre>";
