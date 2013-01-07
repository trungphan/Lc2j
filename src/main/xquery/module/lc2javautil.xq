module namespace lc2ju = 'http://lc2j.tp.net/lc2java/util';
declare namespace sup="http://adobe.com/workflow/template/support";

declare function lc2ju:to-string-literal($indent as xs:integer, $text as xs:string) as xs:string {
    if (count(fn:tokenize($text, '\n')) > 1)
    then lc2ju:make-multiline-literal($indent, $text)
    else if (fn:contains($text, '"'))
    then concat('S(/* ', $text, ' */)')
    else concat('"', $text, '"')
};

declare function lc2ju:make-multiline-literal($indent as xs:integer, $text as xs:string) as xs:string {
    fn:string-join(
        ('S(/*',
        lc2ju:indent($indent, $text),
        '*/)')
    , "&#10;"
    )
};

declare function lc2ju:make-javadoc($indent as xs:integer, $items as item()*) as item()* {
    if (empty($items))
    then ()
    else (
        lc2ju:indent($indent, "/**"),
        for $item in $items
        return
            fn:string-join(
            for $line in fn:tokenize($item, '\n')
                return concat(fn:string-join(for $space in (1 to $indent * 4) return " ", ""), " * ", $line)
            , "&#10;"
            )
        ,
        lc2ju:indent($indent, " */")
    )
};

declare function lc2ju:to-xpath($expr as xs:string) as xs:string {
    concat('xpath(', lc2ju:to-string-literal(1, $expr), ')')
};

declare function lc2ju:to-expr($expr as xs:string) as xs:string {
    concat('x(', lc2ju:to-string-literal(1, $expr), ')')
};

declare function lc2ju:operator-to-java-operator($op as xs:string) as xs:string {
    if ($op = "=")
    then "=="
    else if ($op = "EQUALS")
    then "=="
    else if ($op = "GREATER_THAN")
    then ">"
    else if ($op = "LESS_THAN")
    then "<"
    else if ($op = "NOT_EQUAL")
    then "!="
    else if ($op = "LESS_THAN_EQUALS")
    then "<="
    else if ($op = "GREATER_THAN_EQUALS")
    then ">="
    else $op
};

declare function lc2ju:text-to-class-name($text as xs:string) as xs:string {
    replace(replace($text, " ", "_"), "[-?!/,'\.\(\)&#34;=]", "")
};

declare function lc2ju:text-to-method-name($text as xs:string) as xs:string {
    replace(replace($text, " ", "_"), "[-?!/,'\.\(\)&#34;=]", "")
};

declare function lc2ju:escape-string($text as xs:string) as xs:string {
    replace($text, '"', '\\"')
};

declare function lc2ju:indent($indent, $items as item()*) as item()* {
    for $item in $items
    return
        fn:string-join(
        for $line in fn:tokenize($item, '\n')
            return concat(fn:string-join(for $space in (1 to $indent * 4) return " ", ""), $line)
        , "&#10;"
        )
};
