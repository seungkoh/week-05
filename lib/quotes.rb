# 
# Here is where you will write the class Quotes
# 
# For more information about classes I encourage you to review the following:
# 
# @see http://en.wikibooks.org/wiki/Ruby_Programming/Syntax/Classes
# @see Programming Ruby, Chapter 3
# 
# 
# For this exercise see if you can employ the following techniques:
# 
# Use class convenience methods: attr_reader; attr_writer; and attr_accessor.
# 
# Try using alias_method to reduce redundancy.
# 
# @see http://rubydoc.info/stdlib/core/1.9.2/Module#alias_method-instance_method
# 
class Quotes
  DEFAULT_QUOTE = 'Could not find a quote at this time'
  
  class << self; attr_accessor :missing_quote; end

  self.missing_quote = DEFAULT_QUOTE
  
  def self.load(file)
    self.new :file => file
  end
    
  attr_accessor :file
  
  def initialize(file={})
    @file = file[:file]
  end
  
  def all
    if File.exists? file
      File.readlines(file).map { |quote| quote.strip }
    else
      []
    end
  end
    
  def find(index)
    all.empty? ? Quotes.missing_quote : all[index].nil? ? all.sample : all[index]
  end
  
  def search(criteria = {})
    return all if all.empty? || (file && criteria.empty?)
    criteria.map { |key, value| all.select { |quote| quote.send("#{key}?", value) } }.flatten
  end  
  
  alias_method :quotes, :all
  alias_method :[], :find
end
