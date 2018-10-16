# https://blogs.technet.microsoft.com/cammurray/2014/09/23/using-powershell-to-obtain-your-tenants-office365-health-dashboard/

$cred = get-credential

$jsonPayload = (@{userName=$cred.username;password=$cred.GetNetworkCredential().password;} | convertto-json).tostring()


$cookie = (invoke-restmethod -contenttype "application/json" -method Post -uri "https://api.admin.microsoftonline.com/shdtenantcommunications.svc/Register" -body $jsonPayload).RegistrationCookie

$jsonPayload = (@{lastCookie=$cookie;locale="en-US";preferredEventTypes=@(0,1)} | convertto-json).tostring()

$events = (invoke-restmethod -contenttype "application/json" -method Post -uri "https://api.admin.microsoftonline.com/shdtenantcommunications.svc/GetEvents" -body $jsonPayload)
