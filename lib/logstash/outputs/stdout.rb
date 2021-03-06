require "ap" 
require "logstash/outputs/base"
require "logstash/namespace"

class LogStash::Outputs::Stdout < LogStash::Outputs::Base
  begin
    require "ap"
    HAVE_AWESOME_PRINT = true
  rescue => e
    HAVE_AWESOME_PRINT = false
  end

  config_name "stdout"
  config :debug, :validate => :boolean

  public
  def initialize(params)
    super

    #@debug ||= false
  end

  public
  def register
    # nothing to do
  end

  public
  def receive(event)
    if @debug
      if HAVE_AWESOME_PRINT
        ap event.to_hash
      else
        p event.to_hash
      end
    else
      puts event.to_s
    end
  end # def event
end # class LogStash::Outputs::Stdout
