angular.module('sanjon')
.controller('pagos',['$scope','$http','$location',function($scope,$http,$location){
    $scope.mesas  =[];
    $scope.ordenes=[];
    $scope.derecha=[];
    $scope.izquierda =[];
    $scope.ordenes_disponiblles=[];
    $scope.tipo;
    $scope.descuentoOpciones = [0,5,10,15,20,25,30,35,40,45,50,55,60,65,70,75,80,85,90,95,100];
    $scope.descuentoGeneral ="0" ;
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
        console.log(data);
        for (var x=0;x<data.length;x++){
          data[x].ivaTotal = 0;
          if (x%2==0){
              $scope.izquierda.push(data[x]);
          }else{
              $scope.derecha.push(data[x]);
          }
          if(data[x].iva_check)
            $scope.aplicarDescuentoGeneral(data[x]);
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
  
  $scope.aplicarDescuentoGeneral = function(val){
    //if (val.platillos.length==undefined)
    //  return;
    for(var i=0;i<val.platillos.length;i++){
      val.platillos[i].discount = val.descuentoGeneral;
      if (val.iva_check)
        val.platillos[i].iva = val.iva_valor;
      else
        val.platillos[i].iva = 0;
      $scope.cambiarDescuento(val.platillos[i]);
    }
    console.log(val.descuentoGeneral);
    $scope.calcularDescuento(val);
  }
  
  
  $scope.calcularDescuento = function(val){
    var acu=0;
    var iva=0;
    for(var i=0;i<val.platillos.length;i++){
      var precio = val.platillos[i].quantity * val.platillos[i].price;
      var descuento = (precio)*(val.platillos[i].discount/100);
      iva =iva + (precio - descuento)*(val.platillos[i].iva/100);
       acu =  acu + descuento;
    }
    val.descuentoTotal = acu;
    val.ivaTotal = iva;
  }
  
   $scope.cambiarDescuento = function(val){
    console.log(val);
    if (val.discount===null)
     val.quantity=1;
      $.ajax({
          type:'PUT',
          url: '/saucer_orders/'+val.id,
          dataType: 'json',
          data: { saucer_order: {discount:val.discount,iva:val.iva}},
          success: function(data){
            console.log(data);
            Materialize.toast(val.discount+'% de descuento en '+val.name + ' mas iva: ' + val.iva+'%', 4000)
                     },
          error: function(data){
            $scope.cargarOrdenes();
            console.log(data);
          }
      });
  }
  $scope.descuentoPanel = function(val){
    val.panel = true;
  }
  
  
  $scope.verificarClave = function(val){
     $.ajax({
          type:'POST',
          url: '/passwords/verificar',
          dataType: 'json',
          data: { pass:val.pass},
          success: function(data){
            val.descuentoFlag = data;
            console.log(val.descuentoFlag);
          },
          error: function(data){
            val.descuentoFlag = false;
            console.log(data);
          }
      });
  }
  function init(){
    $scope.cargarOrdenes();
    $scope.getMesas();
    $scope.getOrdenes();    
  }
  init();
  //setInterval(init, 10000);     
}]);

