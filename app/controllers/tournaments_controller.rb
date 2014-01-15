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
        if $website_special_mode
            if current_user
                redirect_to popin_index_path
            else
                render layout: "popin"
            end
        else
            if current_user
                @current_user_email = current_user.email
                sign_out current_user
            end
        end
    end

    def matches_index
        @tournament = Tournament.opened.first
    end

end
