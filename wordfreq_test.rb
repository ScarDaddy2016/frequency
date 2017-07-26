require 'minitest/autorun'
require_relative 'wordfreq'

def fullpath(filename)
  File.absolute_path(File.join(File.dirname(__FILE__)), filename)
end

class WordfreqTest < Minitest::Test
  def test_freq_of_a_word
    wf = Wordfreq.new fullpath('emancipation_proclamation.txt')
    assert_equal 7, wf.frequency('shall')
    assert_equal 2, wf.frequency('designate')

    wf = Wordfreq.new fullpath('seneca_falls.txt')
    assert_equal 2, wf.frequency('compelled')
    assert_equal 6, wf.frequency('women')
  end

  def test_word_not_present_has_freq_of_0
    wf = Wordfreq.new fullpath('seneca_falls.txt')
    assert_equal 0, wf.frequency('computer')
  end

  def test_frequencies
    wf = Wordfreq.new fullpath('emancipation_proclamation.txt')
    frequencies = wf.frequencies
    assert_equal 2, frequencies['virtue']
    assert_equal 1, frequencies['justice']
  end

  def test_top_words
    wf = Wordfreq.new fullpath('seneca_falls.txt')
    top_words = wf.top_words(5)
    assert_equal [
      ["her", 33], ["all", 12], ["which", 12], ["they", 7], ["their", 7]
    ], top_words

    wf = Wordfreq.new fullpath('emancipation_proclamation.txt')
    top_words = wf.top_words(4)
    assert_equal [
      ["states", 20], ["united", 14], ["day", 8], ["shall", 7]
    ], top_words
  end

  def test_report
    expected_output = <<EOF
    her | 33 *********************************
    all | 12 ************
  which | 12 ************
   they | 7  *******
  their | 7  *******
    she | 7  *******
   this | 6  ******
   them | 6  ******
  women | 6  ******
 rights | 6  ******
EOF

    wf = Wordfreq.new fullpath('seneca_falls.txt')
    assert_output expected_output do
      wf.print_report
    end
  end
end
