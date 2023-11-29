<?php
session_start();
unset($_SESSION['user_id'], $_SESSION['user_name'], $_SESSION['user_email'], $_SESSION['user_key']);

$_SESSION['msg'] = "<div class='alert alert-success' role='alert'>Deslogado com sucesso!</div>";
header("Location: index.php");
die("Erro: Página não encontrada!<br>");
