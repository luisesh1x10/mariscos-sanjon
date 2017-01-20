angular.module('sanjon').
controller('pedidos',['$scope','$http', function($scope,$http){
    $scope.categories=[];
    $scope.pedidos=[];
    $scope.group="";
    $scope.indice="";
    $scope.platillo="";
    root = $(location).attr('href').split('?')[0];
    function postPedido(datos,index){
         $.ajax({
          type:'POST',
          url: root+'/saucer_orders',
          dataType: 'json',
          data: { saucer_order: datos},
          success: function(data){
            console.log(data);
            $scope.pedidos.pop(index);
            if ($scope.pedidos.length==0)
                $("#atrasButton")[0].click();
         },
          error: function(data){
            console.log(data);
            
             $("#divEnviar").append('<a class="waves-effect amber darken-4 btn" ng-click="postPedidos()" id="enviar">Enviar</a>');
            Materialize.toast('Un pedido no pudo ser enviado', 4000);
            return true;
          }
         });
    };
    $scope.updatePedidos=function(val){
        $scope.indice=val;
        $('#modalAdd').openModal();
    };
    $scope.removePedido=function(val){
        $scope.pedidos.pop(val);
    };
    $http.get('/categories.json')
    .success(function(data){
        console.log(data);
         $scope.categories=data;
    })
    .error(function(data){
        console.log(data);
    });
    $scope.cargarGrupo=function(val){
        $http.get('/groups/'+val.id+'.json')
        .success(function (data){
            console.log(data);
            $scope.group=data;
        })
        .error(function (data){
            console.log(data);
        });
        
        $('#modalAdd').openModal();
         console.log($scope.group);
    };
    $scope.getPlatilloByid=function (val){
        for (var x=0;x<$scope.group.platillos.length;x++){
            if ($scope.group.platillos[x].id==parseInt(val)){
                console.log('ddd'+$scope.group.platillos[x]);
                return $scope.group.platillos[x];
            }
        }
    }
    $scope.add=function(){
      $scope.pedidos.push(
          {platillo_id:$scope.platillo,
          quantity:$scope.numero,
          notes:$scope.anotaciones,
          price:$scope.getPlatilloByid($scope.platillo).price,
          name:$scope.getPlatilloByid($scope.platillo).name,
          group:$scope.group.id
          });
      $scope.anotaciones="";
      $scope.numero="";
      console.log( $scope.pedidos);
    };
    $scope.postPedidos = function(){
        $("#enviar").remove();
        for (var x=0;x<$scope.pedidos.length;x++)
            postPedido($scope.pedidos[x],x)
    }
    
    
}])
.controller("historial",["$scope","$http",function($scope,$http){
    $scope.ordenes=[];
    
    $scope.query = function(pagina){
        $http.get("/historial.json")
        .success(function(data){
            console.log(data);
            $scope.ordenes= data;
        })
        .error(function(data){
            console.log(data);
        });
    }
    $scope.reactivar = function(val){
          $.ajax({
          type:'PUT',
          url: '/orders/'+115,
          dataType: 'json',
          data: { order: {status:1}},
          success: function(data){
              console.log(data);
              $scope.query(0);
                     },
          error: function(data){
            console.log(data);
          }
         });
        
    }
    $scope.query(0);
}]);