xquery version "3.1";

  module namespace tut="http://amclark42.net/ns/tutorials";
(:  LIBRARIES  :)
(:  NAMESPACES  :)
  (:declare default element namespace "http://www.wwp.northeastern.edu/ns/textbase";:)
  declare namespace array="http://www.w3.org/2005/xpath-functions/array";
  declare namespace http="http://expath.org/ns/http-client";
  declare namespace map="http://www.w3.org/2005/xpath-functions/map";
  declare namespace output="http://www.w3.org/2010/xslt-xquery-serialization";
  declare namespace request="http://exquery.org/ns/request";
  declare namespace rest="http://exquery.org/ns/restxq";
  declare namespace tei="http://www.tei-c.org/ns/1.0";
  declare namespace wwp="http://www.wwp.northeastern.edu/ns/textbase";
  declare namespace xhtml="http://www.w3.org/1999/xhtml";

(:~
  
  
  @author Ash Clark
  @since 2024
 :)
 
(:
    VARIABLES
 :)
  

(:
    FUNCTIONS
 :)
  
  (:~
    Serve out an example form with the given filename. An error is returned if the file doesn't exist.
   :)
  declare
    %rest:GET
    %rest:path('a-form-of-resistance/forms/{$filename}')
    %output:method('html')
    %output:media-type('text/html')
  function tut:display-form($filename as xs:string) {
    if ( not(doc-available('forms/'||$filename)) ) then
      tut:build-page('Page not found', <p>Page not found</p>)
    else
      let $formDoc := doc('forms/'||$filename)
      return tut:build-page($formDoc//xhtml:title, $formDoc//xhtml:main)
  };
  
  
  (:~
    This endpoint takes in any GET or POST request, and simply repeats back parts of the HTTP request.
    Useful for demonstrating what data is sent by the example forms.
   :)
  declare
    %rest:GET
    %rest:POST
    %rest:path('a-form-of-resistance/request')
    %output:method('html')
    %output:media-type('text/html')
  function tut:show-parameters() {
    let $method := request:method()
    let $params :=
      <dl id="req-params">{
        for $key in request:parameter-names()
        let $valSeq := request:parameter($key, '')
        return (
            <dt>{ $key }</dt>,
            for $value in $valSeq
            return <dd>{ xs:string($value) }</dd>
          )
      }</dl>
    return tut:build-page('Form request response', (
        <h1>What’d you just say?:
          <br/><small>What your recent form request says about <em>you</em></small>
        </h1>,
        <main>
          <p><a href="https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods" target="_blank">HTTP 
            request method</a>:
            <a href="https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/{$method}" 
              target="_blank">{ $method }</a>
          </p>
          { $params }
        </main>
      ))
  };

(:
    SUPPORT FUNCTIONS
 :)
  
  declare %private function tut:build-page($title as xs:string, $contents as node()*) as node() {
    <html lang="en">
      <head>
        <title>{ $title }</title>
        <style>{ unparsed-text('css/bootstrap-reboot.min.css') }</style>
        <style>{ unparsed-text('css/forms.css') }</style>
        <style><![CDATA[
          #req-params {
            display: grid;
            grid-template-columns: 10% auto;
          }
          #req-params > dt { grid-column: 1; }
          #req-params > dd { grid-column: 2; }
        ]]></style>
      </head>
      <body>
        { $contents }
      </body>
    </html>
  };
  
