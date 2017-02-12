class ServiceStat

  def initialize
    @fail_count = 0
    @success_count = 0
  end

  def update_stats(response)
    case response.code
      when '200'
        @success_count += 1
      else
        @fail_count +=1
    end
  end

  def number_of_tests_performed
    @success_count + @fail_count
  end

  def stats_hash
    {failCount: @fail_count,
     successCount: @success_count,
     numberOfTestsPerformed: number_of_tests_performed}
  end

end