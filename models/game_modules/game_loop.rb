module Game
  # Game loop
  module Loop
    def run
      session_loop
      ask_new_session
    rescue NewGame
      retry
    rescue NoMoney
      show_end_congrat
    end

    def session_loop
      init_session
      loop do
        begin
          session_loop_inner
        rescue EndSession
          result_event
          return
        end
      end
    end

    def session_loop_inner
      show_ui
      user_turn(ask_choice)
      dealer_turn
      check_cards_count
    end

    def result_event
      show_result
      show_ui(true)
    end
  end
end