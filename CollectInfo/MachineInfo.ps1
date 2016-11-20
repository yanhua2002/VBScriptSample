$computerSystem=Get-WmiObject -Class win32_computersystem
$computerSystemProduct=Get-WmiObject -Class win32_computersystemproduct
$networkAdapterConfiguration=Get-WmiObject -Class win32_networkadapterconfiguration -Filter "ipenabled=$true"

$computerSystem.dnshostname,$computerSystem.domain,$computerSystem.model,$computerSystem.totalphysicalmemory
$computerSystemProduct.identifyingnumber,$computerSystemProduct.uuid
$networkAdapterConfiguration.macaddress,$networkAdapterConfiguration.ipaddress,$networkAdapterConfiguration.servicename

$sqlConn=New-Object System.Data.SqlClient.SqlConnection
$sqlConn.ConnectionString='data source=localhost;initial catalog=[DataBase];integrated security=sspi;'
$sqlConn.Open()
$sqlCommand=$sqlConn.CreateCommand()
$sqlCommand.CommandText="update computerinfo set dnshostname='name' where serialnumber='aaaa'"
$sqlCommand.ExecuteNonQuery()
$sqlCommand.Dispose()
$sqlConn.Close()