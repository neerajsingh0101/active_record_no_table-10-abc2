$:.unshift(File.dirname(__FILE__)) unless
  $:.include?(File.dirname(__FILE__)) || $:.include?(File.expand_path(File.dirname(__FILE__)))

require 'rubygems'


module Validateable_2_1
  [:save, :save!, :update_attribute].each{|attr| define_method(attr){}}
  
  def initialize(options={})
    options.each do |k,v|
      self.send(k.to_s+'=',v) rescue nil
    end
  end

  def method_missing(symbol, *params)
    if(symbol.to_s =~ /(.*)_before_type_cast$/)
      send($1)
    end
  end

  def self.append_features(base)
    super
    base.send(:include, ActiveRecord::Validations)
    base.extend ClassMethods

    base.send :include, ActiveSupport::Callbacks
    base.define_callbacks *ActiveRecord::Validations::VALIDATIONS
  end

  module ClassMethods
    def human_attribute_name(attr)
        attr.humanize
    end
  end
end

module Validateable_2_2

  [:save, :save!, :update_attribute].each{|attr| define_method(attr){}}
  
  def initialize(options={})
    options.each do |k,v|
      self.send(k.to_s+'=',v) rescue nil
    end
  end
 
  def method_missing(symbol, *params)
    if(symbol.to_s =~ /(.*)_before_type_cast$/)
      send($1)
    end
  end
 
  def self.append_features(base)
    super
    base.send(:include, ActiveRecord::Validations)
    base.extend ClassMethods
 
    base.send :include, ActiveSupport::Callbacks
    base.define_callbacks *ActiveRecord::Validations::VALIDATIONS
 
  end
 
  module ClassMethods
     def self_and_descendents_from_active_record
       klass = self
       classes = [klass]
       while klass != klass.base_class
         classes << klass = klass.superclass
       end
       classes
     rescue
       [self]
     end
 
     def human_name(options = {})
       defaults = self_and_descendents_from_active_record.map do |klass|
         :"#{klass.name.underscore}"
       end
       defaults << self.name.humanize
       I18n.translate(defaults.shift, {:scope => [:activerecord, :models], :count => 1, :default => defaults}.merge(options))
     end
 
     def human_attribute_name(attribute_key_name, options = {})
       defaults = self_and_descendents_from_active_record.map do |klass|
         :"#{klass.name.underscore}.#{attribute_key_name}"
       end
       defaults << options[:default] if options[:default]
       defaults.flatten!
       defaults << attribute_key_name.humanize
       options[:count] ||= 1
       I18n.translate(defaults.shift, options.merge(:default => defaults, :scope => [:activerecord, :attributes]))
     end
   end
end

module Validateable_2_3

  [:save, :save!, :update_attribute].each{|attr| define_method(attr){}}
  
  def initialize(options={})
    options.each do |k,v|
      self.send(k.to_s+'=',v) rescue nil
    end
  end
 
  def method_missing(symbol, *params)
    if(symbol.to_s =~ /(.*)_before_type_cast$/)
      send($1)
    end
  end
 
  def self.append_features(base)
    super
    base.send(:include, ActiveRecord::Validations)
    base.extend ClassMethods
 
    base.send :include, ActiveSupport::Callbacks
    base.define_callbacks *ActiveRecord::Validations::VALIDATIONS
  end
 
  module ClassMethods
     def self_and_descendants_from_active_record
       klass = self
       classes = [klass]
       while klass != klass.base_class
         classes << klass = klass.superclass
       end
       classes
     rescue
       [self]
     end
 
     def human_name(options = {})
       defaults = self_and_descendants_from_active_record.map do |klass|
         :"#{klass.name.underscore}"
       end
       defaults << self.name.humanize
       I18n.translate(defaults.shift, {:scope => [:activerecord, :models], :count => 1, :default => defaults}.merge(options))
     end
 
     def human_attribute_name(attribute_key_name, options = {})
       defaults = self_and_descendants_from_active_record.map do |klass|
         :"#{klass.name.underscore}.#{attribute_key_name}"
       end
       defaults << options[:default] if options[:default]
       defaults.flatten!
       defaults << attribute_key_name.humanize
       options[:count] ||= 1
       I18n.translate(defaults.shift, options.merge(:default => defaults, :scope => [:activerecord, :attributes]))
     end
   end
end

if Rails.version >= "2.3.0"
  module ActiveRecord
    class NoTable
      include Validateable_2_3
    end
  end

elsif Rails.version >= '2.2.0' 
  module ActiveRecord
    class NoTable
      include Validateable_2_2
    end
  end

elsif Rails.version >= '2.1.0'
  module ActiveRecord
    class NoTable
      include Validateable_2_1
    end
  end

else
  raise 'this plugin only works with Rails 2.1.x and higher'
end
