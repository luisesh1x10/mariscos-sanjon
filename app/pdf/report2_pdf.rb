class Report2Pdf < Prawn::Document
  def initialize(order,folio)
    super( :margin => [20,20,20,10],:skip_page_creation => false)
    @order = order
    @folio = folio
    header
    text_content
  end

  def header
    #This inserts an image in the pdf file and sets the size of the image
   
  end
  
  def text_content
    # The cursor for inserting content starts on the top left of the page. Here we move it down a little to create more space between the text and the image inserted above
    y_position = cursor - 0

    # The bounding_box takes the x and y coordinates for positioning its content and some options to style it
    bounding_box([0, y_position], :width => 100) do
      
      image "#{Rails.root}/app/assets/images/sanjonLogo.jpg", position: :center,:width=>90
      text "Direccion: Boulevard Madero #1089 col. Las Vegas, 80090 Culiacán. ", size: 9,:align => :center
      text "Fecha: #{Time.now.strftime("%m/%d/%Y")}", size: 9,:align => :center
      text "Hora: #{Time.now.strftime("%I:%M")}", size: 9,:align => :center
      text "Folio: #{@folio}",size:9,:align => :center
      text "Mesero: #{@order.mesero}",size:9,:align => :center
      table_content
      if @order.takeaway
        text "Nombre cliente:",size:9
        text @order.nombre ,size:9
        text "Direccion:",size:9
        text " calle: #{@order.calle} colonia: #{@order.colonia} numero_exterior: #{@order.numero_interior} numero_int: #{@order.numero_exterior} " ,size:9
        text "Anotaciones: #{@order.notas}",size:9
        text "Telefono: #{@order.telefono}",size:9
      else
        text "#{@order.table.name unless @order.table.nil? }"
      end
      text "Gracias por su preferencia"
    end


  end

  def table_content
    table  product_rows,:cell_style => { size: 5,border_width:0} do
      row(0).font_style = :bold
      self.header = true
    end
     text "Total a pagar #{@order.regulador_total(200)}", size: 15, style: :bold
     unless @order.payment.nil?
      text "Pago con: #{@order.payment}", size: 12, style: :bold
      text "Cambio: #{@order.payment-@order.saucerOrders.sum('price*quantity')}", size: 15, style: :bold
     end
  end

  def product_rows
    [['Platillo', 'Cantidad', 'Precio']] +
    @order.regulador(200).map do |so|
      [so.platillo.name,so.quantity,so.price*so.quantity]
    end
  end
end
