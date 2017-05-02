angular.module('sanjon')
.controller('pagos',['$scope','$http','$location',function($scope,$http,$location){
    $scope.mesas  =[];
    $scope.ordenes=[];
    $scope.derecha=[];
    $scope.izquierda =[];
    $scope.ordenes_disponiblles=[];
    $scope.tipo;
    $scope.getOrdenes = function(){
       $('.collapsible').collapsible();
      $http.get("/orders/query.json?takeaway_v=false")
      .success(function(data){
        $scope.ordenes_disponiblles =data;
      })
      .error(function(data){
        console.log(data);
      });
    }
    $scope.getMesas = function(){
      $http.get("/tables.json")
      .success(function(data){
        $scope.mesas =data;
         console.log($scope.mesas);
      })
      .error(function(data){
        console.log(data);
      });
    }
  $scope.cambiarMesa = function(orden){
      $.ajax({
          type:'PUT',
          url: '/orders/'+orden.id,
          dataType: 'json',
          data: { order: {table_id:orden.table_id}},
          success: function(data){
            console.log(data);
             $scope.cargarOrdenes();
                     },
          error: function(data){
            console.log(data);
          }
      });
  }
  $scope.cambiarCantidad = function(val){
    console.log(val);
    if (val.quantity===null)
     val.quantity=1;
      $.ajax({
          type:'PUT',
          url: '/saucer_orders/'+val.id,
          dataType: 'json',
          data: { saucer_order: {quantity:val.quantity}},
          success: function(data){
            console.log(data);
            
                     },
          error: function(data){
            $scope.cargarOrdenes();
            console.log(data);
          }
      });
  }
   $scope.cambiarOrden = function(val){
    console.log(val);
    if (val.quantity===null)
     val.quantity=1;
      $.ajax({
          type:'PUT',
          url: '/saucer_orders/'+val.id,
          dataType: 'json',
          data: { saucer_order: {order_id:val.order_id}},
          success: function(data){
            console.log(data);
          
            $scope.cargarOrdenes();
                     },
          error: function(data){
            Materialize.toast('No se pudo cambiar pedido', 4000) 
            console.log(data);
          }
      });
  }
  table_id=$location.absUrl().split('?')[0].split('/')[4];
  if (Number(table_id))
    cat ="/orders/query.json?table_id="+table_id;
  else
    cat= "/orders/query.json?takeaway_v=true";
  
  $scope.cargarOrdenes = function(){
    $scope.izquierda=[];
    $scope.derecha=[];
    $http.get(cat)
    .success(function (data){
        $scope.ordenes=data;
        for (var x=0;x<data.length;x++){
            if (x%2==0){
                $scope.izquierda.push(data[x]);
            }else{
                $scope.derecha.push(data[x]);
            }
        }
        $scope.tipo=data[0].user_type;
    })
    .error(function (data){
        console.log(data);
    });
  }
  $scope.actulizarPago=function(orden,payment){
    console.log(orden);
      $.ajax({
          type:'PUT',
          url: '/orders/'+orden,
          dataType: 'json',
          data: { order: {payment:payment}},
          success: function(data){
                     },
          error: function(data){
            console.log(data);
          }
      });
  }
   $scope.cargarOrdenes();
  $scope.getMesas();
  $scope.getOrdenes();
        
}]);