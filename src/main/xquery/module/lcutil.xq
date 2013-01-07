module namespace lcutil = 'http://lc2j.tp.net/lcutil';
declare namespace sup="http://adobe.com/workflow/template/support";

declare function lcutil:name-to-action($branch as element(), $name as xs:string) as element() {
    $branch/sup:pools/sup:pool/sup:swimlanes/sup:swimlane/(sup:actions | sup:events)/(sup:invoke | sup:event-throw | sup:event-receive | sup:split | sup:abstract-action | sup:abstract-event)[@name = $name]
    |
    $branch/(sup:actions | sup:events)/(sup:invoke | sup:event-throw | sup:event-receive | sup:split | sup:abstract-action | sup:abstract-event)[@name = $name]
};

declare function lcutil:traverse-breadth-first($action as element(), $exclusion as xs:string*, $inclusion as xs:string*) as element()* {
    reverse(lcutil:_traverse-breadth-first((),($action),$exclusion,$inclusion))
};

declare function lcutil:_traverse-breadth-first(
        $visitedNodesAndRoutes as element()*,
        $workingNodes as element()*,
        $exclusion as xs:string*,
        $inclusion as xs:string*
        ) as element()* {
    if (empty($workingNodes))
    then $visitedNodesAndRoutes
    else
        let $visitedNodesAndRoutesId := $visitedNodesAndRoutes/@id
        let $node := $workingNodes[1]
        let $branch := $node/ancestor::sup:branch[1]
        let $visitableRoutes :=
            if ($node/sup:routes/sup:route/@id = $inclusion)
            then $node/sup:routes/sup:route[not(@id = $visitedNodesAndRoutesId) and @id=$inclusion and not (@id = $exclusion)]
            else $node/sup:routes/sup:route[not(@id = $visitedNodesAndRoutesId) and not (@id = $exclusion)]
        let $newVisited := ($node, $visitableRoutes, $visitedNodesAndRoutes)
        let $visitableNodes :=
            for $route in $visitableRoutes
            let $node := lcutil:name-to-action($branch, $route/@destination)
            where not ($node/@id = $visitedNodesAndRoutesId) 
            return $node
        return lcutil:_traverse-breadth-first($newVisited, (subsequence($workingNodes, 2), $visitableNodes), $exclusion, $inclusion)
};
