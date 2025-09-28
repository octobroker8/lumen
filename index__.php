<?php
// index.php — Frontend em PHP que renderiza o gráfico amCharts 5
// Requisitos:
//  - Carrega histórico inicial via data.php?action=history
//  - Continua pedindo novas velas em loop via data.php?action=next
//  - Permite trocar de par (BTC/USDT, ETH/USDT, EUR/USD, EUR/JPY)
//  - Intervalo das velas em segundos (default: 2s)
?>
<!doctype html>
<html lang="pt-BR">
<head>
  <meta charset="utf-8" />
  <meta name="viewport" content="width=device-width,initial-scale=1" />
  <title>amCharts 5 — Candlestick com Backend PHP (simulado)</title>

  <!-- amCharts 5 (CDN oficial) -->
  <script src="https://cdn.amcharts.com/lib/5/index.js"></script>
  <script src="https://cdn.amcharts.com/lib/5/xy.js"></script>
  <script src="https://cdn.amcharts.com/lib/5/themes/Animated.js"></script>

  <style>
    :root {
      color-scheme: dark;
    }
    html, body {
      height: 100%;
      margin: 0;
      background: #0E1217;
      color: #E7ECEF;
      font-family: system-ui, -apple-system, Segoe UI, Roboto, Ubuntu, Cantarell, "Helvetica Neue", Arial, "Noto Sans", "Apple Color Emoji", "Segoe UI Emoji";
    }
    .topbar {
      display: flex;
      gap: 12px;
      align-items: center;
      padding: 10px 12px;
      background: #121722;
      border-bottom: 1px solid #1f2633;
    }
    .topbar select, .topbar input, .topbar button {
      background: #0E141E;
      color: #D7DFEA;
      border: 1px solid #1f2633;
      border-radius: 6px;
      padding: 8px 10px;
      outline: none;
    }
    #chartdiv {
      width: 100%;
      height: calc(100% - 56px);
    }
    .notice {
      font-size: 12px;
      opacity: .8;
      margin-left: auto;
    }
  </style>
</head>
<body>

  <div class="topbar">
    <label for="pair">Par:</label>
    <select id="pair">
      <option value="BTCUSDT">BTC/USDT</option>
      <option value="ETHUSDT">ETH/USDT</option>
      <option value="EURUSD">EUR/USD</option>
      <option value="EURJPY">EUR/JPY</option>
    </select>

    <label for="interval">Intervalo (s):</label>
    <input id="interval" type="number" min="1" step="1" value="2" style="width:90px" />

    <button id="reload">Recarregar</button>
    <span class="notice">Fonte: simulação local (data.php)</span>
  </div>

  <div id="chartdiv"></div>

<script>
(() => {
  // ==========================
  // Configuração base do app
  // ==========================
  const API_URL = 'data.php';     // mesmo diretório
  let SYMBOL   = 'BTCUSDT';
  let INTERVAL = 2;               // segundos
  let pollTimer = null;           // setInterval handler
  let lastTs = null;              // último timestamp (ms) recebido

  // ==========================
  // UI (par e intervalo)
  // ==========================
  const pairSel   = document.getElementById('pair');
  const intervalI = document.getElementById('interval');
  const reloadBtn = document.getElementById('reload');

  pairSel.addEventListener('change', () => {
    SYMBOL = pairSel.value;
    initChart(); // recarrega tudo para o novo par
  });

  reloadBtn.addEventListener('click', () => {
    INTERVAL = Math.max(1, parseInt(intervalI.value || '2', 10));
    initChart();
  });

  // ==========================
  // amCharts 5 — setup
  // ==========================
  let root, chart, xAxis, yAxis, series, cursor;

  function buildChart() {
    if (root) {
      root.dispose();
    }

    root = am5.Root.new("chartdiv");
    root.setThemes([ am5themes_Animated.new(root) ]);

    chart = root.container.children.push(am5xy.XYChart.new(root, {
      panX: true,
      panY: false,
      wheelX: "panX",
      wheelY: "zoomX",
      pinchZoomX: true,
      layout: root.verticalLayout
    }));

    // Eixo X temporal
    xAxis = chart.xAxes.push(
      am5xy.DateAxis.new(root, {
        baseInterval: { timeUnit: "second", count: INTERVAL },
        groupData: false,
        renderer: am5xy.AxisRendererX.new(root, {}),
        tooltip: am5.Tooltip.new(root, {})
      })
    );

    // Eixo Y de preço
    yAxis = chart.yAxes.push(
      am5xy.ValueAxis.new(root, {
        renderer: am5xy.AxisRendererY.new(root, { pan: "zoom" })
      })
    );

    // Série de velas
    series = chart.series.push(
      am5xy.CandlestickSeries.new(root, {
        name: SYMBOL,
        xAxis,
        yAxis,
        openValueYField: "o",
        highValueYField: "h",
        lowValueYField: "l",
        valueYField: "c",
        valueXField: "t",
        clustered: false,
        tooltip: am5.Tooltip.new(root, {
          labelText: "{name}\nO:{openValueY}\nH:{highValueY}\nL:{lowValueY}\nC:{valueY}"
        })
      })
    );

    // Cursor e scroll
    cursor = chart.set("cursor", am5xy.XYCursor.new(root, { xAxis }));
    chart.set("scrollbarX", am5.Scrollbar.new(root, { orientation: "horizontal" }));

    // Aparição
    series.appear(1000);
    chart.appear(1000, 100);
  }

  // ==========================
  // Data loading
  // ==========================
  async function fetchJSON(url) {
    const r = await fetch(url, { cache: "no-cache" });
    if (!r.ok) throw new Error(`HTTP ${r.status}`);
    return r.json();
  }

  async function loadHistory() {
    const url = `${API_URL}?action=history&symbol=${encodeURIComponent(SYMBOL)}&interval=${INTERVAL}`;
    const data = await fetchJSON(url);
    // data: { symbol, interval, candles:[{t,o,h,l,c,v}] }
    lastTs = null;
    series.data.setAll(data.candles);
    if (data.candles.length) {
      lastTs = data.candles[data.candles.length - 1].t;
    }
  }

  async function pollNext() {
    if (!lastTs) return;
    const url = `${API_URL}?action=next&symbol=${encodeURIComponent(SYMBOL)}&interval=${INTERVAL}&last=${lastTs}`;
    try {
      const data = await fetchJSON(url);
      if (Array.isArray(data.candles) && data.candles.length) {
        for (const c of data.candles) {
          series.data.push(c);
          lastTs = c.t;
        }
      }
    } catch (err) {
      // silencioso para não poluir o console caso a rede oscile
    }
  }

  function startPolling() {
    if (pollTimer) clearInterval(pollTimer);
    // Faz um "ping" um pouco mais rápido que o intervalo da vela
    pollTimer = setInterval(pollNext, Math.max(500, INTERVAL * 900)); // ~0.9x
  }

  async function initChart() {
    buildChart();
    await loadHistory();
    startPolling();
  }

  // inicial
  initChart();
})();
</script>
</body>
</html>
