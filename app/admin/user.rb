ActiveAdmin.register User do
  index do
    column 'Name' do |user|
      begin
          "#{user.encrypted_first_name} #{user.encrypted_last_name} (#{user.id})"
      rescue
        'Unknown'
      end
    end
    column :email
    column :current_sign_in_at
    column :last_sign_in_at
    column :sign_in_count
    default_actions
  end

  filter :email

  form do |f|
    f.inputs 'User Details' do
      f.input :encrypted_first_name, label: 'First Name'
      f.input :encrypted_last_name, label: 'Last Name'

      f.input :email
      f.input :password
      f.input :password_confirmation
    end
    f.actions
  end
end                                   
