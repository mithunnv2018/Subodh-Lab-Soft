package com.subodh;

// Generated Jan 4, 2014 4:28:33 PM by Hibernate Tools 3.4.0.CR1

/**
 * TblClientpricelistMaster generated by hbm2java
 */
public class TblClientpricelistMaster implements java.io.Serializable {

	private String clientpriceId;
	private String partyId;
	private Float clientpriceDiscount;

	public TblClientpricelistMaster() {
	}

	public TblClientpricelistMaster(String clientpriceId) {
		this.clientpriceId = clientpriceId;
	}

	public TblClientpricelistMaster(String clientpriceId, String partyId,
			Float clientpriceDiscount) {
		this.clientpriceId = clientpriceId;
		this.partyId = partyId;
		this.clientpriceDiscount = clientpriceDiscount;
	}

	public String getClientpriceId() {
		return this.clientpriceId;
	}

	public void setClientpriceId(String clientpriceId) {
		this.clientpriceId = clientpriceId;
	}

	public String getPartyId() {
		return this.partyId;
	}

	public void setPartyId(String partyId) {
		this.partyId = partyId;
	}

	public Float getClientpriceDiscount() {
		return this.clientpriceDiscount;
	}

	public void setClientpriceDiscount(Float clientpriceDiscount) {
		this.clientpriceDiscount = clientpriceDiscount;
	}

}
