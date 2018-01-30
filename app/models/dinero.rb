class Dinero
    def self.to_money(val)
        Money.new((sprintf "%.2f",val).tr('.', '')).format
    end
    def self.to_words(val)
        I18n.with_locale(:es) { (val).to_i.to_words }
    end
    def self.mes(val)
        case val
        when 1
            cad = "Enero"
        when 2
            cad = "Febrero"
        when 3
            cad = "Marzo"
        when 4
            cad = "Abril"
        when 5
            cad = "Mayo"
        when 6
            cad = "Junio"
        when 7
            cad = "Julio"
        when 8
            cad = "agosto"
        when 9
            cad = "Septiembre"
        when 10
            cad = "Octubre"
        when 11
            cad = "Noviembre"
        when 12
            cad = "Diciembre"
        else
            cad = "mes invalido"
        end
        return cad
    end
end