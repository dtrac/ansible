
# Ansible Tower Callback Script

$hostConfigKey = '1234567890ABCDEFG'
$uri = 'https://10.1.1.1:443/api/v2/job_templates/14/callback/'

add-type @"
using System.Net;
using System.Security.Cryptography.X509Certificates;
public class TrustAllCertsPolicy : ICertificatePolicy {
    public bool CheckValidationResult(
        ServicePoint srvPoint, X509Certificate certificate,
        WebRequest request, int certificateProblem) {
        return true;
    }
}
"@

[Net.ServicePointManager]::CertificatePolicy = New-Object TrustAllCertsPolicy
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12

$postParams = @{host_config_key=$hostConfigKey}
Invoke-WebRequest -Uri $uri -Method POST -Body $postParams
