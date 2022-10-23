require_relative './states/app_state'
require_relative './interactors/display_interactor'
require_relative './interactors/serial_interactor'
require_relative './services/scroller_service'

class Application
  @setup = nil

  class << self
    include States
    include Interactors
    include Services

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
      puts 'hello'
      @setup.perform && DisplayInteractor.print_perfom if selection.eql?('1')
      sleep 1
    end

    def performing
      sleep 0.5
      SerialInteractor.send_data(@setup, 'req-an-01')
      response = SerialInteractor.read_data(@setup)
      SerialInteractor.send_data(@setup, 'con-an-01') if response.eql?('req-an-01')
      custom_text = gets.chomp
      sleep 0.5
      SerialInteractor.send_data(@setup, custom_text)
      response = SerialInteractor.read_data(@setup)
      @setup.reset unless response.eql?('cust-ends')
      sleep 1
    end
  end
end
