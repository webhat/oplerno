ActiveAdmin.register AdminUser do
  actions :all
  menu parent: 'Admin'

  controller do
    def action_methods
      if current_admin_user.id == 3 
        super
      else
        super - ['destroy', 'new', 'create']
      end
    end
  end

  index do
    column :email
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    default_actions
  end

  filter :email

  form do |f|
    f.inputs 'Admin Details' do
      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end
