

$(document).on("ajax:success","form#pedidos_barra",function(ev,data){
     console.log (data);
     $("#listaPedidos tbody").html("");
     for(var x = 0;x<data.length;x++){
         $("#listaPedidos tbody").append("<tr><td>"+data[x].notes+"</td></tr>");
     }
});



$(document).on("ajax:error","form#pedidos_barra",function(ev,data){
     console.log (data);
    
});

setInterval(function(){$("#pedidos_barra").submit();}, 2000)
