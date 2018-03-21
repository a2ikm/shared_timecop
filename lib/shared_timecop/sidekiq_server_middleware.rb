module SharedTimecop
  class SidekiqServerMiddleware
    def call(worker, msg, queue)
      SharedTimecop.go { yield }
    end
  end
end
