package com.atguigu.crud.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.atguigu.crud.bean.Employee;
import com.atguigu.crud.bean.Msg;
import com.atguigu.crud.service.EmployeeService;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
public class EmployeeController {

	@Autowired
	EmployeeService employeeService;
	
	@RequestMapping(value="/emp/{ids}",method = RequestMethod.DELETE)
	@ResponseBody
	public Msg deleteEmpById(@PathVariable("ids")String ids) {
		if(ids.contains("-")) {
			List<Integer> del_ids =new ArrayList<Integer>();
			String [] str  = ids.split("-");
			for(String s : str) {
				del_ids.add(Integer.parseInt(s));
			}
			employeeService.deleteBatch(del_ids);
		}else {
			employeeService.deleteEmpById(Integer.parseInt(ids));
		}
		return Msg.success();
	}
	
	@RequestMapping(value="/emp/{id}",method = RequestMethod.GET)
	@ResponseBody
	public Msg getEmp(@PathVariable("id")Integer id) {
		Employee employee = employeeService.getEmp(id);
		return Msg.success().add("emp", employee);
	}
	
	@RequestMapping(value="/emp/{empId}",method = RequestMethod.PUT)
	@ResponseBody
	public Msg saveEmp(Employee employee) {
		employeeService.updateEmp(employee);
		return Msg.success();
	}
	
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpWithJson(@RequestParam(value = "pn",defaultValue = "1") Integer pn ,Model model) {
		PageHelper.startPage(pn, 5);
		List<Employee> empList = employeeService.getAll();
		PageInfo page = new PageInfo(empList,5);
		return Msg.success().add("pageInfo", page);
	}
	
	@RequestMapping("/checkUser")
	@ResponseBody
	public Msg checkUser(@RequestParam(value = "empName") String empName) {
		String regx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
		if(!empName.matches(regx)) {
			return Msg.fail().add("va_msg", "用户名可以是6-16位英文和数字的组合或者2-5位中文");
		}
		boolean b = employeeService.checkUser(empName);
		if(b) {
			return Msg.success();
		}else {
			return Msg.fail().add("va_msg", "用户名不可用");
		}
		
	}
	
	@RequestMapping(value="/emp",method=RequestMethod.POST)
	@ResponseBody
	public Msg saveEmp(@Valid Employee employee ,BindingResult result) {
		if(result.hasErrors()) {
			Map<String ,String> map = new HashMap<String ,String>();
			List<FieldError> errors = result.getFieldErrors();
			for(FieldError error : errors) {
				map.put(error.getField(), error.getDefaultMessage());
			}
			return Msg.fail().add("errorFields", map);
		}else{
			employeeService.saveEmp(employee);
			return Msg.success();
		}
		
	}
	
	//@RequestMapping("/emps")
	public String getEmps(@RequestParam(value = "pn",defaultValue = "1") Integer pn ,Model model) {
		PageHelper.startPage(pn, 5);
		List<Employee> empList = employeeService.getAll();
		PageInfo page = new PageInfo(empList,5);
		model.addAttribute("pageInfo",page);
		return "list";
	}
}
