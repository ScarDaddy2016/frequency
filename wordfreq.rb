class Wordfreq
  STOP_WORDS = ['a', 'an', 'and', 'are', 'as', 'at', 'be', 'by', 'for', 'from',
    'has', 'he', 'i', 'in', 'is', 'it', 'its', 'of', 'on', 'that', 'the', 'to',
    'were', 'will', 'with']

  def initialize(filename)
      # read entire file as a string
      contents = File.read(filename)
      # convert the string to lowercase and
      # break into an array of words using a regular expression
      arr = contents.downcase.scan(/\w+/)

      # declare a hash to store the words and frequencies
      # by default make the count equal to 0
      # note this is an instance variable
      @frequencies = Hash.new{ |h, key| h[key] =  0}

      # remove all the words found in the STOP_WORDS array
      # the .include?(x) method evals to 'true' if 'x' is in the array
      arr.delete_if{|word| STOP_WORDS.include?(word)}

      # loop thru each word in the array
      arr.each do |word|
        # because we declared a default value for the hash
        # if this is the first time we have a word, an entry is
        # created so that then we can increment it!
        # of course, if the word already exists in the hash, we increment too!
        @frequencies[word] += 1
      end
  end

  def frequency(word)
    # the count associated with the passed in parameter
    return @frequencies[word]
  end

  def frequencies
    # this function acts as a 'getter' and returns the entire hash
    return @frequencies
  end

  def top_words(number)
    # this returns the top 'n' words as specified by
    # parameter 'number'

    # the sort function converts a hash into an array
    # we want to sort on the frequency, so we need to specify
    # which element in the array we want to sort by
    # each element of the array is ['key',value] so
    # using the a[1], b[1] means to compare the 'values'
    #
    # the sort order is smallest to largest, so we have to reverse the array
    array=@frequencies.sort{|a,b| a[1]<=>b[1]}.reverse

    # use the slice notation to return only that portion of
    # the array asked for
    return array[0...number]
  end

  def print_report
    # print out the table as required

    # first make the array with the 10 most used words
    array = top_words(10)

    # next make an empty string for later concatenation
    table=''

    # loop thru the array and make the table per as specified
    array.each do |word, number|
      left = word.rjust(7)
      vert = ' | '
      num = "#{number}".ljust(3)
      right = '*'*number
      table += left + vert + num + right + "\n"
    end

    # now print the table
    puts table
  end
end

if __FILE__ == $0
  filename = ARGV[0]
  if filename
    full_filename = File.absolute_path(filename)
    if File.exists?(full_filename)
      wf = Wordfreq.new(full_filename)
      wf.print_report
    else
      puts "#{filename} does not exist!"
    end
  else
    puts "Please give a filename as an argument."
  end
end
