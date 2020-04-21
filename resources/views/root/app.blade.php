<!doctype html>
<html lang="{{ app()->getLocale() }}">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="csrf-token" content="{{ csrf_token() }}">
        <title>Banco de im&aacute;genes - ESSSA | Grupo EPM</title>
        <link rel="stylesheet" href=" {{ asset('public/css/CBootstrap.css') }} ">
        @include('layout.css') 
        
    </head>
    <body>
        <div id="app">
           <Login/>
        </div>
        
        <script src=" {{ asset('public/js/app.js') }} "></script>
        @include('layout.js')
    </body>
</html>
