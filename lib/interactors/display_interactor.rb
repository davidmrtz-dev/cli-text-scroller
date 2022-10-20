module Interactors
  class DisplayInteractor
    CLEAR_SCREEN = "\e[H\e[2J".freeze

    class << self
      def welcome
        puts 'Welcome'
      end

      def clear_screen
        puts CLEAR_SCREEN
      end

      def trying_to_connect
        puts 'trying to connect...'
      end

      def connected
        puts 'connected'
      end

      def in_menu
        puts 'in menu'
      end
    end
  end
end
