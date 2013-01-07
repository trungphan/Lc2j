package net.tp.lc2j.livecycle.service;

import java.util.Map;


/**
 * 
 * designateInfo: 
 * 
 * @author Trung
 *
 */
public class UserServiceV2 {

	private UserSelectionInfo designateInfo;
	private TaskRuntimeUISettings taskRuntimeUISettings;
	
	public static Map AssignTask(Object createInfo) {
		return null;
	}
	
	
	public static class TaskResultCollectionInfo {
		public TaskResultCollectionInfo setStoreFormData(boolean storeFormData) {
			return this;
		}
		public TaskResultCollectionInfo setStoreAttachmentData(boolean storeAttachmentData) {
			return this;
		}
	}

	/**
	 * This controls the option in the Workspace User Interface tab of the UserService.AssignTask
	 * 
	 * @author Trung
	 *
	 */
	public static class TaskRuntimeUISettings {
		public TaskRuntimeUISettings setType(String type) {
			return this;
		}
		public TaskRuntimeUISettings setTloPath(String tloPath) {
			return this;
		}
		public TaskRuntimeUISettings setTaskDisplayOptionsMask(int taskDisplayOptionsMask) {
			return this;
		}
	}
	
	public static class UserActionName {
		public UserActionName setUserActionName(String userActionName) {
			return this;
		}
		public UserActionName setRouteName(String routeName) {
			return this;
		}
		public UserActionName setDestination(String destination) {
			return this;
		}
		public UserActionName setConfirmation(boolean confirmation) {
			return this;
		}
		public UserActionName setConfirmationMessage(String confirmationMessage) {
			return this;
		}
		public UserActionName setTooltip(String tooltip) {
			return this;
		}
	}
	
	public static class AttachmentInfo {
		public AttachmentInfo setShowAttachWindow(boolean showAttachWindow) {
			return this;
		}
		public AttachmentInfo setInputVariableName(String inputVariableName) {
			return this;
		}
	}
	
	/**
	 * This controls the option in the Presentation & Data tab of the UserService.AssignTask
	 * Two options:
	 * (1) "use an application asset": dynamicContent = false
	 * Asset: tloPath (can be pdf or xdp)
	 * Action Profile: dciId
	 * Initial Task Data: inputVariableName (xml data to populate form)
	 * 
	 * (2) "use a document variable": dynamicContent = true, tloPath and dciId are blank, inputVariableName is used for variable instead of data as above
	 * Variable: inputVariableName
	 * 
	 * Common options for both:
	 * Submit via Reader: reader91SubmitEnabled
	 * Submit As: formSubmitType
	 * 
	 * 
	 * @author Trung
	 *
	 */
	public static class DCIAndTLOSettingsWrapper {
		private boolean dynamicContent;
		private String tloPath;
		private String dciId;
		private String inputVariableName;
		private boolean reader91SubmitEnabled;
		private String formSubmitType;
		
		
		// these are not sure
		private boolean runFillService;
		private String fillServiceRunType;
		private boolean fillServiceRunOnOpenNewTask;
		private boolean fillServiceRunOnOpenDraft;
		private boolean fillServiceRunOnOpenCompleted;
		
		private String renderServiceCallMappings;
		private String submitServiceCallMappings;

		public DCIAndTLOSettingsWrapper setDynamicContent(boolean dynamicContent) {
			this.dynamicContent = dynamicContent;
			return this;
		}
		public DCIAndTLOSettingsWrapper setTloPath(String tloPath) {
			this.tloPath = tloPath;
			return this;
		}
		public DCIAndTLOSettingsWrapper setDciId(String dciId) {
			this.dciId = dciId;
			return this;
		}
		public DCIAndTLOSettingsWrapper setInputVariableName(String inputVariableName) {
			this.inputVariableName = inputVariableName;
			return this;
		}
		public DCIAndTLOSettingsWrapper setReader91SubmitEnabled(boolean reader91SubmitEnabled) {
			this.reader91SubmitEnabled = reader91SubmitEnabled;
			return this;
		}
		public DCIAndTLOSettingsWrapper setFormSubmitType(String formSubmitType) {
			this.formSubmitType = formSubmitType;
			return this;
		}
		public DCIAndTLOSettingsWrapper setRunFillService(boolean runFillService) {
			this.runFillService = runFillService;
			return this;
		}
		public DCIAndTLOSettingsWrapper setFillServiceRunType(String fillServiceRunType) {
			this.fillServiceRunType = fillServiceRunType;
			return this;
		}
		public DCIAndTLOSettingsWrapper setFillServiceRunOnOpenNewTask(boolean fillServiceRunOnOpenNewTask) {
			this.fillServiceRunOnOpenNewTask = fillServiceRunOnOpenNewTask;
			return this;
		}
		public DCIAndTLOSettingsWrapper setFillServiceRunOnOpenDraft(boolean fillServiceRunOnOpenDraft) {
			this.fillServiceRunOnOpenDraft = fillServiceRunOnOpenDraft;
			return this;
		}
		public DCIAndTLOSettingsWrapper setFillServiceRunOnOpenCompleted(
				boolean fillServiceRunOnOpenCompleted) {
			this.fillServiceRunOnOpenCompleted = fillServiceRunOnOpenCompleted;
			return this;
		}
		public DCIAndTLOSettingsWrapper setRenderServiceCallMappings(String renderServiceCallMappings) {
			this.renderServiceCallMappings = renderServiceCallMappings;
			return this;
		}
		public DCIAndTLOSettingsWrapper setSubmitServiceCallMappings(String submitServiceCallMappings) {
			this.submitServiceCallMappings = submitServiceCallMappings;
			return this;
		}
		
		
	}
	
	/**
	 * 
	 * This controls the option in the Initial User Selection tab of the UserService.AssignTask
	 * 
	 * 
	 * @author Trung
	 *
	 */
	public static class UserSelectionInfo {

		/**
		 * Allow Out of Office Designation. Not applicable for Assign to group/Assign to group queue
		 */
		private boolean outOfOfficeEligible;
		
		/**
		 * 1: Assign to specific user
		 * 2: Assign to process initiator
		 * 3: Assign to Group
		 * 4: XPath expression
		 */
		private int selection;
		
		/**
		 * Assign to random user in group (under Assign to group)
		 */
		private boolean isRandomUser;
		
		/**
		 * XPath expression (only exist if selection = 4)
		 */
		private String xpathExpression;
		
		private boolean groupAssign;
		
		/**
		 * User or Group details (only exist if selection = 1 or 3)
		 */
		private String uid;
		private String emailAddress;
		private String canonicalName;
		private String commonName;
		private String domainId;
		private String domainCommonName;
		
		public UserSelectionInfo setEmailAddress(String emailAddress) {
			this.emailAddress = emailAddress;
			return this;
		}
		public UserSelectionInfo setOutOfOfficeEligible(boolean outOfOfficeEligible) {
			this.outOfOfficeEligible = outOfOfficeEligible;
			return this;
		}
		public UserSelectionInfo setSelection(int selection) {
			this.selection = selection;
			return this;
		}
		public UserSelectionInfo setRandomUser(boolean isRandomUser) {
			this.isRandomUser = isRandomUser;
			return this;
		}
		public UserSelectionInfo setGroupAssign(boolean groupAssign) {
			this.groupAssign = groupAssign;
			return this;
		}
		public UserSelectionInfo setXpathExpression(String xpathExpression) {
			this.xpathExpression = xpathExpression;
			return this;
		}
		public UserSelectionInfo setUid(String uid) {
			this.uid = uid;
			return this;
		}
		public UserSelectionInfo setCanonicalName(String canonicalName) {
			this.canonicalName = canonicalName;
			return this;
		}
		public UserSelectionInfo setCommonName(String commonName) {
			this.commonName = commonName;
			return this;
		}
		public UserSelectionInfo setDomainId(String domainId) {
			this.domainId = domainId;
			return this;
		}
		public UserSelectionInfo setDomainCommonName(String domainCommonName) {
			this.domainCommonName = domainCommonName;
			return this;
		}
		
	}
}