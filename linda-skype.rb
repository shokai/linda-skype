#!/usr/bin/env ruby
# -*- coding: utf-8 -*-
require 'rubygems'
require File.expand_path 'libs/skype', File.dirname(__FILE__)
require 'sinatra/rocketio/linda/client'
$stdout.sync = true

url   = ENV["LINDA_BASE"]  || "http://localhost:5000"
space = ENV["LINDA_SPACE"] || "test"
chat  = ENV["CHAT_ID"]     || ARGV.shift
if chat.empty?
  STDERR.puts "please set Chat ID"
  STDERR.puts "e.g.  bundle exec ruby #{$0} '#shokai/$a1b2cdef3456'"
  exit 1
end

puts "chat_id : #{chat}"

puts "connecting.. #{url}"
linda = Sinatra::RocketIO::Linda::Client.new url
ts = linda.tuplespace[space]

linda.io.on :connect do
  puts "connect!! <#{linda.io.session}> (#{linda.io.type})"
  ts.watch ["skype", "send"] do |tuple|
    p tuple
    if tuple.size == 3
      puts str = tuple[2]
      msg = "(ninja) 《Linda》 #{str} 《masuilab》"
      if Skype.send_chat_message(chat, msg) =~ /STATUS SENDING$/
        ts.write ["skype", "send", str, "success"]
      else
        ts.write ["skype", "send", str, "fail"]
      end
    end
  end
end

linda.io.on :disconnect do
  puts "RocketIO disconnected.."
end

linda.wait
