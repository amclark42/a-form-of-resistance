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
    return
      <html lang="en">
        <head>
          <title>Form request response</title>
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
          <h1>What’d you just say?:
            <br/><small>What your recent form request says about <em>you</em></small>
          </h1>
          <main>
            <p><a href="https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods" target="_blank">HTTP 
              request method</a>:
              <a href="https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/{$method}" 
                target="_blank">{ $method }</a>
            </p>
            { $params }
          </main>
        </body>
      </html>
  };

(:
    SUPPORT FUNCTIONS
 :)
  
  
