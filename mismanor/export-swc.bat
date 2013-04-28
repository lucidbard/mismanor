@echo off
call compc -source-path src/ -output lib/CiF-test.swc -namespace http://CiF CiF-manifest.xml -include-namespaces http://CiF
copy /Y lib\CiF-test.swc lib\CiF.swc
copy /Y lib\CiF-test.swc ..\DesignTool\lib\CiF.swc
copy /Y lib\CiF-test.swc ..\TheProm\lib\CiF.swc
copy /Y lib\CiF-test.swc ..\..\Mismanor\lib\CiF.swc
copy /Y lib\CiF-test.swc ..\..\GrailGM\lib\CiF.swc
