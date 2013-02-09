# Copyight (c) 2013 Kenichi Kamiya
#   No Strict parser for the LTSV(Labeled Tab Separated Values) format 

# What is LTSV?
#  @see http://stanaka.hatenablog.com/entry/2013/02/05/214833

module LTSV

  ROW_SEPARATOR = "\n".freeze
  COLUMN_DELIMITER = "\t".freeze
  LABEL_END = ':'.freeze

  class << self
    # @param [String] line
    # @return [Hash] row - label<Symbol> => value<String>
    def parse_line(line)
      columns = line.split COLUMN_DELIMITER
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

    # @param [String, IO, StringIO, #each_line] stringable
    # @yieldreturn [Hash] row - label<Symbol> => value<String>
    # @return [void]
    def foreach(path)
      return to_enum(__callee__, path) unless block_given?

      open path do |f|
        for_io f
      end
      nil
    end
  end

end

# example

require 'pp'

LTSV.for_io DATA do |row|
  pp row
end

__END__
time:[28/Feb/2013:12:00:00 +0900]	host:192.168.0.1	req:GET /list HTTP/1.1	status:200	size:5316	referer:-	ua:Mozilla/5.0	taken:9789	isrobot:1	dos:-	harddos:-	cache:-
time:[28/May/2013:12:00:00 +0900]	size:5316	host:192.168.0.1	req:GET /list HTTP/1.1	status:433	referer:-	ua:Mozilla/5.0	taken:9789	isrobot:1	dos:-	harddos:-	cache:-