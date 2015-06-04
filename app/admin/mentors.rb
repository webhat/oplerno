ActiveAdmin.register Mentor do
  index do
    column :avatar do |user|
      link_to [user] do
        image_tag(user.avatar.url(:thumb))
      end
    end
    column 'Name' do |user|
      name = 'Unknown'
      begin
        name = user.display_name.force_encoding('utf-8')
      rescue
      end
      link_to "#{name} (#{user.id})", [user]
    end
  end
  form do |f|
    f.actions
    f.inputs 'Mentor Details' do
      f.input :encrypted_first_name, label: 'THIS SHOULD BE BLANK!'
      f.input :encrypted_last_name, label: 'Full Name'
      f.input :slug
    end
    f.inputs 'AngelList', for: [:angel, f.object.angel || f.object.create_angel] do |angel|
      angel.input :angelslug, label: 'AngelList Slug'
      angel.input :twitterslug, label: 'Twitter Slug'
    end

    f.inputs 'Teams' do
      f.input :teams, as: :select, input_html: { multiple: true }
    f.actions
    end
  end
end
