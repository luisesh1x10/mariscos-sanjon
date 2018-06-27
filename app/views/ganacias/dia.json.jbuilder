json.array!(@dias) do |dia|
      json.extract! dia, :inicio, :fin, :ingreso, :egreso
      json.caption dia[:inicio].strftime("%m/%d/%Y")
      json.ganacia dia[:ingreso]-dia[:egreso]
end
