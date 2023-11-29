<?php

if(!defined('ACCESS')){
    header("Location: /");
    die("Erro: Pagina nao encontrada!<br>");
}

if((!isset($_SESSION['user_id'])) OR (!isset($_SESSION['user_email'])) OR (!isset($_SESSION['user_key']))){
    unset($_SESSION['user_id'], $_SESSION['user_name'], $_SESSION['user_email'], $_SESSION['user_key']);
    $_SESSION['msg'] = "<div class='alert alert-danger' role='alert'>Erro: Necessário realizar o login para acessar a página!</div>";
    header("Location: index.php");
    die("Erro: Página não encontrada!<br>");
}
