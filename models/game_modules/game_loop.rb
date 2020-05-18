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
      dealer.ai_turn(deck)
      check_cards_count
    end

    def result_event
      end_session
      dealer.visible = true
      show_ui
      dealer.visible = false
    end
  end
end
