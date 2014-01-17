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
        if $website_special_mode && !session[:popin_closed] && current_user
            redirect_to popin_index_path
        else
            session[:popin_closed] = false
            if current_user
                @current_user_email = current_user.email
            end
        end
    end

    def matches_index
        @tournament = Tournament.opened.first
    end

end
