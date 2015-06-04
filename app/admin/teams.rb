ActiveAdmin.register Team do
  form do |f|
    f.actions
    f.inputs 'Details' do
      f.input :name
      f.input :slug
    end
    f.inputs 'Mentors' do
      f.input :mentors, as: :select, input_html: { multiple: true }
    f.actions
    end
  end
end
