package com.subodh;

// Generated Jan 4, 2014 4:28:33 PM by Hibernate Tools 3.4.0.CR1

/**
 * TblCountryMaster generated by hbm2java
 */
public class TblCountryMaster implements java.io.Serializable {

	private String countryId;
	private String countryName;
	private String countryIsoCode;
	private String countryCurrency;
	private String status;

	public TblCountryMaster() {
	}

	public TblCountryMaster(String countryId) {
		this.countryId = countryId;
	}

	public TblCountryMaster(String countryId, String countryName,
			String countryIsoCode, String countryCurrency, String status) {
		this.countryId = countryId;
		this.countryName = countryName;
		this.countryIsoCode = countryIsoCode;
		this.countryCurrency = countryCurrency;
		this.status = status;
	}

	public String getCountryId() {
		return this.countryId;
	}

	public void setCountryId(String countryId) {
		this.countryId = countryId;
	}

	public String getCountryName() {
		return this.countryName;
	}

	public void setCountryName(String countryName) {
		this.countryName = countryName;
	}

	public String getCountryIsoCode() {
		return this.countryIsoCode;
	}

	public void setCountryIsoCode(String countryIsoCode) {
		this.countryIsoCode = countryIsoCode;
	}

	public String getCountryCurrency() {
		return this.countryCurrency;
	}

	public void setCountryCurrency(String countryCurrency) {
		this.countryCurrency = countryCurrency;
	}

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

}
