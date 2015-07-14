# Copyight (c) 2013 Kenichi Kamiya
#   No Strict parser for the LTSV(Labeled Tab Separated Values) format 

# What is LTSV?
#  @see http://stanaka.hatenablog.com/entry/2013/02/05/214833

require_relative 'ltsv/version'

module LTSV

  ROW_SEPARATOR = "\n".freeze
  COLUMN_DELIMITER = "\t".freeze
  LABEL_END = ':'.freeze
  
  class Error < StandardError; end
  class MalformedDataError < Error; end

  class << self
    # @param [String] line
    # @return [Hash] row - label<Symbol> => value<String>
    def parse_line(line)
      columns = line.chomp.split COLUMN_DELIMITER
      {}.tap {|hash|
        columns.each do |column|
          label, value = *column.split(LABEL_END, 2)
          hash[label.to_sym] = value
        end
      }
    end

    # @param [String] str
    # @return [Array<Hash>] row, row, row ... row
    def parse(str)
      for_stringable(str).to_a
    end

    # @param [String, IO, StringIO, #each_line] stringable
    # @yieldreturn [Hash] row - label<Symbol> => value<String>
    # @return [void]
    def for_stringable(stringable)
      return to_enum(__callee__, stringable) unless block_given?

      stringable.each_line ROW_SEPARATOR do |line|
        yield parse_line(line)
      end
      nil
    end

    alias_method :for_io, :for_stringable

    # @param [String, Pathname] path
    # @yieldreturn [Hash] row - label<Symbol> => value<String>
    # @return [void]
    def foreach(path, &block)
      return to_enum(__callee__, path) unless block_given?

      open path do |f|
        for_io f, &block
      end
      nil
    end
    
    def line_from_hash(hash)
      hash.each_pair.map do |label, value|
        label, value = label.to_s, value.to_s
        raise MalformedDataError, "`#{label}' is an invalid label"  unless valid_label?(label)
        raise MalformedDataError, "`#{value}' is an invalid value" unless valid_value?(value)
        
        "#{label}#{LABEL_END}#{value}"
      end.join COLUMN_DELIMITER
    end
    
    def string_from_hashes(hashes)
      hashes.map{ |h| line_from_hash h }.join ROW_SEPARATOR
    end
    
    def valid_label?(label)
      [COLUMN_DELIMITER, LABEL_END, ROW_SEPARATOR].none? { |special| label.include? special }
    end
    
    def valid_value?(value)
      [COLUMN_DELIMITER, ROW_SEPARATOR].none? { |special| value.include? special }
    end
  end

end
