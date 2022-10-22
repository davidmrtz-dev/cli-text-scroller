module Interactors
  class DisplayInteractor
    CLEAR_SCREEN = "\e[H\e[2J".freeze

    class << self
      # INTERFACE
      def welcome
        clear_screen
        puts 'Welcome'
        puts 'connecting...'
      end

      def print_menu
        clear_screen
        puts 'MENU.'
        puts '1. START.'
        puts '2. SILENCE MODE.'
      end

      def print_perfom
        clear_screen
        puts 'Performing...'
      end

      # LOGGING
      def device_not_connected
        puts 'device not connected'
      end

      def device_disconnected
        puts 'device disconnected'
      end

      def print_connected
        puts 'connected'
      end

      def clear_screen
        print CLEAR_SCREEN
      end
    end
  end
end
