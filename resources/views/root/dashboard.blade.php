<!doctype html>
<html lang="es">
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta http-equiv="Content-Type" content="text/html; charset=utf-8">
        @include('layout.css') 
        
        <title>Banco de im&aacute;genes - ESSSA | Grupo EPM</title>
        <!-- Fonts -->
        <link href="https://fonts.googleapis.com/css?family=Nunito:200,600" rel="stylesheet">
    </head>
    <body>
        
        <div id="app">
            <div @click="$CustomModal.actions.closeCustomModal()" class="customModal"></div> 
            <Dashboard ref="dashboard" />
        </div>
        @include('layout.js')
        <script> window.loggedUser = @json($loggedUser) </script>
        <script src=" {{ asset('public/js/app.js') }} "></script>
        <script src="nonpmplugins/jquery-ui/jquery-ui.min.js" ></script>
    </body>
</html>
