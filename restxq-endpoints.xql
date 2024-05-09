xquery version "3.1";

  module namespace tut="http://amclark42.net/ns/tutorials";
(:  LIBRARIES  :)
(:  NAMESPACES  :)
  declare default element namespace "http://www.w3.org/1999/xhtml";
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
    The landing page for the site.
   :)
  declare
    %rest:GET
    %rest:path('a-form-of-resistance')
    %output:method('xhtml')
    %output:media-type('text/html')
  function tut:main-page() {
    (: Use index.html, but also include the first paragraph from the "About this form" section of each 
      form. :)
    let $index := 
      copy $modIndex := doc('index.html')//xhtml:body/*
      modify 
        for $formItem in $modIndex//xhtml:li[xhtml:a[@class eq 'form-link']]
        let $path := $formItem/xhtml:a/@href/data(.)
        let $summary := (
            text { ": " },
            <span class="form-summary">{ doc($path)//xhtml:details/xhtml:p[1]/node() }</span>
          )
        return
          insert node $summary after $formItem/xhtml:a
      return $modIndex
    return tut:build-page("A Form of Resistance", $index)
  };
  
  (:~
    Serve out an example form with the given filename. An error is returned if the file doesn't exist.
   :)
  declare
    %rest:GET
    %rest:path('a-form-of-resistance/forms/{$filename}')
    %output:method('xhtml')
    %output:media-type('text/html')
  function tut:display-form($filename as xs:string) {
    if ( not(doc-available('forms/'||$filename)) ) then
      tut:build-page('Page not found', <p>Page not found</p>)
    else
      let $formDoc := doc('forms/'||$filename)
      return tut:build-page($formDoc//xhtml:title, $formDoc//xhtml:body/*)
  };
  
  
  (:~
    This endpoint takes in any GET or POST request, and simply repeats back parts of the HTTP request.
    Useful for demonstrating what data is sent by the example forms.
   :)
  declare
    %rest:GET
    %rest:POST
    %rest:path('a-form-of-resistance/request')
    %output:method('xhtml')
    %output:media-type('text/html')
  function tut:show-parameters() {
    let $method := request:method()
    let $allParamKeys := request:parameter-names()
    let $params :=
      let $rows :=
        for $key in $allParamKeys
        let $keyCell := <th scope="row">{ $key }</th>
        let $valSeq := request:parameter($key, '')
        return 
          for $value in $valSeq
          return
            <tr>
              { $keyCell }
              <td><code>{ xs:string($value) }</code></td>
            </tr>
      return
        <table>
          <thead>
            <tr><th scope="column">Parameter name</th> <th scope="column">Value</th></tr>
          </thead>
          <tbody>{ $rows }</tbody>
        </table>
    let $navbar :=
      <nav>
        <a href="./">A Form of Resistance</a>
        {
          let $prevForm := request:parameter('form-name', 'NOPE')
          return
            if ( $allParamKeys = 'form-name' and doc-available('forms/'||$prevForm) ) then
              <a href="forms/{$prevForm}">Back to form</a>
            else ()
        }
      </nav>
    return tut:build-page('Form request response', (
        <main>
          <h1>What’d you just say?:
            <br/><small>What your recent form request says about <em>you</em></small>
          </h1>
          <div>
            <p>HTTP 
              <a href="https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods" target="_blank">request
                method</a>:
              <a href="https://developer.mozilla.org/en-US/docs/Web/HTTP/Methods/{$method}" 
                target="_blank">{ $method }</a>
            </p>
            { $params }
          </div>
          <aside>{ $navbar }</aside>
        </main>
      ))
  };



(:
    SUPPORT FUNCTIONS
 :)
  
  declare %private function tut:build-page($title as xs:string, $contents as node()*) as node() {
    <html lang="en" xmlns="http://www.w3.org/1999/xhtml">
      <head>
        <title>{ $title }</title>
        <style>{ unparsed-text('css/bootstrap-reboot.min.css') }</style>
        <style>{ unparsed-text('css/forms.css') }</style>
      </head>
      <body>
        { $contents }
      </body>
    </html>
  };
  
