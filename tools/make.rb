require "shellwords"
require "pathname"
source_path = Pathname.new(File.expand_path("../..", __FILE__))

if ARGV.include?("release")
	out_dir = source_path.join("release", "@hehu", "addons")
else
	out_dir = source_path.join("addons")
end

out_dir.mkpath

Pathname.glob("#{source_path}/addons/*").select(&:directory?).each do |dir|
	next if dir.basename.to_s == "blank"

	command = [
		"makepbo",
		"-NUP",
		dir.to_s,
		out_dir.join("hehu_#{dir.basename}.pbo").to_s
	].compact

	puts command.map(&:shellescape).join(" ")
	unless system(*command)
		puts "PBO failed! Press enter to close window."
		gets
		exit 1
	end
end
