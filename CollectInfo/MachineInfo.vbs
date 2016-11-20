'on error resume next
strShortComputer="."

'set objSWbemLocator=createobject("WbemScripting.SWbemLocator")
'set objSWbemServices=objSWbemLocator.connectserver(strShortComputer,"root\cimv2","username","password")

set objSWbemServices=getobject("winmgmts:\\"&strShortComputer&"\root\cimv2")

set objSystem=objSWbemServices.instancesof("win32_computersystem")
For Each objSystem0 In objSystem
    strComputer=strComputer & objSystem0.dnshostname & ";"
    strDomain=strDomain & objSystem0.domain & ";"
    strModel=strModel & objSystem0.model & ";"
    strMem=strMem & objSystem0.totalphysicalmemory & ";"
Next
wscript.echo strComputer,strDomain,strModel,strMem

set objProd=objSWbemServices.instancesof("win32_computersystemproduct")
For Each objProd0 In objProd
    strSN=strSN & objProd0.identifyingnumber & ";"
    strUUID=strUUID & objProd0.uuid & ";"
Next
wscript.echo strSN,strUUID

set objNet=objSWbemServices.instancesof("win32_networkadapterconfiguration")
For Each objNet0 In objNet
    if objNet0.ipenabled then
        strMac=strMac & objNet0.macaddress & ";"
        For Each objIP0 In objNet0.ipaddress
            strIP=strIP & objIP0 & ";"
        Next
        strNetDriver=strNetDriver & objNet0.servicename & ";"
    end if
Next
wscript.echo strMac,strIP,strNetDriver

dim objConn
strConn="Driver={SQL Server};Server=George-Acer;Database=TestData;"
strConn2="Provider=SQLOLEDB;Data Source=[ServerNameOrIP];Initial Catalog=[Database];Uid=[User];Pwd=[Password];"
strSqlMachine="UPDATE ComputerInfo SET DNSHostName='" & strComputer & _
    "', Domain='" & strDomain & _
    "', Model='" & strModel & _
    "', Memory='" & strMem & _
    "', UUID='" & strUUID & _
    "', MAC='" & strMac & _
    "', IPAddress='" & strIP & _
    "', NetDriver='" & strNetDriver & _
    "', LastMachineCom=getdate()" & _
    " WHERE SerialNumber='" & strSN & "'"
set objConn=createobject("ADODB.Connection")
objConn.open strConn2
objConn.execute strSqlMachine
objConn.close