# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
$(document).on "ajax:success","form#formulario_ordenar",(ev,data)->
    console.log data
    $('#lista_de_ordenes').append("<li>nombre #{data.name} anotaciones: #{data.notes}</li>");