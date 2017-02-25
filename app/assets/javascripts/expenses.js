angular.module('sanjon').
 controller('gastos',["$scope","$http",function($scope,$http){
     $scope.gastos = [];
     $scope.nuevo = null;
     $scope.ocultar = function (){ 
       if(parseInt($scope.nuevo.category)==1)
        $("#solo_proveedor").show();
       else
        $("#solo_proveedor").hide();
     }
     $scope.obtener_gastos = function(){
         $http.get("/expenses.json")
         .success(function(data){
             console.log(data);
             $scope.gastos=data;
         })
         .error(function(data){
             console.log(data);
         });
         $scope.nuevo = null;
         $("#solo_proveedor").hide();
     }
     $scope.crear_gasto = function(){
          $.ajax({
          type:'POST',
          url: '/expenses',
          dataType: 'json',
          data: { expense: {category:$scope.nuevo.category,amount:$scope.nuevo.amount, description:$scope.nuevo.descricion,quantity:$scope.nuevo.cantidad,ingredients_id:$scope.nuevo.ingredient_id}},
          success: function(data){
             console.log(data);
             $scope.obtener_gastos();
         },
          error: function(data){
             console.log(data);
             $scope.obtener_gastos();
          }
         });
     }
     $("#solo_proveedor").hide();
     $scope.obtener_gastos();
 }]);