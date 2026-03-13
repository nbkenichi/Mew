in_flushright = false
in_example = false
in_lisp = false
prev_line = nil

ARGF.each_line do |line|
  line.chomp!

  if line =~ /^@example/
    in_example = true
  elsif line =~ /^@end example/
    in_example = false
  end

  if line =~ /^@lisp/
    in_lisp = true
  elsif line =~ /^@end lisp/
    in_lisp = false
  end

  if line =~ /^@flushright/
    in_flushright = true
  elsif line =~ /^@end flushright/
    in_flushright = false
  end

  if prev_line.nil?
    prev_line = line
    next
  end

  if !in_example && !in_lisp && !in_flushright && (prev_line =~ /[^[:ascii:]]$/) && (line =~ /^[^[:ascii:]]/)
    prev_line += '@c'
  end
  if !in_example && !in_lisp
    ##  prev_line.gsub!(/(.)([々ッ。、」ー])/, '@w{\1}\2')
    prev_line.gsub!(/(.[々ッ。、」ー])/, '@w{\1}')
  end
  puts prev_line
  prev_line = line
end

puts prev_line if prev_line
