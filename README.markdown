== Introduction

Using ActiveRecord validation utilitites is difficult if you do not have a table for your model. This gem makes it easy to use validation tools even if the model does not have a corresponding table. 

This gem works with Rails 2.1 and higher.

== How to install

<pre>
  <code>
gem sources -a http://gems.github.com
sudo gem install neerajdotname-active_record_no_table
  </code>
</pre>

<pre>
  <code>
config.gem "neerajdotname-active_record_no_table", 
           :lib => active_record_no_table',
           :source => 'http://gems.github.com'                                        
  </code>
</pre>


== How to use this gem

<pre>
  <code>
class User < ActiveRecord::NoTable
   validates_presence_of :name
   attr_accessor :name
end

>> user = User.new
>> user.valid?
>> user.errors.full_messages
>> ["Name can't be blank"]
  </code>
</pre>  

== Feedback

Email me: neerajdotname [at] gmail (dot) com

== License

MIT

Copyright (c) 2009 neerajdotname
