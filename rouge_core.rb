def rougeN(n, cand, ref)
  # cand, ref: array
  candN = []
  refN = []

  # Make subset of size N
  for i in 0..cand.length-n
    candN.push( cand[i,n] )
  end
  for i in 0..ref.length-n
    refN.push( ref[i,n] )
  end

  # Get unique sets of subsets
  candN.uniq!
  refN.uniq!

  # Get intersection
  return (candN & refN).length / refN.length.to_f
end

def rougeL(cand, ref)
  #https://en.wikipedia.org/wiki/Longest_common_substring_problem
  # Initialize 2-D array
  elle = Array.new(cand.length){ Array.new(ref.length, 0) }

  max_lcs_length = 0

  for i in 0...cand.length
    for j in 0...ref.length
      if cand[i] == ref[j]
        if i == 0 || j == 0
          elle[i][j] = 1
        else
          elle[i][j] = elle[i-1][j-1] + 1
        end
      end
      max_lcs_length = elle[i][j] if elle[i][j] > max_lcs_length
    end
  end
  return max_lcs_length.to_f / ref.length
end
