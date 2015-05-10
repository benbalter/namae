#
# DO NOT MODIFY!!!!
# This file is automatically generated by Racc 1.4.9
# from Racc grammer file "".
#

require 'racc/parser.rb'

require 'singleton'
require 'strscan'

module Namae
  class Parser < Racc::Parser

module_eval(<<'...end parser.y/module_eval...', 'parser.y', 107)

  include Singleton

  attr_reader :options, :input

  def initialize
    @input, @options = StringScanner.new(''), {
      :debug => false,
      :prefer_comma_as_separator => false,
      :comma => ',',
      :stops => ',;',
      :separator => /\s*(\band\b|\&|;)\s*/i,
      :title => /\s*\b(sir|lord|count(ess)?|(gen|adm|col|maj|capt|cmdr|lt|sgt|cpl|pvt|prof|dr|md|ph\.?d)\.?)(\s+|$)/i,
      :suffix => /\s*\b(JR|Jr|jr|SR|Sr|sr|[IVX]{2,})(\.|\b)/,
      :appellation => /\s*\b((mrs?|ms|fr|hr)\.?|miss|herr|frau)(\s+|$)/i
    }
  end

  def debug?
    options[:debug] || ENV['DEBUG']
  end

  def separator
    options[:separator]
  end

  def comma
    options[:comma]
  end

  def stops
    options[:stops]
  end

  def title
    options[:title]
  end

  def suffix
    options[:suffix]
  end

  def appellation
    options[:appellation]
  end

  def prefer_comma_as_separator?
    options[:prefer_comma_as_separator]
  end

  def parse(input)
    parse!(input)
  rescue => e
    warn e.message if debug?
    []
  end

  def parse!(string)
    input.string = normalize(string)
    reset
    do_parse
  end

  def normalize(string)
    string = string.strip
    string
  end

  def reset
    @commas, @words, @initials, @suffices, @yydebug = 0, 0, 0, 0, debug?
    self
  end

  private

  def stack
    @vstack || @racc_vstack || []
  end

  def last_token
    stack[-1]
  end

  def consume_separator
    return next_token if seen_separator?
    @commas, @words, @initials, @suffices = 0, 0, 0, 0
    [:AND, :AND]
  end

  def consume_comma
    @commas += 1
    [:COMMA, :COMMA]
  end

  def consume_word(type, word)
    @words += 1

    case type
    when :UWORD
      @initials += 1 if word =~ /^[[:upper:]]+\b/
    when :SUFFIX
      @suffices += 1
    end

    [type, word]
  end

  def seen_separator?
    !stack.empty? && last_token == :AND
  end

  def suffix?
    !@suffices.zero? || will_see_suffix?
  end

  def will_see_suffix?
    input.peek(8).to_s.strip.split(/\s+/)[0] =~ suffix
  end

  def will_see_initial?
    input.peek(6).to_s.strip.split(/\s+/)[0] =~ /^[[:upper:]]+\b/
  end

  def seen_full_name?
    prefer_comma_as_separator? && @words > 1 &&
      (@initials > 0 || !will_see_initial?) && !will_see_suffix?
  end

  def next_token
    case
    when input.nil?, input.eos?
      nil
    when input.scan(separator)
      consume_separator
    when input.scan(/\s*#{comma}\s*/)
      if @commas.zero? && !seen_full_name? || @commas == 1 && suffix?
        consume_comma
      else
        consume_separator
      end
    when input.scan(/\s+/)
      next_token
    when input.scan(title)
      consume_word(:TITLE, input.matched.strip)
    when input.scan(suffix)
      consume_word(:SUFFIX, input.matched.strip)
    when input.scan(appellation)
      [:APPELLATION, input.matched.strip]
    when input.scan(/((\\\w+)?\{[^\}]*\})*[[:upper:]][^\s#{stops}]*/)
      consume_word(:UWORD, input.matched)
    when input.scan(/((\\\w+)?\{[^\}]*\})*[[:lower:]][^\s#{stops}]*/)
      consume_word(:LWORD, input.matched)
    when input.scan(/(\\\w+)?\{[^\}]*\}[^\s#{stops}]*/)
      consume_word(:PWORD, input.matched)
    when input.scan(/('[^'\n]+')|("[^"\n]+")/)
      consume_word(:NICK, input.matched[1...-1])
    else
      raise ArgumentError,
        "Failed to parse name #{input.string.inspect}: unmatched data at offset #{input.pos}"
    end
  end

  def on_error(tid, value, stack)
    raise ArgumentError,
      "Failed to parse name: unexpected '#{value}' at #{stack.inspect}"
  end

# -*- racc -*-
...end parser.y/module_eval...
##### State transition tables begin ###

racc_action_table = [
   -40,    30,    28,    31,   -39,    16,    39,   -40,    67,   -40,
   -40,   -39,    17,   -39,   -39,    62,    59,    66,    53,    52,
    54,    53,    52,    54,    30,   -34,    31,    32,    39,    53,
    52,    54,   -38,    59,   -22,    58,    39,    68,    58,   -38,
    53,    52,    54,    14,    12,    15,    39,    39,     7,     8,
    14,    12,    15,    33,    39,     7,     8,    14,    22,    15,
    24,    14,    22,    15,    24,    53,    52,    54,    30,    42,
    31,    30,    28,    31,    53,    52,    54,   -20,   -20,   -20,
    30,    46,    31,    14,    22,    15,    30,    28,    31,    30,
    28,    31,    30,    28,    31,   -19,   -19,   -19,   -19,   -19,
   -19,    45,    58,    59,    39 ]

racc_action_check = [
    15,    41,    41,    41,    14,     1,    40,    15,    50,    15,
    15,    14,     1,    14,    14,    44,    50,    49,    49,    49,
    49,    62,    62,    62,    43,    49,    43,    11,    62,    45,
    45,    45,    12,    38,    12,    37,    45,    57,    60,    12,
    32,    32,    32,     0,     0,     0,    61,    32,     0,     0,
    17,    17,    17,    16,    64,    17,    17,    20,    20,    20,
    20,     9,     9,     9,     9,    73,    73,    73,    24,    24,
    24,    25,    25,    25,    67,    67,    67,    28,    28,    28,
    29,    29,    29,     5,     5,     5,    35,    35,    35,    21,
    21,    21,    10,    10,    10,    42,    42,    42,    22,    22,
    22,    27,    70,    72,    23 ]

racc_action_pointer = [
    40,     5,   nil,   nil,   nil,    80,   nil,   nil,   nil,    58,
    89,    25,    32,   nil,     4,     0,    53,    47,   nil,   nil,
    54,    86,    95,    94,    65,    68,   nil,    99,    74,    77,
   nil,   nil,    37,   nil,   nil,    83,   nil,    26,    23,   nil,
    -4,    -2,    92,    21,    13,    26,   nil,   nil,   nil,    15,
     6,   nil,   nil,   nil,   nil,   nil,   nil,    28,   nil,   nil,
    29,    36,    18,   nil,    44,   nil,   nil,    71,   nil,   nil,
    93,   nil,    93,    62,   nil ]

racc_action_default = [
    -1,   -49,    -2,    -4,    -5,   -49,    -8,    -9,   -10,   -23,
   -49,   -49,   -19,   -28,   -30,   -31,   -49,   -49,    -6,    -7,
   -49,   -49,   -38,   -41,   -49,   -49,   -29,   -15,   -22,   -23,
   -30,   -31,   -36,    75,    -3,   -49,   -15,   -45,   -42,   -43,
   -41,   -49,   -22,   -23,   -14,   -36,   -21,   -16,   -24,   -37,
   -26,   -32,   -38,   -39,   -40,   -14,   -11,   -46,   -47,   -44,
   -45,   -41,   -36,   -17,   -49,   -33,   -35,   -49,   -48,   -12,
   -45,   -18,   -25,   -27,   -13 ]

racc_goto_table = [
     3,    37,    26,    50,    56,    18,     2,     9,    47,    23,
    73,    64,    20,    26,    19,    27,    50,     3,    60,     1,
    23,    63,    26,    34,     9,   nil,    36,    69,    21,    40,
    44,    43,    25,    50,   nil,    72,    26,    74,    71,    70,
    55,   nil,   nil,    35,   nil,   nil,    61,    41,   nil,    65,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,    65 ]

racc_goto_check = [
     3,     8,    17,    16,     9,     3,     2,     7,    12,     3,
    14,    15,     7,    17,     4,    10,    16,     3,     8,     1,
     3,    12,    17,     2,     7,   nil,    10,     9,    11,    10,
    10,     7,    11,    16,   nil,    16,    17,     9,    12,     8,
    10,   nil,   nil,    11,   nil,   nil,    10,    11,   nil,     3,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,   nil,
   nil,   nil,   nil,     3 ]

racc_goto_pointer = [
   nil,    19,     6,     0,     9,   nil,   nil,     7,   -22,   -33,
     5,    23,   -24,   nil,   -57,   -38,   -29,    -7,   nil ]

racc_goto_default = [
   nil,   nil,   nil,    51,     4,     5,     6,    29,   nil,   nil,
    11,    10,   nil,    48,    49,   nil,    38,    13,    57 ]

racc_reduce_table = [
  0, 0, :racc_error,
  0, 12, :_reduce_1,
  1, 12, :_reduce_2,
  3, 12, :_reduce_3,
  1, 13, :_reduce_4,
  1, 13, :_reduce_none,
  2, 13, :_reduce_6,
  2, 13, :_reduce_7,
  1, 13, :_reduce_none,
  1, 16, :_reduce_9,
  1, 16, :_reduce_10,
  4, 15, :_reduce_11,
  5, 15, :_reduce_12,
  6, 15, :_reduce_13,
  3, 15, :_reduce_14,
  2, 15, :_reduce_15,
  3, 17, :_reduce_16,
  4, 17, :_reduce_17,
  5, 17, :_reduce_18,
  1, 22, :_reduce_none,
  2, 22, :_reduce_20,
  3, 22, :_reduce_21,
  1, 21, :_reduce_none,
  1, 21, :_reduce_none,
  1, 23, :_reduce_24,
  3, 23, :_reduce_25,
  1, 23, :_reduce_26,
  3, 23, :_reduce_27,
  1, 18, :_reduce_none,
  2, 18, :_reduce_29,
  1, 28, :_reduce_none,
  1, 28, :_reduce_none,
  1, 25, :_reduce_none,
  2, 25, :_reduce_33,
  0, 26, :_reduce_none,
  1, 26, :_reduce_none,
  0, 24, :_reduce_none,
  1, 24, :_reduce_none,
  1, 14, :_reduce_none,
  1, 14, :_reduce_none,
  1, 14, :_reduce_none,
  0, 19, :_reduce_none,
  1, 19, :_reduce_none,
  1, 27, :_reduce_none,
  2, 27, :_reduce_44,
  0, 20, :_reduce_none,
  1, 20, :_reduce_none,
  1, 29, :_reduce_none,
  2, 29, :_reduce_48 ]

racc_reduce_n = 49

racc_shift_n = 75

racc_token_table = {
  false => 0,
  :error => 1,
  :COMMA => 2,
  :UWORD => 3,
  :LWORD => 4,
  :PWORD => 5,
  :NICK => 6,
  :AND => 7,
  :APPELLATION => 8,
  :TITLE => 9,
  :SUFFIX => 10 }

racc_nt_base = 11

racc_use_result_var = true

Racc_arg = [
  racc_action_table,
  racc_action_check,
  racc_action_default,
  racc_action_pointer,
  racc_goto_table,
  racc_goto_check,
  racc_goto_default,
  racc_goto_pointer,
  racc_nt_base,
  racc_reduce_table,
  racc_token_table,
  racc_shift_n,
  racc_reduce_n,
  racc_use_result_var ]

Racc_token_to_s_table = [
  "$end",
  "error",
  "COMMA",
  "UWORD",
  "LWORD",
  "PWORD",
  "NICK",
  "AND",
  "APPELLATION",
  "TITLE",
  "SUFFIX",
  "$start",
  "names",
  "name",
  "word",
  "display_order",
  "honorific",
  "sort_order",
  "u_words",
  "opt_suffices",
  "opt_titles",
  "last",
  "von",
  "first",
  "opt_words",
  "words",
  "opt_comma",
  "suffices",
  "u_word",
  "titles" ]

Racc_debug_parser = false

##### State transition tables end #####

# reduce 0 omitted

module_eval(<<'.,.,', 'parser.y', 11)
  def _reduce_1(val, _values, result)
     result = [] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 12)
  def _reduce_2(val, _values, result)
     result = [val[0]] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 13)
  def _reduce_3(val, _values, result)
     result = val[0] << val[2] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 15)
  def _reduce_4(val, _values, result)
     result = Name.new(:given => val[0]) 
    result
  end
.,.,

# reduce 5 omitted

module_eval(<<'.,.,', 'parser.y', 17)
  def _reduce_6(val, _values, result)
     result = val[0].merge(:family => val[1]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 18)
  def _reduce_7(val, _values, result)
     result = val[1].merge(val[0]) 
    result
  end
.,.,

# reduce 8 omitted

module_eval(<<'.,.,', 'parser.y', 21)
  def _reduce_9(val, _values, result)
     result = Name.new(:appellation => val[0]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 22)
  def _reduce_10(val, _values, result)
     result = Name.new(:title => val[0]) 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 26)
  def _reduce_11(val, _values, result)
             result = Name.new(:given => val[0], :family => val[1],
           :suffix => val[2], :title => val[3])
       
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 31)
  def _reduce_12(val, _values, result)
             result = Name.new(:given => val[0], :nick => val[1],
           :family => val[2], :suffix => val[3], :title => val[4])
       
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 36)
  def _reduce_13(val, _values, result)
             result = Name.new(:given => val[0], :nick => val[1],
           :particle => val[2], :family => val[3],
           :suffix => val[4], :title => val[5])
       
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 42)
  def _reduce_14(val, _values, result)
             result = Name.new(:given => val[0], :particle => val[1],
          :family => val[2])
       
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 47)
  def _reduce_15(val, _values, result)
             result = Name.new(:particle => val[0], :family => val[1])
       
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 52)
  def _reduce_16(val, _values, result)
             result = Name.new({ :family => val[0], :suffix => val[2][0],
           :given => val[2][1] }, !!val[2][0])
       
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 57)
  def _reduce_17(val, _values, result)
             result = Name.new({ :particle => val[0], :family => val[1],
           :suffix => val[3][0], :given => val[3][1] }, !!val[3][0])
       
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 62)
  def _reduce_18(val, _values, result)
             result = Name.new({ :particle => val[0,2].join(' '), :family => val[2],
           :suffix => val[4][0], :given => val[4][1] }, !!val[4][0])
       
    result
  end
.,.,

# reduce 19 omitted

module_eval(<<'.,.,', 'parser.y', 68)
  def _reduce_20(val, _values, result)
     result = val.join(' ') 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 69)
  def _reduce_21(val, _values, result)
     result = val.join(' ') 
    result
  end
.,.,

# reduce 22 omitted

# reduce 23 omitted

module_eval(<<'.,.,', 'parser.y', 73)
  def _reduce_24(val, _values, result)
     result = [nil,val[0]] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 74)
  def _reduce_25(val, _values, result)
     result = [val[2],val[0]] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 75)
  def _reduce_26(val, _values, result)
     result = [val[0],nil] 
    result
  end
.,.,

module_eval(<<'.,.,', 'parser.y', 76)
  def _reduce_27(val, _values, result)
     result = [val[0],val[2]] 
    result
  end
.,.,

# reduce 28 omitted

module_eval(<<'.,.,', 'parser.y', 79)
  def _reduce_29(val, _values, result)
     result = val.join(' ') 
    result
  end
.,.,

# reduce 30 omitted

# reduce 31 omitted

# reduce 32 omitted

module_eval(<<'.,.,', 'parser.y', 84)
  def _reduce_33(val, _values, result)
     result = val.join(' ') 
    result
  end
.,.,

# reduce 34 omitted

# reduce 35 omitted

# reduce 36 omitted

# reduce 37 omitted

# reduce 38 omitted

# reduce 39 omitted

# reduce 40 omitted

# reduce 41 omitted

# reduce 42 omitted

# reduce 43 omitted

module_eval(<<'.,.,', 'parser.y', 94)
  def _reduce_44(val, _values, result)
     result = val.join(' ') 
    result
  end
.,.,

# reduce 45 omitted

# reduce 46 omitted

# reduce 47 omitted

module_eval(<<'.,.,', 'parser.y', 99)
  def _reduce_48(val, _values, result)
     result = val.join(' ') 
    result
  end
.,.,

def _reduce_none(val, _values, result)
  val[0]
end

  end   # class Parser
  end   # module Namae
