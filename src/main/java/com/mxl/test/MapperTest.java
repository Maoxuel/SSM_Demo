package com.mxl.test;

import com.mxl.dao.DepartmentMapper;
import com.mxl.dao.EmployeeMapper;
import com.mxl.domain.Department;
import com.mxl.domain.Employee;
import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.UUID;

/*
    测试dao层
    推荐spring项目就可以用spring的单元测试，会自动注入所需要的组件
    1.导入springTest模块
    2.使用@ContextConfiguration指定spring配置文件的位置
    3.直接autowired要使用的组件即可
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"})
public class MapperTest {
    @Autowired
    DepartmentMapper departmentMapper;
    @Autowired
    EmployeeMapper employeeMapper;
    @Autowired
    SqlSession sqlSession;
    /*
        测试DepartmentMapper
     */
    @Test
    public void testCRUD(){
//        //1.创建springIOC容器
//        ApplicationContext ac = new ClassPathXmlApplicationContext("applicationContext.xml");
//        //2.从容器中取出mapper
//        DepartmentMapper mapper = ac.getBean(DepartmentMapper.class);
//        System.out.println(departmentMapper);

        //插入几个部门
//        departmentMapper.insertSelective(new Department(null,"Department"));
//        departmentMapper.insertSelective(new Department(null,"Test"));

        //插入几个员工
        //employeeMapper.insertSelective(new Employee(null,"Arthur","M","Arthur@163.com",1));

        //批量插入员工，使用可批量操作的sqlSession
        EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
        for (int i=0;i<100;i++){
            String uid = UUID.randomUUID().toString().substring(0, 5)+i;
            mapper.insertSelective(new Employee(null,uid,"M",uid+"@163.com",1));
        }
        System.out.println("批量插入完成");
    }
}
