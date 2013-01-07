package net.tp.lc2j.annot;

public @interface ShortLivedProcess {

	public String name();
	
	public String type();
	
	public String transactionPropagation();
	
	public int transactionTimeout();

}
