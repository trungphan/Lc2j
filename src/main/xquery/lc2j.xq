(: XQuery main module :)
declare namespace sup="http://adobe.com/workflow/template/support";
declare namespace output = "http://www.w3.org/2010/xslt-xquery-serialization";

import module namespace lc2j="http://lc2j.tp.net/lc2java" at "module/lc2java.xq";

declare option output:method "text";
declare option output:encoding "iso-8859-1";
declare option output:indent "no";
declare option output:omit-xml-declaration "yes";

declare variable $package as xs:string external;
declare variable $classname as xs:string external;

string-join(
    let $process := ./sup:process
    return lc2j:render-process($process, $package, if (string-length($classname) = 0) then $process/@name else $classname)
, "&#10;") 

