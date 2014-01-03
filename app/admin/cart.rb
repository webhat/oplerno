ActiveAdmin.register Cart do
  index do
    column :total_price
    column :purchased_at
    default_actions                   
  end                                 

  filter :purchased_at
end                                   
