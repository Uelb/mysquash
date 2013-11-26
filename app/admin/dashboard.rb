ActiveAdmin.register_page "Dashboard" do

  menu :priority => 1, :label => proc{ I18n.t("active_admin.dashboard") }

  page_action :mail do 
      if !params[:editor].blank? && !params[:users].nil?
        UserMailer.mail_to_users(params[:editor], params[:mail_subject], params[:users].map(&:to_i)).deliver
        redirect_to admin_dashboard_path, :notice => "The email has been correctly sent."
      elsif params[:editor].blank?
        redirect_to admin_dashboard_path, :alert => "The body of the message cannot be empty."
      elsif params[:users].nil?
        redirect_to admin_dashboard_path, :alert => "You have to choose at least one user as the recipient of the message."
      end
  end

  content :title => proc{ I18n.t("active_admin.dashboard") } do
    panel "Send a mail to all the users" do 
      @users = User.all
      render partial: "admin/mail_form", :locals => { :users => @users }
    end
  end
end
