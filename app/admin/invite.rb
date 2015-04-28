ActiveAdmin.register Invite do
  actions :all, :except => [:destroy]
  menu parent: "Incentive"
end
