package com.jdbcConnectionPool;

import javax.sql.DataSource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.namedparam.NamedParameterJdbcTemplate;

public class JdbcConnection {
	private DataSource dataSource;
	private JdbcTemplate jdbcTemplate;
	private NamedParameterJdbcTemplate namedParameterJDBCTemplate;
	
	public NamedParameterJdbcTemplate getNamedParameterJDBCTemplate() {
		return new NamedParameterJdbcTemplate(dataSource);
	}
	
	public DataSource getDataSource() {
		return dataSource;
	}
	public JdbcTemplate getJdbcTemplate() {
		return new JdbcTemplate(dataSource);
	}
	public void setDataSource(DataSource dataSource) {
		this.dataSource = dataSource;
	}
	public void setJdbcTemplate(JdbcTemplate jdbcTemplate) {
		this.jdbcTemplate = jdbcTemplate;
	}
	
	


	


}
