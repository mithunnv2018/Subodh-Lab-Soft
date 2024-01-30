package com.esaya.util;

import java.io.Serializable;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Random;

import javax.servlet.http.HttpSession;

import org.hibernate.Query;
import org.hibernate.SQLQuery;
import org.hibernate.Session;
import org.hibernate.Transaction;


import com.subodh.TblRunningidMaster;

//import com.caddybook.TblTempGolfclubsMaster;
//import com.caddybook.Tblsequence;


 
public class QuickUtil  {
	
	public static String x1x=null;
	public static String runYear=null;
	public QuickUtil() {
		// TODO Auto-generated constructor stub
	}

	public static String saveToNew(Object mobj) {
		Session session = HibernateUtils.currentSession();
		Transaction tx = null;
		boolean rollback = true;
		try {
			tx = session.beginTransaction();
			Serializable save = session.save(mobj);

			tx.commit();
			rollback = false;
			return save.toString();
		} catch (Exception e) {
			e.printStackTrace();
			System.err.println("saveToNew Failed for "	+ mobj.getClass()+ e.getCause());
		} finally {
			if (rollback && tx != null) {
				tx.rollback();
			}
			HibernateUtils.closeSession();
		}
		return "";
	}
	public static void makelist()
	{
		x1x = "abc";
	}
	public static void updateToOld(Object mobj) {
		Session session = HibernateUtils.currentSession();
		Transaction tx = null;
		boolean rollback = true;
		try {
			tx = session.beginTransaction();
			session.update(mobj);

			tx.commit();
			rollback = false;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rollback && tx != null) {
				tx.rollback();
			}
			HibernateUtils.closeSession();
		}
	}

	public static int deleteFromDB(String tablename, String whereclause) {
		Session session = HibernateUtils.currentSession();
		Transaction tx = null;
		int ret = 0;
		boolean rollback = true;
		try {
			tx = session.beginTransaction();
			Query createQuery = session.createQuery("delete from " + tablename
					+ " where " + whereclause);
			ret = createQuery.executeUpdate();
			System.out.println("Mith Rows Deleted:" + ret);
			tx.commit();
			rollback = false;
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			if (rollback && tx != null) {
				tx.rollback();
			}
			HibernateUtils.closeSession();

		}
		return ret;
	}
	
	/*	public static <T> List retrieveALL(T a, String tablename, String columnames) {
		Session session = HibernateUtils.currentSession();
		try {
			Query query = session.createQuery("SELECT   " + columnames
					+ " FROM " + tablename + " a");

			// +" WHERE u_username='" + U_UserName +
			// "' AND u_pass='"+U_Pass+"'");
			List<T> dataList = query.list();
			return dataList;

		} catch (Exception e) {
			System.out.println("checklogin method error:" + e.getMessage());
			e.printStackTrace();
		} finally {

			HibernateUtils.closeSession();
		}
		return null;
	}
*/
	public static <T> List retrieveALLwithHB(T a, String tablename,
			String columnames) {
		Session session = HibernateUtils.currentSession();
		try {
			Query query = session.createQuery("from  " + tablename + " a");

			// +" WHERE u_username='" + U_UserName +
			// "' AND u_pass='"+U_Pass+"'");
			List<T> dataList = query.list();
			return dataList;

		} catch (Exception e) {
			System.out.println("retieveALlwithHB method error:"
					+ e.getMessage());
			e.printStackTrace();
		} finally {

			HibernateUtils.closeSession();
		}
		return null;
	}

	public static <T> List retrieveWherClause(T a, String tablename,
			String whereclause) {
		Session session = HibernateUtils.currentSession();
		try {
			// Query query = session.createQuery("SELECT   "+columnames
			// + " FROM "+tablename+" a" +" "+whereclause);

			// +" WHERE u_username='" + U_UserName +
			// "' AND u_pass='"+U_Pass+"'");
			Query query = session.createQuery("from " + tablename + " where "
					+ whereclause);
			List<T> dataList = query.list();
			return dataList;

		} catch (Exception e) {
			System.out.println("checklogin method error:" + e.getMessage());
			e.printStackTrace();
		} finally {

			HibernateUtils.closeSession();
		}
		return null;
	}

	public static <T> List retrieveDistinctWhereClause(T a, String tablename,String[] columns,String whereclause )
	{
		Session session = HibernateUtils.currentSession();
		System.out.println("QuickUtil.retrieveDistinctWhereClause()");
		try {
			
			String distinctcolumn="";
			if(columns.length>0)
			{
				for(int i=0;i<columns.length;i++)
				{
					distinctcolumn+="a."+columns[i];
					if((i+1)==columns.length)
					{
						
					}
					else
					{
						distinctcolumn+=" , ";
					}
					
				}
			}
			
			String query="SELECT DISTINCT "+distinctcolumn+" FROM "+tablename+" a ";
			if((whereclause.trim()).isEmpty()==false)
			{
				query+="WHERE "+whereclause;
			}
			Query createQuery = session.createQuery(query);
			 List<T> list = createQuery.list();
			 return list;
		} catch (Exception e) {
			System.err.println("error here mith : "+e.getMessage());
			e.printStackTrace();
		}
		finally
		{
			HibernateUtils.closeSession();
		}
		return null;
	}
	
	/*
	 * Exceute Raw SQL Query
	 */
	public static List CreateSQLQuery(String sql)
	{
		Session session = HibernateUtils.currentSession();
		
		try{
			
			Query qx = session.createSQLQuery(sql);
			List lstqry = qx.list();
			return lstqry;
			
		}catch(Exception ex1)
		{
			
			System.err.println("ErrorCreateSQLQuery:" + ex1.getMessage());
			ex1.printStackTrace();
			return null;
		}
		finally
		{
			HibernateUtils.closeSession();
		}
	}

	public static Integer doGetNextPKdate()
	{
		Date  abc=Calendar.getInstance().getTime();
		int a=(int) abc.getTime();
		return a;
	}

	public static Integer doGetNextPK(String tablename, String pkid) {
	
		if (tablename.isEmpty()) {
			Integer ret = new Random().nextInt(10000);
			return ret;
		} else {
			StringBuffer sqlQry = new StringBuffer();
			sqlQry.append(" SELECT  max(E." + pkid + ") from  " + tablename
					+ " E");
	
			try {
				Session session = HibernateUtils.currentSession();
				Query dashBrdQry = session.createQuery(sqlQry.toString());
	
				List dataList = dashBrdQry.list();
				System.out.println("size is" + dataList.size());
	
				if (dataList.get(0) == null) {
					return 1;
				}
				System.out.println("class is" + dataList.get(0).getClass()
						+ "valui is " + dataList.get(0));
				Integer a = 0;
	
				System.out.println("IS a string here");
				if (dataList.get(0).getClass().getName().indexOf("String") != -1) {
					String r = (String) dataList.get(0);
					a = Integer.parseInt(r);
				} else if (dataList.get(0).getClass().getName()
						.indexOf("Integer") != -1) {
					a = (Integer) dataList.get(0);
				}
				a++;
				System.out.println("Value is " + a);
				return a;
	
				// Integer ret=(Integer) dataList.get(0);
				// ret++;
	
				// return ret;
	
			} catch (Exception e) {
				System.out.println("dogetNextPK method has error "
						+ e.getMessage());
				e.printStackTrace();
			} finally {
	
				HibernateUtils.closeSession();
			}
		}
		return null;
	}

	/**
	 * 
	 * donextpk for getting pk 
	 * 
	 */
	
	public static String doGetNextPK(String strname) {
		
		List<TblRunningidMaster> retrieveWherClause = retrieveWherClause(new TblRunningidMaster(), "TblRunningidMaster", "Run_Name='" + strname + "'");
		
		TblRunningidMaster objempcat = new TblRunningidMaster();
		
		objempcat= retrieveWherClause.get(0);
		
		objempcat.setRunNos(objempcat.getRunNos() + 1);
		
		QuickUtil.updateToOld(objempcat);
		
		return "" +  objempcat.getRunPreappend() + objempcat.getRunNos().toString() +""; 
		
	}
	
	public static Integer doGetNextPK(String tablename, String fldname,String fldwhereclause) {
		
		if (tablename.isEmpty()) {
			Integer ret = new Random().nextInt(10000);
			return ret;
		} else {
			StringBuffer sqlQry = new StringBuffer();
			sqlQry.append(" SELECT  " + fldname + " from  " + tablename
					+ " where " + fldwhereclause);
	
			try {
				Session session = HibernateUtils.currentSession();
				Query dashBrdQry = session.createQuery(sqlQry.toString());
	
				List dataList = dashBrdQry.list();
				System.out.println("size is" + dataList.size());
	
				if (dataList.get(0) == null) {
					return 1;
				}
				System.out.println("class is" + dataList.get(0).getClass()
						+ "valui is " + dataList.get(0));
				Integer a = 0;
	
				System.out.println("IS a string here");
				if (dataList.get(0).getClass().getName().indexOf("String") != -1) {
					String r = (String) dataList.get(0);
					a = Integer.parseInt(r);
				} else if (dataList.get(0).getClass().getName()
						.indexOf("Integer") != -1) {
					a = (Integer) dataList.get(0);
				}
				a++;
				System.out.println("Value is " + a);
				return a;
	
				// Integer ret=(Integer) dataList.get(0);
				// ret++;
	
				// return ret;
	
			} catch (Exception e) {
				System.out.println("dogetNextPK method has error "
						+ e.getMessage());
				e.printStackTrace();
			} finally {
	
				HibernateUtils.closeSession();
			}
		}
		return null;
	}

	
	//end getting pk for employeecategory
	/**
	 * retrieves a random number and checks if the new Primary Key is Not
	 * repeated.
	 * 
	 * @param tablename
	 * @param column
	 *            must be a integer type columnn
	 * @param b
	 *            is just for methodoverloading
	 * @return
	 */
	public static Integer doGetNextPK(String tablename, String column, boolean b) {
		boolean stop2 = false;
		Integer pk2 = 0;

		for (int i = 0; i < 100 && stop2 != true; i++) {
			pk2 = doGetNextPK("", "");
			if (tablename.length() == 0 || column.length() == 0) {
				System.out
						.println("doGetNextPK tablename is empty so returned random number");
				return pk2;
			}
			try {
				List abcd = retrieveWherClause(new Object(), tablename, column
						+ "=" + pk2);
				if (abcd.size() == 0) {
					System.out
							.println("doGetNextPK is a uniques number so returned random number");

					stop2 = true;
					return pk2;
				} else {
					System.out
							.println("doGetNextPK tablename is already existing");

				}

			} catch (Exception e) {
				// TODO Auto-generated catch block

				e.printStackTrace();
				break;
			}
		}
		System.out.println("doGetNextPK(3args) had an error");
		return pk2;
	}

	public static  Integer doGetNextSequence(String tablename) 
	{
//		List<Tblsequence> retrieveWherClause = QuickUtil.retrieveWherClause(new Tblsequence(), "Tblsequence", "tablename='"+tablename+"' ");
//		if(retrieveWherClause.size()>0)
//		{
//			Tblsequence t = retrieveWherClause.get(0);
//			Integer nextsequenceno = t.getNextsequenceno();
//			++nextsequenceno;
//			System.out.println("New sequence id is "+nextsequenceno);
//			t.setNextsequenceno(nextsequenceno);
//			QuickUtil.updateToOld(t);
//			System.out.println("Update sequence id.");
//			return nextsequenceno;
//		}
		return 1;
	
	}
 
}
