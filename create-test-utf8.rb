# -*- coding: utf-8 -*-
in_file = File.open('latex-utf8.tex', 'r')
out_file = File.open('test-utf8.tex', 'w')
header = ['\documentclass[10pt,a4paper]{book}', 
          '%', 
          '\usepackage[left=20mm,right=20mm,top=25mm,bottom=25mm]{geometry}', 
          '\usepackage[utf8]{inputenc}', 
          '\usepackage[T1]{fontenc}', 
          '\usepackage{tabularx}',
          '\usepackage{courier}',
          '%', 
          '\input{latex-utf8.tex}', 
          '%', 
          '\pagestyle{empty}', 
          '%', 
          '\begin{document}', 
          '\begin{tabularx}{1\linewidth}{b{10mm}b{5mm}X}']

header.each do |s|
  out_file.puts s
end

in_file.each do |line|
  if line.include?('\Declare')
    unicode_id = line[line.index(%r|\{|)+1...line.index(%r|\}|)]
    unicode_char = line[line.index(%r/[[:alnum:]]\}/)+3...line.index(%r|%|)-2]
    comment = line[line.index(%r/}[[:space:]]%/)+6..-1].gsub('%','')
    
    out_file.print "\\texttt{#{unicode_id}}" + ' & ' + unicode_char + ' & ' + "\\verb+" + comment + "+ " + "\\tabularnewline"
    out_file.puts
  end
end

out_file.puts '\end{tabularx}'
out_file.puts '\end{document}'

in_file.close()
out_file.close()
