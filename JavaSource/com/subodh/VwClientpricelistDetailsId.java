package com.subodh;

// Generated Jan 4, 2014 4:28:33 PM by Hibernate Tools 3.4.0.CR1

/**
 * VwClientpricelistDetailsId generated by hbm2java
 */
public class VwClientpricelistDetailsId implements java.io.Serializable {

	private String particularsId;
	private double clientpricedetDisc;
	private double clientpricedetAmt;
	private String partyId;

	public VwClientpricelistDetailsId() {
	}

	public VwClientpricelistDetailsId(String particularsId,
			double clientpricedetDisc, double clientpricedetAmt) {
		this.particularsId = particularsId;
		this.clientpricedetDisc = clientpricedetDisc;
		this.clientpricedetAmt = clientpricedetAmt;
	}

	public VwClientpricelistDetailsId(String particularsId,
			double clientpricedetDisc, double clientpricedetAmt, String partyId) {
		this.particularsId = particularsId;
		this.clientpricedetDisc = clientpricedetDisc;
		this.clientpricedetAmt = clientpricedetAmt;
		this.partyId = partyId;
	}

	public String getParticularsId() {
		return this.particularsId;
	}

	public void setParticularsId(String particularsId) {
		this.particularsId = particularsId;
	}

	public double getClientpricedetDisc() {
		return this.clientpricedetDisc;
	}

	public void setClientpricedetDisc(double clientpricedetDisc) {
		this.clientpricedetDisc = clientpricedetDisc;
	}

	public double getClientpricedetAmt() {
		return this.clientpricedetAmt;
	}

	public void setClientpricedetAmt(double clientpricedetAmt) {
		this.clientpricedetAmt = clientpricedetAmt;
	}

	public String getPartyId() {
		return this.partyId;
	}

	public void setPartyId(String partyId) {
		this.partyId = partyId;
	}

	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof VwClientpricelistDetailsId))
			return false;
		VwClientpricelistDetailsId castOther = (VwClientpricelistDetailsId) other;

		return ((this.getParticularsId() == castOther.getParticularsId()) || (this
				.getParticularsId() != null
				&& castOther.getParticularsId() != null && this
				.getParticularsId().equals(castOther.getParticularsId())))
				&& (this.getClientpricedetDisc() == castOther
						.getClientpricedetDisc())
				&& (this.getClientpricedetAmt() == castOther
						.getClientpricedetAmt())
				&& ((this.getPartyId() == castOther.getPartyId()) || (this
						.getPartyId() != null && castOther.getPartyId() != null && this
						.getPartyId().equals(castOther.getPartyId())));
	}

	public int hashCode() {
		int result = 17;

		result = 37
				* result
				+ (getParticularsId() == null ? 0 : this.getParticularsId()
						.hashCode());
		result = 37 * result + (int) this.getClientpricedetDisc();
		result = 37 * result + (int) this.getClientpricedetAmt();
		result = 37 * result
				+ (getPartyId() == null ? 0 : this.getPartyId().hashCode());
		return result;
	}

}
