
$(document).ready(function(){
    $("#generarTicket").click(function(){
        window.location = "/corte/index?fecha="+$("#fecha").val();
    });    
    $("#imprimir").click(function(){
        window.open("/corte/index.pdf?fecha="+$("#fecha").val(),"_blank");
    });    
});
