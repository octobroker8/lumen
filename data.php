<?php
/**
 * /data.php (SAFE)
 * Retorna SEMPRE um array JSON de velas [{time,open,high,low,close,volume}, ...]
 * mesmo em erro (retorna []) para não quebrar o front.
 */

@header('Content-Type: application/json; charset=utf-8');
@header('Cache-Control: no-store, no-cache, must-revalidate, max-age=0');

function out_array($arr) {
  echo json_encode(is_array($arr) ? $arr : [], JSON_UNESCAPED_SLASHES);
  exit;
}

try {
  $pairRaw   = $_GET['pair']     ?? 'BTCUSDT';
  $mode      = $_GET['mode']     ?? 'history';              // history | update
  $interval  = isset($_GET['interval']) ? (int)$_GET['interval'] : 60; // segundos
  $limit     = isset($_GET['limit'])    ? max(10, (int)$_GET['limit']) : 300;

  // Normaliza paridade
  $pair = strtoupper(preg_replace('/[^A-Z0-9]/i', '', $pairRaw));

  $pairs = [
    'BTCUSDT' => ['start' => 40000.0, 'step' => 60.0,  'decimals' => 2],
    'ETHUSDT' => ['start' => 2500.0,  'step' => 8.0,   'decimals' => 2],
    'EURUSD'  => ['start' => 1.1000,  'step' => 0.001, 'decimals' => 5],
    'EURJPY'  => ['start' => 160.00,  'step' => 0.20,  'decimals' => 3],
  ];

  if (!isset($pairs[$pair])) {
    // Em vez de erro, devolve array vazio
    out_array([]);
  }

  if ($interval < 1)  $interval = 1;
  if ($limit   > 5000) $limit    = 5000;

  $cfg      = $pairs[$pair];
  $decimals = $cfg['decimals'];

  $baseDir   = __DIR__ . '/storage/ohlc';
  if (!is_dir($baseDir)) @mkdir($baseDir, 0775, true);
  $stateFile = sprintf('%s/state_%s_%ss.json', $baseDir, $pair, $interval);

  $load_state = function($file){
    if (is_file($file)) {
      $raw = @file_get_contents($file);
      if ($raw) {
        $j = json_decode($raw, true);
        if (is_array($j)) return $j;
      }
    }
    return null;
  };
  $save_state = function($file, $data){
    $tmp = $file . '.' . uniqid('', true) . '.tmp';
    @file_put_contents($tmp, json_encode($data, JSON_UNESCAPED_SLASHES));
    @rename($tmp, $file);
  };

  $fmt = function($v) use ($decimals) { return round((float)$v, $decimals); };

  $gen_candle = function($t, $prevClose) use ($cfg, $fmt){
    $step = $cfg['step'];
    $dir   = (mt_rand(0,100) < 53) ? 1 : -1;
    $delta = $dir * (mt_rand(50,150)/100.0) * $step;

    $open  = $prevClose;
    $close = $open + $delta;

    $wig   = (mt_rand(50,180)/100.0) * $step;
    $high  = max($open, $close) + $wig * (mt_rand(60,100)/100.0);
    $low   = min($open, $close) - $wig * (mt_rand(60,100)/100.0);

    $h = max($open, $close, $high);
    $l = min($open, $close, $low);

    return [
      'time'   => $t * 1000,
      'open'   => $fmt($open),
      'high'   => $fmt($h),
      'low'    => $fmt($l),
      'close'  => $fmt($close),
      'volume' => 0
    ];
  };

  $build_history = function($interval, $limit) use ($cfg, $gen_candle){
    $nowBar   = (int) floor(time() / $interval) * $interval;
    $firstBar = $nowBar - ($limit * $interval);

    $series     = [];
    $prevClose  = $cfg['start'];
    for ($t = $firstBar; $t < $nowBar; $t += $interval) {
      $c = $gen_candle($t, $prevClose);
      $series[]  = $c;
      $prevClose = $c['close'];
    }
    $state = [
      'last_time'  => $nowBar - $interval,
      'last_close' => $prevClose
    ];
    return [$series, $state];
  };

  $build_updates = function($state, $interval) use ($cfg, $gen_candle){
    $out      = [];
    $nowBar   = (int) floor(time() / $interval) * $interval;

    $lastTime  = $state['last_time']  ?? ($nowBar - $interval);
    $lastClose = $state['last_close'] ?? $cfg['start'];

    $steps = (int) floor(($nowBar - $lastTime) / $interval);
    if ($steps <= 0) return [$out, $state];

    for ($i=1; $i<=$steps; $i++){
      $barTime  = $lastTime + $interval;
      $c        = $gen_candle($barTime, $lastClose);
      $out[]    = $c;
      $lastTime  = $barTime;
      $lastClose = $c['close'];
    }
    $state['last_time']  = $lastTime;
    $state['last_close'] = $lastClose;
    return [$out, $state];
  };

  mt_srand((int)(microtime(true) * 1000000) % PHP_INT_MAX);
  $state = $load_state($stateFile);

  if ($mode === 'history' || !$state) {
    list($series, $newState) = $build_history($interval, $limit);
    $save_state($stateFile, $newState);
    out_array($series);
  }

  if ($mode === 'update') {
    list($updates, $newState) = $build_updates($state, $interval);
    if (!empty($updates)) $save_state($stateFile, $newState);
    out_array($updates);
  }

  // Modo inválido: devolve array vazio
  out_array([]);

} catch (\Throwable $e) {
  // Nunca quebra o front; apenas retorna []
  out_array([]);
}
