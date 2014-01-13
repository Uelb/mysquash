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
        p @current_user_inscription
    end

end
