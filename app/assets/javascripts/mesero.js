 angular.module('sanjon').
 controller('pedidos_mesero',["$scope","$http",function($scope,$http){
    $scope.mesas=[];
    $scope.ordenes=[];
    $scope.categorias=[];
    $scope.grupos=[];
    $scope.platillos=[];
    $scope.cantidad=[];
    $scope.pedidos=[];
    $scope.pedido_actual=[];
    $scope.bolsas=[];
    $scope.estado=0;
    function limpiar(){
        $scope.mesas=[];
        $scope.ordenes=[];
        $scope.categorias=[];
        $scope.grupos=[];
        $scope.platillos=[];
        $scope.cantidad=[];
    }
    $('#abrir_orden').hide();
    $scope.test=function(v){
        alert(v);
    };
    $scope.atras= function(){
        if ($scope.estado<1){
            Materialize.toast('No se puede retroceder mas', 4000);  
            return;
        }
        
        limpiar();
        $scope.estado=$scope.estado-2;
        ///Materialize.toast($scope.estado+"", 4000);  
        switch ($scope.estado) {
            case -1:
                $scope.getMesas();
                $scope.estado=$scope.estado+1;
            break;
            case 0:
                $scope.siguiente($scope.pedido_actual.table_id);
            break;
            case 1:
                $scope.siguiente($scope.pedido_actual.order_id);
            break;
            case 2:
                $scope.siguiente($scope.pedido_actual.category_actual);
            break;
            case 3:
                $scope.siguiente($scope.pedido_actual.group_id);
            break;
            case 4:
                $scope.siguiente($scope.pedido_actual.platillo_actual);
            break;
            default:
                // code
        }
        
    };
    $scope.createBag=function(){
         $.ajax({
          type:'POST',
          url: '/bags',
          dataType: 'json',
          data: { bag: {}},
          success: function(data){
            $scope.bag_id=data.id;
         },
          error: function(data){
           console.log("no se pudo crear bolsa");
          }
         });
    };
    $scope.siguiente = function(val){
        $scope.estado++;
        switch($scope.estado){
            case 1:
                $scope.pedido_actual.table_id=val;
                $scope.mesas=[];
                $scope.getOrdenes(val);
                $('#abrir_orden').show();
            break;
            case 2:
                $scope.pedido_actual.order_id=val;
                $('#abrir_orden').hide();
                $scope.ordenes=[];
                $scope.getCategorias();
            break;
            case 3:
                $scope.pedido_actual.category_id=val.id;
                $scope.pedido_actual.category_actual=val;
                $scope.categorias=[];
                $scope.grupos=val.groups;
            break;
            case 4:
                $scope.pedido_actual.group_id=val;
                $scope.grupos=[];
                $scope.getPlatillos(val);
            break;
            case 5:
                $scope.pedido_actual.platillo_id=val.id;
                $scope.pedido_actual.platillo_actual=val;
                $scope.pedido_actual.nombre=val.name;
                $scope.pedido_actual.precio=val.price;
                $scope.platillos=[];
                $scope.cantidad=[{id:1,name:"x1"},{id:2,name:"x2"},{id:3,name:"x3"},{id:4,name:"x4"},{id:5,name:"x5"}];
                
            break;
             case 6:
                $scope.pedido_actual.quantity=val;
                $scope.cantidad=[];
                $scope.getCategorias();
                $scope.estado=2;
                add();
            break;
            default:
        }
    };
    
    $scope.getMesas = function(){
      $http.get("/tables.json")
      .success(function(data){
          $scope.mesas=data;
      })
      .error(function(data){
          Materialize.toast('Error al cargar datos', 4000);
      });
    };
    $scope.getOrdenes = function(val){
         $http.get("/orders/query.json?table_id="+val)
      .success(function(data){
          $scope.ordenes=data;
          for (var x=0; x<$scope.ordenes.length;x++){
              if ($scope.ordenes[x].pedidos>0)
                $scope.ordenes[x].color="amber darken-2";
          }
          console.log($scope.ordenes);
        if ($scope.ordenes.length==0){
            $scope.createOrden(val);
        }
      })
      .error(function(data){
          Materialize.toast('Error al cargar datos', 4000);
      });
    }
    $scope.getCategorias = function(){
      $http.get("/categories.json")
      .success(function(data){
          $scope.categorias=data;
          console.log(data);
      })
      .error(function(data){
          Materialize.toast('Error al cargar datos', 4000);
      });
    };
    $scope.getPlatillos = function(val){
      $http.get("/groups/"+val+".json")
      .success(function(data){
          $scope.platillos=data.platillos;
          console.log(data);
      })
      .error(function(data){
          Materialize.toast('Error al cargar datos'+val, 4000);
      });
    };
    function add(){
      $scope.pedidos.push({
          platillo_id:$scope.pedido_actual.platillo_id,
          quantity:$scope.pedido_actual.quantity,
          order_id:$scope.pedido_actual.order_id,
          category_id:$scope.pedido_actual.category_id,
          table_id:$scope.pedido_actual.mesa_id,
          name:$scope.pedido_actual.nombre,
          price:$scope.pedido_actual.precio,
          notes:$scope.pedido_actual.anotaciones,
          select:false
          });
    };
    $scope.createOrden=function(mesa_id){
         $.ajax({
          type:'POST',
          url: '/tables/'+mesa_id+'/orders?locale=es',
          dataType: 'json',
          data: { order: {}},
          success: function(data){
            Materialize.toast('Se ha creado una nueva orden', 4000);  
            $scope.ordenes.push(data);
            $('#recargar').click()
            console.log($scope.ordenes);
         },
          error: function(data){
            Materialize.toast('Un pedido no pudo ser enviado', 4000);
            return true;
          }
         });
    }
    $scope.postPedidos = function(){
        $("#enviar").hide();
        postBolsas();
        for (var x=0;x<$scope.pedidos.length;x++)
            postPedido($scope.pedidos,x);
    }
    function postBolsas(){
        
        $.ajax({
          type:'POST',
          url: '/create_bag' ,
          dataType: 'json',
          data: { datos:JSON.stringify($scope.bolsas)},
          success: function(data){
            console.log("prueba bolsa retorno");
            console.log(data);
            $scope.bolsas=[];
            if ($scope.pedidos.length==0&&$scope.bolsas.length==0){
               window.location.replace("/pedido");
               Materialize.toast('Platillos enviados con EXITO!!', 4000);
        }
         },
          error: function(data){
            console.log(data);
            $("#enviar").show();
            Materialize.toast('Un grupo de pedidos no pudo ser enviado', 4000);
            return true;
          }
         });
        
    };
    function postPedido(datos,index){
          $.ajax({
          type:'POST',
          url: '/orders/'+datos[index].order_id+'/saucer_orders',
          dataType: 'json',
          data: { saucer_order: datos[index]},
          success: function(data){
            console.log(data);
            datos.pop(index);
            if ($scope.pedidos.length==0&&$scope.bolsas.length==0){
               window.location.replace("/pedido");
               Materialize.toast('Platillos enviados con EXITO!!', 4000);
            }
         },
          error: function(data){
            $("#enviar").show();
            Materialize.toast('Un pedido no pudo ser enviado', 4000);
            return true;
          }
         });
    };
    $scope.removePedido=function(val){
        $scope.pedidos.splice(val,1);
    };
     $scope.getPlatilloByid=function (val){
        for (var x=0;x<$scope.group.platillos.length;x++){
            if ($scope.group.platillos[x].id==parseInt(val)){
                return $scope.group.platillos[x];
            }
        }
    };
    $scope.agrupar = function (){
        var aux= new Array();
        for (var i=0;i<$scope.pedidos.length;i++){
            if ($scope.pedidos[i].select==true){
                aux.push($scope.pedidos[i]);
                $scope.pedidos.splice(i, 1);
                i=i-1;
            }
        }
        console.log("hola");
        console.log(aux);
        if (aux.length==0)
            return
        $scope.bolsas.push(aux);
    };
    $scope.desagrupar=function(i){
        $scope.pedidos=$scope.pedidos.concat($scope.bolsas[i]);
        $scope.bolsas.splice(i, 1);
    };
    $scope.getMesas();
 }]);