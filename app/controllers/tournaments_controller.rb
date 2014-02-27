# encoding: utf-8
class TournamentsController < ApplicationController

    layout 'inscriptions'

    def show
        @tournament = Tournament.opened.first
        if @tournament.nil?
            redirect_to no_tournament_path and return 
        end
        @males = @tournament.users.males
        @females = @tournament.users.females
        @inscriptions = @tournament.inscriptions
        @next_tournament = Tournament.where(published_in_next_tournament: true).first
        if current_user
            @current_user_inscription = @inscriptions.where(user_id: current_user.id).first
        end
        @popin_closed = session[:popin_closed]
        @after_confirmation = session[:after_confirmation]
        session[:after_confirmation] = false
        @user_email = session[:email]
        if $website_special_mode && !session[:popin_closed] && current_user
            redirect_to popin_index_path and return
        else
            session[:popin_closed] = false
            if current_user
                @current_user_email = current_user.email
            end
            if $website_special_mode
                render layout: "popin"
            end 
        end
    end

    def matches_index
        @tournament = Tournament.opened.first
    end

end
