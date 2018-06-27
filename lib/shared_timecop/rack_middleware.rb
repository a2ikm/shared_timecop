module SharedTimecop
  class RackMiddleware
    def initialize(app)
      @app = app
    end
    def call(env)
      SharedTimecop.go { @app.call(env) }
    end
  end
end
