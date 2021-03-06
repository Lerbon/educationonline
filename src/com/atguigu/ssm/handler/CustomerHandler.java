package com.atguigu.ssm.handler;

import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.atguigu.ssm.beans.Customer;
import com.atguigu.ssm.beans.Department;
import com.atguigu.ssm.sevice.CustomerService;
import com.atguigu.ssm.sevice.DepartmentService;
import com.atguigu.ssm.sevice.DepartmentServiceImpl;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Controller
public class CustomerHandler {
	@Autowired
	private CustomerService customerService;
	@Autowired
	private DepartmentService departmentService;
	
	/**
	 * 删除顾客
	 */
	@RequestMapping(value="/delcust/{id}",method = RequestMethod.DELETE)
	public String deleteCustomerById(@PathVariable("id")Integer id) {
		System.out.println(id);
		Boolean deleteCustById = customerService.deleteCustById(id);
		return "redirect:/custs/1";
	}
	
	/**
	 * 修改顾客信息
	 */
	@RequestMapping(value = "/cust" , method = RequestMethod.PUT)
	public String updateCustomer(Customer customer) {
		customerService.updateCustById(customer);
		return "redirect:/custs/1";
	}

	/**
	 * 去往修改页面
	 */
	@RequestMapping(value = "/cust/{id}", method = RequestMethod.GET)
	public String toUpdatePage(@PathVariable("id") Integer id, Map<String, Object> map) {
		Customer customer = customerService.selectCustomerById(id);
		map.put("customer", customer);
		return "update";
	}

	/**
	 * 真正的添加
	 */
	@RequestMapping(value = "/cust", method = RequestMethod.POST)
	public String addCusts(Customer customer) {
		System.out.println("-------------------------");
		customerService.addNewCust(customer);
		return "redirect:/custs/1";
	}

	/**
	 * 去往添加页面
	 */
	@RequestMapping(value = "/cust", method = RequestMethod.GET)
	public String toAddPage(Map<String, Object> map) {
		List<Department> allDepartments = departmentService.listAllDepartments();
		map.put("customer", new Customer());
		map.put("depts", allDepartments);
		return "input";
	}

	/**
	 * 查询显示所有顾客信息
	 * 
	 */
	@RequestMapping(value = "/custs/{pageNum}", method = RequestMethod.GET)
	public String listAllCusts(@PathVariable("pageNum") Integer pageNum, Map<String, Object> map) {
		// 设置分页信息
		PageHelper.startPage(pageNum, 2);
		List<Customer> customers = customerService.listAllCustomers();
		PageInfo<Customer> info = new PageInfo<>(customers, 5);
		map.put("info", info);
		map.put("custs", customers);
		return "list";
	}
}
