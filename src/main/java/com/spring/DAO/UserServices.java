package com.spring.DAO;

import java.security.MessageDigest;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.MapSqlParameterSource;
import org.springframework.jdbc.core.namedparam.SqlParameterSource;
import org.springframework.stereotype.Service;

import com.jdbcConnectionPool.JdbcConnection;
import com.spring.interfaces.*;
import com.spring.model.District;
import com.spring.model.Login;
import com.spring.model.State;
import com.spring.model.UserDetail;
import com.spring.model.UserRole;

public class UserServices implements IUserInterface {
	@Autowired
	private JdbcConnection jdbcTemplate;
	

	// Login user service
	public String authenticateUser(Login login) {

		String sql = "Select count(*) from Login Where userID=? and password=?";
		int i = 0;

		i = jdbcTemplate.getJdbcTemplate().queryForObject(sql,
				new Object[] { login.getId(), login.getPassword() },
				Integer.class);
		if (i > 0) {
			String sqlForGettingRole = "select RoleID from Login where userID=?";
			String roleID = jdbcTemplate.getJdbcTemplate().queryForObject(
					sqlForGettingRole, new Object[] { login.getId() },
					String.class);
			return roleID;

		} else {

			return null;

		}

	}

	// create user service
	public boolean createUser(UserDetail userDetail) {

		String sqlForCheckUserExists = "Select count(*) from Login Where userID=?";
		int alreadyExists = 0;
		alreadyExists = jdbcTemplate.getJdbcTemplate().queryForObject(
				sqlForCheckUserExists, new Object[] { userDetail.getLogin().getId() },
				Integer.class);
		if (alreadyExists > 0) {
			return false;
		} else {
			String sql = "Insert into userDetail(userName,sex,mobileNumber,dateOfBirth,districtId,stateId,roleID,ID)"
					+ "values(?,?,?,?,?,?,?,?)";
			String sqlInsert = "insert into Login(userId,Password,RoleID) values(?,?,?)";
			int i, j = 0;
			j = jdbcTemplate.getJdbcTemplate().update(sqlInsert,
					userDetail.getLogin().getId(), userDetail.getLogin().getPassword(),
					userDetail.getUserRole().getRoleId());

			if (j > 0) {
				String sqlGetID="select ID from Login where userID="+userDetail.getLogin().getId();
				int ID=jdbcTemplate.getJdbcTemplate().queryForObject( sqlGetID,Integer.class);
				i = jdbcTemplate.getJdbcTemplate().update(sql,
						userDetail.getUserName(), userDetail.getSex(),
						userDetail.getMobileNumber(),
						userDetail.getDateOfBirth(),
						userDetail.getDistrict().getDistrictId(), userDetail.getState().getStateId(),userDetail.getUserRole().getRoleId(),ID);

			}

			else {
				return false;
			}
			if (i > 0) {
				return true;
			} else {
				return false;
			}
		}
	}

	// delete user service
	
	public boolean deleteUser(int Id) {
		
		String sql ="Delete from Login Where ID="+Id;
		int i=0;
		i = jdbcTemplate.getJdbcTemplate().update(sql);
        if(i>0)
        {
        	return true;
        }
		
		
		return false;
	}

	
	public UserDetail editUser(int Id) {
		// TODO Auto-generated method stub
		return null;
	}

	// get all users from database
	public ArrayList<UserDetail> getAllUsers() {
		ArrayList<UserDetail> userDetails=new ArrayList<UserDetail>();
		StringBuffer sql =new StringBuffer();
		sql.append("SELECT Login.UserID,Login.ID,UserRole.RoleName,UserDetail.UserName,UserDetail.Sex,UserDetail.MobileNumber, ");
		sql.append("UserDetail.DateOfBirth,States.StateName,District.DistrictName ");
		sql.append("FROM Login,UserDetail,States,District,UserRole ");
		sql.append("Where Login.RoleID=UserRole.RoleID and Login.ID=UserDetail.ID and UserDetail.StateID=district.StateID and UserDetail.DistrictID=District.DistrictID and States.StateID=District.StateID");
		List<Map<String, Object>> rows = jdbcTemplate.getJdbcTemplate()
				.queryForList(sql.toString());
		
		for(Map row:rows)
		{
			UserDetail userDetail=new UserDetail();
			Login login=new Login();
			UserRole role=new UserRole();
			District district =new District();
			State state=new State();
			login.setID(Integer.parseInt(row.get("ID").toString()));
			login.setId((String) row.get("UserID"));
			role.setUserRole((String) row.get("RoleName"));
			district.setDistrictName((String) row.get("DistrictName"));
			state.setStateName((String) row.get("StateName"));
			userDetail.setLogin(login);
			userDetail.setDistrict(district);
			userDetail.setState(state);
			userDetail.setUserRole(role);
			userDetail.setUserName((String) row.get("UserName"));
			userDetail.setSex((String) row.get("Sex"));
			//userDetail.setMobileNumber(Integer.parseInt(row.get("MobileNumber").toString()));
			userDetail.setDateOfBirth((Date) row.get("DateOfBirth"));
			
			
			userDetails.add(userDetail);
			
			
		}
		return userDetails;
			
	
	
	}

	// get name of states from database
	public Map<Integer, String> getStates() {

		String sql = "Select * from states";

		List<Map<String, Object>> rows = jdbcTemplate.getJdbcTemplate()
				.queryForList(sql);
		Map<Integer, String> states = new HashMap<Integer, String>();
		for (Map row : rows) {
			State state = new State();
			state.setStateId((Integer.parseInt(row.get("stateID").toString())));
			state.setStateName(((String) row.get("StateName")));
			states.put(state.getStateId(), state.getStateName());
		}
		return states;
	}

	// get district of particular state from database

	public Map<Integer, String> getDistrictList(int stateId) {

		String sql = "Select * from district  where stateID=?";

		List<Map<String, Object>> rows = jdbcTemplate.getJdbcTemplate()
				.queryForList(sql, stateId);
		Map<Integer, String> districtList = new HashMap<Integer, String>();
		for (Map row : rows) {
			District district = new District();
			district.setDistrictId(((Integer.parseInt(row.get("districtId")
					.toString()))));
			district.setDistrictName((((String) row.get("districtName"))));
			districtList.put(district.getDistrictId(),
					district.getDistrictName());
		}
		return districtList;
	}

	// get street of particular state and district from database

	public Map<Integer, String> getRoles() {
		String sql = "Select * from userRole";

		List<Map<String, Object>> rows = jdbcTemplate.getJdbcTemplate()
				.queryForList(sql);
		Map<Integer, String> userRoles = new HashMap<Integer, String>();
		for (Map row : rows) {
			UserRole role = new UserRole();
			role.setRoleId(Integer.parseInt(row.get("RoleId").toString()));
			role.setUserRole((String) row.get("RoleName"));
			userRoles.put(role.getRoleId(), role.getUserRole());
		}
		return userRoles;
	}

	public int getStateID(String stateName) {
		String sql="select stateID from states where stateName=:stateName";
		SqlParameterSource namedParameter=new MapSqlParameterSource("stateName",stateName);
		int stateID=jdbcTemplate.getNamedParameterJDBCTemplate().queryForObject(sql, namedParameter, Integer.class);	
				return stateID;
		
	}

	

}
