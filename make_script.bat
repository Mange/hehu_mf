@echo off
if not defined build_dir goto :missing_variables

mkdir "%build_dir%\hehu_cqb\functions"

pushd %tools_dir%\binmake
@echo on
binmake.exe "%source_dir%\config.cpp" "%build_dir%\hehu_cqb\config.bin"
@echo off
popd

@echo on
copy "%source_dir%\functions\" "%build_dir%\hehu_cqb\functions"

"%tools_dir%\filebank\filebank.exe" -property prefix=hehu_cqb "%build_dir%\hehu_cqb"

@echo off
mkdir "%target_dir%\@hehu_cqb\addons"

@echo on
copy "%build_dir%\hehu_cqb.pbo" "%target_dir%\@hehu_cqb\addons"
copy "%source_dir%\mod.cpp" "%target_dir%\@hehu_cqb"
copy "%source_dir%\README.md" "%target_dir%\@hehu_cqb\readme.txt"

pause
exit 0

:missing_variables
echo You need to set up your make.bat file and run that one instead!
pause
exit 1