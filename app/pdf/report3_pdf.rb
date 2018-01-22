class Report3Pdf < Prawn::Document
  def initialize(lista,folio,fecha,hora,mesero,total)
    super( :margin => [20,20,20,10],:skip_page_creation => false)
    @order = lista
    @folio = folio
    @fecha = fecha
    @hora = hora
    @mesero = mesero
    @total = total
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
      text "DATOS FISCALES",size:9, :align => :center
      text "RFC: MEPG880120616",size:9, :align => :center
      text "Domicilio:",size:9, :align => :center
      text "BLV. francisco indalecio madero #1089 las vegas C.P.80090 Culiacan Sinaloa Mexico",size:9, :align => :center
      text "Tel: 2752193",size:9, :align => :center
      text "Regimen de incorporacion fiscal",size:9, :align => :center
      text "Correo: organizacionmedina@hotmail.com",size:9, :align => :center
      text "Fecha: #{@fecha.to_date.strftime("%d/%m/%Y")}", size: 9,:align => :center
      text "Folio: #{@folio}",size:9,:align => :center
      text "Mesero: #{@mesero}",size:9,:align => :center
      table_content
      text "#{Table.all.sample.name}"
      text "Gracias por su preferencia"
    end


  end

  def table_content
    table  product_rows,:cell_style => { size: 5,border_width:0} do
      row(0).font_style = :bold
      self.header = true
    end
     text "Subtotal: #{@total}", size: 15, style: :bold
     text "IVA: #{((@total.to_f)*0.16).round(2)}", size: 15, style: :bold
     text "Total: #{((@total.to_f)*1.16).round(2)}", size: 15, style: :bold
    
  end

  def product_rows
    [['Platillo', 'Cantidad', 'Precio']] +
    @order.map do |so|
      [so["platillo"],so["cantidad"],so["precio"].to_f*so["cantidad"].to_i]
      
    end
  end
end
