ActiveAdmin.register User do
	actions :all, :except => [:destroy]
  index do
    column 'Name' do |user|
      begin
          link_to "#{user.encrypted_first_name} #{user.encrypted_last_name} (#{user.id})", "/users/#{user.id}"
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

	action_item only: :show, if: proc{ current_admin_user.id == 3 } do
		unless User.find(params[:id]).access_locked?
			link_to 'Lock User', "/admin/users/#{params[:id]}/lock"
		else
			link_to 'Unlock User', "/admin/users/#{params[:id]}/unlock"
		end
	end

	member_action :lock, :method => :get do
		user = User.find(params[:id])
		user.lock_access!
		redirect_to :action => :show, :notice => "Locked!"
	end

	member_action :unlock, :method => :get do
		user = User.find(params[:id])
		user.unlock_access!
		redirect_to :action => :show, :notice => "Locked!"
	end

	action_item only: :show, if: proc{ current_admin_user.id == 3 } do
		link_to 'Become User', "/admin/users/#{params[:id]}/become", :target => "_blank"
	end

	member_action :become, :method => :get do
		return unless current_admin_user.id == 3
		sign_in(:user, User.find(params[:id]), { :bypass => true })
		redirect_to user_url
	end

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
