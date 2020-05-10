package com.mxl.controller;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.mxl.domain.Employee;
import com.mxl.domain.Msg;
import com.mxl.service.EmployeeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.FieldError;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/*
    处理员工curd
 */
@Controller
public class EmployeeController {

    @Autowired
    EmployeeService employeeService;

    //根据id删除用户
    //单个/批量二合一，批量：1-2-3  单个1
    @ResponseBody
    @RequestMapping(value = "/emps/{ids}",method = RequestMethod.DELETE)
    public Msg deleteEmpById(@PathVariable("ids") String ids){
        if (ids.contains("-")){
            List<Integer> del_ids = new ArrayList<>();
            String[] strings = ids.split("-");
            for(String id:strings){
                del_ids.add(Integer.parseInt(id));
            }
            employeeService.deleteBatch(del_ids);
        }else {
            int id = Integer.parseInt(ids);
            employeeService.deleteEmp(id);

        }
        return Msg.success();
    }

    //保存(更新)员工
    /*
        ajax发送put请求不会成功
        tomcat不会封装put请求中的数据，只会封装Post请求的数据
        解决：1.ajax使用post发请求，data中携带请求方法
              2.ajax使用put请求，配置过滤器
     */
    @ResponseBody
    @RequestMapping(value = "/emps/{empId}", method = RequestMethod.PUT)
    public Msg saveEmp(Employee employee) {
        employeeService.updateEmp(employee);
        return Msg.success();
    }

    //查询用户
    @RequestMapping(value = "/emps/{id}", method = RequestMethod.GET)
    @ResponseBody
    public Msg getEmp(@PathVariable("id") Integer id) {
        Employee employee = employeeService.getEmp(id);
        return Msg.success().add("emp", employee);
    }

    //检查用户名是否可用
    @ResponseBody
    @RequestMapping("/checkEmp")
    public Msg checkEmp(@RequestParam("empName") String empName) {
        //用户名是否合法
        String regEx = "(^[a-zA-Z0-9_-]{6,16}$)|(^[\\u2E80-\\u9FFF]{2,5})";
        if (!empName.matches(regEx)) {
            return Msg.fail().add("va_msg", "用户名必须是6-16位字母和英文或2-5位中文的组合");
        }
        //是否重复
        boolean b = employeeService.checkEmp(empName);
        if (b) {
            return Msg.success();
        } else {
            return Msg.fail().add("va_msg", "用户名不可用");
        }
    }

    /*保存员工
       不仅前端需要校验，重要数据后端更需要校验，使用JSR303校验
       导入Hibernate-validator
    */
    @RequestMapping(value = "/emps", method = RequestMethod.POST)
    @ResponseBody
    public Msg saveEmp(@Valid Employee employee, BindingResult result) {
        if (result.hasErrors()) {
            //校验失败，返回并在模态框中显示错误信息
            Map<String, Object> map = new HashMap<>();
            List<FieldError> errors = result.getFieldErrors();
            for (FieldError error : errors) {
                //错误的字段名和错误信息
                map.put(error.getField(), error.getDefaultMessage());

            }
            return Msg.fail().add("errorFileds", map);
        } else {
            employeeService.saveEmp(employee);
            return Msg.success();
        }
    }

    //使用@ResponseBody需要导入Jackson包
    @RequestMapping("/emps")
    @ResponseBody
    public Msg getEmpsWithJson(@RequestParam(value = "pn", defaultValue = "1") Integer pn) {
        //这不是一个分页查询
        //引入PageHelper分页插件
        //在查询之前只需要调用,传入页码和大小
        PageHelper.startPage(pn, 5);
        //startPage后面紧跟的查询就是个分页查询
        List<Employee> list = employeeService.getAll();
        //使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了
        //它封装了详细的分页的信息，包括查询出的结果,传入连续显示的页数
        PageInfo page = new PageInfo(list, 5);
        return Msg.success().add("pageInfo", page);
    }

    //@RequestMapping("/emps")
    public String getEmps(@RequestParam(value = "pn", defaultValue = "1") Integer pn, Model model) {
        //这不是一个分页查询
        //引入PageHelper分页插件
        //在查询之前只需要调用,传入页码和大小
        PageHelper.startPage(pn, 5);
        //startPage后面紧跟的查询就是个分页查询
        List<Employee> list = employeeService.getAll();
        //使用pageInfo包装查询后的结果，只需要将pageInfo交给页面就行了
        //它封装了详细的分页的信息，包括查询出的结果,传入连续显示的页数
        PageInfo page = new PageInfo(list, 5);
        model.addAttribute("pageInfo", page);
        return "list";
    }
}
