class Requet < ActiveRecord::Base
  belongs_to :sucursal
  has_many :requets_lines
  # 0 ----- pendiente
  # 1 ----- en proceso
  # 2 ----- surtido
    def listaDeIngredientes()
        ingredientes = []
        self.requets_lines.each do |line|
            ingredientes.push(line.ingrediente)
        end
        ingredientes
    end
    
    def avanzar()
        self.update(status: self.status + 1) if self.status < 3
    end
end
