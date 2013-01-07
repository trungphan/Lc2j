package net.tp.lc2j.livecycle.service;

import java.util.Map;

public class JdbcService {
	public static Map querySingle(Object datasourceName, Object sql_info, Object save_locations) {
		return null;
	}

	public static Map queryMultipleToXml(Object datasourceName, Object sql_info, Object xml_info) {
		return null;
	}
	
	public static Map execute(Object datasourceName, Object sql_info) {
		return null;
	}
	
	public static Map callStoredProcedure(Object datasourceName, Object procedure_info) {
		return null;
	}
	
	public static class SqlStatementInfoBean {
		
		public SqlStatementInfoBean setQueryString(String queryString) {
			return this;
		}
		
		public SqlStatementInfoBean setIsPrepared(boolean isPrepared) {
			return this;
		}

		public SqlStatementInfoBean setParam(int index, String value, String type, String testValue) {
			return this;
		}
		
		
	}
	
	public static class StoredProcedureInfoBean {
		public StoredProcedureInfoBean setCallableStatement(String callableStatement) {
			return this;
		}
		
		public StoredProcedureInfoBean setIsPrepared(boolean isPrepared) {
			return this;
		}
		
		public StoredProcedureInfoBean setParam(int index, String value, String type, String testValue) {
			return this;
		}
	}
	
	public static class XmlDocumentInfoBean {
		public XmlDocumentInfoBean setRootName(String rootName) {
			return this;
		}
		
		public XmlDocumentInfoBean setRepeatingElementName(String repeatingElementName) {
			return this;
		}

		public XmlDocumentInfoBean setEscapeIllegalCharacters(boolean escapeIllegalCharacters) {
			return this;
		}
		
		public XmlDocumentInfoBean setColumnMap(String elementName, int columnIndex, String columnName) {
			return this;
		}
		

	}
	
	public static class ResultMapping {
		
		public ResultMapping setMap(String processVariable, int columnIndex, String columnName) {
			return this;
		}
		
	}
	
}
