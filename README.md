# Varnish API Cache engine
API Cache Solution with Varnish 4.0
## Requirements
             * API Backend
             * Varnish
             * Cloudflare or cloudfront (Optional: Only if ssl termination for API's is needed)
##### Note: Varnish will not support SSL in both end, So make backend available without SSL

![](https://github.com/shafeequeaslam/varnish_api_cache_engine/blob/master/Varnish%20API%20Cache%20Engine.png)

#### Mobile App (or) Browser


* We can access the cached API’s with host name https://api.example.com from Mobile app or any other client application.


#### CloudFront

* Main purpose of Cloudfront is to provide SSL termination, as Varnish does not support SSL Termination.

* Even Though Cloudfront will cache all API’s for 5 mins as configured in Cloudfront to accept max-age cache header from varnish and max-age is set to 5 mins in default.vcl file of varnish 

* In Cloudfront’s behaviour it is configured to
            Redirect HTTP to HTTPS and
            Whitelist Host and User-Agent headers
#### Varnish Server

* Varnish 4.0 is installed and configured with the following configuration file.

* As the backend (https://example.com) uses SSL and it redirects HTTP to HTTPS, and Varnish does not support SSL in both end, we added the backend IP and domain name in hosts file in order to get API responses through port 80 from backend.

* We can configure How much RAM Varnish can use in /etc/varnish/varnish.params with VARNISH_STORAGE variable.
Eg: VARNISH_STORAGE="malloc,1G"

* Find the default.vcl file for varnish -  https://github.com/shafeequeaslam/varnish_api_cache_engine/blob/master/default.vcl

* All the API’s are cached for 5 Mins in cloudfront, As we are passing max-age=300 from varnish.

#### API Backend

* API Backend should be configured to serve on 80 (HTTP). HTTP to HTTPS redirection should be there in Cloudfront/ Cloudflare only. 


* We can add more API’s which needed to be cached in default.vcl file and define particular cache ttl.
