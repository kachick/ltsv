* ***This repository is archived***
* ***No longer maintained***
* ***All versions have been yanked from https://rubygems.org for releasing valuable namespace for others***

ltsv
==============

![Build Status](https://github.com/kachick/ltsv/actions/workflows/test_behaviors.yml/badge.svg?branch=main)

Description
-----------

An reader/writer library for the LTSV(Labeled Tab Separated Values) format. 
See LTSV specs http://ltsv.org/.

Usage
-----

```ruby
require 'ltsv'

LTSV.parse_line "key1:val1	key2:val2\n" #=> {:key1=>"val1", :key2=>"val2"}

LTSV.parse 'key1:val1	key2:val2
key1:val1	key2:val2	key3:val3' #=> [{:key1=>"val1", :key2=>"val2"}, {:key1=>"val1", :key2=>"val2", :key3=>"val3"}]

LTSV.foreach foo.log.ltsv do |entry|
  p entry # calls the block with parsed hash
end

LTSV.for_io STDIN do |entry|
  p entry # calls the block with parsed hash
end

LTSV.line_from_hash({key1: 'val1', key2: 'val2'}) #=> "key1:val1	key2:val2"
LTSV.line_from_hash valid: "with\ttab" #=> LTSV::MalformedDataError
```

Requirements
-------------

* Ruby - 3.1 or higher

License
--------

The MIT X11 License  
Copyright (c) 2013 Kenichi Kamiya  
See MIT-LICENSE for further details.
