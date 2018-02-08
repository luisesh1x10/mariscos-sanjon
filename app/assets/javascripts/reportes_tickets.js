angular.module('sanjon')
.controller("ticket",["$scope","$http",function($scope,$http){
    $scope.ordenes=[];
    $scope.imprimir = function(val,folio,fecha){
        window.open("/reportes_ticket/"+val+".pdf?folio="+folio+"&fecha="+fecha,"_blank")
    }
    $scope.query = function(pagina){
        $http.get("/reportes_ticket/historial")
        .success(function(data){
            console.log(data);
            $scope.ordenes= data;
        })
        .error(function(data){
            console.log(data);
        });
    }
    $scope.query(0);
}])
.controller("generadorTicket",["$scope","$http",function($scope,$http){
    var vm = this;
    vm.limpiar = function(){
        vm.datos={
            fecha:"",
            hora:"",
            folio:"",
            mesero:"",
            lista:[],
            mesa:"",
            total:"",
            iva:""
        }    
    }
    $scope.dd=[1,2,3,4,5];
    vm.generar = function(){
        var cad = JSON.stringify(vm.datos);
        console.log(cad);
        window.open("/reportes_ticket/reporte3.pdf?datos="+cad,"_blank");
    }
    $scope.$watch("vm.datos.lista",function(newValue,oldValue) {
         
        if (newValue===oldValue) {
          return;
        }
        var total = 0;
        for(var i = 0; i<vm.datos.lista.length; i++){
            total = total + vm.datos.lista[i].cantidad * vm.datos.lista[i].precio
        }
        vm.datos.total = total;
        vm.datos.iva = total*.16;
    },true);
    vm.agregarLista = function(){
        temp = {platillo:vm.platillo,
                cantidad:vm.cantidad,
                precio:vm.precio
                }
        vm.datos.lista.push(temp);
        vm.platillo = "";
        vm.cantidad = "";
        vm.precio = "";
    }
    vm.eliminarLista = function(index){
        if (index > -1)
            vm.datos.lista.splice(index, 1);
    }
    vm.limpiar();
}]);