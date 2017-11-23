TablePress maker for Web directories
==============

This Ruby script queries a website that offers directory listings, and converts them into TablePress tables
for inclusion into a Wordpress website.  The first column is the date and the second column is a link to the
file on the remote server.  When directories are encountered in the listing, these are recursively
parsed, but flattened and not listed, so that all files are listed in a single table. The directory structure
is only reflected by including the directory names in the links.
Optionally, each filename can be looked up in a separate web-based database to retrieve a description of each
file, which is then included in a third column in the generated table.

Configuration
-------------
The URL of the web-based filename lookup API, together with the usernames
and passwords for it and for the directory to be parsed, are stored in `secrets.yml` which is not included
in the sources.  An example of that file file is available as `example-secrets.yml`.

Command-Line Options
--------------------
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

Usage
-----
This script was developed to allow lists of files to be shown in a Wordpress website.  The idea is to periodically
recreate or update the table either via `wp-cron` or by manipulating the Wordpress API.  The output format is
compatible with TablePress' import format.

Deployment
----------

TBA.

License
-------
Copyright 2017 John Messenger

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.

Author
------
John Messenger, ADVA Optical Networking Ltd., Vice-chair, 802.1
