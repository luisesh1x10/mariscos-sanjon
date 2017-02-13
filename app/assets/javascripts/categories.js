angular.module("sanjon")
.controller("categorias",["$scope","$http","$location",function($scope,$http,$location){
   $scope.url = window.location.href.split("?")[0]+".json";
   $scope.activos = 0;
   $scope.bolsas = [];
   $scope.estados=[];
   $scope.audio = new Audio('/bells.mp3');
      $scope.estados.push("Pendiente");
      $scope.estados.push("En Proceso");
      $scope.estados.push("Terminado");
    console.log($scope.url);
    console.log( window.location.pathname);
    $scope.beep = function(){
        $scope.audio.play();
    }
    $scope.avanzar = function(val){
        $http.get("/avanzar/"+val.id+".json")
        .success(function(data){
            $scope.obtener_platillos();
        })
        .error(function(data){
            console.log(data);
        });
    }
    $scope.obtener_platillos = function(){
        $http.get($scope.url)
        .success(function (data){
            console.log(angular.toJson($scope.bolsas) === JSON.stringify(data));
            if (!(angular.toJson($scope.bolsas) === JSON.stringify(data))){
                var ids1 = new Array();
                var ids2 = new Array();
                for (var x = 0; x<$scope.bolsas.length;x++)
                    ids1.push($scope.bolsas[x].id);
                for (var x = 0; x<data.length;x++)
                    ids2.push(data[x].id);
                for (var x = 0; x<ids1.length;x++){
                    var index = ids2.indexOf(ids1[x]);
                    if (index > -1)
                        ids2.splice(index,1)
                }
                        
                if (ids2.length>0)
                    $scope.beep();
                $scope.bolsas=data;
                $scope.bolsas.length==0?$scope.activos=0:$scope.activos=numero_platillos(data);
            }
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
      $scope.obtener_platillos();
    }
    $http.get($scope.url)
        .success(function (data){
            $scope.bolsas=data;
            $scope.bolsas.length==0?$scope.activos=0:$scope.activos=numero_platillos(data);
        })
        .error(function (data){
            console.log(data);
        });
    
}]);