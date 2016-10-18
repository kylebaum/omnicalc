class CalculationsController < ApplicationController

  def word_count
    @text = params[:user_text]
    @special_word = params[:user_word]

    # ================================================================================
    # Your code goes below.
    # The text the user input is in the string @text.
    # The special word the user input is in the string @special_word.
    # ================================================================================


    @character_count_with_spaces = @text.length

    @character_count_without_spaces = @text.gsub(" ","").length

    @word_count = @text.scan(/(\w|-)+/).size

    @occurrences = @text.scan(@special_word).size

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("word_count.html.erb")
  end

  def loan_payment
    @apr = params[:annual_percentage_rate].to_f
    @years = params[:number_of_years].to_i
    @principal = params[:principal_value].to_f

    # ================================================================================
    # Your code goes below.
    # The annual percentage rate the user input is in the decimal @apr.
    # The number of years the user input is in the integer @years.
    # The principal value the user input is in the decimal @principal.
    # ================================================================================
    @apr_calc = ((@apr/1200)).to_f
    @term_months = (@years*12)

    @monthly_payment = ((@apr_calc*@principal)*((1+@apr_calc)**@term_months))/(((1+@apr_calc)**@term_months)-1)


    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("loan_payment.html.erb")
  end

  def time_between
    @starting = Chronic.parse(params[:starting_time])
    @ending = Chronic.parse(params[:ending_time])

    # ================================================================================
    # Your code goes below.
    # The start time is in the Time @starting.
    # The end time is in the Time @ending.
    # Note: Ruby stores Times in terms of seconds since Jan 1, 1970.
    #   So if you subtract one time from another, you will get an integer
    #   number of seconds as a result.
    # ================================================================================

    @seconds = @ending-@starting
    @minutes = (@ending-@starting)/60
    @hours = ((@ending-@starting)/60)/60
    @days = ((@ending-@starting)/60)/60/24
    @weeks = ((@ending-@starting)/60)/60/24/7
    @years = ((@ending-@starting)/60)/60/24/7/52

    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("time_between.html.erb")
  end

  def descriptive_statistics
    @numbers = params[:list_of_numbers].gsub(',', '').split.map(&:to_f)

    # ================================================================================
    # Your code goes below.
    # The numbers the user input are in the array @numbers.
    # ================================================================================

    @sorted_numbers = @numbers.sort

    @count = @numbers.count

    @minimum = @numbers.min

    @maximum = @numbers.max

    @max = @numbers.max
    @min = @numbers.min
    @range = @max-@min

    def median(array)
       array_sorted = array.sort
       array_length = array_sorted.length
       (array_sorted[(array_length - 1) / 2] + array_sorted[array_length / 2]) / 2.0
     end
     @median = median(@numbers)


    def sum(list_of_numbers)
         running_total = 0
         list_of_numbers.each do |number|
           running_total = running_total + number
         end
         return running_total
       end

       @sum = sum(@numbers)

    @mean = (@numbers.sum)/@count


  def variance(list_of_numbers)
       sq_diff = 0
       running_total = 0
       list_of_numbers.each do |number|
         sq_diff = (number - (list_of_numbers.sum / list_of_numbers.count))**2
         running_total = running_total + sq_diff
       end
       return running_total / list_of_numbers.count
     end
     @variance = variance(@numbers)

  def standard_deviation(list_of_numbers)
    variance = variance(@numbers)
    return Math.sqrt(variance)
  end
    @standard_deviation = standard_deviation(@numbers)

@sorted_numbers = @numbers.sort
    @most_common_count = 0

    @sorted_numbers.each do |num|
      if @sorted_numbers.count(num) > @most_common_count

        @most_common_count = @sorted_numbers.count(num)
        @most_common = num
      end
    end

      @mode = @most_common


    # ================================================================================
    # Your code goes above.
    # ================================================================================

    render("descriptive_statistics.html.erb")
  end
end
