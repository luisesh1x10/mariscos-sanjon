angular.module("sanjon")
.controller("categorias",["$scope","$http","$location",function($scope,$http,$location){
    console.log($location.path()+"");
    $scope.obtener_platillos = function(){
        console.log("dfsd");
    }
}]);