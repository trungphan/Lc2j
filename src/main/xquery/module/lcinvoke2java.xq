module namespace invk2j = 'http://lc2j.tp.net/lc2java/invoke';
import module namespace lc2ju="http://lc2j.tp.net/lc2java/util" at "lc2javautil.xq";

declare function invk2j:parse-UserSelectionInfo($indent as xs:integer, $branch as element(), $input_name as xs:string, $input_value as xs:string) as item()* {
    lc2ju:indent($indent, concat("Object ", $input_name, " = new UserServiceV2.UserSelectionInfo() // Initial User Selection")),
    let $value as document-node() := parse-xml($input_value)
    let $selection := $value/*:com.adobe.idp.taskmanager.dsc.userservicev2.UserSelectionInfo/*:selection
    let $outOfOfficeEligible := $value/*:com.adobe.idp.taskmanager.dsc.userservicev2.UserSelectionInfo/*:m__outOfOfficeEligible
    let $isGroupAssign := $value/*:com.adobe.idp.taskmanager.dsc.userservicev2.UserSelectionInfo/*:isGroupAssign
    let $isRandomUser := $value/*:com.adobe.idp.taskmanager.dsc.userservicev2.UserSelectionInfo/*:isRandomUser
    let $emailAddress := $value/*:com.adobe.idp.taskmanager.dsc.userservicev2.UserSelectionInfo/*:m__EmailAddress
    let $uid := $value/*:com.adobe.idp.taskmanager.dsc.userservicev2.UserSelectionInfo/*:m__UID
    let $domainCommonName := $value/*:com.adobe.idp.taskmanager.dsc.userservicev2.UserSelectionInfo/*:m__domainCommonName
    let $domainId := $value/*:com.adobe.idp.taskmanager.dsc.userservicev2.UserSelectionInfo/*:m__domainId
    let $canonicalName := $value/*:com.adobe.idp.taskmanager.dsc.userservicev2.UserSelectionInfo/*:m__canonicalName
    let $commonName := $value/*:com.adobe.idp.taskmanager.dsc.userservicev2.UserSelectionInfo/*:m__commonName
    let $xpathExpression := $value/*:com.adobe.idp.taskmanager.dsc.userservicev2.UserSelectionInfo/*:m__xpathExpression
    return (
        lc2ju:indent($indent + 1, concat('.setSelection(', $selection, ') // ', if ($selection = 1) then 'Assign to specific user' else if ($selection = 2) then 'Assign to process initiator' else if ($selection = 3) then 'Assign to group' else if ($selection = 4) then 'Xpath expression' else '')),
        if (empty($outOfOfficeEligible)) then() else lc2ju:indent($indent + 1, concat('.setOutOfOfficeEligible(', $outOfOfficeEligible, ') // Allow Out Of Office Designation')),
        if (empty($isGroupAssign)) then() else lc2ju:indent($indent + 1, concat('.setGroupAssign(', $isGroupAssign, ')')),
        if (empty($isRandomUser)) then() else lc2ju:indent($indent + 1, concat('.setRandomUser(', $isRandomUser, ') // Assign to random user in group (only applicable if selection == Assign to group)')),
        if (empty($emailAddress)) then() else lc2ju:indent($indent + 1, concat('.setEmailAddress("', $emailAddress, '")')),
        if (empty($uid)) then() else lc2ju:indent($indent + 1, concat('.setUid("', $uid, '")')),
        if (empty($canonicalName)) then() else lc2ju:indent($indent + 1, concat('.setCanonicalName("', $canonicalName, '")')),
        if (empty($commonName)) then() else lc2ju:indent($indent + 1, concat('.setCommonName("', $commonName, '")')),
        if (empty($domainId)) then() else lc2ju:indent($indent + 1, concat('.setDomainId("', $domainId, '")')),
        if (empty($domainCommonName)) then() else lc2ju:indent($indent + 1, concat('.setDomainCommonName("', $domainCommonName, '")')),
        if (empty($xpathExpression)) then() else lc2ju:indent($indent + 1, concat('.setXpathExpression("', $xpathExpression, '")'))
        ),
    lc2ju:indent($indent, ";")
};

declare function invk2j:parse-DCIAndTLOSettingsWrapper($indent as xs:integer, $branch as element(), $input_name as xs:string, $input_value as xs:string) as item()* {
    lc2ju:indent($indent, concat("Object ", $input_name, " = new UserServiceV2.DCIAndTLOSettingsWrapper() // Presentation And Data")),
    let $value as document-node() := parse-xml($input_value)
    let $dynamicContent := $value/*:com.adobe.idp.taskmanager.dsc.userservicev2.DCIAndTLOSettingsWrapper/*:dciSettings/*:dynamicContent
    let $tloPath := $value/*:com.adobe.idp.taskmanager.dsc.userservicev2.DCIAndTLOSettingsWrapper/*:dciSettings/*:tloPath
    let $dciId := $value/*:com.adobe.idp.taskmanager.dsc.userservicev2.DCIAndTLOSettingsWrapper/*:dciSettings/*:dciId
    let $inputVariableName := $value/*:com.adobe.idp.taskmanager.dsc.userservicev2.DCIAndTLOSettingsWrapper/*:dciSettings/*:inputVariableName
    let $reader91SubmitEnabled := $value/*:com.adobe.idp.taskmanager.dsc.userservicev2.DCIAndTLOSettingsWrapper/*:dciSettings/*:reader91SubmitEnabled
    let $formSubmitType := $value/*:com.adobe.idp.taskmanager.dsc.userservicev2.DCIAndTLOSettingsWrapper/*:dciSettings/*:formSubmitType
    let $renderServiceCallMappings := $value/*:com.adobe.idp.taskmanager.dsc.userservicev2.DCIAndTLOSettingsWrapper/*:dciSettings/*:renderServiceCallMappings
    let $submitServiceCallMappings := $value/*:com.adobe.idp.taskmanager.dsc.userservicev2.DCIAndTLOSettingsWrapper/*:dciSettings/*:submitServiceCallMappings
    let $runFillService := $value/*:com.adobe.idp.taskmanager.dsc.userservicev2.DCIAndTLOSettingsWrapper/*:dciSettings/*:runFillService
    let $fillServiceRunType := $value/*:com.adobe.idp.taskmanager.dsc.userservicev2.DCIAndTLOSettingsWrapper/*:dciSettings/*:fillServiceRunType
    let $fillServiceRunOnOpenNewTask := $value/*:com.adobe.idp.taskmanager.dsc.userservicev2.DCIAndTLOSettingsWrapper/*:dciSettings/*:fillServiceRunOnOpenNewTask
    let $fillServiceRunOnOpenDraft := $value/*:com.adobe.idp.taskmanager.dsc.userservicev2.DCIAndTLOSettingsWrapper/*:dciSettings/*:fillServiceRunOnOpenDraft
    let $fillServiceRunOnOpenCompleted := $value/*:com.adobe.idp.taskmanager.dsc.userservicev2.DCIAndTLOSettingsWrapper/*:dciSettings/*:fillServiceRunOnOpenCompleted
    return (
        lc2ju:indent($indent + 1, concat('.setDynamicContent(', $dynamicContent, ') // ', if ($dynamicContent = "false") then 'use an application asset' else 'use a document variable')),
        lc2ju:indent($indent + 1, concat('.setTloPath("', $tloPath, '") // ', if ($dynamicContent = "false") then 'Asset' else 'N/A')),
        lc2ju:indent($indent + 1, concat('.setDciId("', $dciId, '") // ', if ($dynamicContent = "false") then 'Action Profile' else 'N/A')),
        lc2ju:indent($indent + 1, concat('.setInputVariableName("', $inputVariableName, '") // ', if ($dynamicContent = "false") then 'Initial Task Data' else 'Variable')),
        lc2ju:indent($indent + 1, concat('.setReader91SubmitEnabled(', $reader91SubmitEnabled, ') // Submit via Reader')),
        lc2ju:indent($indent + 1, concat('.setFormSubmitType("', $formSubmitType, '") // Submit As')),
        if (empty($renderServiceCallMappings)) then() else lc2ju:indent($indent + 1, concat('.setRenderServiceCallMappings("', $renderServiceCallMappings, '") // N/A')),
        if (empty($submitServiceCallMappings)) then() else lc2ju:indent($indent + 1, concat('.setSubmitServiceCallMappings("', $submitServiceCallMappings, '") // N/A')),
        lc2ju:indent($indent + 1, concat('.setRunFillService(', $runFillService, ') // N/A')),
        lc2ju:indent($indent + 1, concat('.setFillServiceRunType("', $fillServiceRunType, '") // N/A')),
        lc2ju:indent($indent + 1, concat('.setFillServiceRunOnOpenNewTask(', $fillServiceRunOnOpenNewTask, ') // N/A')),
        lc2ju:indent($indent + 1, concat('.setFillServiceRunOnOpenDraft(', $fillServiceRunOnOpenDraft, ') // N/A')),
        lc2ju:indent($indent + 1, concat('.setFillServiceRunOnOpenCompleted(', $fillServiceRunOnOpenCompleted, ') // N/A'))
        ),
    lc2ju:indent($indent, ";")
};

declare function invk2j:parse-UserActionName($indent as xs:integer, $branch as element(), $input_name as xs:string, $input_value as xs:string) as item()* {
    lc2ju:indent($indent, concat("List ", $input_name, " = new ArrayList();")),
    let $value as document-node() := parse-xml($input_value)
    for $userAction in $value/*:list/*:com.adobe.idp.taskmanager.dsc.userservicev2.UserActionName
    let $userActionName := $userAction/*:userActionName/data(.)
    let $confirmation := $userAction/*:confirmation/data(.)
    let $confirmationMessage := $userAction/*:confirmationMessage/data(.)
    let $routeName := $userAction/*:route[text()]/data(.)
    let $tooltip := $userAction/*:tooltip/data(.)
    let $destination := $userAction/*:destination/data(.)
    return (
        lc2ju:indent($indent, concat($input_name, ".add(new UserServiceV2.UserActionName()")),
        lc2ju:indent($indent + 1, concat('.setUserActionName("', $userActionName, '")')),
        lc2ju:indent($indent + 1, concat('.setRouteName("', $routeName, '")')),
        lc2ju:indent($indent + 1, concat('.setDestination("', $destination, '")')),
        lc2ju:indent($indent + 1, concat('.setConfirmation(', $confirmation, ')')),
        lc2ju:indent($indent + 1, concat('.setConfirmationMessage(', lc2ju:to-string-literal(1, $confirmationMessage), ')')),
        lc2ju:indent($indent + 1, concat('.setTooltip(', lc2ju:to-string-literal(1, $tooltip), ')')),
        lc2ju:indent($indent, ");")
        )
};

declare function invk2j:parse-TaskRuntimeUISettings($indent as xs:integer, $branch as element(), $input_name as xs:string, $input_value as xs:string) as item()* {
    lc2ju:indent($indent, concat("Object ", $input_name, " = new UserServiceV2.TaskRuntimeUISettings() // Workspace User Interface")),
    let $value as document-node() := parse-xml($input_value)
    let $type := $value/*:com.adobe.idp.taskmanager.dsc.userservicev2.datatype.TaskRuntimeUISettings/*:m__type
    let $tloPath := $value/*:com.adobe.idp.taskmanager.dsc.userservicev2.datatype.TaskRuntimeUISettings/*:m__tloPath
    let $taskDisplayOptionsMask := $value/*:com.adobe.idp.taskmanager.dsc.userservicev2.datatype.TaskRuntimeUISettings/*:m__taskDisplayOptionsMask
    return (
        lc2ju:indent($indent + 1, concat('.setType("', $type, '")')),
        lc2ju:indent($indent + 1, concat('.setTloPath("', $tloPath, '") // Resource for Custom')),
        lc2ju:indent($indent + 1, concat(".setTaskDisplayOptionsMask(", $taskDisplayOptionsMask, ") // 2: Must open the form to complete the task, 4: Open the form in maximized mode"))
        ),
    lc2ju:indent($indent, ";")
};

declare function invk2j:parse-AttachmentInfo($indent as xs:integer, $branch as element(), $input_name as xs:string, $input_value as xs:string) as item()* {
    lc2ju:indent($indent, concat("Object ", $input_name, " = new UserServiceV2.AttachmentInfo() // Attachments")),
    let $value as document-node() := parse-xml($input_value)
    let $showAttachWindow := $value/*:com.adobe.idp.taskmanager.dsc.userservicev2.AttachmentInfo/*:m__showAttachWindow
    let $inputVariableName := $value/*:com.adobe.idp.taskmanager.dsc.userservicev2.AttachmentInfo/*:m__inputVariableName
    return (
        lc2ju:indent($indent + 1, concat('.setShowAttachWindow(', $showAttachWindow, ') // Show attachment window for this task')),
        lc2ju:indent($indent + 1, concat('.setInputVariableName("', $inputVariableName, '") // Input list'))
        ),
    lc2ju:indent($indent, ";")
};

declare function invk2j:parse-TaskResultCollectionInfo($indent as xs:integer, $branch as element(), $input_name as xs:string, $input_value as xs:string) as item()* {
    lc2ju:indent($indent, concat("Object ", $input_name, " = new UserServiceV2.TaskResultCollectionInfo()")),
    let $value as document-node() := parse-xml($input_value)
    let $storeFormData := $value/*:com.adobe.idp.taskmanager.dsc.userservicev2.TaskResultCollectionInfo/*:m__storeFormData
    let $storeAttachmentData := $value/*:com.adobe.idp.taskmanager.dsc.userservicev2.TaskResultCollectionInfo/*:m__storeAttachmentData
    return (
        lc2ju:indent($indent + 1, concat(".setStoreFormData(", $storeFormData, ")")),
        lc2ju:indent($indent + 1, concat(".setStoreAttachmentData(", $storeAttachmentData, ")"))
        ),
    lc2ju:indent($indent, ";")
};


declare function invk2j:parse-Composite($indent as xs:integer, $branch as element(), $input_name as xs:string, $input_value as xs:string) as item()* {
    lc2ju:indent($indent, concat("Map ", $input_name, " = new HashMap();")),
    let $value as document-node() := parse-xml($input_value)
    for $map in $value/*:composite/*:mapping
    let $property := $map/@property/data(.)
    let $property_value := $map/data(.)
    return
        if (fn:contains($property_value, "com.adobe.idp.taskmanager.dsc.userservicev2.TaskResultCollectionInfo"))
        then (
            invk2j:parse-TaskResultCollectionInfo($indent,$branch,$property,$property_value),
            lc2ju:indent($indent, concat($input_name, '.put("', $property, '", ', $property, ');'))
            )
        else if (fn:contains($property_value, "com.adobe.idp.taskmanager.dsc.userservicev2.datatype.TaskRuntimeUISettings"))
        then (
            invk2j:parse-TaskRuntimeUISettings($indent,$branch,$property,$property_value),
            lc2ju:indent($indent, concat($input_name, '.put("', $property, '", ', $property, ');'))
            )
        else if (fn:contains($property_value, "com.adobe.idp.taskmanager.dsc.userservicev2.UserActionName"))
        then (
            invk2j:parse-UserActionName($indent,$branch,$property,$property_value),
            lc2ju:indent($indent, concat($input_name, '.put("', $property, '", ', $property, ');'))
            )
        else if (fn:contains($property_value, "com.adobe.idp.taskmanager.dsc.userservicev2.AttachmentInfo"))
        then (
            invk2j:parse-AttachmentInfo($indent,$branch,$property,$property_value),
            lc2ju:indent($indent, concat($input_name, '.put("', $property, '", ', $property, ');'))
            )
        else if (fn:contains($property_value, "com.adobe.idp.taskmanager.dsc.userservicev2.DCIAndTLOSettingsWrapper"))
        then (
            invk2j:parse-DCIAndTLOSettingsWrapper($indent,$branch,$property,$property_value),
            lc2ju:indent($indent, concat($input_name, '.put("', $property, '", ', $property, ');'))
            )
        else if (fn:contains($property_value, "com.adobe.idp.taskmanager.dsc.userservicev2.UserSelectionInfo"))
        then (
            invk2j:parse-UserSelectionInfo($indent,$branch,$property,$property_value),
            lc2ju:indent($indent, concat($input_name, '.put("', $property, '", ', $property, ');'))
            )
        else (
            lc2ju:indent($indent, concat($input_name, '.put("', $property, '", ', lc2ju:to-string-literal(1, $map/data(.)), ');'))
        )
};

declare function invk2j:parse-ResultMapping($indent as xs:integer, $branch as element(), $input_name as xs:string, $input_value as xs:string) as item()* {
    lc2ju:indent($indent, concat("Object ", $input_name, " = new JdbcService.ResultMapping()")),
    let $value as document-node() := parse-xml($input_value)
    for $map in $value/*:list/*:map
    let $process_variable := $map/*:entry[string="process_variable"]/*:string[2]/data(.)
    let $column_index := $map/*:entry[string="column_index"]/*:string[2]/data(.)
    let $column_name := $map/*:entry[string="column_name"]/*:string[2]/data(.)
    return
        lc2ju:indent($indent + 1, concat('.setMap("', $process_variable, '", ', $column_index, ', "', $column_name, '")' ))
    ,
    lc2ju:indent($indent, ";")
};

declare function invk2j:parse-XmlDocumentInfoBean($indent as xs:integer, $branch as element(), $input_name as xs:string, $input_value as xs:string) as item()* {
    lc2ju:indent($indent, concat("Object ", $input_name, " = new JdbcService.XmlDocumentInfoBean()")),
    let $value as document-node() := parse-xml($input_value)
    let $root_name := $value/*:com.adobe.idp.dsc.jdbc.bean.XmlDocumentInfoBean/*:m__rootName/data(.)
    let $repeating_element_name := $value/*:com.adobe.idp.dsc.jdbc.bean.XmlDocumentInfoBean/*:m__repeatingElementName/data(.)
    let $escape_illegal_characters := $value/*:com.adobe.idp.dsc.jdbc.bean.XmlDocumentInfoBean/*:m__escapeIllegalCharacters/data(.)
    return (
        lc2ju:indent($indent + 1, concat('.setRootName("', $root_name, '")')),
        lc2ju:indent($indent + 1, concat('.setRepeatingElementName("', $repeating_element_name, '")')),
        lc2ju:indent($indent + 1, concat('.setEscapeIllegalCharacters(', $escape_illegal_characters, ')')),
        for $map in $value/*:com.adobe.idp.dsc.jdbc.bean.XmlDocumentInfoBean/*:m__columnNameMappings/*:map
        let $element_name := $map/*:entry[string="element_name"]/*:string[2]/data(.)
        let $column_index := $map/*:entry[string="column_index"]/*:string[2]/data(.)
        let $column_name := $map/*:entry[string="column_name"]/*:string[2]/data(.)
        return
            lc2ju:indent($indent + 1, concat('.setColumnMap("', $element_name, '", ', $column_index, ', "', $column_name, '")' ))
        )
    ,
    lc2ju:indent($indent, ";")
};

declare function invk2j:parse-StoredProcedureInfoBean($indent as xs:integer, $branch as element(), $input_name as xs:string, $input_value as xs:string) as item()* {
    lc2ju:indent($indent, concat("Object ", $input_name, " = new JdbcService.StoredProcedureInfoBean()")),
    let $value as document-node() := parse-xml($input_value)
    let $query_string := $value/*:com.adobe.idp.dsc.jdbc.bean.StoredProcedureInfoBean/*:m__callableStatement/data(.)
    let $is_prepared := $value/*:com.adobe.idp.dsc.jdbc.bean.StoredProcedureInfoBean/*:m__isPrepared/data(.)
    return (
        lc2ju:indent($indent + 1, concat(".setCallableStatement(", lc2ju:make-multiline-literal(1, $query_string), ")")),
        lc2ju:indent($indent + 1, concat(".setIsPrepared(", $is_prepared, ")")),
        for $map in $value/*:com.adobe.idp.dsc.jdbc.bean.StoredProcedureInfoBean/*:m__parameterMappingList/*:map
        let $index := $map/*:entry[string="index"]/*:string[2]/data(.)
        let $value := $map/*:entry[string="value"]/*:string[2]/data(.)
        let $type := $map/*:entry[string="type"]/*:string[2]/data(.)
        let $test_value := $map/*:entry[string="test_value"]/*:string[2]/data(.)
        return
            lc2ju:indent($indent + 1, concat(".setParam(", $index, ', ', lc2ju:to-string-literal(1, $value), ', "', $type, '", "', $test_value  , '")' ))
        )
    ,
    lc2ju:indent($indent, ";")
};


declare function invk2j:parse-SqlStatementInfoBean($indent as xs:integer, $branch as element(), $input_name as xs:string, $input_value as xs:string) as item()* {
    lc2ju:indent($indent, concat("Object ", $input_name, " = new JdbcService.SqlStatementInfoBean()")),
    let $value as document-node() := parse-xml($input_value)
    let $query_string := $value/*:com.adobe.idp.dsc.jdbc.bean.SqlStatementInfoBean/*:queryString/data(.)
    let $is_prepared := $value/*:com.adobe.idp.dsc.jdbc.bean.SqlStatementInfoBean/*:isPrepared/data(.)
    return (
        lc2ju:indent($indent + 1, concat(".setQueryString(", lc2ju:make-multiline-literal(1, $query_string), ")")),
        lc2ju:indent($indent + 1, concat(".setIsPrepared(", $is_prepared, ")")),
        for $map in $value/*:com.adobe.idp.dsc.jdbc.bean.SqlStatementInfoBean/*:parameterList/*:map
        let $index := $map/*:entry[string="index"]/*:string[2]/data(.)
        let $value := $map/*:entry[string="value"]/*:string[2]/data(.)
        let $type := $map/*:entry[string="type"]/*:string[2]/data(.)
        let $test_value := $map/*:entry[string="test_value"]/*:string[2]/data(.)
        return
            lc2ju:indent($indent + 1, concat(".setParam(", $index, ', "', $value, '", "', $type, '", "', $test_value  , '")' ))
        )
    ,
    lc2ju:indent($indent, ";")
};

declare function invk2j:parse-SetValueMapping($indent as xs:integer, $branch as element(), $input_name as xs:string, $input_value as xs:string) as item()* {
    lc2ju:indent($indent, concat("Object ", $input_name, " = new SetValue.Mappings()")),
    let $value as document-node() := parse-xml($input_value)
    for $r at $pos in $value/*/*:com.adobe.idp.workflow.dsc.type.SetValueMapping
        return lc2ju:indent($indent + 1, concat('.assign("', $r/*:m__locationExpr/data(.), '").to(', lc2ju:to-string-literal($indent, $r/*:m__valueExpr/data(.)), ')')),
    lc2ju:indent($indent, ";")
};


