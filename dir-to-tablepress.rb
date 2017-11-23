#!/usr/bin/env ruby
####
# Copyright 2017 John Messenger
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
####

require 'rubygems'
require 'date'
require 'logger'
require 'rest-client'
require 'slop'
require 'yaml'
require './tptable'

#
# Main program
#
begin
  opts = Slop.parse do |o|
    o.banner = 'usage: dir-to-tablepress.rb [options] URL-of-directory'
    o.string '-s', '--secrets', 'secrets YAML file name', default: 'secrets.yml'
    o.bool   '-d', '--debug', 'debug mode'
    o.bool   '-u', '--update', 'update an existing table'
    o.bool   '-l', '--lookup', 'look up filenames in the web database'
    o.string '-o', '--outfile', 'output filename'
    o.int    '-p', '--per-page', 'how many files to display per page', default: 15
    o.on '--help' do
      STDERR.puts o
      exit
    end
  end

  # The first argument to the script is the URL of the directory to convert.
  if opts.args.count == 1
    arch_url = opts.args[0]
  else
    STDERR.puts opts
    exit
  end

  config = YAML.load(File.read(opts[:secrets]))
  $stdout.reopen(opts[:outfile]) if opts[:outfile]

  # Set up logging (which is not used)
  $DEBUG = opts.debug?
  $logger = Logger.new(STDERR)
  $logger.level = Logger::INFO
  $logger.level = Logger::DEBUG if $DEBUG

  # When debugging, use a proxy on localhost to allow Charles Proxy to see the interactions
  if $DEBUG
    RestClient.proxy = "http://localhost:8888"
    $logger.debug("Using HTTP proxy #{RestClient.proxy}")
  end

  arch_creds = [config['username'], config['password']]
  db_creds = [config['db_user'], config['db_password']]

  tptable = TPTable.new(arch_url, creds: arch_creds, db_url: config['db_uri'], db_creds: db_creds)

  # Retrieve and parse the directory into an array of file details.
  files = tptable.parse_dir(lookup: opts[:lookup])

  if $DEBUG
    files.each do |f|
      puts "#{f[:date]} #{f[:name]} #{f[:href]} #{f[:desc]}"
    end
  end

  puts tptable.to_json(per_page: opts[:per_page], lookup: opts[:lookup])

end
