class ReportPdf < Prawn::Document
  def initialize(order)
    super()
    @order = order
    header
    text_content
  end

  def header
    #This inserts an image in the pdf file and sets the size of the image
   
  end

  def text_content
    # The cursor for inserting content starts on the top left of the page. Here we move it down a little to create more space between the text and the image inserted above
    y_position = cursor - 50

    # The bounding_box takes the x and y coordinates for positioning its content and some options to style it
    
      text "Mariscos Hmnos Sanjon", size: 15, style: :bold
      text "Calidad, Sabor y Servicio que ¡Nos distinguen! No seremos los mejores del mundo pero... ¡Si los Mejores del rumbo! Direccion: Boulevard Madero #1089 col. Las Vegas, 80090 Culiacán. "
  
  end

  def table_content
    table product_rows do
      row(0).font_style = :bold
      self.header = true
      self.column_widths = [300, 80,160 ]
    end
     text "Total a pagar #{@order.saucerOrders.sum('price*quantity')}", size: 15, style: :bold
  end

  def product_rows
    [['Platillo', 'Cantidad', 'Precio']] +
      @order.saucerOrders.map do |so|
      [so.platillo.name,so.quantity,so.price]
    end
  end
end