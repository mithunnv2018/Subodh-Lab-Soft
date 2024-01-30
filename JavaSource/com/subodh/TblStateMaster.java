package com.subodh;

// Generated Jan 4, 2014 4:28:33 PM by Hibernate Tools 3.4.0.CR1

import java.util.HashSet;
import java.util.Set;

/**
 * TblStateMaster generated by hbm2java
 */
public class TblStateMaster implements java.io.Serializable {

	private String stateId;
	private String stateName;
	private String stateCode;
	private String countryId;
	private String status;
	private Set<TblCityMaster> tblCityMasters = new HashSet<TblCityMaster>(0);

	public TblStateMaster() {
	}

	public TblStateMaster(String stateId) {
		this.stateId = stateId;
	}

	public TblStateMaster(String stateId, String stateName, String stateCode,
			String countryId, String status, Set<TblCityMaster> tblCityMasters) {
		this.stateId = stateId;
		this.stateName = stateName;
		this.stateCode = stateCode;
		this.countryId = countryId;
		this.status = status;
		this.tblCityMasters = tblCityMasters;
	}

	public String getStateId() {
		return this.stateId;
	}

	public void setStateId(String stateId) {
		this.stateId = stateId;
	}

	public String getStateName() {
		return this.stateName;
	}

	public void setStateName(String stateName) {
		this.stateName = stateName;
	}

	public String getStateCode() {
		return this.stateCode;
	}

	public void setStateCode(String stateCode) {
		this.stateCode = stateCode;
	}

	public String getCountryId() {
		return this.countryId;
	}

	public void setCountryId(String countryId) {
		this.countryId = countryId;
	}

	public String getStatus() {
		return this.status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public Set<TblCityMaster> getTblCityMasters() {
		return this.tblCityMasters;
	}

	public void setTblCityMasters(Set<TblCityMaster> tblCityMasters) {
		this.tblCityMasters = tblCityMasters;
	}

}
