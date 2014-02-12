#!/usr/bin/env ruby

require 'mechanize'
require 'open-uri'
require 'io/console'
require 'sys/proctable'
require 'optparse'
include Sys

OptionParser.new do |opts|
  opts.banner = "Usage: dogemine.rb [options]"

  opts.on('-u', '--username USERNAME', String,
          'Specify dogehouse username (default prompts)') do |u|
    @username = u
  end

  opts.on('-p', '--password PASSWORD', String,
          'Specify dogehouse password (default prompts with noecho)') do |p|
    @password = p
  end

  opts.on('-c', '--cmd CMD', String,
          'Specify command to call (url automatically appended at the end)') do |c|
    @cmd = c
  end
end.parse!

def get_username_and_password
  if !@username
    print "Username: "
    @username = gets.chomp
  end

  if !@password
    print "Password: "
    @password = STDIN.noecho(&:gets).chomp
    puts
  end
  return @username, @password
end

def get_best_url
  agent = Mechanize.new
  agent.get("https://dogehouse.org/?page=login")

  form = agent.page.forms[0]
  form['username'], form['password'] = get_username_and_password
  form.submit

  agent.get("https://dogehouse.org/?page=dashboard")

  rows = agent.page.parser.css('.stratumtable table').children

  somemapthing = {}

  minimum = nil
  minimum_port = nil

  1.upto(rows[0].children.length-1) do |i|
    name = rows[0].children[i].content
    value = rows[1].children[i].content
    if name[0] == 'L'
      if minimum.nil? || value < minimum
        minimum = value
        minimum_port = name[2..-1]
      end
    end
  end

  agent.get("https://dogehouse.org/?page=gettingstarted")

  urls = agent.page.parser.css('.module_content > li > table > tbody > tr kbd').map(&:content)

  return urls.find { |url| url.end_with?(minimum_port) }
end

def launch_miner
  url = get_best_url
  if ProcTable.ps.none?{|p| p.cmdline.start_with? @cmd}
    exec("#{@cmd} #{url}")
  end
end

launch_miner
