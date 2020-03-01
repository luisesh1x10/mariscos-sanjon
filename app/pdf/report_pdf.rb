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
    bounding_box([0, y_position], :width => 180) do
      
      image "#{Rails.root}/app/assets/images/sanjonLogo.jpg", position: :center,:width=>90
      text "DATOS FISCALES",size:9, :align => :center
      text "GUADALUPE MEDINA PÁEZ",size:9, :align => :center
      text "RFC: MEPG880120616",size:9, :align => :center
      text "DOMICILIO:",size:9, :align => :center
      text "BLV. FRANCISCO INDALECIO MADERO #1089 LAS VEGAS C.P.80090 CULIACÁN SINALOA MÉXICO",size:9, :align => :center
      text "TEL: 2752193",size:9, :align => :center
      text "REGIMÉN DE INCORPORACIÓN FISCAL",size:9, :align => :center
      text "CORREO: hnossanjon@hotmail.com",size:9, :align => :center
      text "FECHA: #{Time.now.strftime("%m/%d/%Y")}", size: 9,:align => :center
      text "HORA: #{Time.now.strftime("%I:%M")}", size: 9,:align => :center
      text "FOLIO: #{@order.id}",size:9,:align => :center
      text "MESERO: #{@order.mesero}",size:9,:align => :center
      table_content
      if @order.takeaway
        text "NOMBRE CLIENTE:",size:9
        text @order.nombre ,size:9
        text "DIRECCIÓN:",size:9
        text "CALLE: #{@order.calle} colonia: #{@order.colonia} numero_exterior: #{@order.numero_interior} numero_int: #{@order.numero_exterior} " ,size:9
        text "ANOTACIONES: #{@order.notas}",size:9
        text "TELEFONO: #{@order.telefono}",size:9
      else
        text "#{@order.table.name unless @order.table.nil? }"
      end
      text "GRACIAS POR  SU PREFERENCIA"
    end


  end

  def table_content
    table  product_rows,:cell_style => { size:8,border_width:0,padding:2.5} do
      row(0).font_style = :bold
      self.header = true
    end
     text "Sub Total: #{Dinero.to_money @order.total - (@order.total * 0.16)}", size: 15, style: :bold
     text "Descuento: #{Dinero.to_money @order.descuentoTotal}", size: 15, style: :bold if @order.descuentoTotal > 0
     #text "IVA: #{Dinero.to_money @order.ivaTotal}", size: 15, style: :bold 
     text "IVA: #{Dinero.to_money @order.total * 0.16}", size: 15, style: :bold 
     text "Total: #{Dinero.to_money @order.totalConDescuentoYIva}", size: 15, style: :bold
     unless @order.payment.nil?
      text "PAGÓ CON: #{Dinero.to_money @order.payment}", size: 12, style: :bold
      text "SU CAMBIO: #{Dinero.to_money(@order.payment - @order.totalConDescuentoYIva)}", size: 15, style: :bold
     end
  end

  def product_rows
    [['PLATILLO','#','PRECIO','IVA']] +
    @order.saucerOrders.map do |so|
      [so.platillo.name, so.quantity, Dinero.to_money(so.valorTotal), Dinero.to_money(so.valorTotal * (Config.last.iva.to_f / 100))]
    end
  end
end
