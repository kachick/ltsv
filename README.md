ltsv
==============

[![Build Status](https://secure.travis-ci.org/kachick/ltsv.png)](http://travis-ci.org/kachick/ltsv)
[![Gem Version](https://badge.fury.io/rb/ya_ltsv.png)](http://badge.fury.io/rb/ltsv)
[![Dependency Status](https://gemnasium.com/kachick/ltsv.svg)](https://gemnasium.com/kachick/ltsv)

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

LTSV.line_from_hash({:key1=>"val1", :key2=>"val2"}) #=> "key1:val1	key2:val2"
LTSV.line_from_hash valid: "with\ttab" #=> LTSV::MalformedDataError
```

Requirements
-------------

* Ruby - [1.9.3 or later](http://travis-ci.org/#!/kachick/ltsv)

Install
-------

```bash
gem install ya-ltsv
```

Link
----

* [code](https://github.com/kachick/ltsv)
* [API](http://www.rubydoc.info/github/kachick/ltsv)
* [issues](https://github.com/kachick/ltsv/issues)
* [CI](http://travis-ci.org/#!/kachick/ltsv)
* [gem](https://rubygems.org/gems/ya_ltsv)

License
--------

The MIT X11 License  
Copyright (c) 2013 Kenichi Kamiya  
See MIT-LICENSE for further details.
