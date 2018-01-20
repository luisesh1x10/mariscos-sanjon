angular.module('sanjon')
.controller("ticket",["$scope","$http",function($scope,$http){
    $scope.ordenes=[];
    $scope.imprimir = function(val,folio){
        window.open("/reportes_ticket/"+val+".pdf?folio="+folio,"_blank")
    }
    $scope.query = function(pagina){
        $http.get("reportes_ticket/historial")
        .success(function(data){
            console.log(data);
            $scope.ordenes= data;
        })
        .error(function(data){
            console.log(data);
        });
    }
    $scope.query(0);
}]);