module namespace lc2j = "http://lc2j.tp.net/lc2java";

declare namespace sup="http://adobe.com/workflow/template/support";

import module namespace util="http://lc2j.tp.net/util" at "util.xq";
import module namespace lcutil="http://lc2j.tp.net/lcutil" at "lcutil.xq";
import module namespace lc2ju="http://lc2j.tp.net/lc2java/util" at "lc2javautil.xq";
import module namespace invk2j="http://lc2j.tp.net/lc2java/invoke" at "lcinvoke2java.xq";

declare function lc2j:render-invoke($indent as xs:integer,$branch as element(), $invoke as element(sup:invoke)) as item()* {
    let $service_name := replace($invoke/@service-name/data(.), "/", ".")
    let $operation_name := $invoke/@operation-name/data(.)
    for $input in $invoke/sup:input[@type!="IMPLICIT"]
    let $input_type := $input/@type/data(.)
    let $input_name := $input/@name/data(.)
    let $input_value := $input/sup:value/data(.)
       return
          if ($input_type = "VARIABLE")
          then lc2ju:indent($indent, concat("Object ", $input_name, " = ", lc2ju:to-expr($input_value), ";"))
          else if ($input_type = "XPATH")
          then lc2ju:indent($indent, concat("Object ", $input_name, " = ", lc2ju:to-xpath($input_value), ";"))
          else if (fn:string-length($input_value) = 0)
          then lc2ju:indent($indent, concat("Object ", $input_name, ' = "";'))
          else if ($service_name = "Script" and $operation_name = "executeScript")
          then (
              lc2ju:indent($indent, concat("Object ", $input_name, ' = new Script() {')),
              lc2ju:indent($indent + 1, "public void run() throws Exception {"),
              lc2ju:indent($indent + 2, replace(replace($input_value, "^\s*import ", "//import "), "\n\s*import ", "&#10;//import ")),
              lc2ju:indent($indent + 1, "}"),
              lc2ju:indent($indent, "};")
              )
          else
              let $lines := fn:tokenize($input_value, '\n')
              let $firstLine := $lines[1]
              return
                  if (count($lines) <= 1)
                  then lc2ju:indent($indent, concat("Object ", $input_name, ' = "', $input_value, '";'))
                  else if (fn:contains($input_value, "com.adobe.idp.workflow.dsc.type.SetValueMapping"))
                  then invk2j:parse-SetValueMapping($indent, $branch, $input_name, $input_value)
                  else if (fn:contains($input_value, "com.adobe.idp.dsc.jdbc.bean.SqlStatementInfoBean"))
                  then invk2j:parse-SqlStatementInfoBean($indent,$branch,$input_name,$input_value)
                  else if (fn:contains($input_value, "com.adobe.idp.dsc.jdbc.bean.StoredProcedureInfoBean"))
                  then invk2j:parse-StoredProcedureInfoBean($indent,$branch,$input_name,$input_value)
                  else if (fn:contains($input_value, "com.adobe.idp.dsc.jdbc.bean.XmlDocumentInfoBean"))
                  then invk2j:parse-XmlDocumentInfoBean($indent,$branch,$input_name,$input_value)
                  else if (fn:contains($input_value, "<string>process_variable</string>") and fn:contains($input_value, "<string>column_index</string>") and fn:contains($input_value, "<string>column_name</string>"))
                  then invk2j:parse-ResultMapping($indent,$branch,$input_name,$input_value)
                  else if (fn:contains($input_value, "<composite>"))
                  then invk2j:parse-Composite($indent,$branch,$input_name,$input_value)
                  else lc2ju:indent($indent, concat("Object ", $input_name, ' = ', lc2ju:make-multiline-literal(1, $input_value), ';'))
                  
    ,
    lc2ju:indent($indent, concat("Map result = ", replace($invoke/@service-name/data(.), "/", "."), ".", $invoke/@operation-name/data(.), 
    "(",
    string-join(
        for $input in $invoke/sup:input[@type!="IMPLICIT"]
        return $input/@name/data(.)
    , ", ")        
    ,");")),
    for $output in $invoke/sup:output
    let $type := $output/@type
    let $value := $output/sup:value/text()
    return
        if (not($value))
        then lc2ju:indent($indent, concat('result.get("', $output/@name, '");'))
        else if ($type = "VARIABLE")
        then lc2ju:indent($indent, concat($value, ' = result.get("', $output/@name, '");'))
        else lc2ju:indent($indent, concat('setProcessData(', lc2ju:to-string-literal(1, $value), ', result.get("', $output/@name, '"));'))
};

declare function lc2j:render-event-throw($indent as xs:integer,$branch as element(), $event as element(sup:event-throw)) as item()* {
    lc2ju:indent($indent, concat('BaseEvent event = new BaseEvent("', $event/@event-type-name, '");')),
    for $map in $event/sup:eventDataMappings/sup:eventDataMapping
    return
        lc2ju:indent($indent, concat('event.setData("', $map/sup:eventDataReference/text(), '", x(', lc2ju:to-string-literal(1, $map/sup:processVariableReference/text()), '));')),
    lc2ju:indent($indent, 'dispatchEvent(event);')
};

declare function lc2j:render-action($indent as xs:integer,$branch as element(), $action as element()) as item()* {
    "",
    "",
    lc2ju:make-javadoc($indent, $action/sup:description[text()]/data(.)),
    let $swimlane := $action/ancestor::sup:swimlane
    return
    if (not(empty($swimlane)))
    then lc2ju:indent($indent, concat('@Swimlane(name = "', $swimlane/@name, '")'))
    else (),
    typeswitch($action)
    case element(sup:split)
        return (
            lc2ju:indent($indent, concat('@Split(name = "', lc2ju:escape-string($action/@name), '", waitType = "', $action/@join-type, '")')),
            lc2ju:indent($indent, concat("private void ", lc2ju:text-to-method-name($action/@name/data(.)), "() {"))
            )
    case element(sup:invoke)
        return (
            lc2ju:indent($indent, concat('@Action(name = "', lc2ju:escape-string($action/@name), '")')),
            lc2ju:indent($indent, concat("private void ", lc2ju:text-to-method-name($action/@name/data(.)), "() {")),
            lc2j:render-invoke($indent + 1, $branch, $action)
            )
    case element(sup:event-throw)
        return (
            lc2ju:indent($indent, concat('@Event(name = "', lc2ju:escape-string($action/@name), '", category = "', $action/@event-category, '", typeName = "', $action/@event-type-name, '")')),
            lc2ju:indent($indent, concat("private void ", lc2ju:text-to-method-name($action/@name/data(.)), "() {")),
            lc2j:render-event-throw($indent + 1, $branch, $action)
            )
    case element(sup:event-receive)
        return (
            lc2ju:indent($indent, concat('@Event(name = "', lc2ju:escape-string($action/@name), '", category = "', $action/@event-category, '", typeName = "', $action/@event-type-name, '")')),
            lc2ju:indent($indent, concat("private void ", lc2ju:text-to-method-name($action/@name/data(.)), "() {"))
            )
    case element(sup:abstract-action)
        return (
            lc2ju:indent($indent, concat('@AbstractAction(name = "', lc2ju:escape-string($action/@name), '", type ="', $action/@type, '")')),
            lc2ju:indent($indent, concat("private void ", lc2ju:text-to-method-name($action/@name/data(.)), "() {"))
            )
    case element(sup:abstract-event)
        return (
            lc2ju:indent($indent, concat('@AbstractEvent(name = "', lc2ju:escape-string($action/@name), '")')),
            lc2ju:indent($indent, concat("private void ", lc2ju:text-to-method-name($action/@name/data(.)), "() {"))
            )
    default return (
            lc2ju:indent($indent, concat('@Unknown(name = "', lc2ju:escape-string($action/@name), '")')),
            lc2ju:indent($indent, concat("private void ", lc2ju:text-to-method-name($action/@name/data(.)), "() {"))
            )
    ,
    lc2ju:indent($indent, "}")

};

declare function lc2j:render-actions($indent, $branch as element()) as item()* {
    for $action in $branch/sup:pools/sup:pool/sup:swimlanes/sup:swimlane/(sup:actions | sup:events)/*
      | $branch/(sup:actions | sup:events)/*
        let $action_id := $action/@id/data(.)
        order by $action_id
        return lc2j:render-action($indent, $branch,$action)
};

declare function lc2j:render-branch($indent as xs:integer, $branch as element()) as item()* {
    lc2j:render-workflow($indent, $branch),
    lc2j:render-actions($indent, $branch),
    for $subbranch in $branch/sup:pools/sup:pool/sup:swimlanes/sup:swimlane/sup:actions/sup:split/sup:branches/sup:branch |
                      $branch/sup:actions/sup:split/sup:branches/sup:branch
    return (
        "",
        "",
        lc2ju:make-javadoc($indent, $subbranch/sup:description[text()]/data(.)),
        lc2ju:indent($indent, concat('@Branch(name = "', $subbranch/@name, '", type = "', $subbranch/@type, '")')),
        lc2ju:indent($indent, concat("private class ", lc2ju:text-to-class-name($subbranch/@name), " extends BaseBranch {")),
        lc2j:render-branch($indent + 1, $subbranch),
        lc2ju:indent($indent, "}")
        )
};

declare function lc2j:render-imports($process as element()) as item()* {
    distinct-values((
        "import java.util.*;",
        "import java.text.*;",
        "import net.tp.lc2j.annot.*;",
        "import net.tp.lc2j.base.*;",
        "import net.tp.lc2j.livecycle.service.*;",
        for $javascript in $process//sup:actions/sup:invoke[@service-name="Script" and @operation-name = "executeScript"]/sup:input[@name="aScript"]/sup:value
        for $line in fn:tokenize($javascript, '\n')
        where contains($line, "import ")
        return $line
    ))
};

declare function lc2j:render-process($process as element(), $package as xs:string, $classname as xs:string) as item()* {
    if (string-length($package) = 0)
    then ()
    else concat("package ", $package, ";"),
    "",
    lc2j:render-imports($process),
    "",
    "",
    lc2ju:make-javadoc(0, $process/sup:description[text()]/data(.)),
    '@SuppressWarnings({"rawtypes", "unchecked", "unused"})',
    concat( if ($process/@type = "asynchronous") then '@LongLivedProcess' else '@ShortLivedProcess', '(name = "', $process/@name, '", type = "', $process/@type, '", transactionPropagation = "', $process/@transaction-propagation, '", transactionTimeout = ', $process/@transaction-timeout, ')'),
    if ($process/@deprecated = "true") then "@Deprecated" else (),
    concat("public class ", $classname, " extends BaseAction {"),
    lc2j:render-variables(1, $process),
    lc2j:render-startpoints(1, $process, $classname),
    lc2j:render-branch(1, $process/sup:branch),
    "}"
};

declare function lc2j:render-startpoints($indent as xs:integer, $process as element(), $classname as xs:string) as item()* {
    lc2j:render-startpoints-default($indent, $process, $classname),
    lc2j:render-startpoints-workspace($indent, $process, $classname),
    lc2j:render-startpoints-event($indent, $process, $classname)
};

declare function lc2j:render-startpoints-default($indent as xs:integer, $process as element(), $classname as xs:string) as item()* {
    "",
    "",
    lc2ju:indent($indent, concat("public static Map invoke(",
        string-join(
            for $variable in $process/sup:variables/sup:variable
            where $variable/@in = "true"
            return concat("Object ", $variable/@name)
        , ", "),
        ") {")),
    lc2ju:indent($indent + 1, concat(lc2ju:text-to-class-name($classname), " instance = new ", lc2ju:text-to-class-name($classname), "();")),
    lc2ju:indent($indent + 1, "instance.startWorkflow(1);"),
    lc2ju:indent($indent + 1, "Map result = new HashMap();"),
    for $variable in $process/sup:variables/sup:variable
    where $variable/@out = "true"
    return lc2ju:indent($indent + 1, concat('result.put("', $variable/@name, '", instance.', $variable/@name, ');')),
    lc2ju:indent($indent + 1, "return result;"),
    lc2ju:indent($indent, "}")
};

declare function lc2j:render-startpoints-workspace($indent as xs:integer, $process as element(), $classname as xs:string) as item()* {
    if (empty($process//sup:endpoints/sup:endpoint[@typeName="TaskManager"])) then ()
    else
        "",
        "",
        lc2ju:indent($indent,"public static void invokeFromWorkspace() {"),
        "",
        lc2ju:indent($indent + 1, "Map data = new HashMap();"),
        let $endpoint := $process//sup:endpoints/sup:endpoint[@typeName="TaskManager"][1],
        $value as document-node() := parse-xml($endpoint/sup:value/data(.))
        for $entry in $value/*:map/*:entry
        let $entry-name := $entry/*:string[1],
        $entry-value := $entry/*:string[2]
        return (
            lc2ju:indent($indent + 1, concat("data.put(", lc2ju:to-string-literal($indent + 1, $entry-name), ", ", lc2ju:to-string-literal($indent + 1, $entry-value), ");"))
        ),
        lc2ju:indent($indent,"}")        
};

declare function lc2j:render-startpoints-event($indent as xs:integer, $process as element(), $classname as xs:string) as item()* {
    if (empty($process/sup:start-points/sup:start-event-receive)) then ()
    else (
        "",
        "",
        lc2ju:indent($indent, "public static void invokeByEvent(BaseEvent event) {"),
        for $event in $process/sup:start-points/sup:start-event-receive
        return (
            lc2ju:indent($indent + 1, 
                concat('if (',
                    string-join(
                        (
                        concat('event.getTypeName() == "', $event/@event-type-name, '"' ),
                        for $filter in $event/sup:eventFilters/sup:Filter
                        return concat('event.expr("', $filter/sup:LHSOperand, '") ', lc2ju:operator-to-java-operator($filter/sup:operator), ' x("', $filter/sup:RHSOperand, '")')
                        )
                    , " &#38;&#38; "),
                    ') {'
                )),
            lc2ju:indent($indent + 2, concat(lc2ju:text-to-class-name($classname), " instance = new ", lc2ju:text-to-class-name($classname), "();")),
            for $callback in $event/sup:callback-datamappings/sup:callback-datamapping
            return lc2ju:indent($indent + 2, concat('instance.setProcessData("', $callback/sup:processVariableReference, '", event.getData("', $callback/sup:event-data-reference, '"));')),
            lc2ju:indent($indent + 2, "instance.startWorkflow(1);"),
            lc2ju:indent($indent + 1, "}")
        ),
        lc2ju:indent($indent, "}")
    )    
};

declare function lc2j:render-variables($indent as xs:integer,$process as element()) as item()* {
    "",
    for $variable in $process/sup:variables/sup:variable
        let $type := $variable/@type/data(.)
        let $default := if ($variable/sup:value/text()) then concat(" = ", lc2ju:to-string-literal(1, $variable/sup:value/data(.))) else ""
        let $configuration := $variable/@configuration = "true"
        return (
(:            "",
            lc2ju:indent($indent, concat('@Variable(type = "', $variable/@type, '", searchable =', $variable/@searchable, ', visibleInUI=', $variable/@visibleInUI, ')' )), :)
            lc2ju:indent($indent, concat(if ($configuration) then "static " else "", "private Object ", $variable/@name/data(.), $default, ";"))
        )
};


declare function lc2j:traverse-depth-first($start as element()) as element()* {
    reverse(lc2j:_traverse-depth-first(($start), ($start), (1)))
};

declare function lc2j:_traverse-depth-first(
    $currentResult as element()*,
    $stack as element()*,
    $stackPos as xs:integer*) as element()* {

    let $nextItem := lc2j:child-at-pos($stack[1], $stackPos[1])
    return
        if (empty($nextItem))
        then
            if (count($stack) = 1)
            then $currentResult
            else lc2j:_traverse-depth-first($currentResult, subsequence($stack, 2), insert-before(subsequence($stackPos, 3), 1, ($stackPos[2] + 1)))
        else
            if (some $item in $currentResult satisfies $item/@id = $nextItem/@id)
            then lc2j:_traverse-depth-first($currentResult, $stack, insert-before(subsequence( $stackPos, 2), 1, ($stackPos[1] + 1)))
            else lc2j:_traverse-depth-first(insert-before($currentResult, 1, ($nextItem)) , insert-before($stack, 1, ($nextItem)), insert-before($stackPos, 1, (1)))
};

declare function lc2j:render-workflow($indent as xs:integer, $branch as element()) as item()* {
    "",
    "",
    lc2ju:indent($indent, "private void startWorkflow(int step) {"),
    if (not(empty($branch/@start-action))) then (
        lc2ju:indent($indent + 1, "switch (step) {"),
        let $startActionName := $branch/@start-action/data(.)
        let $start := lcutil:name-to-action($branch, $startActionName)
        let $actions as element()* := lc2j:traverse-depth-first($start)
        (: let $actions as element()* := algo:tranverse-depth-first-multiple-starts($branch, $start | $branch/sup:pools/sup:pool/sup:swimlanes/sup:swimlane/sup:events/sup:event-receive | $branch/sup:events/sup:event-receive) :)
        for $e at $pos in $actions
            return
            (
                "",
                (: display swimlane :)
                let $swimlane := $e/ancestor::sup:swimlane
                return
                    if ($pos = 1 or $swimlane/@name != $actions[$pos - 1]/ancestor::sup:swimlane/@name)
                    then lc2ju:indent($indent, concat('// L', count($swimlane/preceding-sibling::*) + 1, ' ', $swimlane/@name))
                    else (),
                (: display in routes :)
                let $fromActionIndexes :=
                    for $fromAction in $branch/sup:pools/sup:pool/sup:swimlanes/sup:swimlane/(sup:actions | sup:events)/* | $branch/(sup:actions | sup:events)/*
                    where $fromAction/sup:routes/sup:route/@destination = $e/@name
                    return string(util:index-of($actions, $fromAction))
                return
                    if (empty($fromActionIndexes) or (count($fromActionIndexes) = 1 and xs:integer($fromActionIndexes[1]) = $pos - 1))
                    then ()
                    else lc2ju:indent($indent + 1, concat('// from ', string-join($fromActionIndexes, ', ') ))
                ,
                lc2ju:indent($indent + 1, concat("case ", if ($pos < 10) then " " else "", $pos, ": ", lc2ju:text-to-method-name($e/@name/data(.)), "(); //", $e/@service-name | $e/@event-type-name)),
                typeswitch ($e)
                case element(sup:split)
                    return (
                        lc2ju:indent($indent + 2, concat('     new SplitAction("', $e/@name , '") {')),
                        lc2ju:indent($indent + 3, concat("     public void wait_", $e/@join-type , "() {")),
                        for $subbranch in $e/sup:branches/sup:branch
                        return lc2ju:indent($indent + 4, concat("     new ", lc2ju:text-to-class-name($subbranch/@name), '().startWorkflow(1);')),
                        lc2ju:indent($indent + 3, "     }"),
                        lc2ju:indent($indent + 2, "     };")
                        )
                default return (),
                lc2j:render-routes($indent+2, $branch, $actions, $e)
            ),
        lc2ju:indent($indent + 1, "}")
    )
    else ()
    ,
    lc2ju:indent($indent, "}")
};

declare function lc2j:render-routes($indent as xs:integer, $branch as element(), $actions as element()*, $thisAction as element()) as item()* {
    let $countRoute := count($thisAction/sup:routes/sup:route)
    let $firstRoute := $thisAction/sup:routes/sup:route[1]
    let $currPos := util:index-of($actions, $thisAction)
    let $longLived as xs:boolean := $thisAction/@isLongLived = "true"
    return
        if ($countRoute = 0)
        then lc2ju:indent($indent, "     break;")
        else if ($longLived)
        then
            lc2ju:indent($indent,
                for $route at $pos in $thisAction/sup:routes/sup:route
                let $dest := lcutil:name-to-action($branch, $route/@destination/data(.))
                let $destPos := util:index-of($actions, $dest)
                    return if (fn:exists($route/sup:conditions/sup:condition)) then (
                        concat(
                        "     if (",
                        fn:string-join(
                            for $condition in $route/sup:conditions/sup:condition
                                return concat (lc2ju:to-expr($condition/@expr1/data(.)), ' ', lc2ju:operator-to-java-operator($condition/@operator/data(.)), ' ', lc2ju:to-expr($condition/@expr2/data(.)))
                            , if ($route/@connective/data(.) = "or") then " || " else " &#38;&#38; "
                        )
                        ,
                        ") {"
                        ),
                      lc2ju:indent(1, concat("     asyncRoute(", $destPos, ', "', $route/@name/data(.), '"); }' ))
                    )
                   else
                      concat("     asyncRoute(", $destPos, ', "', $route/@name/data(.), '");' )
            )
        else if ($countRoute = 1 and empty( $firstRoute/sup:conditions/sup:condition ))
        then
            let $dest := lcutil:name-to-action($branch, $firstRoute/@destination/data(.))
            let $destPos := util:index-of($actions, $dest)
            return
                if ($destPos = $currPos + 1)
                then ()
                else lc2ju:indent($indent, concat ("     jumpTo(", $destPos, ', "', $firstRoute/@name/data(.), '"); break;'))
        else 
            lc2ju:indent($indent,
                for $route at $pos in $thisAction/sup:routes/sup:route
                let $dest := lcutil:name-to-action($branch, $route/@destination/data(.))
                let $destPos := util:index-of($actions, $dest)
                    return if (fn:exists($route/sup:conditions/sup:condition)) then (
                        concat(
                        "     if (",
                        fn:string-join(
                            for $condition in $route/sup:conditions/sup:condition
                                return concat (lc2ju:to-expr($condition/@expr1/data(.)), ' ', lc2ju:operator-to-java-operator($condition/@operator/data(.)), ' ', lc2ju:to-expr($condition/@expr2/data(.)))
                            , if ($route/@connective/data(.) = "or") then " || " else " &#38;&#38; "
                        )
                        ,
                        ") {"
                        ),
                      lc2ju:indent(1, concat("     jumpTo(", $destPos, ', "', $route/@name/data(.), '"); break; }' ))
                    )
                   else
                      concat("     jumpTo(", $destPos, ', "', $route/@name/data(.), '"); break;' )
            )
};



(: must return a sequence of 1 or 0 element :)
declare function lc2j:child-at-pos($parent as element(), $pos as xs:integer) as element()? {
    let $branch := $parent/ancestor::sup:branch[1]
    for $route in $parent/sup:routes/sup:route[$pos]
    return lcutil:name-to-action($branch, $route/@destination)
};
