package com.atguigu.crud.test;

import java.util.List;

import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mock.web.MockHttpServletRequest;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;
import org.springframework.test.context.web.WebAppConfiguration;
import org.springframework.test.web.servlet.MockMvc;
import org.springframework.test.web.servlet.MvcResult;
import org.springframework.test.web.servlet.request.MockMvcRequestBuilders;
import org.springframework.test.web.servlet.setup.MockMvcBuilders;
import org.springframework.web.context.WebApplicationContext;

import com.atguigu.crud.bean.Employee;
import com.github.pagehelper.PageInfo;

@RunWith(SpringJUnit4ClassRunner.class)
@WebAppConfiguration
@ContextConfiguration(locations = {"classpath:applicationContext.xml","file:src/main/webapp/WEB-INF/dispatcherServlet-servlet.xml"})
public class MvcTest {

	@Autowired
	WebApplicationContext context;
	//MVC请求模拟器
	MockMvc mockMvc;
	
	@Before
	public void initMokcMvc() {
		mockMvc = MockMvcBuilders.webAppContextSetup(context).build();
	}
	
	@Test
	public void testPage() throws Exception {
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/empstest").param("pn", "5")).andReturn();
		MockHttpServletRequest request = result.getRequest();
		PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
		System.out.println("��ǰҳ��:"+pageInfo.getPageNum());
		System.out.println("��ҳ��:"+pageInfo.getPages());
		System.out.println("�ܼ�¼��:"+pageInfo.getTotal());
		int [] pageNum = pageInfo.getNavigatepageNums();
		for(int i : pageNum) {
			System.out.println(" "+i);
		}
		List<Employee> list = pageInfo.getList();
		for(Employee emp : list) {
			System.out.println("ID:"+emp.getEmpId()+"����:"+emp.getEmpName());
		}
	}
	
	@Test
	public void test() throws Exception {
		MvcResult result = mockMvc.perform(MockMvcRequestBuilders.get("/depts")).andReturn();
//		MockHttpServletRequest request = result.getRequest();
//		PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
//		System.out.println("��ǰҳ��:"+pageInfo.getPageNum());
//		System.out.println("��ҳ��:"+pageInfo.getPages());
//		System.out.println("�ܼ�¼��:"+pageInfo.getTotal());
//		int [] pageNum = pageInfo.getNavigatepageNums();
//		for(int i : pageNum) {
//			System.out.println(" "+i);
//		}
//		List<Employee> list = pageInfo.getList();
//		for(Employee emp : list) {
//			System.out.println("ID:"+emp.getEmpId()+"����:"+emp.getEmpName());
//		}
	}
}
