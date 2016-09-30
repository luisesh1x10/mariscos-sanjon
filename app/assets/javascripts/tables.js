angular.module('sanjon')
.controller('pagos',['$scope','$http','$location',function($scope,$http,$location){
    $scope.ordenes=[];
    $scope.derecha=[];
    $scope.izquierda =[];
    $scope.tipo;
  table_id=$location.absUrl().split('?')[0].split('/')[4];
  $http.get("/orders/query.json?table_id="+table_id)
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
  
}]);