require_relative './states/app_state'
require_relative './interactors/display_interactor'
require_relative './interactors/serial_interactor'

class Application
  @state = nil

  class << self
    include States
    include Interactors

    def setup
      DisplayInteractor.welcome
      sleep 2
      DisplayInteractor.clear_screen
      sleep 1
      @state = AppState.new
    end

    def run
      connect if @state.connecting?
      in_menu if @state.in_menu?
    end

    private

    def connect
      DisplayInteractor.trying_to_connect
      sleep 1
      @state.connect if SerialInteractor.connected
    end

    def in_menu
      DisplayInteractor.connected
      sleep 1
      DisplayInteractor.in_menu
      sleep 1
    end
  end
end
