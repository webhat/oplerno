ActiveAdmin.register Setting do
  menu parent: 'Admin'
  form do |f|
    f.inputs 'User Details' do
      f.input :key, label: 'Key'
      f.input :value, label: 'Value'
    end
    f.actions
  end
end
