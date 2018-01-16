# Dirtp: TablePress maker for Web directories


This Ruby script queries a website that offers directory listings, and converts them into TablePress tables
for inclusion into a Wordpress website.  The first column is the date and the second column is a link to the
file on the remote server.  When directories are encountered in the listing, these are recursively
parsed, but flattened and not listed, so that all files are listed in a single table. The directory structure
is only reflected by including the directory names in the links.
Optionally, each filename can be looked up in a separate web-based database to retrieve a description of each
file, which is then included in a third column in the generated table.

## Usage

Check the `bin/dir-to-tablepress.rb` script for an example of using this gem.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'dirtp'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install dirtp

## Command-Line Options
This gem comes with a commend-line utility which demonstrates its use and can be used
to generate Tablepress JSON tables.

Without any options, the script prints a usage message and exits.  The mandatory first argument us the URL of the
directory to parse.  
* `--lookup`  (abbreviated `-l`): Look up each filename in a web-based database and include the resulting description
  as a third column in the generated table.  To use this option, some configuration options need to be defined
  in the `secrets.yml` file: `db_uri` is the URL of the lookup API, to which a query in the form `?filename=fname`
  will be appended.  The output is expected in XML, as documented elsewhere.  The only tag interpretted is the
  `<description>` and this text is included in the third table column.
  
* `--update table-ref` (abbreviated `-u`): this unimplmented option will extend an existing table.  Existing
  entries will not be modified.  Additional entries will be added. Entries for files which are no longer present
  will be removed with a warning.
* `--outfile outputfilename` (abbreviated `-o`): write the table to `outfilename` instead of standard output.
* `--secrets secretfile.yml` (abbreviated `-s`): Use the given file for the configuration options rather than the
  default `secrets.yml`. 
* `--debug`  (abbreviated `-d`): print additional debugging information to STDERR and use a localhost proxy on port
  8888 to allow web traffic to be inspected.

### Configuration
The URL of the web-based filename lookup API, together with the usernames
and passwords for it and for the directory to be parsed, are stored in `secrets.yml` which is not included
in the sources.  An example of that file file is available as `example-secrets.yml`.

### Usage
The example script was developed to allow lists of files to be shown in a Wordpress website.  The idea is to periodically
recreate or update the table either via `wp-cron` or by manipulating the Wordpress API.  The output format is
compatible with TablePress' import format.


## Development

After checking out the repo, run `bin/setup` to install dependencies. You can also run `bin/console` for an interactive prompt that will allow you to experiment.

To install this gem onto your local machine, run `bundle exec rake install`. To release a new version, update the version number in `version.rb`, and then run `bundle exec rake release`, which will create a git tag for the version, push git commits and tags, and push the `.gem` file to [rubygems.org](https://rubygems.org).

## Contributing

Bug reports and pull requests are welcome on GitHub at https://github.com/jlm/dir-to-tablepress.
