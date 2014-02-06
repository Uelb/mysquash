ActiveAdmin.register LeconsComment do
  permit_params :comment, :author  

  filter :displayed
  filter :author
  filter :comment
  filter :created_at

  config.sort_order = "displayed_desc"

  index do
  	selectable_column
  	column :comment
  	column :author
  	bool_column :displayed
  	column :created_at
  	default_actions
  end
end
