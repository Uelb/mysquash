ActiveAdmin.register LeconsPicture do

  
  # See permitted parameters documentation:
  # https://github.com/gregbell/active_admin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  permit_params :picture
  #
  # or
  #
  # permit_params do
  #  permitted = [:permitted, :attributes]
  #  permitted << :other if resource.something?
  #  permitted
  # end

  index do 
    selectable_column
    column :id
    column :picture_file_name
    column :picture_content_type
    column "Picture" do |lecons_picture|
      link_to(image_tag(lecons_picture.picture.url(:thumb), :height => '100'), admin_lecons_picture_path(lecons_picture))
    end
    default_actions
  end
  
  form do |f|
    f.inputs "Details" do
      f.input :picture, as: :file, :hint => f.template.image_tag(f.object.picture.url(:medium))
    end
    f.actions
  end
end
