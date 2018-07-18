require "base64"
require "json"
require "net/http"

Net::HTTP.class_eval do
  def request_delete(path, initheader = nil, &block)
    request(Net::HTTP::Delete.new(path, initheader), &block)
  end
end

module SharedTimecop::Store
  class Server
    WriteFailed = Class.new(StandardError)
    ClearFailed = Class.new(StandardError)

    DEFAULT_HOST = "localhost"
    DEFAULT_PORT = 6543

    def initialize(host: nil, name: nil)
      @host, @port = parse_host_and_port(host)
      @path = build_path(name)
    end

    def read
      res = do_http { |h| h.request_get(@path) }
      if res.code == "200"
        binary = Base64.strict_decode64(res.body)
        Marshal.load(binary)
      else
        nil
      end
    end

    def write(stack_item)
      binary = Marshal.dump(stack_item)
      value = Base64.strict_encode64(binary)
      res = do_http { |h| h.request_post(@path, value) }
      if res.code == "201"
        stack_item
      else
        raise WriteFailed, res.body
      end
    end

    def clear
      res = do_http { |h| h.request_delete(@path) }
      if res.code == "200"
        nil
      else
        raise ClearFailed, res.body
      end
    end

    private

    def build_path(name = nil)
      if name.nil?
        "/"
      else
        "/?name=#{name}"
      end
    end

    def parse_host_and_port(host_and_port)
      if host_and_port.nil?
        [DEFAULT_HOST, DEFAULT_PORT]
      else
        host, port = host_and_port.split(":")
        port ||= DEFAULT_PORT
        [host, port]
      end
    end

    def do_http
      res = nil
      Net::HTTP.start(@host, @port) do |http|
        res = yield(http)
      end
      res
    end
  end

  register :server, Server
end
