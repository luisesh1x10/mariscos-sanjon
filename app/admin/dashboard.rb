ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  content title: proc{ I18n.t("active_admin.dashboard") } do

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
         panel "Ganancias totales" do
           para "Total vendido bruto #{SaucerOrder.all.sum('price*quantity')}"
         end
       end
       column do
         panel "Ganancias de hoy" do
           para "Total vendido bruto #{SaucerOrder.where(:created_at => Date.today.beginning_of_day..Date.today.end_of_day).sum('price*quantity')}"
         end
       end
     end
  end # content
end
