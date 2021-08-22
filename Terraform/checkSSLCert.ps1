function Get_SSlCert  {
$url = "https://www.microsoft.com/"
[Net.ServicePointManager]::ServerCertificateValidationCallback = { $true }
$req = [Net.HttpWebRequest]::Create($url)
$req.GetResponse() | Out-Null
$result = [PSCustomObject]@{
   URL = $url
   'Cert Start Date' = $req.ServicePoint.Certificate.GetEffectiveDateString()
   'Cert End Date' = $req.ServicePoint.Certificate.GetExpirationDateString()
}
$result
}