ActiveAdmin.register Tournament do

  permit_params :open, :title, :description, :date, :men_limit, :women_limit, :published_in_next_tournament
  
  member_action :open, :method => :get do
    tournament = Tournament.find params[:id]
    tournament.open!
	redirect_to :action => :show, :notice => "Opened!"
  end

  action_item only: :show do 
    link_to('Open', open_admin_tournament_path(tournament))
  end
  
end
