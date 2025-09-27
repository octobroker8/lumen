<?php
define('DEBUG', false);
define('DEMO', false);



$cache = 0;
if(DEBUG)  $cache = time();

// PrimePag

include('classes/primepag.php');

// Support Database
include('classes/db.class.php');
$db  = new sql_db();
$db->getConnect();

// Core
include('classes/core.class.php');
$core  = new Core();

$dados = json_decode(file_get_contents('php://input'), true);
if($_SERVER["HTTP_AUTHORIZATION"] === $authoPrime){
  if($dados['notification_type'] === 'pix_qrcode' || $dados['notification_type'] === 'pix_static_qrcode' ) {
    $prime = $db->assoc("SELECT * FROM primepag WHERE reference_code = '".$dados["message"]["reference_code"]."'");
    $i = $db->assoc("SELECT * FROM payin WHERE id = '".$prime["transacao"]."' AND status = '0'");
    if(!empty($i) && $dados["message"]["status"] === "paid"){
      $valor = number_format($dados["message"]["value_cents"] / 100, 2, '.', '');
      $bonus = number_format($i["bonus"], 2, '.', '');
      $primepag = $db->update('users', "balance=balance+'".$valor."', bonus=bonus+'".$bonus."', `depositante`='1', cron_afiliado = 0 WHERE id = '".$i["user_id"]."'");
      $db->update('payin', "status = '1', amount = '".$valor."'  WHERE id = '".$prime["transacao"]."'");
      $partner = $db->read("SELECT user_id FROM referals WHERE referal_id = '".$i["user_id"]."'");
      if($partner) {
        $core->partnerStat('deposits', $valor, $partner);
        $core->partnerStat('deposito', 1, $partner);
      }
      $json['status'] = 'ok';
      $json['id'] = $i['id'];
      echo json_encode($json);
    }else{
      header('HTTP/1.1 500 Internal Server Booboo');
      header('Content-Type: application/json; charset=UTF-8');
      die(json_encode(array('msg' => 'ERROR')));
    }
  }elseif($dados['notification_type'] === 'pix_payment') {
    $arr = [];
    $payout = $db->assoc("SELECT * FROM payout WHERE reference_code = '".$dados['message']['reference_code']."'");
    if(!$payout){
      header('HTTP/1.1 500 Internal Server Booboo');
      header('Content-Type: application/json; charset=UTF-8');
      die(json_encode(array('msg' => 'Pagamento não encontrado!')));
    }
    if($dados['message']['status'] === "completed"){
      $arr['status'] = 1;
    }elseif($dados['message']['status'] === "canceled" && (int)$payout['status'] != 6){
      $payout['metadata'] = json_decode($payout['metadata'], true);
      $payout['metadata']['cancellation_reason'] = $dados['message']['cancellation_reason'];
      $valor = number_format($dados["message"]["value_cents"] / 100, 2, '.', '');
      $arr['metadata'] = json_encode($payout['metadata']);
      $arr['status'] = 6;
      if($payout['tipo'] === "normal"){
        $primepag = $db->update('users', "balance=balance+'".$valor."' WHERE id = '".$payout["user_id"]."'");
      }elseif($payout['tipo'] === 'afiliado'){
        $primepag = $db->update('users', "balance_afiliado=balance_afiliado+'".$valor."' WHERE id = '".$payout["user_id"]."'");
      }
      
    }elseif($dados['message']['status'] === "sent"){
      $arr['status'] = 3;
    }elseif($dados['message']['status'] === "authorization_pending"){
      $arr['status'] = 4;
    }elseif($dados['message']['status'] === "auto_authorization"){
      $arr['status'] = 5;
    }
     $arr['tipo'] = $payout['tipo'];
     $db->update('payout', $arr, " reference_code = '".$dados['message']['reference_code']."' ");
     header("HTTP/1.1 200 OK");
     header('Content-Type: application/json; charset=UTF-8');
     echo json_encode(array('msg' => 'OK!'));
  }
  

}else{
  header('HTTP/1.1 404 Internal Server Booboo');
  header('Content-Type: application/json; charset=UTF-8');
  die();
}