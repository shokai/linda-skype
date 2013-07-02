#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'rubygems'
require 'skype'
require 'sinatra/rocketio/linda/client'
$stdout.sync = true

url   = ENV["LINDA_BASE"]  || "http://localhost:5000"
space = ENV["LINDA_SPACE"] || "test"
chat_topic = ENV["CHAT_TOPIC"]  || ARGV.shift
if chat_topic.empty?
  STDERR.puts "please set Chat Topic"
  STDERR.puts "e.g.  bundle exec ruby #{$0} 'linda'"
  exit 1
end

chat = Skype.chats.find{|c| c.topic =~ /#{chat_topic}/ }
puts "chat id:#{chat.id}  topic:#{chat.topic}"

puts "connecting.. #{url}"
linda = Sinatra::RocketIO::Linda::Client.new url
ts = linda.tuplespace[space]

linda.io.on :connect do
  puts "connect!! <#{linda.io.session}> (#{linda.io.type})"
  ts.watch ["skype", "send"] do |tuple|
    p tuple
    if tuple.size == 3
      puts str = tuple[2]
      msg = "(ninja) 《Linda》 #{str} 《#{space}》"
      chat.post msg
      ts.write ["skype", "send", str, "success"]
    end
  end
end

linda.io.on :disconnect do
  puts "RocketIO disconnected.."
end

linda.wait
