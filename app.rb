require 'json'
require 'redis'
require 'new_relic/agent'

NewRelic::Agent.manual_start(:sync_startup => true)

class Background
	include ::NewRelic::Agent::Instrumentation::ControllerInstrumentation
	def foo
		r = Redis.new
		r.set('foo','bar')
	end
	add_transaction_tracer :foo, :category => :task
end

Background.new.foo

::NewRelic::Agent.shutdown