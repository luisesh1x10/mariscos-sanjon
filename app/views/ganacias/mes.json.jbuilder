def nombre_del_mes(val)
    case val
        when 1 
            "enero"
        when 2 
            "febrero"
        when 3 
            "marzo"
        when 4 
            "abril"
        when 5 
            "mayo"
        when 6 
            "junio"
        when 7 
            "julio"
        when 8
            "agosto"
        when 9
            "septiembre"
        when 10
            "octubre"
        when 11 
            "noviembre"
        when 12 
            "diciembre"
    end
end
json.array!(@meses) do |mes|
      json.extract! mes, :inicio, :fin, :ingreso, :egreso
      json.caption "#{nombre_del_mes mes[:inicio].month} del #{mes[:inicio].year}"
      json.ganacia mes[:ingreso]-mes[:egreso]
end
