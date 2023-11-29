<?php
session_start();
define('ACCESS', true);
include_once '../connection.php';
?>
<!DOCTYPE html>
<html lang="pt-br">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="shortcut icon" href="../images/icon/favicon.ico" >
        <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/css/bootstrap.min.css" integrity="sha384-B0vP5xmATw1+K9KRQjQERJvTumQW0nPEzvF6L/Z6nronJ3oUOFUFpCjEUQouq2+l" crossorigin="anonymous">
        <link rel="stylesheet" href="css/login.css">
        <title>Loja UBC - Login</title>
    </head>
    <body>
        <?php
        //Criptografar a senha
        //$password_encrypted = password_hash("123456a", PASSWORD_DEFAULT);
        //echo $password_encrypted;
        
        //Receber os dados do formulário
        $data = filter_input_array(INPUT_POST, FILTER_DEFAULT);

        //Variável para receber a mensagem de erro ou sucesso
        $msg = "";

        // Acessar o IF quando o usuário clica no botão
        if (isset($data['BtnLogin'])) {
            $empty_input = false;
            $data = array_map('trim', $data);
            if (in_array("", $data)) {
                $empty_input = true;
                $msg = "<div class='alert alert-danger' role='alert'>Erro: Necessário preencher todos os campos!</div>";
            } elseif (!filter_var($data['email'], FILTER_VALIDATE_EMAIL)) {
                $empty_input = true;
                $msg = "<div class='alert alert-danger' role='alert'>Erro: Necessário preencher com e-mail válido!</div>";
            }

            // Acessa o IF quando não há nenhum erro no formulário
            if (!$empty_input) {
                //Pesquisar o usuário BD
                $query_user = "SELECT id, name, email, password FROM users WHERE email =:email LIMIT 1";
                $result_user = $conn->prepare($query_user);
                $result_user->bindParam(':email', $data['email']);
                $result_user->execute();
                if($result_user->rowCount() != 0){
                    //$msg = "<div class='alert alert-success' role='alert'>E-mail encontrado!</div>";
                    $row_user = $result_user->fetch(PDO::FETCH_ASSOC);
                    
                    //Verificar a senha
                    if(password_verify($data['password'], $row_user['password'])){
                        //$msg = "<div class='alert alert-success' role='alert'>Usuário e senha valida!</div>";
                        $_SESSION['user_id'] = $row_user['id'];
                        $_SESSION['user_name'] = $row_user['name'];
                        $_SESSION['user_email'] = $row_user['email'];
                        $_SESSION['user_key'] = password_hash($row_user['id'], PASSWORD_DEFAULT);
                        
                        header("Location: list-payment.php");
                    }else{
                        $msg = "<div class='alert alert-danger' role='alert'>Erro: Usuário ou a senha incorreta!</div>";
                    }
                }else{
                    $msg = "<div class='alert alert-danger' role='alert'>Erro: Usuário ou a senha incorreta!</div>";
                }
            }
        }
        ?>
        <form method="POST" action="" class="form-signin">
            <div class="text-center mb-4">
                <img class="mb-4" src="../images/logo/logo.png" alt="" width="72" height="72">
                <h1 class="h3 mb-3 font-weight-normal">Área Restrita</h1>                
            </div>
            <?php
            if (!empty($msg)) {
                echo $msg;
                $msg = "";
            }
            if(isset($_SESSION['msg'])){
                echo $_SESSION['msg'];
                unset($_SESSION['msg']);
            }
            ?>
            <div class="form-label-group">
                <input type="email" name="email" id="email" class="form-control" placeholder="E-mail" value="<?php if(isset($data['email'])){ echo $data['email']; } ?>" autofocus>
                <label for="email">E-mail</label>
            </div>

            <div class="form-label-group">
                <input type="password" name="password" id="password" class="form-control" placeholder="Senha" value="<?php if(isset($data['password'])){ echo $data['password']; } ?>">
                <label for="password">Senha</label>
            </div>

            <button type="submit" name="BtnLogin" class="btn btn-lg btn-primary btn-block" value="BtnLogin">Acessar</button>
        </form>

        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@4.6.0/dist/js/bootstrap.bundle.min.js" integrity="sha384-Piv4xVNRyMGpqkS2by6br4gNJ7DXjqk09RmUpJ8jgGtD7zP9yug3goQfGII0yAns" crossorigin="anonymous"></script>
    </body>
</html>
