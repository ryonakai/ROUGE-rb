ROUGE.rb
======================
ROUGE.rb is a simple package for calculating ROUGE scores, which is a major automatic evaluation method for summarization (Lin 2004).

This package consists of 2 file: `rouge.rb` is a command line interface, and `rouge_core.rb` includes core functions to calculate ROUGE-N and ROUGE-L scores.

Usage
------
` paste candidates.txt references.txt | ruby rouge.rb [-cdD] [-nN] [-vX] `
- `-c` : Char mode (otherwise word mode). Candidates and references are split into characters.  
- `-d` (Default) : Cut off candidates so that candidate.length <= reference.length .
- `-D` : Do not cut off.
- `-n[N=2]` : Calculate ROUGE 1, 2, ...N.
- `-v[X=2]` Every-line output. Print ROUGE X, candidate, and reference.

References
------
Lin, Chin-Yew. 2004. ROUGE: a Package for Automatic Evaluation of Summaries. In Proceedings of the Workshop on Text Summarization Branches Out (WAS 2004), Barcelona, Spain, July 25 - 26, 2004.
