package com.atguigu.crud.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.atguigu.crud.bean.Department;
import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.dao.DepartmentMapper;
import com.atguigu.crud.dao.EmployeeMapper;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {
	
	@Autowired
	DepartmentMapper departmentMapper;
	@Autowired
	EmployeeMapper employeeMapper;
	@Autowired
	SqlSession sqlSession;

	/**
	 * 
	 * <p>����CURD</p> 
	 * @author HX
	 * @date 2019��5��6�� ����8:55:27
	 * @see
	 */
	@Test
	public void testCURD() {
//		ApplicationContext ctx = new ClassPathXmlApplicationContext();
//		DepartmentMapper department = ctx.getBean(DepartmentMapper.class);
//		System.out.println(department);
		
//		departmentMapper.insertSelective(new Department(null,"������"));
//		departmentMapper.insertSelective(new Department(null,"���Բ�"));
		
//		employeeMapper.insertSelective(new Employee(null,"Jerry","M","Jerry@atguigu.com",1));
		
		
//		  for() { 
//			  employeeMapper.insertSelective(new Employee(null,"Jerry","M","Jerry@atguigu.com",1)); 
//			  }
		
		EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
		for(int i=0;i<1000;i++) {
			String uid = UUID.randomUUID().toString().substring(0, 5)+i;
			mapper.insertSelective(new Employee(null,uid,"M",uid+"@atguigu.com",1));
		}
		System.out.println("�������");
		
	}
}
