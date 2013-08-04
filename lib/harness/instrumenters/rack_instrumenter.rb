module Harness
  class RackInstrumenter
    def initialize(app)
      @app = app
    end

    def call(env)
      status, headers, body = ActiveSupport::Notifications.instrument 'rack.request', timer: true, counter: true do
        @app.call env
      end

      statsd.increment "rack.request.#{status}"

      [status, headers, body]
    end

    private
    def statsd
      Harness.config.statsd
    end
  end
end