#usage: paste candidates.txt reference.txt | ruby rouge.rb [-cdD ][-nN] [-vX]
# -c : char mode
# -d (Default) : cut off candidate so that candidate.length <= reference.length
# -D : do not cut off.
# -n[N=2] : calculate ROUGE 1, 2, ...N.
# -v[X=2] Every-line output. Print ROUGE X, candidate, and reference.

require './rouge_core.rb'
require 'optparse'
params = ARGV.getopts('cdDv:n:')

char_mode = params['c']
cut_long_candidate = !params['D']
rouge_nums = (params['n'] || 2).to_i
print_rouge = params['v']

rouge_N_totals = Array.new(rouge_nums, 0)
rouge_L_total = 0
count_sentences = 0

$stdin.readlines.each do |line|
  split = line.rstrip.split("\t")
  next if split.length != 2
  candS, refS = split

  # Split into chars or words
  delimiter = char_mode ? '' : ' '
  cand = candS.split(delimiter)
  ref = refS.split(delimiter)

  # Skip if too short
  next if cand.length <= 2 || ref.length <= 2

  # Cut long candidate
  cand = cand[0...ref.length] if cut_long_candidate

  #Calculate ROUGE scores
  for i in 1..rouge_nums
    rN = rougeN(i, cand, ref)
    rouge_N_totals[i-1] += rN
    rouge_to_print = rN if print_rouge.to_i == i
  end
  rL = rougeL(cand, ref)
  rouge_L_total += rL
  rouge_to_print = rL if print_rouge == 'L'
  count_sentences += 1

  if print_rouge
    puts sprintf("[R%s = %.4f]\n%s\n%s\n\n", print_rouge, rouge_to_print, candS, refS)
  end
end

rouge_Ns = rouge_N_totals.map { |e| e/count_sentences.to_f  }
rouge_L  = rouge_L_total/count_sentences.to_f

puts "Number of sentences: #{count_sentences}\n\n"

puts ( char_mode ? 'Character-' : 'Word-' ) + "based ROUGE Scores:"
puts "[candidate longer than refference have been cut]" if cut_long_candidate

for i in 1..rouge_nums
  puts "ROUGE #{i} : #{rouge_Ns[i-1]}"
end
puts "ROUGE L : #{rouge_L}"
