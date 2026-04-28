angular.module("sanjon")
.controller("categorias",["$scope","$http","$location","$window","$q",function($scope,$http,$location,$window,$q){
   $scope.url = window.location.href.split("?")[0] + ".json";
   $scope.historialURL = window.location.href.split("?")[0] + '/historial';
   $scope.originUrl = window.location.href.split("/historial")[0];
   $scope.activos = 0;
   $scope.mostrados = 0;
   $scope.bolsas = [];
   $scope.pagina = 0;
   $scope.cargando = false;
   $scope.puedeCargarMas = true;
   $scope.estados=[];
   $scope.audio = new Audio('/bells.mp3');
      $scope.estados.push("Pendiente");
      $scope.estados.push("En Proceso");
      $scope.estados.push("Terminado");
    console.log($scope.url);
    console.log( window.location.pathname);
    $scope.beep = function(){
        $scope.audio.play();
        $scope.audio.pause();
        $scope.audio.play();
    }
    $scope.avanzar = function(val){
        $http.get("/avanzar/"+val.id+".json")
        .success(function(data){
            $scope.obtener_platillos(true);
        })
        .error(function(data){
            console.log(data);
        });
    }
    function normalizarRespuesta(data){
        if (angular.isArray(data)) {
            return {
                bolsas: data,
                has_more: data.length >= 30,
                page: 0,
                total_pedidos: null
            };
        }
        return {
            bolsas: data.bags || [],
            has_more: data.has_more,
            page: data.page || 0,
            total_pedidos: data.total_pedidos
        };
    }
    function idsDeBolsas(bolsas){
        var ids = [];
        for (var x = 0; x < bolsas.length; x++)
            ids.push(bolsas[x].id);
        return ids;
    }
    function unirBolsas(bolsasActuales, bolsasNuevas){
        var ids = idsDeBolsas(bolsasActuales);
        for (var x = 0; x < bolsasNuevas.length; x++) {
            if (ids.indexOf(bolsasNuevas[x].id) === -1)
                bolsasActuales.push(bolsasNuevas[x]);
        }
        return bolsasActuales;
    }
    function totalPedidos(respuesta){
        return respuesta.total_pedidos === null || angular.isUndefined(respuesta.total_pedidos) ? numero_platillos($scope.bolsas) : respuesta.total_pedidos;
    }
    function totalPaginasCargadas(){
        return $scope.pagina + 1;
    }
    $scope.obtener_platillos = function(reiniciar){
        if ($scope.cargando) return;
        if (!reiniciar && !$scope.puedeCargarMas) return;

        var paginaSolicitada = reiniciar ? 0 : $scope.pagina + 1;
        $scope.cargando = true;

        $http.get($scope.url, {params: {page: paginaSolicitada}})
        .success(function (data){
            var respuesta = normalizarRespuesta(data);
            var bolsas = respuesta.bolsas;

            if (reiniciar) {
                if (!(angular.toJson($scope.bolsas.slice(0, bolsas.length)) === JSON.stringify(bolsas))){
                    var ids1 = idsDeBolsas($scope.bolsas);
                    var ids2 = idsDeBolsas(bolsas);
                    for (var x = 0; x<ids1.length;x++){
                        var index = ids2.indexOf(ids1[x]);
                        if (index > -1)
                            ids2.splice(index,1)
                    }

                    if (ids2.length>0)
                        $scope.beep();
                }
                $scope.bolsas = bolsas;
                $scope.pagina = 0;
                $scope.puedeCargarMas = respuesta.has_more;
            } else {
                $scope.bolsas = unirBolsas($scope.bolsas, bolsas);
                $scope.pagina = paginaSolicitada;
                $scope.puedeCargarMas = respuesta.has_more;
            }

            $scope.activos = totalPedidos(respuesta);
            $scope.mostrados = numero_platillos($scope.bolsas);
        })
        .error(function (data){
            console.log(data);
        })
        .finally(function(){
            $scope.cargando = false;
            // Si al terminar el usuario sigue cerca del final, cargar la siguiente pagina de inmediato
            if ($scope.puedeCargarMas && cercaDelFinal()) {
                $scope.obtener_platillos(false);
            }
        });
    }
    $scope.cargar_mas = function(){
        $scope.obtener_platillos(false);
    }
    function cercaDelFinal(){
        var documento = document.documentElement;
        var scrollTop = $window.pageYOffset || documento.scrollTop || document.body.scrollTop || 0;
        var altoVentana = $window.innerHeight || documento.clientHeight;
        var altoDocumento = Math.max(
            document.body.scrollHeight,
            documento.scrollHeight,
            document.body.offsetHeight,
            documento.offsetHeight
        );
        // Disparar cuando faltan ~3 pantallas para llegar al fondo
        // O cuando ya se scrolleo mas del 55% del contenido total
        var distanciaAlFondo = altoDocumento - (scrollTop + altoVentana);
        var cercaPorPx = distanciaAlFondo <= altoVentana * 3;
        var cercaPorPct = altoDocumento > 0 && ((scrollTop + altoVentana) / altoDocumento) >= 0.55;
        return cercaPorPx || cercaPorPct;
    }
    // Scroll throttled con requestAnimationFrame para evitar jank
    var scrollPendiente = false;
    var rAF = $window.requestAnimationFrame || function(cb){ return setTimeout(cb, 16); };
    function onScroll(){
        if (scrollPendiente) return;
        scrollPendiente = true;
        rAF(function(){
            scrollPendiente = false;
            // Chequeo rapido fuera del digest cycle
            if ($scope.cargando || !$scope.puedeCargarMas) return;
            if (!cercaDelFinal()) return;
            $scope.$apply(function(){
                $scope.cargar_mas();
            });
        });
    }
    angular.element($window).on('scroll', onScroll);
    $scope.$on('$destroy', function(){
        angular.element($window).off('scroll', onScroll);
    });
    $scope.refrescar_platillos = function(){
        if ($scope.cargando) return;
        var paginasCargadas = totalPaginasCargadas();
        var peticiones = [];
        for (var pagina = 0; pagina < paginasCargadas; pagina++) {
            peticiones.push($http.get($scope.url, {params: {page: pagina}}));
        }
        $scope.cargando = true;
        $q.all(peticiones)
        .then(function (respuestas){
            var bolsas = [];
            var puedeCargarMas = false;
            for (var i = 0; i < respuestas.length; i++) {
                var respuesta = normalizarRespuesta(respuestas[i].data);
                bolsas = unirBolsas(bolsas, respuesta.bolsas);
                puedeCargarMas = respuesta.has_more;
            }
            if (!(angular.toJson($scope.bolsas) === JSON.stringify(bolsas))){
                var ids1 = idsDeBolsas($scope.bolsas);
                var ids2 = idsDeBolsas(bolsas);
                for (var x = 0; x<ids1.length;x++){
                    var index = ids2.indexOf(ids1[x]);
                    if (index > -1)
                        ids2.splice(index,1)
                }
                if (ids2.length>0)
                    $scope.beep();
                $scope.bolsas = bolsas;
            }
            $scope.puedeCargarMas = puedeCargarMas;
            var ultimaRespuesta = respuestas.length > 0 ? normalizarRespuesta(respuestas[0].data) : null;
            $scope.activos = ultimaRespuesta ? totalPedidos(ultimaRespuesta) : numero_platillos($scope.bolsas);
            $scope.mostrados = numero_platillos($scope.bolsas);
        })
        .catch(function (data){
            console.log(data);
        })
        .then(function(){
            $scope.cargando = false;
            if (!$scope.$$phase) $scope.$apply();
        });
    }
    $scope.refrescar_primera_pagina = function(){
        $http.get($scope.url, {params: {page: 0}})
        .success(function (data){
            var respuesta = normalizarRespuesta(data);
            var bolsas = respuesta.bolsas;
            if (!(angular.toJson($scope.bolsas.slice(0, bolsas.length)) === JSON.stringify(bolsas))){
                var ids1 = idsDeBolsas($scope.bolsas);
                var ids2 = idsDeBolsas(bolsas);
                for (var x = 0; x<ids1.length;x++){
                    var index = ids2.indexOf(ids1[x]);
                    if (index > -1)
                        ids2.splice(index,1)
                }
                if (ids2.length>0)
                    $scope.beep();
                $scope.bolsas = unirBolsas(bolsas, $scope.bolsas);
                $scope.mostrados = numero_platillos($scope.bolsas);
            }
            $scope.activos = totalPedidos(respuesta);
        })
        .error(function (data){
            console.log(data);
        });
    }
    function numero_platillos(val){
        var sum=0;
        for(var x=0;x<val.length;x++){
            sum = sum + val[x].platillos.length;    
        }
        return sum;
    }
    setInterval(myMethod, 10000);

    function myMethod( )
    {
      $scope.refrescar_platillos();
    }
    $scope.obtener_platillos(true);
    
}]);
