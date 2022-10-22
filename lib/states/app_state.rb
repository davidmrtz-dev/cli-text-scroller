module States
  class AppState
    include AASM

    aasm do
      state :connecting, initial: true
      state :in_menu

      event :connect do
        transitions from: :connecting, to: :in_menu, if: :connecting?
      end
    end

    def initialize(config = { connected: false })
      @config = config
    end
  end
end
