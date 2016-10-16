'on error resume next
strShortComputer="."

set objWMISVC=getobject("winmgmts:\\"&strShortComputer&"\root\cimv2")

set objSystem=objWMISVC.instancesof("win32_computersystem")
For Each objSystem0 In objSystem
    strComputer=strComputer & objSystem0.dnshostname & ";"
    strUser=strUser & objSystem0.username & ";"
    strMem=strMem & objSystem0.totalphysicalmemory & ";"
Next
wscript.echo strComputer,strUser,strMem

set objProd=objWMISVC.instancesof("win32_computersystemproduct")
For Each objProd0 In objProd
    strModel=strModel & objProd0.name & ";"
    strVersion=strVersion & objProd0.version & ";"
    strSN=strSN & objProd0.identifyingnumber & ";"
    strUUID=strUUID & objProd0.uuid & ";"
Next
wscript.echo strModel,strVersion,strSN,strUUID

set objNet=objWMISVC.instancesof("win32_networkadapterconfiguration")
For Each objNet0 In objNet
    if objNet0.ipenabled then
        strMac=strMac & objNet0.macaddress & ";"
    end if
Next
wscript.echo strMac

dim objConn
strConn="Driver={SQL Server};Server=George-Acer;Database=TestData;"
strSql="UPDATE ComputerInfo SET DNSHostname='" & strComputer & _
    "', DomainUser='" & strUser & _
    "', Memory='" & strMem & _
    "', Model='" & strModel & _
    "', Version='" & strVersion & _
    "', UUID='" & strUUID & _
    "', MAC='" & strMac & _
    "', LastCom=getdate()" & _
    " WHERE SerialNumber='" & strSN & "'"
set objConn=createobject("ADODB.Connection")
objConn.open strConn
objConn.execute strSql
objConn.close