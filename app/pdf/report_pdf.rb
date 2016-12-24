class ReportPdf < Prawn::Document
  def initialize(order)
    super( :margin => [20,20,20,10],:skip_page_creation => false)
    @order = order
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
      text "Folio: #{@order.id}",size:9,:align => :center
      text "Mesero: #{@order.mesero}",size:9,:align => :center
      table_content
      if @order.takeaway
        text "Direccion:",size:9
        text @order.customer.direccion,size:9
        text "Anotaciones: #{@order.customer.anotaciones}",size:9
        text "Telefono: #{@order.customer.telefono}",size:9
      end
      text "Gracias por su preferencia"
    end


  end

  def table_content
    table  product_rows,:cell_style => { size: 5,border_width:0} do
      row(0).font_style = :bold
      self.header = true
    end
     text "Total a pagar #{@order.saucerOrders.sum('price*quantity')}", size: 15, style: :bold
     unless @order.payment.nil?
      text "Pago con: #{@order.payment}", size: 12, style: :bold
      text "Cambio: #{@order.payment-@order.saucerOrders.sum('price*quantity')}", size: 15, style: :bold
     end
  end

  def product_rows
    [['Platillo', 'Cantidad', 'Precio']] +
    @order.saucerOrders.map do |so|
      [so.platillo.name,so.quantity,so.price]
    end
  end
end
