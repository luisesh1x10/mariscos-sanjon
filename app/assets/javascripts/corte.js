
$(document).ready(()=>{
    $("#generarTicket").click(()=>{
        window.location = "/corte/index?fecha="+$("#fecha").val();
    });    
    $("#imprimir").click(()=>{
        window.open("/corte/index.pdf?fecha="+$("#fecha").val(),"_blank");
    });    
});
