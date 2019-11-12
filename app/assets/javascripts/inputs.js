
 angular.module('sanjon').
 controller('inputs',["$scope","$http",function($scope,$http){
   $scope.mesas=[];
   $scope.marcar = function(pedido) {
        if (pedido.select==null){
            pedido.select = true;
            pedido.cap="Agrupado";
            return;
        }
        pedido.select= !(pedido.select);
        if (pedido.select)
            pedido.cap="Agrupado";
        else 
            pedido.cap="Suelto";
    }
    
    $scope.cargarInputs = function() {
        
    }
 }]);