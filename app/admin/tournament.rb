# encoding: utf-8
ActiveAdmin.register Tournament do

  permit_params :open, :title, :description, :date, :men_limit, :women_limit, :published_in_next_tournament
  filter :date
  filter :title
  filter :open
  filter :published_in_next_tournament
  config.sort_order = "open_desc"

  member_action :open, :method => :get do
    tournament = Tournament.find params[:id]
    tournament.open!
	redirect_to :action => :show, :notice => "Opened!"
  end

  action_item only: :show do 
    link_to('Open', open_admin_tournament_path(tournament))
  end

  index do 
    selectable_column  
    column :title
    column :date
    bool_column :open
    column :men_limit
    column :women_limit
    bool_column :published_in_next_tournament
    column :created_at
    actions defaults: true do |inscription|
      link_to "Valider", validate_admin_inscription_path(inscription), method: :put
    end
  end
  
end
