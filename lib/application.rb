require_relative './states/app_state'
require_relative './interactors/display_interactor'
require_relative './interactors/serial_interactor'

class Application
  @setup = nil

  class << self
    include States
    include Interactors

    def setup
      DisplayInteractor.welcome
      @setup ||= AppState.new
    end

    def run
      connecting if @setup.connecting?
      connected if @setup.connected?
      performing if @setup.performing?
    end

    private

    def connecting
      SerialInteractor.setup(@setup) unless SerialInteractor.connected
      sleep 1
    end

    def connected
      DisplayInteractor.print_menu
      selection = gets.chomp
      @setup.perform && DisplayInteractor.print_perfom if selection.eql?('1')
      sleep 1
    end

    def performing
      SerialInteractor.send_data(@setup, 'req-an-01')
      response = SerialInteractor.read_data(@setup)
      SerialInteractor.send_data(@setup, 'con-an-01') if response.eql?('req-an-01')
      sleep 2
      puts 'okok'
    end
  end
end
