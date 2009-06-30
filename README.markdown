== Introduction

This is a gem to 

== How to install this gem 

<pre>
  <code>
    gem sources -a http://gems.github.com
    sudo gem install neerajdotname-active_record_no_table
  </code>
</pre>

== How to use this gem

class User < ActiveRecord::NoTable
  validates_presence_of :name
  attr_accessor :name
end


== Feedback

Email me: neerajdotname [at] gmail (dot) com

== License

MIT

Copyright (c) 2009 neerajdotname
