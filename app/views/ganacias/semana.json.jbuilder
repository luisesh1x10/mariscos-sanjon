json.array!(@semanas) do |semana|
      json.extract! semana, :inicio, :fin, :ingreso, :egreso
      json.caption  "#{semana[:inicio].to_date} - #{semana[:fin].to_date}"
      json.ganacia semana[:ingreso]-semana[:egreso]
end