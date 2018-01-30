class CortePdf < Prawn::Document
  def initialize(ingresos,egresos,sumIngresos,sumEgresos)
    super( :margin => [20,20,20,10],:skip_page_creation => false)
    @ingresos = ingresos
    @egresos = egresos
    @sumIngresos = sumIngresos
    @sumEgresos = sumEgresos
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
      text "Fecha: #{Time.now.strftime("%m/%d/%Y")}", size: 9,:align => :center
      text "Hora: #{Time.now.strftime("%I:%M")}", size: 9,:align => :center
      text "CORTE DEL DIA", :align => :center
      text "Ventas Totales: "
      text "#{Dinero.to_money @sumIngresos}", :align => :right
      text "Egresos:"
      text "#{Dinero.to_money @sumEgresos}", :align => :right
      text "Ganancias: "
      text "#{Dinero.to_money @sumIngresos - @sumEgresos}", :align => :right
      text "#{@ingresos.count} ventas en el dia"
      text "-------------------------"
      text "---ventas---", :align => :center
      text "Ventas Totales: #{Dinero.to_money @sumIngresos}"
      text "Descuentos: #{Dinero.to_money 0}"
      
      text "-------------------------"
      
    end
  end
end
