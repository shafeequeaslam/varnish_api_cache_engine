# Varnish API Cache engine
API Cache Solution with Varnish 4.0
## Requirements
             * API Backend
             * Varnish
             * Cloudflare or cloudfront (Optional: Only if ssl termination for API's is needed)
##### Note: Varnish will not support SSL in both end, So make backend available without SSL

![](https://github.com/shafeequeaslam/varnish_api_cache_engine/blob/master/Varnish%20API%20Cache%20Engine.png)

#### Mobile App (or) Browser


We can access the cached API’s with host name https://api.example.com from Mobile app or any other client application.


#### CloudFront

* Main purpose of Cloudfront is to provide SSL termination, as Varnish does not support SSL Termination.

* Even Though Cloudfront will cache all API’s for 5 mins as configured in Cloudfront to accept max-age cache header from varnish and max-age is set to 5 mins in default.vcl file of varnish 

* In Cloudfront’s behaviour it is configured to
            - Redirect HTTP to HTTPS and
            - Whitelist Host and User-Agent headers
