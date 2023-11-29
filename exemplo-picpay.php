<?php

include_once './config.php';

// Dados da compra
$referenceId = rand(1000, 9999);
$data_buy = [
    "referenceId" => $referenceId,
    "callbackUrl" => "http://www.sualoja.com.br/callback",
    "returnUrl" => "http://www.sualoja.com.br/cliente/pedido/$referenceId",
    "value" => 20.51,
    "expiresAt" => "2022-05-01T16:00:00-03:00",
    "buyer" => [
        "firstName" => "João",
        "lastName" => "Da Silva",
        "document" => "123.456.789-10",
        "email" => "teste@picpay.com",
        "phone" => "+55 27 12345-6789"
    ]
];

var_dump($dada_buy);



//Iniciar cUrl
$ch = curl_init();

// URL de requisição no PicPay
curl_setopt($ch, CURLOPT_URL, 'https://appws.picpay.com/ecommerce/public/payments');

// Paramêtro de resposta
curl_setopt($ch, CURLOPT_RETURNTRANSFER, true);

// Enviar o parâmetro referente ao SSL
curl_setopt($ch, CURLOPT_SSL_VERIFYPEER, false);

// Enviar dados da compra
curl_setopt($ch, CURLOPT_POSTFIELDS, json_encode($data_buy));

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
var_dump($data_result);

echo "<img src='" . $data_result->qrcode->base64 . "'><br><br>";
echo "Link da fatura: <a href='" . $data_result->paymentUrl . "' target='_blank'>Fatura</a><br><br>";
