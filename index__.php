<?php
ini_set('display_errors', 1);
ini_set('display_startup_errors', 1);
error_reporting(E_ALL);
register_shutdown_function(function(){ $e = error_get_last(); if($e){ echo "<pre>FATAL:\n".print_r($e,true)."</pre>"; }});

<!DOCTYPE html>
<html lang="pt-BR">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Manutenção Programada</title>
    <style>
        body, html {
            margin: 0;
            padding: 0;
            height: 100%;
            font-family: Arial, sans-serif;
            display: flex;
            justify-content: center;
            align-items: center;
            background-color: #151515;
        }
        .container {
            text-align: center;
            max-width: 90%;
            padding: 20px;
        }
        img {
            max-width: 100%;
            height: auto;
        }
        .message {
            margin-top: 20px;
            padding: 10px;
            background-color: #fff;
            border: 1px solid #ddd;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }
        @media (max-width: 600px) {
            .message {
                font-size: 14px;
            }
        }
    </style>
</head>
<body>
    <div class="container">
        <img src="logo/logo.png" alt="Logo">
        <div class="message">
            Teremos uma manutenção programada em nossa infraestrutura para melhor atendê-los.<br><br>
            Durante este período algumas funções ficarão indisponíveis e teremos instabilidades no sistema de investimentos.<br><br>
            Contamos com sua compreensão durante este período de 48h.<br><br>
        </div>
    </div>
</body>
</html>
