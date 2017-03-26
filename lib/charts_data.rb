module ChartsData
  def hash_prefix_sum(hash)
    hash.each_with_object({}) do |(sym, val), acc|
      acc[sym] = if acc.empty?
                    val
                  else
                    val + acc.values.last
                  end
    end
  end
end
