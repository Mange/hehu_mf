require "pathname"
source_path = File.expand_path("../..", __FILE__)

Pathname.glob("#{source_path}/addons/*").select(&:directory?).each do |dir|
	next if dir.basename == "blank"

	unless system(
		"makepbo",
		"-NUP",
		#"-@=z\\hehu\\addons\\#{dir.basename}",
		dir.to_s,
		"#{dir.dirname}/hehu_#{dir.basename}.pbo"
	)
		puts "PBO failed!"
		exit 1
	end
end
