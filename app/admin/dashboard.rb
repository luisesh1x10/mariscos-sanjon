ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do
    ahora = Time.zone.now
    fecha_corte = ahora.hour < 6 ? ahora.to_date - 1.day : ahora.to_date
    inicio_corte = fecha_corte.beginning_of_day + 6.hours
    fin_corte = fecha_corte.end_of_day + 6.hours
    ingresos_hoy = SaucerOrder.ingresosTotal(fecha_corte, fecha_corte)
    egresos_hoy = Expense.where(:created_at => inicio_corte..fin_corte).sum('amount')

    # Here is an example of a simple dashboard with columns and panels.
    #
      columns do
    #   column do
    #     panel "Recent Posts" do
    #       ul do
    #         Post.recent(5).map do |post|
    #           li link_to(post.title, admin_post_path(post))
    #         end
    #       end
    #     end
    #   end
    column do
      panel "Top 10 mas vendido" do
        table_for Platillo.joins(:saucer_orders).select(:name,:id).group(:id).order('SUM(saucer_orders.quantity) desc').limit(10) do
          column :id
          column :name
        end
      end
    end
    column do
      panel "Top 10 menos vendido" do
        table_for Platillo.joins(:saucer_orders).select(:name,:id).group(:id).order('SUM(saucer_orders.quantity)').limit(10) do
          column :id
          column :name
        end
      end
    end
       column do
         panel "Ganancias totales" do
           para "Total vendido bruto #{Dinero.to_money SaucerOrder.all.sum('price*quantity')}"
         end
         panel "Tickets falsos" do
            link_to('Ir a generador de tickets','/reportes_ticket')
         end
         panel "Cofiguracion" do
           
           render "config"
            
         end
         
       end
       column do
         
         panel "Ingresos de hoy" do
           para "Total vendido #{Dinero.to_money ingresos_hoy}"
         end
         
         panel "Egresos de hoy" do
           para "Total gastado #{Dinero.to_money egresos_hoy}"
         end
         
         panel "Ganancias de hoy" do
           para "Total ganacias #{Dinero.to_money ingresos_hoy - egresos_hoy}"
         end
       end
       
     end
    render 'users_table'
  end # content
  
 
end
