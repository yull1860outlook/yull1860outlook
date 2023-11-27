#!/bin/sh

###############################################
# To get request statistics with curl
#Windows:
curl -w " \n dns_resolution: %{time_namelookup}, tcp_established: %{time_connect}, ssl_handshake_done: %{time_appconnect}, TTFB: %{time_starttransfer} \n" -o "C:\Users\shz\Desktop\output.txt" -s https://harrytestapim.azure-api.net/httpbinApim/get
#Linux: 
curl -w " \n dns_resolution: %{time_namelookup}, tcp_established: %{time_connect}, ssl_handshake_done: %{time_appconnect}, TTFB: %{time_starttransfer} \n" -o "C:\Users\shz\Desktop\output.txt" -s -H "Ocp-Apim-Subscription-Key: 80450f7d0b6d481382113073f67822c1" "https://harrytestapim.azure-api.net/httpbinApim/get"
#For loop:
for i in {1..5000}; do echo "$i "; date '+%Y%m%d %H:%M:%S:%s'; curl -w "dns_resolution: %{time_namelookup}, tcp_established: %{time_connect}, ssl_handshake_done: %{time_appconnect}, TTFB: %{time_starttransfer}\n" -o output.txt -s --key "APIM.key" --cert "APIM.crt" -H "Ocp-Apim-Subscription-Key: 80450f7d0b6d481382113073f67822c1" "https://harrytestapim.azure-api.net/httpbinApim/get"; done 2>&1 | tee ~/statisticFile.txt

##################################
#Shell script run continuous DNS
while true; do curl -v -s -I ${YOUR_KEYVAULT_HTTPS_URL} 2>&1 | egrep "(Could not resolve host|Connected to)" | python -c 'import sys,time;sys.stdout.write("".join(( " ".join((time.strftime("[%Y-%m-%d %H:%M:%S]", time.localtime()), line)) for line in sys.stdin )))'; sleep 3; done | tee check_dns_resolution_$WEBSITE_SITE_NAME.log 


###########################
#get MSI token from app kudu
response=$(curl $IDENTITY_ENDPOINT'?api-version=2019-08-01&resource=https%3A%2F%2Fmanagement.azure.com%2F' -H "X-IDENTITY-HEADER:$IDENTITY_HEADER"  -H Metadata:true -s);access_token=$(echo $response | python -c 'import sys, json; print (json.load(sys.stdin)["access_token"])');echo $access_token

#############################
# example call to for OneDeploy to push a file (similar to ZipDeploy but works for multiple package types)
curl -X POST -H "Authorization: Bearer $TOKEN" -T "@<file-path>" https://<app-name>.scm.azurewebsites.net/api/publish?type=zip
curl -X POST -H "Authorization: Bearer $TOKEN" -T "@<file-path>" https://<app-name>.scm.azurewebsites.net/api/publish?type=jar
curl -X POST -H "Authorization: Bearer $TOKEN" -T "@<file-path>" https://<app-name>.scm.azurewebsites.net/api/publish?type=war
curl -X POST -H "Authorization: Bearer $TOKEN" -T "@<file-path>" https://<app-name>.scm.azurewebsites.net/api/publish?type=ear

#################################
# example call to invoke a webjob
curl -X POST -H "Authorization: Bearer $TOKEN" https://<app-name>.scm.azurewebsites.net/api/trigeredwebjobs/<job-name>/run

#######################################################################################
#log stream , token can be obtain from above MSI endpoint (with website contributor RBAC)
curl -H "Authorization: Bearer $TOKEN" https://<app-name>.scm.azurewebsites.net/api/logstream

##################
#ARM sample 
#   check REST API document for respective API usage
#   PUT/POST may need request body , can use '-d <data>'
#
POST https://management.azure.com/subscriptions/7a3eb7f7-2f34-45bb-94f1-4ac54f32665a/resourceGroups/mbpythonflaskapp/providers/Microsoft.Web/sites/mbpythonflaskapp/restart?api-version=2016-08-01

#################
#AAD get token
curl -X POST -d 'grant_type=client_credentials&client_id=<your clientid>&client_secret=<your client secret>&resource=https%3A%2F%2Fmanagement.azure.com%2F' https://login.microsoftonline.com/<subscription id>/oauth2/token   

#################
#Keyvault 
#  only endpoint support anonymous 
curl -i https://<vaultname>.vault.azure.net/healthstatus


#Storage 
curl -H "$x_ms_date_h" -H "x-ms-version: 2017-11-09"
  "https://${storage_account}.${blob_store_url}/${container_name}?restype=container&comp=list"

#download blob using SAS
curl https://labsesa11.blob.core.windows.net/test/labjavaapp_202104120306.log?sp=r&st=2021-06-23T03:17:35Z&se=2021-06-23T11:17:35Z&spr=https&sv=2020-02-10&sr=b&sig=<SAS-signature>


#Upload a blob
Curl -X PUT -H "x-ms-version: 2017-11-09" -H "x-ms-date: 2023-03-06"  -H "x-ms-blob-type:BlockBlob"    "https://${storage_account}.blob.core.windows.net/${container_name}/{destfile}?{sas_token}" -T <file>
#or
curl -X PUT -T [file_path] -H "x-ms-blob-type: BlockBlob" "https://[storage_account_name].blob.core.windows.net/[container_name]/[blob_name]?[sas_token]"





####################################
#  check TLS/SSL handshake 
#    - target IP / port
#    - cert CN , cipher used 
#    - To bypass server cert validation , you can use -k 
#

yying@vsdev:~$ curl https://labjavaapp.azurewebsites.net -v
* Rebuilt URL to: https://labjavaapp.azurewebsites.net/
*   Trying 20.188.98.74...
* TCP_NODELAY set
* Connected to labjavaapp.azurewebsites.net (20.188.98.74) port 443 (#0)
* ALPN, offering h2
* ALPN, offering http/1.1
* successfully set certificate verify locations:
*   CAfile: /etc/ssl/certs/ca-certificates.crt
  CApath: /etc/ssl/certs
* TLSv1.3 (OUT), TLS handshake, Client hello (1):
* TLSv1.3 (IN), TLS handshake, Server hello (2):
* TLSv1.2 (IN), TLS handshake, Certificate (11):
* TLSv1.2 (IN), TLS handshake, Server key exchange (12):
* TLSv1.2 (IN), TLS handshake, Server finished (14):
* TLSv1.2 (OUT), TLS handshake, Client key exchange (16):
* TLSv1.2 (OUT), TLS change cipher, Client hello (1):
* TLSv1.2 (OUT), TLS handshake, Finished (20):
* TLSv1.2 (IN), TLS handshake, Finished (20):
* SSL connection using TLSv1.2 / ECDHE-RSA-AES256-GCM-SHA384
* ALPN, server accepted to use h2
* Server certificate:
*  subject: C=US; ST=WA; L=Redmond; O=Microsoft Corporation; CN=*.azurewebsites.net
*  start date: Mar 14 18:39:55 2022 GMT
*  expire date: Mar  9 18:39:55 2023 GMT
*  subjectAltName: host "labjavaapp.azurewebsites.net" matched cert "*.azurewebsites.net"
*  issuer: C=US; O=Microsoft Corporation; CN=Microsoft Azure TLS Issuing CA 01
*  SSL certificate verify ok.
* Using HTTP2, server supports multi-use
* Connection state changed (HTTP/2 confirmed)
* Copying HTTP/2 data in stream buffer to connection buffer after upgrade: len=0
* Using Stream ID: 1 (easy handle 0x55c4f775f6a0)
> GET / HTTP/2
> Host: labjavaapp.azurewebsites.net
> User-Agent: curl/7.58.0
> Accept: */*
>
* Connection state changed (MAX_CONCURRENT_STREAMS updated)!
< HTTP/2 404
< date: Thu, 14 Jul 2022 03:18:34 GMT
< content-length: 0
< x-powered-by: ASP.NET
<
* Connection #0 to host labjavaapp.azurewebsites.net left intact
yying@vsdev:~$


############################
# Send Email with curl
#
curl --connect-timeout 15 -v --insecure "smtp://smtp.office365.com:587" -u "email:password" --mail-from "emailFrom" --mail-rcpt "emailTo" --ssl --upload-file temp.txt
https://stackoverflow.com/questions/14722556/using-curl-to-send-email  


###########################
# using IP instead of FQDN (and set HOST header manually)
curl.exe -v https://13.75.76.44 -H "Host: ambitious-moss-04d53eb00.2.azurestaticapps.net"

###########################
# or override DNS result to particular IP
curl.exe -v  https://ambitious-moss-04d53eb00.2.azurestaticapps.net --resolve ambitious-moss-04d53eb00.2.azurestaticapps.net:443:20.98.190.171