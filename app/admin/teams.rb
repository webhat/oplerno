# encoding : utf-8
ActiveAdmin.register Team do
  menu parent: 'Accelerator'
  form do |f|
    f.actions
    f.inputs 'Details' do
      f.input :name
      f.input :slug
      f.input :description
    end
    f.inputs 'Mentors' do
      f.input :mentors, as: :select, input_html: { multiple: true }
    f.actions
    end
  end
end
