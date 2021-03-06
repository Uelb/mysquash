# encoding: utf-8

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

  page_action :switch_mode do 
    $website_special_mode = !$website_special_mode
    redirect_to admin_dashboard_path, :notice => "Le site a correctement changé de mode."
  end

  action_item do 
    if $website_special_mode
      text = "Passer le site en mode normal"
    else
      text = "Passer le site en mode d'affichage des horaires"
    end
    link_to(text, "/admin/dashboard/switch_mode")
  end

  content :title => proc{ I18n.t("active_admin.dashboard") + " : Le site est en mode #{if $website_special_mode then 'd\'affichage des horaires' else 'normal' end }"} do
    if Tournament.opened.first
      panel "Les matches pour le prochain tournoi." do
        @inscriptions = Tournament.opened.first.inscriptions
        if(@inscriptions.empty?)
          span "Il n'y a pas encore d'inscriptions pour le tournoi en cours ou le tournoi en cours n'a pas encore été créé."
        else
          render partial: "admin/match_management", :locals => {:inscriptions => @inscriptions}
        end
      end
    end

    panel "Envoyer un email à tous les utilisateurs" do 
      @users = User.all
      render partial: "admin/mail_form", :locals => { :users => @users }
    end
  end
end
