package com.subodh;

// Generated Jan 4, 2014 4:28:33 PM by Hibernate Tools 3.4.0.CR1

/**
 * TblTaxheadMaster generated by hbm2java
 */
public class TblTaxheadMaster implements java.io.Serializable {

	private String taxheadId;
	private String taxheadName;
	private double taxheadPercent;
	private String taxheadYear;
	private String taxheadStatus;

	public TblTaxheadMaster() {
	}

	public TblTaxheadMaster(String taxheadId, String taxheadName,
			double taxheadPercent, String taxheadYear, String taxheadStatus) {
		this.taxheadId = taxheadId;
		this.taxheadName = taxheadName;
		this.taxheadPercent = taxheadPercent;
		this.taxheadYear = taxheadYear;
		this.taxheadStatus = taxheadStatus;
	}

	public String getTaxheadId() {
		return this.taxheadId;
	}

	public void setTaxheadId(String taxheadId) {
		this.taxheadId = taxheadId;
	}

	public String getTaxheadName() {
		return this.taxheadName;
	}

	public void setTaxheadName(String taxheadName) {
		this.taxheadName = taxheadName;
	}

	public double getTaxheadPercent() {
		return this.taxheadPercent;
	}

	public void setTaxheadPercent(double taxheadPercent) {
		this.taxheadPercent = taxheadPercent;
	}

	public String getTaxheadYear() {
		return this.taxheadYear;
	}

	public void setTaxheadYear(String taxheadYear) {
		this.taxheadYear = taxheadYear;
	}

	public String getTaxheadStatus() {
		return this.taxheadStatus;
	}

	public void setTaxheadStatus(String taxheadStatus) {
		this.taxheadStatus = taxheadStatus;
	}

}
