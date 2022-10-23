require_relative './states/app_state'
require_relative './interactors/display_interactor'
require_relative './interactors/serial_interactor'
require_relative './services/scroller_service'

class Application
  REQUEST_ANIMATION = 'req-an-01'
  CONFIRM_REQUEST = 'con-an-01'
  FINISHED_ANIMATION = 'cust-ends'

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
      @setup.perform && DisplayInteractor.print_listening if selection.eql?('1')
      sleep 1
    end

    def performing
      sleep 0.5
      SerialInteractor.send_data(@setup, REQUEST_ANIMATION)
      response = SerialInteractor.read_data(@setup)
      SerialInteractor.send_data(@setup, CONFIRM_REQUEST) if response.eql?(REQUEST_ANIMATION)
      custom_text = gets.chomp
      DisplayInteractor.print_listening
      sleep 0.5
      SerialInteractor.send_data(@setup, custom_text)
      response = SerialInteractor.read_data(@setup)
      @setup.reset unless response.eql?(FINISHED_ANIMATION)
      sleep 1
    end
  end
end
