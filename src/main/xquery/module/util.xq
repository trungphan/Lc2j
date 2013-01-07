module namespace util = "http://lc2j.tp.net/util";

declare function util:index-of($elements as element()*, $element as element()) as xs:integer {
    let $positions as xs:integer* := 
        for $e at $pos in $elements
        where $e/@id = $element/@id
            return $pos
    return
        if (empty($positions))
        then -1
        else $positions[1]
};


declare function util:index-of-match-first 
  ( $arg as xs:string? ,
    $pattern as xs:string )  as xs:integer? {
       
  if (matches($arg,$pattern))
  then string-length(tokenize($arg, $pattern)[1]) + 1
  else ()
 } ;

