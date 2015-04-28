ActiveAdmin.register InviteCredit do
  actions :all, :except => [:destroy, :edit]
  menu parent: "Incentive"
end
