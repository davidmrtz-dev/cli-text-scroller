module Interactors
  class SerialInteractor
    @port = nil

    class << self
      def setup(setup)
        @port ||= SerialPort.new('/dev/cu.usbserial-1120', 9600, 8)
        DisplayInteractor.print_connected
        setup&.connect
      rescue Errno::ENOENT
        DisplayInteractor.device_not_connected
      end

      def send_data(setup, data)
        @port.write(data)
      rescue Errno::ENXIO
        DisplayInteractor.device_disconnected
        @port = nil
        setup&.reset
      end

      def read_data(setup)
        @port.readline(9)
      rescue Errno::ENXIO
        DisplayInteractor.device_disconnected
        @port = nil
        setup&.reset
      end

      def connected
        !@port.nil?
      end
    end
  end
end
