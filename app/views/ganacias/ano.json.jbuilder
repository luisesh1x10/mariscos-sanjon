json.array!(@anos) do |ano|
      json.extract! ano, :inicio, :fin, :ingreso, :egreso
      json.caption ano[:inicio].year
      json.ganacia ano[:ingreso]-ano[:egreso]
end