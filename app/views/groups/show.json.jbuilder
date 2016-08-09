json.id @group.id
json.name @group.name
json.platillos @group.platillos.where(is_child:false) do |platillo|
    json.name platillo.name
    json.id platillo.id
    json.price platillo.price
end

