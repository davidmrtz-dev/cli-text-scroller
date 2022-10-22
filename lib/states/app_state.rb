module States
  class AppState
    include AASM

    aasm do
      state :connecting, initial: true
      state :connected
      state :performing

      event :connect do
        transitions from: :connecting, to: :connected, if: :connecting?
      end

      event :perform do
        transitions from: :connected, to: :performing, if: :connected?
      end

      event :reset do
        transitions from: :performing, to: :connecting, if: :performing?
      end
    end
  end
end
