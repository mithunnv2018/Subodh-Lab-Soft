package com.subodh;

// Generated Jan 4, 2014 4:28:33 PM by Hibernate Tools 3.4.0.CR1

/**
 * TblPartytypeMaster generated by hbm2java
 */
public class TblPartytypeMaster implements java.io.Serializable {

	private String partyTypeId;
	private String partyTypeName;

	public TblPartytypeMaster() {
	}

	public TblPartytypeMaster(String partyTypeId) {
		this.partyTypeId = partyTypeId;
	}

	public TblPartytypeMaster(String partyTypeId, String partyTypeName) {
		this.partyTypeId = partyTypeId;
		this.partyTypeName = partyTypeName;
	}

	public String getPartyTypeId() {
		return this.partyTypeId;
	}

	public void setPartyTypeId(String partyTypeId) {
		this.partyTypeId = partyTypeId;
	}

	public String getPartyTypeName() {
		return this.partyTypeName;
	}

	public void setPartyTypeName(String partyTypeName) {
		this.partyTypeName = partyTypeName;
	}

}
