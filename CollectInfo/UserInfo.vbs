'on error resume next
strShortComputer="."

set objSWbemServices=getobject("winmgmts:\\"&strShortComputer&"\root\cimv2")

set objProd=objSWbemServices.instancesof("win32_computersystemproduct")
For Each objProd0 In objProd
    strSN=strSN & objProd0.identifyingnumber & ";"
Next
wscript.echo strSN

dim objWshShell
set objWshShell=wscript.createobject("wscript.shell")
strUser=objWshShell.expandenvironmentstrings("%USERNAME%")
strUserDomain=objWshShell.expandenvironmentstrings("%USERDOMAIN%")

strReg1CTI=objWshShell.RegRead("HKCU\Software\Classes\VirtualStore\MACHINE\SOFTWARE\Samwoo\AA\PBXSoftPhone\CTIServerAIP")
strReg1Ext=objWshShell.RegRead("HKCU\Software\Classes\VirtualStore\MACHINE\SOFTWARE\Samwoo\AA\PBXSoftPhone\DeviceName")
strReg2CTI=objWshShell.RegRead("HKLM\SOFTWARE\Samwoo\AA\PBXSoftPhone\CTIServerAIP")
strReg2Ext=objWshShell.RegRead("HKLM\SOFTWARE\Samwoo\AA\PBXSoftPhone\DeviceName")

wscript.echo strUser,strUserDomain,strReg1CTI,strReg1Ext,strReg2CTI,strReg2Ext

dim objConn
strConn="Driver={SQL Server};Server=George-Acer;Database=TestData;"
strConn2="Provider=SQLOLEDB;Data Source=[ServerNameOrIP];Initial Catalog=[Database];Uid=[User];Pwd=[Password];"
strSqlUser="UPDATE ComputerInfo SET UserName='" & strUser & _
    "', UserDomain='" & strUserDomain & _
    "', CTIUser='" & strReg1CTI & _
    "', EXTUser='" & strReg1Ext & _
    "', CTIMachine='" & strReg2CTI & _
    "', EXTMachine='" & strReg2Ext & _
    "', LastUserCom=getdate()" & _
    " WHERE SerialNumber='" & strSN & "'"
set objConn=createobject("ADODB.Connection")
objConn.open strConn2
objConn.execute strSqlUser
objConn.close