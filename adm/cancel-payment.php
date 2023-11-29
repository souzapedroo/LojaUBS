<?php

session_start();
ob_start();

define('ACCESS', true);

include_once './validate.php';
include '../config.php';

$reference_id = filter_input(INPUT_GET, 'id', FILTER_SANITIZE_NUMBER_INT);

if (!empty($reference_id)) {
    include_once './function.php';
    
    // Verificar o status do pagamento, salvar no BD e recuperar o authorizationId antes de cancelar a compra
    $data_result = paymentStatus($reference_id);

    var_dump($data_result);

    //Iniciar cUrl
    $ch = curl_init();

    // URL de requisição no PicPay
    curl_setopt($ch, CURLOPT_URL, "https://appws.picpay.com/ecommerce/public/payments/$reference_id/cancellations");

    // Paramêtro de resposta
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

    // Enviar o parâmetro referente ao SSL
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);

    //Informar que a requisição será através do método POST
    curl_setopt($ch, CURLOPT_POST, true);

    if (isset($data_result->authorizationId)) {
        // Enviar dados para o cancelamento
        $data_authorization = ['authorizationId' => $data_result->authorizationId];
        curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data_authorization));
    }

    // Enviar os headers
    $headers = [];
    $headers[] = 'Content-Type: application/json';
    $headers[] = 'x-picpay-token:' . PICPAYTOKEN;
    curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);

    // Realizar a requisição
    $result = curl_exec($ch);

    // Fechar a conexão
    curl_close($ch);
    
    // Verificar o status do pagamento e salvar no BD
    paymentStatus($reference_id);
    
    //Mensagem de sucesso
    $_SESSION['msg'] = "<div class='alert alert-success' role='alert'>Pagamento cancelado com sucesso!</div>";
    //Redirecionar o usuário
    header("Location: list-payment.php");
} else {
    //Mensagem de erro
    $_SESSION['msg'] = "<div class='alert alert-danger' role='alert'>Erro: Selecione um pagamento!</div>";
    //Redirecionar o usuário
    header("Location: list-payment.php");
}
