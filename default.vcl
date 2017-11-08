#
# This is an example VCL file for Varnish.
#
# It does not do anything by default, delegating control to the
# builtin VCL. The builtin VCL is called when there is no explicit
# return statement.
#
# See the VCL chapters in the Users Guide at https://www.varnish-cache.org/docs/
# and http://varnish-cache.org/trac/wiki/VCLExamples for more examples.

# Marker to tell the VCL compiler that this VCL has been adapted to the
# new 4.0 format.
vcl 4.0;

# Default backend definition. Set this to point to your content server.
backend default {
    .host = "HOSTNAME/IP";
    .port = "80";
}

sub vcl_recv {
    # Happens before we check if we have this in cache already.
    #
    # Typically you clean up the request here, removing cookies you don't need,
    # rewriting the request, etc.

    #Set backend hostname to your origin hostname                 
    if (req.http.host ~ "REQUIRED_CACHED_API_DOMAIN_NAME") {
          set req.http.host = "API_BACKEND_DOMAIN_NAME";
        }

    # Only cache GET and HEAD requests (pass through POST requests).
    if (req.method != "GET" && req.method != "HEAD") {
          return (pass);
        }

    # Return to hash for the following API Requests (Look to Cache for the following requests)
    if (req.url ~ "^/API_URL_ONE" ||
        req.url ~ "^/API_URL_TWO" ||
        req.url ~ "^/API_URL_THREE" ||
        req.url ~ "^/API_URL_FOUR" ||
        req.url ~ "^/API_URL_FIVE" ||
        req.url ~ "^/API_URL_SIX" ) {
          return (hash);
        }
    else {
          return (pass);
        }
}

sub vcl_backend_response {
    # Happens after we have read the response headers from the backend.
    #
    # Here you clean the response headers, removing silly Set-Cookie headers
    # and other mistakes your backend does.

  ##API CACHE TTL CONFIG ##
    # Cache below APIs for 8 Hours
    if (bereq.url ~ "^/API_URL_ONE" ||
        bereq.url ~ "^/API_URL_TWO" ) {

          unset beresp.http.set-cookie;
          set beresp.http.cache-control = "public, max-age=300";
          set beresp.ttl = 8h;
          return (deliver);
        }
    # Cache below APIs for 5 Hours                                
    if (bereq.url ~ "^/API_URL_THREE" ||
        bereq.url ~ "^/API_URL_FOUR") {

          unset beresp.http.set-cookie;
          set beresp.http.cache-control = "public, max-age=300";
          set beresp.ttl = 5h;
          return (deliver);
        }
    # Cache below APIs for 1 Hour 
    if (bereq.url ~ "^/API_URL_FIVE" ||
        bereq.url ~ "^/API_URL_SIX" ){

          unset beresp.http.set-cookie;
          set beresp.http.cache-control = "public, max-age=300";
          set beresp.ttl = 1h;
          return (deliver);
        }
}

sub vcl_deliver {
    # Happens when we have all the pieces we need, and are about to send the
    # response to the client.
    #
    # You can do accounting or modifying the final object here.
}

