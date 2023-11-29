<?php

session_start();
ob_start();
define('ACCESS', true);
include_once './validate.php';
include_once '../config.php';
include_once '../connection.php';

$reference_id = filter_input(INPUT_GET, 'id', FILTER_SANITIZE_NUMBER_INT);

if (!empty($reference_id)) {
    //Iniciar cUrl
    $ch = curl_init();

    // URL de requisição no PicPay
    curl_setopt($ch, CURLOPT_URL, "https://appws.picpay.com/ecommerce/public/payments/$reference_id/status");

    // Paramêtro de resposta
    curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

    // Enviar o parâmetro referente ao SSL
    curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);

    // Enviar os headers
    $headers = [];
    $headers[] = 'Content-Type: application/json';
    $headers[] = 'x-picpay-token:' . PICPAYTOKEN;
    curl_setopt($ch, CURLOPT_HTTPHEADER, $headers);

    // Realizar a requisição
    $result = curl_exec($ch);

    // Fechar a conexão
    curl_close($ch);

    // Ler o conteúdo da resposta
    $data_result = json_decode($result);

    // Imprimir o conteúdo da resposta
    //var_dump($data_result);

    $query_pay_status = "SELECT id status_id FROM payments_status WHERE status = '" . $data_result->status . "' LIMIT 1";
    $result_pay_status = $conn->prepare($query_pay_status);
    $result_pay_status->execute();

    if ($result_pay_status->rowCount() != 0) {
        $row_pay_status = $result_pay_status->fetch(PDO::FETCH_ASSOC);
        //var_dump($row_pay_status);
        extract($row_pay_status);
        //var_dump($status_id);
        // Cadastrar o status da transação
        if ((isset($data_result->authorizationId)) AND (!empty($data_result->authorizationId))) {
            $query_transactions = "INSERT INTO transactions_status (authorization_id, payments_statu_id, payments_picpay_id, created) VALUES ('" . $data_result->authorizationId . "', $status_id, $reference_id, NOW())";
            $add_transactions = $conn->prepare($query_transactions);
            $add_transactions->execute();
        } else {
            $query_transactions = "INSERT INTO transactions_status (payments_statu_id, payments_picpay_id, created) VALUES ($status_id, $reference_id, NOW())";
            $add_transactions = $conn->prepare($query_transactions);
            $add_transactions->execute();
        }


        //Editar a compra informado o status da compra no PicPay
        $query_up_pay_picpay = "UPDATE payments_picpays SET payments_statu_id = $status_id, modified = NOW() WHERE id = $reference_id LIMIT 1";
        $up_pay_picpay = $conn->prepare($query_up_pay_picpay);
        $up_pay_picpay->execute();
        $_SESSION['msg'] = "<div class='alert alert-success' role='alert'>Status da compra alterado com sucesso!</div>";
        header("Location: list-payment.php");
    } else {
        $_SESSION['msg'] = "<div class='alert alert-danger' role='alert'>Erro: Tente novamente!</div>";
        header("Location: list-payment.php");
    }
} else {
    $_SESSION['msg'] = "<div class='alert alert-danger' role='alert'>Erro: Selecione um pagamento!</div>";
    header("Location: list-payment.php");
}

