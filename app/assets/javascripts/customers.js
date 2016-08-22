$(document).ready(function(){
    
    $(".field").addClass("input-field col s12 m4 l4");
     $(".crud-links").addClass("btn waves-effect red");
});
 
 
 angular.module('sanjon').
 controller('domicilio',["$scope","$http",function($scope,$http){
     $scope.clientes=[];
     $scope.tel_query="";
     $scope.referencia="";
     $http.get("/customers.json")
     .success(function(data){
       $scope.clientes=data;
         console.log(data);
     })
     .error(function(data){
         console.log(data);
     })
     $scope.actualizar = function(){
      if ($scope.tel_query!=null)
       query="?telefono="+$scope.tel_query;
      else 
       query="";
        $http.get("/customers.json"+query)
        .success(function(data){
          $scope.clientes=data;
            console.log(data);
        })
     }
     $scope.ordenar=function(val){
      $.ajax({
          type:'POST',
          url: '/customers/create_order',
          dataType: 'json',
          data: { order: {
           takeaway:true,
           customer_id:val
          }},
          success: function(data){
            console.log(data);
            $(location).attr('href','orders/domicilio'); 
         },
          error: function(data){
            console.log(data);   
            $(location).attr('href','orders/domicilio'); 
            //Materialize.toast('Error no se puede conectar para generar orden', 4000);
            return true;
          }
         });
      
     }
 }]);